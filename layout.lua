local CurrentPage = PageNames[props["page_index"].Value]

-- Plugin background
table.insert(graphics, {
  Type = "GroupBox",
  Fill = { 35, 35, 35 },
  StrokeColor = { 35, 35, 35 },
  StrokeWidth = 0,
  CornerRadius = 0,
  Position = { 0, 0 },
  Size = { 800, 600 },
  ZOrder = -10
})

-- Build version in bottom left
table.insert(graphics, {
  Type = "Label",
  Text = "v" .. PluginInfo.BuildVersion,
  Color = { 150, 150, 150 },
  FontSize = 9,
  Font = "Roboto",
  Position = { 10, 580 },
  Size = { 100, 15 }
})

if CurrentPage == "Control" then
  -- Connection section
  table.insert(graphics, {
    Type = "GroupBox",
    Text = "Connection",
    Fill = { 55, 55, 55 },
    Color = { 221, 221, 221 },
    StrokeColor = { 80, 80, 80 },
    StrokeWidth = 1,
    CornerRadius = 8,
    Font = "Roboto",
    FontSize = 11,
    Position = { 10, 10 },
    Size = { 380, 100 },
    ZOrder = -5
  })

  -- IP Address
  table.insert(graphics, {
    Type = "Label",
    Text = "IP Address:",
    Color = { 200, 200, 200 },
    FontSize = 11,
    Font = "Roboto",
    HTextAlign = "Right",
    Position = { 20, 35 },
    Size = { 80, 24 }
  })

  layout["IPAddress"] = {
    PrettyName = "Connection~IP Address",
    Style = "Text",
    Position = { 105, 35 },
    Size = { 150, 24 },
    FontSize = 11,
    Color = { 255, 255, 255 },
    CornerRadius = 4
  }

  -- Port
  table.insert(graphics, {
    Type = "Label",
    Text = "Port:",
    Color = { 200, 200, 200 },
    FontSize = 11,
    Font = "Roboto",
    HTextAlign = "Right",
    Position = { 20, 65 },
    Size = { 80, 24 }
  })

  layout["Port"] = {
    PrettyName = "Connection~Port",
    Style = "Text",
    Position = { 105, 65 },
    Size = { 80, 24 },
    FontSize = 11,
    Color = { 255, 255, 255 },
    CornerRadius = 4
  }

  -- Connect button
  layout["Connect"] = {
    PrettyName = "Connection~Connect",
    Style = "Button",
    ButtonVisualStyle = "Flat",
    Position = { 200, 35 },
    Size = { 80, 24 },
    Color = { 0, 180, 80 },
    OffColor = { 80, 80, 80 },
    UnlinkOffColor = true,
    Legend = "Connect",
    FontSize = 12,
    CornerRadius = 4
  }

  -- Status LED
  layout["Status"] = {
    PrettyName = "Connection~Status",
    Style = "Led",
    Position = { 290, 40 },
    Size = { 16, 16 },
    Color = { 0, 255, 0 },
    OffColor = { 100, 0, 0 },
    UnlinkOffColor = true
  }

  -- Status text
  table.insert(graphics, {
    Type = "Label",
    Text = "Status",
    Color = { 200, 200, 200 },
    FontSize = 10,
    Font = "Roboto",
    Position = { 315, 40 },
    Size = { 60, 16 }
  })

  -- Discover button
  layout["Discover"] = {
    PrettyName = "Connection~Discover Devices",
    Style = "Button",
    ButtonVisualStyle = "Flat",
    Position = { 200, 65 },
    Size = { 80, 24 },
    Color = { 0, 120, 200 },
    Legend = "Discover",
    FontSize = 11,
    CornerRadius = 4
  }

  -- Matrix Routing section
  table.insert(graphics, {
    Type = "GroupBox", 
    Text = "Matrix Routing",
    Fill = { 55, 55, 55 },
    Color = { 221, 221, 221 },
    StrokeColor = { 80, 80, 80 },
    StrokeWidth = 1,
    CornerRadius = 8,
    Font = "Roboto",
    FontSize = 11,
    Position = { 400, 10 },
    Size = { 380, 120 },
    ZOrder = -5
  })

  -- TX Selection
  table.insert(graphics, {
    Type = "Label",
    Text = "TX:",
    Color = { 200, 200, 200 },
    FontSize = 11,
    Font = "Roboto",
    HTextAlign = "Right",
    Position = { 410, 35 },
    Size = { 40, 24 }
  })

  layout["TX Selection"] = {
    PrettyName = "Matrix~TX Selection",
    Style = "Text",
    Position = { 455, 35 },
    Size = { 150, 24 },
    FontSize = 11,
    Color = { 255, 255, 255 },
    CornerRadius = 4
  }

  -- RX Selection
  table.insert(graphics, {
    Type = "Label",
    Text = "RX:",
    Color = { 200, 200, 200 },
    FontSize = 11,
    Font = "Roboto",
    HTextAlign = "Right",
    Position = { 410, 65 },
    Size = { 40, 24 }
  })

  layout["RX Selection"] = {
    PrettyName = "Matrix~RX Selection",
    Style = "Text",
    Position = { 455, 65 },
    Size = { 150, 24 },
    FontSize = 11,
    Color = { 255, 255, 255 },
    CornerRadius = 4
  }

  -- Route buttons
  layout["Route"] = {
    PrettyName = "Matrix~Route",
    Style = "Button",
    ButtonVisualStyle = "Flat",
    Position = { 620, 35 },
    Size = { 60, 24 },
    Color = { 0, 150, 50 },
    Legend = "Route",
    FontSize = 11,
    CornerRadius = 4
  }

  layout["Disconnect RX"] = {
    PrettyName = "Matrix~Disconnect",
    Style = "Button",
    ButtonVisualStyle = "Flat",
    Position = { 690, 35 },
    Size = { 80, 24 },
    Color = { 180, 50, 0 },
    Legend = "Disconnect",
    FontSize = 10,
    CornerRadius = 4
  }

  layout["Get Matrix"] = {
    PrettyName = "Matrix~Get Status",
    Style = "Button",
    ButtonVisualStyle = "Flat",
    Position = { 620, 65 },
    Size = { 80, 24 },
    Color = { 80, 120, 180 },
    Legend = "Get Status",
    FontSize = 10,
    CornerRadius = 4
  }

  -- System Info section
  table.insert(graphics, {
    Type = "GroupBox",
    Text = "System Information",
    Fill = { 55, 55, 55 },
    Color = { 221, 221, 221 },
    StrokeColor = { 80, 80, 80 },
    StrokeWidth = 1,
    CornerRadius = 8,
    Font = "Roboto",
    FontSize = 11,
    Position = { 10, 120 },
    Size = { 380, 80 },
    ZOrder = -5
  })

  layout["System Version"] = {
    PrettyName = "System~Version",
    Style = "Text",
    Position = { 20, 145 },
    Size = { 180, 24 },
    FontSize = 11,
    Color = { 200, 200, 200 }
  }

  layout["Device Count"] = {
    PrettyName = "System~Device Count",
    Style = "Text",
    Position = { 210, 145 },
    Size = { 80, 24 },
    FontSize = 11,
    Color = { 200, 200, 200 }
  }

  -- Matrix Status
  layout["Matrix Status"] = {
    PrettyName = "Matrix~Current Status",
    Style = "Text",
    Position = { 400, 140 },
    Size = { 380, 24 },
    FontSize = 10,
    Color = { 200, 200, 200 }
  }

