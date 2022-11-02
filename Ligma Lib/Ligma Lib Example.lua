-- example code provided by Unixian#4669, ui lib done by Liga#0001
-- this is very messy, don't use these same practices when actually using this lib.

local library = loadstring(syn.request({
    Method = "GET",
    Url = "https://wednesday.wtf/ars/library.lua"
  }).Body)()
  
  local window = library:new_window("liga ui lib", nil, nil)
  
  local main_tab = window:new_tab("main")
  local settings_tab = window:new_tab("settings")
  
  library:apply_settings(settings_tab)
  
  local label_group = main_tab:new_group("labels", false)
  local textbox_group = main_tab:new_group("textboxes", true)
  local checkbox_group = main_tab:new_group("checkboxes", false)
  local list_group = main_tab:new_group("lists", true)
  local slider_group = main_tab:new_group("sliders", false)
  local button_group = main_tab:new_group("buttons", true)
  
  
  label_group:new_label({
    text = "Example Label"
  })
  
  label_group:new_label({
    text = "Unsafe Label",
    unsafe = true
  })
  
  textbox_group:new_textbox("textbox_flag1", {
    text = "Example Textbox",
    callback = function(state)
      print("textbox 1: " .. tostring(state))
    end
  })
  
  textbox_group:new_textbox("textbox_flag2", {
    text = "Example Textbox w/ Default",
    default = "Default Text",
    callback = function(state)
      print("textbox 2: " .. tostring(state))
    end
  })
  
  
  checkbox_group:new_checkbox("checkbox_flag1", {
    text = "Example Checkbox",
    callback = function(state)
      print("checkbox 1: " .. tostring(state))
    end
  })
  
  checkbox_group:new_checkbox("checkbox_flag2",{
    text = "Example Checkbox w/ Default",
    default = true,
    callback = function(state)
      print("checkbox 2: " .. tostring(state))
    end
  })
  
  checkbox_group:new_checkbox("checkbox_flag3",{
    text = "Checkbox w/ Colorpicker",
    default = true,
    callback = function(state)
      print("checkbox 3: " .. tostring(state))
    end
  }):add_colorpicker("colorpicker_flag1", {
    text = "Example Colorpicker",
    default = {
      color = Color3.fromRGB(255, 0, 0),
      transparency = 0
    }
  })
  
  checkbox_group:new_checkbox("checkbox_flag4", {
    text = "Checkbox w/ Keybind",
    default = true,
    callback = function(state)
      print("checkbox 4: " .. tostring(state))
    end
  }):add_keybind("keybind_flag1", {
    text = "Example Keybind",
    default = Enum.KeyCode.RightShift,
    state = false,
    mode = "Toggle",
    callback = function(state)
      print("keybind 1: " .. tostring(state))
    end
  })
  
  checkbox_group:new_checkbox("checkbox_flag3",{
    text = "Unsafe Checkbox",
    unsafe = true,
    callback = function(state)
      print("checkbox 3: " .. tostring(state))
    end
  })
  
  list_group:new_list("list_flag1", {
    text = "Example List",
    values = {"Option 1", "Option 2", "Option 3"},
    callback = function(state)
      print("list 1: " .. tostring(state))
    end
  })
  
  list_group:new_list("list_flag2", {
    text = "Example List w/ Default",
    values = {"Option 1", "Option 2", "Option 3"},
    default = "Option 2",
    callback = function(state)
      print("list 2: " .. tostring(state))
    end
  })
  
  list_group:new_list("list_flag4", {
    text = "Multi List",
    values = {"Option 1", "Option 2", "Option 3"},
    multi = true,
    default = {"Option 1", "Option 3"},
    callback = function(state)
      table.foreach(state, print)
    end
  })
  
  slider_group:new_slider("slider_flag1", {
    text = "Example Slider",
    min = 0,
    max = 100,
    default = 50,
    decimals = 0,
    callback = function(state)
      print("slider 1: " .. tostring(state))
    end
  })
  
  slider_group:new_slider("slider_flag2", {
    text = "Example Slider w/ Suffix",
    min = 0,
    max = 100,
    default = 50,
    decimals = 0,
    suffix = " units",
    callback = function(state)
      print("slider 2: " .. tostring(state))
    end
  })
  
  button_group:new_button({
    text = "Example Button",
    callback = function()
      print("button 1 pressed")
    end
  })
  