local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua"))()

local watermark = library:Watermark("watermark | 60 fps | v4.20 | dev")
-- watermark:Set("Watermark Set")
-- watermark:Hide() -- toggles watermark

local main = library:Load{
    Name = "vozoid hax or something",
    SizeX = 600,
    SizeY = 650,
    Theme = "Midnight",
    Extension = "json", -- config file extension
    Folder = "vozoid ui or something" -- config folder name
}

-- library.Extension = "txt" (config file extension)
-- library.Folder = "config folder name"

local tab = main:Tab("Tab")

local section = tab:Section{
    Name = "Section",
    Side = "Left"
}

local label = section:Label("Label")

--label:Set("Label Set")

section:Button{
    Name = "Destroy UI",
    Callback  = function()
        library:Unload()
    end
}

section:Button{
    Name = "Button",
    Callback  = function()
        print("Button clicked")
    end
}

local seperator = section:Separator("Separator")
--separator:Set("Separator Set")

local toggle = section:Toggle{
    Name = "Toggle",
    Flag = "Toggle 1",
    --Default = true,
    Callback  = function(bool)
        print("Toggle 1 is now " .. (bool and "enabled" or "disabled"))
    end
}

local togglepicker1 = toggle:ColorPicker{
    Default = Color3.fromRGB(255, 0, 0), 
    Flag = "Toggle 1 Picker 1", 
    Callback = function(color)
        print("Toggle 1 Picker 1 is now " .. string.format("%s, %s, %s, %s", math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255), math.floor(color.A * 100) / 100))
    end
}

--togglepicker1:Set(Color3.fromRGB(255, 255, 255))

local togglepicker2 = toggle:ColorPicker{
    Default = Color3.fromRGB(0, 255, 0), 
    Flag = "Toggle 1 Picker 2", 
    Callback = function(color)
        print("Toggle 1 Picker 2 is now " .. string.format("%s, %s, %s, %s", math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255), math.floor(color.A * 100) / 100))
    end
}

--togglepicker2:Set(Color3.fromRGB(255, 255, 255))

--toggle:Toggle(true)

local toggle2 = section:Toggle{
    Name = "Toggle 2",
    Flag = "Toggle 2",
    --Default = true,
    Callback  = function(bool)
        print("Toggle 2 is now " .. (bool and "enabled" or "disabled"))
    end
}

toggle2:Keybind{
    --Default = Enum.KeyCode.A,
    Blacklist = {Enum.UserInputType.MouseButton1},
    Flag = "Toggle 2 Keybind 1",
    Mode = "Toggle", -- mode to nil if u dont want it to toggle the toggle
    Callback = function(key, fromsetting)
        if fromsetting then
            print("Toggle 2 Keybind 1 is now " .. tostring(key))
        else
            print("Toggle 2 Keybind 1 was pressed")
        end
    end
}

local toggle3 = section:Toggle{
    Name = "Toggle 3",
    Flag = "Toggle 3",
    --Default = true,
    Callback  = function(bool)
        print("Toggle 3 is now " .. (bool and "enabled" or "disabled"))
    end
}

toggle3:Slider{
    Text = "[value]/5",
    --Default = 5,
    Min = 0,
    Max = 5,
    Float = 0.5,
    Flag = "Slider 1",
    Callback = function(value)
        print("Toggle 3 Slider 1 is now " .. value)
    end
}

local toggle4 = section:Toggle{
    Name = "Toggle 4",
    Flag = "Toggle 4",
    --Default = true,
    Callback  = function(bool)
        print("Toggle 4 is now " .. (bool and "enabled" or "disabled"))
    end
}

toggle4:Dropdown{
    --Default = "Option 1",
    Content = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    --Max = 5, -- turns into multidropdown
    --Scrollable = true, -- makes it scrollable
    --ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(option)
        print("Dropdown 1 is now " .. tostring(option))
    end
}


