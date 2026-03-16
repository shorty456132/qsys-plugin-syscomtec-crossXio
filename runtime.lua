--[[
    Syscomtec crossXio SCT-IPCX Controller
    TCP control plugin for matrix routing, video walls, and device management
    Commands use ASCII over TCP port 23 with carriage return termination
]]

--------------------
-- Variables -------
--------------------

-- TCP Socket
TCP = TcpSocket.New()
TCP.ReadTimeout = 0
TCP.WriteTimeout = 0
TCP.ReconnectTimeout = 5

-- Timers
PollTimer = Timer.New()
HeartbeatTimer = Timer.New()

-- State variables
DeviceList = {}
MatrixState = {}
HeartbeatTimeout = 15  -- Must be > poll interval

-- Debug settings
local DebugPrint = Properties["Debug Print"].Value
DebugTx, DebugRx = false, false
if DebugPrint == "Tx/Rx" or DebugPrint == "All" then
  DebugTx, DebugRx = true, true
elseif DebugPrint == "Tx" then
  DebugTx = true  
elseif DebugPrint == "Rx" then
  DebugRx = true
end

-- End Variables ---

--------------------
-- Functions -------
--------------------

function Initialize()
  local ip = Controls["IPAddress"].String
  local port = tonumber(Controls["Port"].String) or 23
  
  if ip ~= "" and Controls["Connect"].Boolean then
    print("Connecting to " .. ip .. ":" .. tostring(port))
    Controls["Status"].Value = 5  -- Initializing
    Controls["Status"].String = "Connecting..."
    TCP:Connect(ip, port)
  end
end

function Send(cmd)
  if TCP.IsConnected then
    if DebugTx then print("TX: " .. cmd) end
    TCP:Write(cmd .. "\r")
  else
    print("Error: Not connected, unable to send: " .. cmd)
  end
end

function ParseResponse(data)
  if DebugRx then print("RX: " .. data) end
  
  Controls["Last Response"].String = data
  
  -- Parse different response types
  if data:find("^API version:") then
    Controls["System Version"].String = data
    
  elseif data:find("^devicelist is") then
    ParseDeviceList(data)
    
  elseif data:find("^matrix information:") then
    -- Matrix response starts, clear previous state
    MatrixState = {}
    
  elseif data:find("^%w+%-%w+ %w+%-%w+") then
    -- Matrix route line (TX-device RX-device format)
    local tx, rx = data:match("^(%S+) (%S+)")
    if tx and rx then
      if not MatrixState[tx] then
        MatrixState[tx] = {}
      end
      table.insert(MatrixState[tx], rx)
    end
    UpdateMatrixDisplay()
    
  elseif data:find("hostname's alias is") then
    -- Alias response
    print("Alias info: " .. data)
    
  else
    -- Generic response
    print("Response: " .. data)
  end
  
  ResetHeartbeat()
end

function ParseDeviceList(data)
  -- Extract device hostnames from "devicelist is hostname1 hostname2 ..."
  local deviceStr = data:match("devicelist is (.+)")
  if deviceStr then
    DeviceList = {}
    local count = 0
    for device in deviceStr:gmatch("%S+") do
      table.insert(DeviceList, device)
      count = count + 1
    end
    
    Controls["Device Count"].String = tostring(count) .. " devices"
    
    -- Update device controls with discovered devices
    local maxDevices = Properties["Max Devices"].Value
    for i = 1, maxDevices do
      if DeviceList[i] then
        Controls["Device" .. i .. " Name"].String = DeviceList[i]
      else
        Controls["Device" .. i .. " Name"].String = ""
      end
    end
    
    print("Discovered " .. count .. " devices")
  end
end

function UpdateMatrixDisplay()
  local status = ""
  for tx, rxList in pairs(MatrixState) do
    if status ~= "" then status = status .. "; " end
    status = status .. tx .. "->" .. table.concat(rxList, ",")
  end
  Controls["Matrix Status"].String = status
end

function ResetHeartbeat()
  HeartbeatTimer:Stop()
  HeartbeatTimer:Start(HeartbeatTimeout)
end

-- End Functions ---

--------------------
-- TCP Handlers ----
--------------------

TCP.Connected = function()
  print("Connected to crossXio controller")
  Controls["Status"].Value = 0  -- OK
  Controls["Status"].String = "Connected"
  
  -- Initial discovery
  Timer.CallAfter(function()
    Send("config get version")
    Send("config get devicelist")
  end, 1)
  
  -- Start polling
  PollTimer:Start(Properties["Poll Rate"].Value)
  ResetHeartbeat()
end

TCP.Reconnect = function()
  print("Reconnecting to crossXio controller...")
  Controls["Status"].Value = 1  -- Compromised
  Controls["Status"].String = "Reconnecting..."
end

TCP.Data = function()
  local data = TCP:ReadLine(TcpSocket.EOL.Custom, "\r")
  while data do
    ParseResponse(data)
    data = TCP:ReadLine(TcpSocket.EOL.Custom, "\r")
  end
end

TCP.Closed = function()
  print("TCP connection closed")
  Controls["Status"].Value = 2  -- Fault
  Controls["Status"].String = "Disconnected"
  PollTimer:Stop()
  HeartbeatTimer:Stop()
end

TCP.Error = function(sock, err)
  print("TCP Error: " .. tostring(err))
  Controls["Status"].Value = 2  -- Fault
  Controls["Status"].String = "Error: " .. tostring(err)
  PollTimer:Stop()
  HeartbeatTimer:Stop()
