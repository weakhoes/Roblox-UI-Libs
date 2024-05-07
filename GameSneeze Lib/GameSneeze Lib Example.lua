local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/matas3535/gamesneeze/main/Library.lua"))()

local Window = Library:New({
    Name = "Title", -- name, Name, title, Title
})

--[[
    Window:SetName("string"),
	Window:GetConfig(),
	Window:LoadConfig("string"),
	Window:Move("vector2"),
	Window:CloseContent(),
	Window:IsOverContent(),
	Window:Unload(),
	Window:Fade(),
]]

local Page = Window:Page({
    Name = "Page" -- name, Name, title, Title
})

local PlayerPage = Window:Page({
    Name = "Players"
})

--[[
    Page:GetTotalYSize("string"),
	Page:Update(),
	Page:Show()
]]

local PageSection1 = Page:Section({
    Name = "Section", -- name, Name, title, Title
    Fill = true,
    Side = "Left"
})

--[[
    Section:Update("number")
]]

local PageMultiSection, pms1, pms2 = Page:MultiSection({
    Sections = {"1", "2", "3"},
    Side = "Right"
})

--[[
    (section, Sections) = "table", -- { "strings" }
	(size, Size) = "number",
	(fill, Fill) = "boolean",
	(side, Side) = "string",
	(callback, Callback, callBack, CallBack) = "function"
]]

local Label = PageSection1:Label({
    Name = "Label", -- name, Name, title, Title
    Center = true
})

local TextBox = PageSection1:TextBox({
    Default = "TextBox", 
    Placeholder =  "Type Here...", 
    Max = 100,
    Reactive = true,
    Callback = function(value) 
        print(value)
    end
})

--[[
    TextBox:Get(),
	TextBox:Set("string")
]]

local Toggle1 = PageSection1:Toggle({
    Name = "Toggle", -- name, Name, title, Title
    --Default = false,
    callback = function(value)
        print(value)
    end
})

--[[
    Toggle:Get(),
	Toggle:Set("boolean"),
	Toggle:Colorpicker("table"), -- (Window:Colorpicker Derivative),
	Toggle:Keybind("table"), -- (Window:Keybind Derivative)
]]

local KeyBindToggle1 = PageSection1:Toggle({
    Name = "KeyBindToggle", -- name, Name, title, Title
    --Default = false,
    callback = function(value)
        print(value)
    end
}):Keybind({
    Name = "KeybindToggle", -- name, Name, title, Title
    Default = Enum.KeyCode.X, 
    KeybindName = "KeybindToggle", 
    Mode = "Toggle", 
    Callback = function(Input, State) 
        print(Input, State) 
    end
})

--[[
    Keybind:Get(),
	Keybind:Set("table"),
	Keybind:Shorten("string"),
	Keybind:Change("input"),
	Keybind:Active(),
	Keybind:Reset()
]]

local Keybind1 = PageSection1:Keybind({
    Name = "Keybind", -- name, Name, title, Title
    Default = Enum.KeyCode.X, 
    KeybindName = "Keybind", 
    Mode = "Toggle", 
    Callback = function(Input, State) 
        print(Input, State) 
    end
})

--[[
    Keybind:Get(),
	Keybind:Set("table"),
	Keybind:Shorten("string"),
	Keybind:Change("input"),
	Keybind:Active(),
	Keybind:Reset()
]]


local Button1 = PageSection1:Button({
    Name = "Button", -- name, Name, title, Title
    callback = function(value)
        print(value)
    end
})

local Slider1 = PageSection1:Slider({
    Name = "Slider", -- name, Name, title, Title
    Min = 1, -- def, Def, default, Default
    Max = 100, -- min, Min, minimum, Minimum
    Default = 1, -- max, Max, maximum, Maximum
    --Suffix = "ms", -- suffix, Suffix, ending, Ending, prefix, Prefix, measurement, Measurement
    --decimals = 0.01,
    --Disabled = false, -- disable, Disable, disabled, Disabled
    callback = function(value)
        print(value)
    end
})

--[[
    Slider:Get(),
	Slider:Set("number"),
	Slider:Refresh()
]]

local MultiBox = PageSection1:Multibox({
    Name = "MultiBox", 
    Default = {"1", "2"}, 
    Options = {"1", "2", "3", "4", "5", "6", "7", "8"}, 
    Min = 2, 
    Max = 5, 
    callback = function(value) 
        print(value) 
    end
})

--[[
    Multibox:Get(),
	Multibox:Set("string"),
	Multibox:Update()
]]

local DropDown = PageSection1:Dropdown({
    Name = "DropDown", -- name, Name, title, Title
    Default = "1",
    Max = "3",
    Options = {"1", "2", "3"},
    callback = function(value)
        print(value)
    end
})

--[[
    Dropdown:Get(),
	Dropdown:Set("string"),
	Dropdown:Update()
]]

local ColorPicker1 = PageSection1:Colorpicker({
    Name = "ColorPicker", -- name, Name, title, Title
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.25,
    Info = "Color",
    callback = function(value)
        print(value)
    end
})

--[[
    Colorpicker:Get(),
	Colorpicker:Set("table"),
	Colorpicker:Refresh(),
	Colorpicker:Colorpicker() -- (Window:Colorpicker Derivative)
]]

local Label = PageSection1:Label({
    Name = "ListBox", -- name, Name, title, Title
    Center = true
})

local List1 = PageSection1:List({
    Name = "List", -- name, Name, title, Title
    Default = 1,
    Max = 5,
    Options = {"1", "2", "3", "4", "5"}
})

--[[
    List:Get(),
	List:Set("table"),
	List:Refresh(),
	List:UpdateScroll()
]]



local PlayerList = PlayerPage:PlayerList({})

--[[
    PlayerList:GetSelection(),
	PlayerList:UpdateScroll(),
	PlayerList:Refresh("table"),
	PlayerList:Update()
]]

Window:Initialize() -- DO NOT REMOVE