local box = section:Box{
    Name = "Box",
    --Default = "hi",
    Placeholder = "Box Placeholder",
    Flag = "Box 1",
    Callback = function(text)
        print("Box 1 is now " .. text)
    end
}

--box:Set("New box text")

local slider = section:Slider{
    Name = "Slider",
    Text = "[value]/1",
    --Default = 0.1,
    Min = 0,
    Max = 1,
    Float = 0.1,
    Flag = "Slider 1",
    Callback = function(value)
        print("Slider 1 is now " .. value)
    end
}

--slider:Set(1)

local dropdown = section:Dropdown{
    Name = "Dropdown",
    --Default = "Option 1",
    Content = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Flag = "Dropdown 1",
    Callback = function(option)
        print("Dropdown 1 is now " .. tostring(option))
    end
}


dropdown:Set() -- using this without any args or with wrong args will unset the dropdown
--dropdown:Set("option 6") wont work and will unset

dropdown:Refresh{
    "Refreshed option 1",
    "Refreshed option 2",
    "Refreshed option 3"
}

dropdown:Set("Refreshed option 1")

dropdown:Add("Option 4")

dropdown:Remove("Option 4")

local multidropdown = section:Dropdown{
    Name = "Multi dropdown",
    --Default = {"Option 1"},
    Max = 3, -- makes it multi
    Content = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Flag = "Multi dropdown 1",
    Callback = function(option)
        print("Multi dropdown 1 is now " .. table.concat(option, ", "))
    end
}

multidropdown:Set() -- using this without any args or with wrong args will unset the dropdown
multidropdown:Set{} -- using this without any args or with wrong args will unset the dropdown
--multidropdown:Set{"option 12321313"} wont work and will unset
--multidropdown:Set("hello") wont work and will unset

multidropdown:Refresh{
    "Refreshed option 1",
    "Refreshed option 2",
    "Refreshed option 3",
    "Refreshed option 4"
}

multidropdown:Set{
    "Refreshed option 1",
    "Refreshed option 2"
}

multidropdown:Add("Option 5")

multidropdown:Remove("Option 5")

local dropdown = section:Dropdown{
    Name = "Scrolling Dropdown",
    --Default = "Option 1",
    Scrollable = true,
    ScrollingMax = 5,
    Content = {
        "Option 1",
        "Option 2",
        "Option 3",
        "Option 4",
        "Option 5",
        "Option 6",
        "Option 7"
    },
    Flag = "Scrolling Dropdown 1",
    Callback = function(option)
        print("Scrolling Dropdown 1 is now " .. tostring(option))
    end
}

local colorpicker = section:ColorPicker{
    Name = "Color picker",
    Default = Color3.fromRGB(0, 255, 0),
    Flag = "Color picker 1",
    Callback = function(color)
        print("Color picker 1 is now: " .. string.format("%s, %s, %s, %s", math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255), math.floor(color.A * 100) / 100))
    end
}

--colorpicker:Set(Color3.fromRGB(255, 255, 255))

local colorpickerpicker1 = colorpicker:ColorPicker{
    Default = Color3.fromRGB(0, 255, 255),
    DefaultAlpha = 0.5,
    Flag = "Color picker picker 1",
    Callback = function(color)
        print("Color picker 1 picker 1 is now: " .. string.format("%s, %s, %s, %s", math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255), math.floor(color.A * 100) / 100))
    end
}

--colorpickerpicker1:Set(Color3.fromRGB(255, 255, 255))

local colorpickerpicker2 = colorpicker:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255),
    Flag = "Color picker picker 2",
    Callback = function(color)
        print("Color picker 1 picker 2 is now " .. string.format("%s, %s, %s, %s", math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255), math.floor(color.A * 100) / 100))
    end
}

--colorpickerpicker2:Set(Color3.fromRGB(255, 255, 255))