elseif CurrentPage == "Video Walls" then
  -- Video Wall section header
  table.insert(graphics, {
    Type = "Header",
    Text = "Video Wall Management",
    Color = { 221, 221, 221 },
    Font = "Roboto",
    FontSize = 14,
    FontStyle = "Bold",
    Position = { 10, 20 },
    Size = { 380, 20 }
  })

  local vwCount = props["Video Wall Count"].Value
  for i = 1, vwCount do
    local yPos = 50 + (i - 1) * 110
    
    -- Video Wall group box
    table.insert(graphics, {
      Type = "GroupBox",
      Text = "Video Wall " .. i,
      Fill = { 55, 55, 55 },
      Color = { 221, 221, 221 },
      StrokeColor = { 80, 80, 80 },
      StrokeWidth = 1,
      CornerRadius = 8,
      Font = "Roboto",
      FontSize = 11,
      Position = { 10, yPos },
      Size = { 770, 100 },
      ZOrder = -5
    })

    -- VW Name
    table.insert(graphics, {
      Type = "Label",
      Text = "Name:",
      Color = { 200, 200, 200 },
      FontSize = 11,
      Font = "Roboto",
      HTextAlign = "Right",
      Position = { 20, yPos + 25 },
      Size = { 50, 24 }
    })

    layout["VW" .. i .. " Name"] = {
      PrettyName = string.format("Video Wall~VW %d Name", i),
      Style = "Text",
      Position = { 75, yPos + 25 },
      Size = { 100, 24 },
      FontSize = 11,
      Color = { 255, 255, 255 },
      CornerRadius = 4
    }

    -- Rows
    table.insert(graphics, {
      Type = "Label",
      Text = "Rows:",
      Color = { 200, 200, 200 },
      FontSize = 11,
      Font = "Roboto",
      HTextAlign = "Right",
      Position = { 185, yPos + 25 },
      Size = { 40, 24 }
    })

    layout["VW" .. i .. " Rows"] = {
      PrettyName = string.format("Video Wall~VW %d Rows", i),
      Style = "Text",
      Position = { 230, yPos + 25 },
      Size = { 40, 24 },
      FontSize = 11,
      Color = { 255, 255, 255 },
      CornerRadius = 4
    }

    -- Cols
    table.insert(graphics, {
      Type = "Label",
      Text = "Cols:",
      Color = { 200, 200, 200 },
      FontSize = 11,
      Font = "Roboto",
      HTextAlign = "Right",
      Position = { 280, yPos + 25 },
      Size = { 40, 24 }
    })

    layout["VW" .. i .. " Cols"] = {
      PrettyName = string.format("Video Wall~VW %d Cols", i),
      Style = "Text",
      Position = { 325, yPos + 25 },
      Size = { 40, 24 },
      FontSize = 11,
      Color = { 255, 255, 255 },
      CornerRadius = 4
    }

    -- TX
    table.insert(graphics, {
      Type = "Label",
      Text = "TX:",
      Color = { 200, 200, 200 },
      FontSize = 11,
      Font = "Roboto",
      HTextAlign = "Right",
      Position = { 375, yPos + 25 },
      Size = { 30, 24 }
    })

    layout["VW" .. i .. " TX"] = {
      PrettyName = string.format("Video Wall~VW %d TX", i),
      Style = "Text",
      Position = { 410, yPos + 25 },
      Size = { 120, 24 },
      FontSize = 11,
      Color = { 255, 255, 255 },
      CornerRadius = 4
    }

    -- Control buttons
    layout["VW" .. i .. " Create"] = {
      PrettyName = string.format("Video Wall~VW %d Create", i),
      Style = "Button",
      ButtonVisualStyle = "Flat",
      Position = { 550, yPos + 25 },
      Size = { 70, 24 },
      Color = { 0, 150, 50 },
      Legend = "Create",
      FontSize = 11,
      CornerRadius = 4
    }

    layout["VW" .. i .. " Remove"] = {
      PrettyName = string.format("Video Wall~VW %d Remove", i),
      Style = "Button",
      ButtonVisualStyle = "Flat",
      Position = { 630, yPos + 25 },
      Size = { 70, 24 },
      Color = { 180, 50, 0 },
      Legend = "Remove",
      FontSize = 11,
      CornerRadius = 4
    }
  end