end

TCP.Timeout = function()
  print("TCP Timeout")
  Controls["Status"].Value = 2  -- Fault
  Controls["Status"].String = "Timeout"
  PollTimer:Stop()
end

--------------------
-- EventHandlers ---
--------------------

-- Connection controls
Controls["Connect"].EventHandler = function(ctl)
  if ctl.Boolean then
    Initialize()
  else
    TCP:Disconnect()
  end
end

Controls["IPAddress"].EventHandler = function(ctl)
  if ctl.String ~= "" then
    if Controls["Connect"].Boolean then
      Initialize()
    end
  end
end

Controls["Port"].EventHandler = function(ctl)
  if Controls["Connect"].Boolean then
    Initialize()
  end
end

-- Discovery
Controls["Discover"].EventHandler = function(ctl)
  if ctl.Boolean then  -- Trigger button pressed
    Send("config get devicelist")
  end
end

-- Matrix routing
Controls["Route"].EventHandler = function(ctl)
  if ctl.Boolean then
    local tx = Controls["TX Selection"].String
    local rx = Controls["RX Selection"].String
    if tx ~= "" and rx ~= "" then
      Send("matrix set " .. tx .. " " .. rx)
      print("Routing " .. tx .. " to " .. rx)
    end
  end
end

Controls["Disconnect RX"].EventHandler = function(ctl)
  if ctl.Boolean then
    local rx = Controls["RX Selection"].String
    if rx ~= "" then
      Send("matrix set NULL " .. rx)
      print("Disconnecting " .. rx)
    end
  end
end

Controls["Get Matrix"].EventHandler = function(ctl)
  if ctl.Boolean then
    Send("matrix get")
  end
end

-- Video Wall controls
local vwCount = Properties["Video Wall Count"].Value
for i = 1, vwCount do
  Controls["VW" .. i .. " Create"].EventHandler = function(ctl)
    if ctl.Boolean then
      local name = Controls["VW" .. i .. " Name"].String
      local rows = Controls["VW" .. i .. " Rows"].String
      local cols = Controls["VW" .. i .. " Cols"].String
      local tx = Controls["VW" .. i .. " TX"].String
      
      if name ~= "" and rows ~= "" and cols ~= "" and tx ~= "" then
        Send("vw add " .. name .. " " .. rows .. " " .. cols .. " " .. tx)
        print("Creating video wall: " .. name)
      end
    end
  end
  
  Controls["VW" .. i .. " Remove"].EventHandler = function(ctl)
    if ctl.Boolean then
      local name = Controls["VW" .. i .. " Name"].String
      if name ~= "" then
        Send("vw rm " .. name)
        print("Removing video wall: " .. name)
      end
    end
  end
end

-- Scene controls
local sceneCount = Properties["Scene Count"].Value
for i = 1, sceneCount do
  Controls["Scene" .. i .. " Recall"].EventHandler = function(ctl)
    if ctl.Boolean then
      local sceneName = Controls["Scene" .. i .. " Name"].String
      if sceneName ~= "" then
        Send("scene active " .. sceneName)
        print("Recalling scene: " .. sceneName)
      end
    end
  end
end

-- Device controls
local maxDevices = Properties["Max Devices"].Value
for i = 1, maxDevices do
  -- Set alias
  Controls["Device" .. i .. " Alias"].EventHandler = function(ctl)
    local hostname = Controls["Device" .. i .. " Name"].String
    local alias = ctl.String
    if hostname ~= "" and alias ~= "" then
      Send("config set device alias " .. hostname .. " " .. alias)
      print("Setting alias for " .. hostname .. " to " .. alias)
    end
  end
  
  -- Device reboot
  Controls["Device" .. i .. " Reboot"].EventHandler = function(ctl)
    if ctl.Boolean then
      local hostname = Controls["Device" .. i .. " Name"].String
      if hostname ~= "" then
        Send("config set device reboot " .. hostname)
        print("Rebooting device: " .. hostname)
      end
    end
  end
  
  -- Device standby (CEC)
  Controls["Device" .. i .. " Standby"].EventHandler = function(ctl)
    if ctl.Boolean then
      local hostname = Controls["Device" .. i .. " Name"].String
      if hostname ~= "" then
        Send("config set device standby " .. hostname)
        print("Sending standby to device: " .. hostname)
      end
    end
  end
  
  -- Device wake (CEC)
  Controls["Device" .. i .. " Wake"].EventHandler = function(ctl)
    if ctl.Boolean then
      local hostname = Controls["Device" .. i .. " Name"].String
      if hostname ~= "" then
        Send("config set device onetouchplay " .. hostname)
        print("Sending wake to device: " .. hostname)
      end
    end
  end
end

-- Custom command
Controls["Send Command"].EventHandler = function(ctl)
  if ctl.Boolean then
    local cmd = Controls["Custom Command"].String
    if cmd ~= "" then
      Send(cmd)
    end
  end
end

-- Timers
PollTimer.EventHandler = function()
  if TCP.IsConnected then
    Send("config get devicelist")
  end
end

HeartbeatTimer.EventHandler = function()
  print("Lost communication with crossXio controller!")
  Controls["Status"].Value = 2  -- Fault
  Controls["Status"].String = "Communication Lost"
  Initialize()
end

-- Initialize defaults
Controls["IPAddress"].String = "192.168.11.243"  -- Default control IP
Controls["Port"].String = "23"

--End Eventhandlers-