local keybind = section:Keybind{
    Name = "Keybind",
    --Default = Enum.KeyCode.A,
    --Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2},
    Flag = "Keybind 1",
    Callback = function(key, fromsetting)
        if fromsetting then
            print("Keybind 1 is now " .. tostring(key))
        else
            print("Keybind 1 was pressed")
        end
    end
}


--library:SaveConfig("config", true) -- universal config
--library:SaveConfig("config") -- game specific config
--library:DeleteConfig("config", true) -- universal config
--library:DeleteConfig("config") -- game specific config
--library:GetConfigs(true) -- return universal and game specific configs (table)
--library:GetConfigs() -- return game specific configs (table)
--library:LoadConfig("config", true) -- load universal config
--library:LoadConfig("config") -- load game specific config

local configs = main:Tab("Configuration")

local themes = configs:Section{Name = "Theme", Side = "Left"}

local themepickers = {}

local themelist = themes:Dropdown{
    Name = "Theme",
    Default = library.currenttheme,
    Content = library:GetThemes(),
    Flag = "Theme Dropdown",
    Callback = function(option)
        if option then
            library:SetTheme(option)

            for option, picker in next, themepickers do
                picker:Set(library.theme[option])
            end
        end
    end
}

library:ConfigIgnore("Theme Dropdown")

local namebox = themes:Box{
    Name = "Custom Theme Name",
    Placeholder = "Custom Theme",
    Flag = "Custom Theme"
}

library:ConfigIgnore("Custom Theme")

themes:Button{
    Name = "Save Custom Theme",
    Callback = function()
        if library:SaveCustomTheme(library.flags["Custom Theme"]) then
            themelist:Refresh(library:GetThemes())
            themelist:Set(library.flags["Custom Theme"])
            namebox:Set("")
        end
    end
}

local customtheme = configs:Section{Name = "Custom Theme", Side = "Right"}

themepickers["Accent"] = customtheme:ColorPicker{
    Name = "Accent",
    Default = library.theme["Accent"],
    Flag = "Accent",
    Callback = function(color)
        library:ChangeThemeOption("Accent", color)
    end
}

library:ConfigIgnore("Accent")

themepickers["Window Background"] = customtheme:ColorPicker{
    Name = "Window Background",
    Default = library.theme["Window Background"],
    Flag = "Window Background",
    Callback = function(color)
        library:ChangeThemeOption("Window Background", color)
    end
}

library:ConfigIgnore("Window Background")

themepickers["Window Border"] = customtheme:ColorPicker{
    Name = "Window Border",
    Default = library.theme["Window Border"],
    Flag = "Window Border",
    Callback = function(color)
        library:ChangeThemeOption("Window Border", color)
    end
}

library:ConfigIgnore("Window Border")

themepickers["Tab Background"] = customtheme:ColorPicker{
    Name = "Tab Background",
    Default = library.theme["Tab Background"],
    Flag = "Tab Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Background", color)
    end
}

library:ConfigIgnore("Tab Background")

themepickers["Tab Border"] = customtheme:ColorPicker{
    Name = "Tab Border",
    Default = library.theme["Tab Border"],
    Flag = "Tab Border",
    Callback = function(color)
        library:ChangeThemeOption("Tab Border", color)
    end
}

library:ConfigIgnore("Tab Border")

themepickers["Tab Toggle Background"] = customtheme:ColorPicker{
    Name = "Tab Toggle Background",
    Default = library.theme["Tab Toggle Background"],
    Flag = "Tab Toggle Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Toggle Background", color)
    end
}

library:ConfigIgnore("Tab Toggle Background")

themepickers["Section Background"] = customtheme:ColorPicker{
    Name = "Section Background",
    Default = library.theme["Section Background"],
    Flag = "Section Background",
    Callback = function(color)
        library:ChangeThemeOption("Section Background", color)
    end
}

library:ConfigIgnore("Section Background")

