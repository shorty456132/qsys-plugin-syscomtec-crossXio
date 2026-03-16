table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = { "None", "Tx/Rx", "Tx", "Rx", "All" },
  Value = "Tx/Rx"
})

table.insert(props, {
  Name = "Poll Rate",
  Type = "integer",
  Min = 5,
  Max = 60,
  Value = 10
})

table.insert(props, {
  Name = "Max Devices",
  Type = "integer",
  Min = 8,
  Max = 64,
  Value = 16
})

table.insert(props, {
  Name = "Video Wall Count",
  Type = "integer",
  Min = 1,
  Max = 8,
  Value = 4
})

table.insert(props, {
  Name = "Scene Count",
  Type = "integer",
  Min = 1,
  Max = 32,
  Value = 16
})