elseif CurrentPage == "Scenes" then
  -- Scenes section header
  table.insert(graphics, {
    Type = "Header",
    Text = "Scene Management",
    Color = { 221, 221, 221 },
    Font = "Roboto",
    FontSize = 14,
    FontStyle = "Bold",
    Position = { 10, 20 },
    Size = { 380, 20 }
  })

  local sceneCount = props["Scene Count"].Value
  local cols = 4
  local rows = math.ceil(sceneCount / cols)
  
  for i = 1, sceneCount do
    local col = ((i - 1) % cols) + 1
    local row = math.ceil(i / cols)
    local xPos = 10 + (col - 1) * 190
    local yPos = 50 + (row - 1) * 80

    -- Scene group box
    table.insert(graphics, {
      Type = "GroupBox",
      Text = "Scene " .. i,
      Fill = { 55, 55, 55 },
      Color = { 221, 221, 221 },
      StrokeColor = { 80, 80, 80 },
      StrokeWidth = 1,
      CornerRadius = 8,
      Font = "Roboto",
      FontSize = 10,
      Position = { xPos, yPos },
      Size = { 180, 70 },
      ZOrder = -5
    })

    layout["Scene" .. i .. " Name"] = {
      PrettyName = string.format("Scenes~Scene %d Name", i),
      Style = "Text",
      Position = { xPos + 10, yPos + 25 },
      Size = { 160, 20 },
      FontSize = 10,
      Color = { 255, 255, 255 },
      CornerRadius = 4
    }

    layout["Scene" .. i .. " Recall"] = {
      PrettyName = string.format("Scenes~Scene %d Recall", i),
      Style = "Button",
      ButtonVisualStyle = "Flat",
      Position = { xPos + 55, yPos + 50 },
      Size = { 70, 20 },
      Color = { 80, 120, 180 },
      Legend = "Recall",
      FontSize = 10,
      CornerRadius = 4
    }
  end

