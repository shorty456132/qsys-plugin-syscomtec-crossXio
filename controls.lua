-- Connection Controls
table.insert(ctrls, {
  Name = "IPAddress",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both"
})

table.insert(ctrls, {
  Name = "Port",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both"
})

table.insert(ctrls, {
  Name = "Connect",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Both"
})

table.insert(ctrls, {
  Name = "Status",
  ControlType = "Indicator",
  IndicatorType = "Status",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})

-- Discovery and Info Controls
table.insert(ctrls, {
  Name = "Discover",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "System Version",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})

table.insert(ctrls, {
  Name = "Device Count",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})

-- Matrix Routing Controls
table.insert(ctrls, {
  Name = "TX Selection",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both"
})

table.insert(ctrls, {
  Name = "RX Selection",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both"
})

table.insert(ctrls, {
  Name = "Route",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "Disconnect RX",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "Get Matrix",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "Matrix Status",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})

-- Video Wall Controls
local vwCount = props["Video Wall Count"].Value
for i = 1, vwCount do
  table.insert(ctrls, {
    Name = "VW" .. i .. " Name",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Both"
  })
  
  table.insert(ctrls, {
    Name = "VW" .. i .. " Rows",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Both"
  })
  
  table.insert(ctrls, {
    Name = "VW" .. i .. " Cols",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Both"
  })
  
  table.insert(ctrls, {
    Name = "VW" .. i .. " TX",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Both"
  })
  
  table.insert(ctrls, {
    Name = "VW" .. i .. " Create",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  
  table.insert(ctrls, {
    Name = "VW" .. i .. " Remove",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
end

-- Scene Controls
local sceneCount = props["Scene Count"].Value
for i = 1, sceneCount do
  table.insert(ctrls, {
    Name = "Scene" .. i .. " Name",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Both"
  })
  
  table.insert(ctrls, {
    Name = "Scene" .. i .. " Recall",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
end

-- Device Controls
local maxDevices = props["Max Devices"].Value
for i = 1, maxDevices do
  table.insert(ctrls, {
    Name = "Device" .. i .. " Name",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Output"
  })
  
  table.insert(ctrls, {
    Name = "Device" .. i .. " Alias",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Both"
  })
  
  table.insert(ctrls, {
    Name = "Device" .. i .. " Reboot",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  
  table.insert(ctrls, {
    Name = "Device" .. i .. " Standby",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  
  table.insert(ctrls, {
    Name = "Device" .. i .. " Wake",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
end

-- Command Controls
table.insert(ctrls, {
  Name = "Custom Command",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both"
})

table.insert(ctrls, {
  Name = "Send Command",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

table.insert(ctrls, {
  Name = "Last Response",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Output"
})
