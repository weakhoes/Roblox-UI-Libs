Hello, and welcome to this documentation document! This will briefly cover all the necessary steps, you need to create a nice UI. :)
The main variable you will be using is called ("library").

Function Map:
library: {
	AddWindow(<string> title, <table> options [optional])
	-> {
		AddTab(<string> title)
		-> {
			AddLabel(<string> text)
			AddButton(<string> title, <function> callback)
			AddTextBox(<string> title, <function> callback, <table> options [clear = true]) -- callback args: <string> text
			AddSwitch(<string> title, <function> callback) -- callback args: <boolean> statement
			-> {
				Set(<boolean> statement)
			}
			AddSlider(<string> title, <function> callback, <table> options [min = 0, max = 100, readonly = false]) -- callback args: <number> number selected
			-> {
				Set(<number> number)
			}
			AddKeybind(<string> title, <function> callback, <table> options [standard = Enum.KeyCode.RightShift])
			-> {
				SetKeybind(<Enum> keycode object)
			}
			AddDropdown(<string> title, <function> callback) -- callback args: <string> selected object name
			-> {
				Add(<string> title) -- adds object with ("title") to the dropdown list
				-> {
					Remove() -- removes the object from the dropdown list
				}
			}
			AddColorPicker(<function> callback) -- callback args: <Color3> color selected
			-> {
				Set(<Color3> color)
			}
			AddConsole(<table> options [y = 200 (height of the console), full = false (fills out entire tab), source = "Lua" (or "Logs"), readonly = true])
			-> {
				Get() -- returns input
				Set(<string> input) -- sets input
				Log(<string> message) -- adds a message to the console
			}
			AddHorizontalAlignment() -- creates empty ui-element, will align elements horizontally (buttons only)
			-> {
				AddButton(...) -- same as other AddButton, except it will be placed horizontally
			}
			AddFolder(<string> title)
			-> {
				-- returns the same as AddTab, except functions used from this return will be added into the folder.
			}

			Show() -- function to open tab
		}
	}

	FormatWindows() -- will place the current windows nicely. this function is recommended to use after UI setup.
}

To create a new window, simply use the following function:
local window = library:AddWindow(<string> title, <table> options) -- Keep in mind that the options argument is not necessary, if you just leave it nil, it will use the default ui_options table, which is located at the top.

Notice how I assign the window to a variable ("window"). This is because the function returns a table consisting of more functions, which you can use on this window.

To add a tab to our window, we can use the following function:
local tab = window:AddTab()
This function will also return a table with functions.
To make this tab *show* as first thing, we will add this:
tab:Show()

Now we can begin adding stuff to this tab!

[Examples]:
AddLabel:
```
tab:AddLabel("Hello World!")
```

AddButton:
```
tab:AddButton("Give ...", function()
	print("Gave ... !")
end)
```

AddTextBox:
```
tab:AddTextBox("Teleport to Player", function(text)
	teleport_to(game:GetService("Players"):FindFirstChild("text") or game:GetService("Players").LocalPlayer)
end)
```

AddSwitch:
```
local switch = tab:AddSwitch("God Mode", function(bool)
	toggle_god_mode(bool)
end)
switch:Set(true)
```

AddSlider:
```
local slider = tab:AddSlider("WalkSpeed", function(p)
	setwalkspeed(p)
end, {
	["min"] = 16,
	["max"] = 100,
})
slider:Set(16)
```

AddKeybind:
```
local keybind = tab:AddKeybind("Toggle", function(obj)
	ui_options.toggle_key = obj
end, {
	["standard"] = Enum.KeyCode.RightShift,
})
```

AddDropdown:
```
local dropdown = tab:AddDropdown("Teleport to Location", function(text)
	if text == "Mars" then
		teleport(CFrame.new(...))
	elseif ...
	end
end)
local mars = dropdown:Add("Mars")
local earth = dropdown:Add("Earth")
local not_a_planet = dropdown:Add("Iridocyclitis")
not_a_planet:Remove()
```

AddColorPicker:
```
tab:AddLabel("Theme color")
local cp = tab:AddColorPicker(function(color)
	ui_options.main_color = color
end)
```

AddFolder:
```
local folder = tab:AddFolder()
folder:AddSwitch()
folder:AddLabel("Woo! I'm inside a folder!")

local folder2 = folder:AddFolder()
folder2:AddLabel("I'm inside *two* folders :smirk:")
```

[Adding Options]:
The only two element-functions taking options right now is "AddSlider" and "AddTextBox".
To set options, simply add a table as the last argument, like this:
```
tab:AddSlider("WalkSpeed", function(x)
	setwalkspeed(x)
end, {
	["min"] = 16, -- default : 0
	["max"] = 100, -- default : 100
})
```

Now for AddTextBox example:
```
tab:AddTextBox("Epic", function(text)
	print("TextBox : " .. text)
end, {
	["clear"] = false, -- default : true
})
```

AddConsole example:
```
tab:AddConsole({
	["y"] = 210,
	["readonly"] = false,
	["source"] = "Lua",
})
```