elseif CurrentPage == "Devices" then
  -- Devices section header
  table.insert(graphics, {
    Type = "Header",
    Text = "Device Management",
    Color = { 221, 221, 221 },
    Font = "Roboto",
    FontSize = 14,
    FontStyle = "Bold",
    Position = { 10, 20 },
    Size = { 380, 20 }
  })

  local maxDevices = props["Max Devices"].Value
  for i = 1, maxDevices do
    local yPos = 50 + (i - 1) * 60
    
    -- Device group box (smaller height to fit more)
    table.insert(graphics, {
      Type = "GroupBox",
      Text = "Device " .. i,
      Fill = { 55, 55, 55 },
      Color = { 221, 221, 221 },
      StrokeColor = { 80, 80, 80 },
      StrokeWidth = 1,
      CornerRadius = 8,
      Font = "Roboto",
      FontSize = 10,
      Position = { 10, yPos },
      Size = { 770, 50 },
      ZOrder = -5
    })

    layout["Device" .. i .. " Name"] = {
      PrettyName = string.format("Devices~Device %d Name", i),
      Style = "Text",
      Position = { 20, yPos + 20 },
      Size = { 150, 20 },
      FontSize = 10,
      Color = { 200, 200, 200 }
    }

    layout["Device" .. i .. " Alias"] = {
      PrettyName = string.format("Devices~Device %d Alias", i),
      Style = "Text",
      Position = { 180, yPos + 20 },
      Size = { 120, 20 },
      FontSize = 10,
      Color = { 255, 255, 255 },
      CornerRadius = 4
    }

    layout["Device" .. i .. " Reboot"] = {
      PrettyName = string.format("Devices~Device %d Reboot", i),
      Style = "Button",
      ButtonVisualStyle = "Flat",
      Position = { 320, yPos + 18 },
      Size = { 60, 24 },
      Color = { 180, 120, 0 },
      Legend = "Reboot",
      FontSize = 9,
      CornerRadius = 4
    }

    layout["Device" .. i .. " Standby"] = {
      PrettyName = string.format("Devices~Device %d Standby", i),
      Style = "Button",
      ButtonVisualStyle = "Flat",
      Position = { 390, yPos + 18 },
      Size = { 60, 24 },
      Color = { 180, 50, 0 },
      Legend = "Standby",
      FontSize = 9,
      CornerRadius = 4
    }

    layout["Device" .. i .. " Wake"] = {
      PrettyName = string.format("Devices~Device %d Wake", i),
      Style = "Button",
      ButtonVisualStyle = "Flat",
      Position = { 460, yPos + 18 },
      Size = { 60, 24 },
      Color = { 0, 150, 50 },
      Legend = "Wake",
      FontSize = 9,
      CornerRadius = 4
    }
  end

elseif CurrentPage == "Setup" then
  -- Command section
  table.insert(graphics, {
    Type = "GroupBox",
    Text = "Custom Commands",
    Fill = { 55, 55, 55 },
    Color = { 221, 221, 221 },
    StrokeColor = { 80, 80, 80 },
    StrokeWidth = 1,
    CornerRadius = 8,
    Font = "Roboto",
    FontSize = 11,
    Position = { 10, 20 },
    Size = { 770, 100 },
    ZOrder = -5
  })

  layout["Custom Command"] = {
    PrettyName = "Commands~Custom Command",
    Style = "Text",
    Position = { 20, 45 },
    Size = { 400, 24 },
    FontSize = 11,
    Color = { 255, 255, 255 },
    CornerRadius = 4
  }

  layout["Send Command"] = {
    PrettyName = "Commands~Send",
    Style = "Button",
    ButtonVisualStyle = "Flat",
    Position = { 430, 45 },
    Size = { 80, 24 },
    Color = { 80, 120, 180 },
    Legend = "Send",
    FontSize = 11,
    CornerRadius = 4
  }

  layout["Last Response"] = {
    PrettyName = "Commands~Last Response",
    Style = "Text",
    Position = { 20, 85 },
    Size = { 740, 24 },
    FontSize = 10,
    Color = { 200, 200, 200 }
  }

end