themepickers["Section Border"] = customtheme:ColorPicker{
    Name = "Section Border",
    Default = library.theme["Section Border"],
    Flag = "Section Border",
    Callback = function(color)
        library:ChangeThemeOption("Section Border", color)
    end
}

library:ConfigIgnore("Section Border")

themepickers["Text"] = customtheme:ColorPicker{
    Name = "Text",
    Default = library.theme["Text"],
    Flag = "Text",
    Callback = function(color)
        library:ChangeThemeOption("Text", color)
    end
}

library:ConfigIgnore("Text")

themepickers["Disabled Text"] = customtheme:ColorPicker{
    Name = "Disabled Text",
    Default = library.theme["Disabled Text"],
    Flag = "Disabled Text",
    Callback = function(color)
        library:ChangeThemeOption("Disabled Text", color)
    end
}

library:ConfigIgnore("Disabled Text")

themepickers["Object Background"] = customtheme:ColorPicker{
    Name = "Object Background",
    Default = library.theme["Object Background"],
    Flag = "Object Background",
    Callback = function(color)
        library:ChangeThemeOption("Object Background", color)
    end
}

library:ConfigIgnore("Object Background")

themepickers["Object Border"] = customtheme:ColorPicker{
    Name = "Object Border",
    Default = library.theme["Object Border"],
    Flag = "Object Border",
    Callback = function(color)
        library:ChangeThemeOption("Object Border", color)
    end
}

library:ConfigIgnore("Object Border")

themepickers["Dropdown Option Background"] = customtheme:ColorPicker{
    Name = "Dropdown Option Background",
    Default = library.theme["Dropdown Option Background"],
    Flag = "Dropdown Option Background",
    Callback = function(color)
        library:ChangeThemeOption("Dropdown Option Background", color)
    end
}

library:ConfigIgnore("Dropdown Option Background")

local configsection = configs:Section{Name = "Configs", Side = "Left"}

local configlist = configsection:Dropdown{
    Name = "Configs",
    Content = library:GetConfigs(), -- GetConfigs(true) if you want universal configs
    Flag = "Config Dropdown"
}

library:ConfigIgnore("Config Dropdown")

local loadconfig = configsection:Button{
    Name = "Load Config",
    Callback = function()
        library:LoadConfig(library.flags["Config Dropdown"]) -- LoadConfig(library.flags["Config Dropdown"], true)  if you want universal configs
    end
}

local delconfig = configsection:Button{
    Name = "Delete Config",
    Callback = function()
        library:DeleteConfig(library.flags["Config Dropdown"]) -- DeleteConfig(library.flags["Config Dropdown"], true)  if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}


local configbox = configsection:Box{
    Name = "Config Name",
    Placeholder = "Config Name",
    Flag = "Config Name"
}

library:ConfigIgnore("Config Name")

local save = configsection:Button{
    Name = "Save Config",
    Callback = function()
        library:SaveConfig(library.flags["Config Dropdown"] or library.flags["Config Name"]) -- SaveConfig(library.flags["Config Name"], true) if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}

local keybindsection = configs:Section{Name = "UI Toggle Keybind", Side = "Left"}

keybindsection:Keybind{
    Name = "UI Toggle",
    Flag = "UI Toggle",
    Default = Enum.KeyCode.Insert,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Close()
        end
    end
}

keybindsection:Keybind{
    Name = "Destroy UI",
    Flag = "Unload UI",
    Default = Enum.KeyCode.Delete,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Unload()
        end
    end
}


local scrolling = main:Tab("Scrolling Columns")

for i = 1, 20 do
    local sec = scrolling:Section{
        Name = tostring(math.random(2000, 20000000)),
        Side = math.random(1, 2) == 1 and "Left" or "Right"
    }

    for i = 1, math.random(3, 10) do
        if math.random(1, 2) == 1 then
            sec:Label(tostring(math.random(2000, 20000000)))
        else
            sec:Button{Name = tostring(math.random(2000, 20000000))}
        end
    end
end

--library:Close()
--library:Unload()