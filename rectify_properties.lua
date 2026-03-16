-- Hide debug property in production if needed
if props.plugin_show_debug and props.plugin_show_debug.Value == false then
  props["Debug Print"].IsHidden = true
end
