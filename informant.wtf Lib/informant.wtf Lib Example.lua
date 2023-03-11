-- Credits To The Original Devs @xz, @goof
getgenv().Config = {
	Invite = "informant.wtf",
	Version = "0.0",
}

getgenv().luaguardvars = {
	DiscordName = "gzz#2600",
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Other/main/Lmao.lua"))()

library:init() -- Initalizes Library Do Not Delete This

local Window = library.NewWindow({
	title = "Informant.Wtf",
	size = UDim2.new(0, 525, 0, 650)
})

local tabs = {
    Tab1 = Window:AddTab("Tab1"),
	Settings = library:CreateSettingsTab(Window),
}

-- 1 = Set Section Box To The Left
-- 2 = Set Section Box To The Right

local sections = {
	Section1 = tabs.Tab1:AddSection("Section1", 1),
	Section2 = tabs.Tab1:AddSection("Section2", 2),
}

sections.Section1:AddToggle({
	enabled = true,
	text = "Toggle1",
	flag = "Toggle_1",
	tooltip = "Tooltip1",
	risky = true, -- turns text to red and sets label to risky
	callback = function(lol)
	    print("Toggle Is Now Set To : ".. lol)
	end
})

sections.Section1:AddButton({
	enabled = true,
	text = "Button1",
	flag = "Button_1",
	tooltip = "Tooltip1",
	risky = false,
	confirm = false, -- shows confirm button
	callback = function(v)
	    print(v)
	end
})

sections.Section1:AddSeparator({
	text = "Separator"
})

sections.Section1:AddSlider({
	text = "Slider", 
	flag = 'Slider_1', 
	suffix = "", 
	value = 0.000,
	min = 0.1, 
	max = 0.999,
	increment = 0.001,
	tooltip = "Tooltip1",
	risky = false,
	callback = function(v) 
		print("Slider Value Is Now : ".. v)
	end
})

sections.Section1:AddBind({
	text = "Keybind",
	flag = "Key_1",
	nomouse = true,
	noindicator = true,
	tooltip = "Tooltip1",
	mode = "toggle",
	bind = Enum.KeyCode.Q,
	risky = false,
	keycallback = function(v)
	    print("Keybind Changed!")
	end
})

sections.Section1:AddList({
	enabled = true,
	text = "List",
	flag = "List_1",
	multi = false,
	tooltip = "Tooltip1",
    risky = false,
    dragging = false,
    focused = false,
	value = "1",
	values = {
		"1",
		"2",
		"3"
	},
	callback = function(v)
	    print("List Value Is Now : "..v)
	end
})

sections.Section1:AddBox({
    enabled = true,
    focused = true,
    text = "TextBox1",
    input = "PlaceHolder1",
	flag = "Text_1",
	risky = false,
	callback = function(v)
	    print(v)
	end
})

sections.Section1:AddText({
    enabled = true,
    text = "Text1",
    flag = "Text_1",
    risky = false,
})

sections.Section1:AddColor({
    enabled = true,
    text = "ColorPicker1",
    flag = "Color_1",
    tooltip = "ToolTip1",
    color = Color3.new(255, 255, 255),
    trans = 0,
    open = false,
    callback = function()
        
    end
})

library:SendNotification("Notification", 5, Color3.new(255, 0, 0))

--Window:SetOpen(true) -- Either Close Or Open Window