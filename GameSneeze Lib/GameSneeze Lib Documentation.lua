Library Load Return = Library, Utility, Flags, Theme

Library:(New, Loader)(Properties)
	Properties = {
		(name, Name, title, Title) = "string",
		(size, Size) = "vector2",
		(accent, Accent, color, Color) = "color3",
		(callback, Callback, callBack, CallBack) = "function",
		(style, Style) = "number", -- UI Styles (1, 2)
		(PageAmmount) = "number" -- Only use if UI Style is 1
	}
	Functions = {
		Window:SetName("string"),
		Window:GetConfig(),
		Window:LoadConfig("string"),
		Window:Move("vector2"),
		Window:CloseContent(),
		Window:IsOverContent(),
		Window:Unload(),
		Window:Fade(),
		Window:Initialize() -- Call at the end of UI load.
	},
	Example = [[
		local Window = Library:New({Name = "Title here", Style = 1, PageAmmount = 7, Size = Vector2.new(554, 629)})
	]]
	Return = Window

	{

		Window:Page(Properties)
			Properties = {
				(name, Name, title, Title) = "string"
			},
			Functions = {
				Page:GetTotalYSize("string"),
				Page:Update(),
				Page:Show()
			},
			Example = [[
				local Page = Window:Page({Name = "Page Name Here"})
			]]
			Return = Page

	}

		{

			Pages:Section(Properties)
				Properties = {
					(name, Name, title, Title) = "string",
					(size, Size) = "number",
					(fill, Fill) = "boolean",
					(side, Side) = "string"
				},
				Functions = {
					Section:Update("number")
				},
				Example = [[
					local Section = Page:Section({Name = "Section Name Here", Fill = true, Side = "Right"})
				]]
				Return = Section

			Pages:MultiSection(Properties)
				Properties = {
					(section, Sections) = "table", -- { "strings" }
					(size, Size) = "number",
					(fill, Fill) = "boolean",
					(side, Side) = "string",
					(callback, Callback, callBack, CallBack) = "function"
				},
				Functions = {
					Section:Update("number")
				},
				Example = [[
					local Main, Extra, Yes = Page:Section({Sections = {"Main", "Extra", "Yes"}, Fill = true, Side = "Right"})
				]]
				Return = Sections...

			Pages:PlayerList(Properties)
				Properties = { },
				Functions = {
					PlayerList:GetSelection(),
					PlayerList:UpdateScroll(),
					PlayerList:Refresh("table"),
					PlayerList:Update()
				},
				Example = [[
					local PlayerList = Page:PlayerList({})
				]]
				Return = PlayerList

		}

			{

				Sections:Label(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(middle, Middle, center, Center) = "boolean",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = { },
					Example = [[
						local Label = Section:Label({Name = "Label Name Here", Center = true, Flag = "Section_Label"})
					]]
					Return = Label

				Sections:Toggle(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "boolean",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						Toggle:Get(),
						Toggle:Set("boolean"),
						Toggle:Colorpicker("table"), -- (Window:Colorpicker Derivative),
						Toggle:Keybind("table"), -- (Window:Keybind Derivative)
					},
					Example = [[
						local Toggle = Section:Toggle({Name = "Toggle Here", Default = true, Callback = function(State) print(State) end, Flag = "Section_Toggle"})
					]]
					Return = Toggle

				Sections:Slider(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "number",
						(min, Min, minimum, Minimum) = "number",
						(max, Max, maximum, Maximum) = "number",
						(maximumtext, Maximumtext, maxiumText, MaximumText) = "string",
						(suffix, Suffix, ending, Ending, prefix, Prefix, measurement, Measurement) = "string",
						(disable, Disable, disabled, Disabled) = "boolean",
						(decimals, Decimals) = "number",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						Slider:Get(),
						Slider:Set("number"),
						Slider:Refresh()
					},
					Example = [[
						local Slider = Section:Slider({Name = "Toggle Here", Default = true, Callback = function(State) print(State) end, Flag = "Section_Toggle"})
					]]
					Return = Slider

				Sections:Button(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = { },
					Example = [[
						local Button = Section:Button({Name = "Button Name Here", Callback = function(State) print(State) end, Flag = "Section_Button"})
					]]
					Return = Button

				Sections:TextBox(Properties)
					Properties = {
						(def, Def, default, Default) = "string",
						(max, Max, maximum, Maximum) = "number",
						(placeholder, Placeholder, placeHolder, PlaceHolder) = "string",
						(reactive, Reactive) = "boolean",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						TextBox:Get(),
						TextBox:Set("string")
					},
					Example = [[
						local TextBox = Section:TextBox({Default = "Hello", Placeholder "robux ammount", Maximum = 10, Callback = function(State) print(State) end, Flag = "Section_TextBox"})
					]]
					Return = TextBox

				Sections:ButtonHolder(Properties)
					Properties = {
						(buttons, Buttons) = "table",
							{
								"table"
									{
										(name, Name, title, Title),
										(callback, Callback, callBack, CallBack)
									}
							}
					},
					Functions = { },
					Example = [[
						local ButtonHolder = Section:ButtonHolder({Buttons = {{"First Button", function() print("Clicked 1") end}, {"Second Button", function() print("Clicked 2") end}}})
					]]
					Return = ButtonHolder

				Sections:Dropdown(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "string",
						(max, Max, maximum, Maximum) = "number",
						(options, Options) = "table",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						Dropdown:Get(),
						Dropdown:Set("string"),
						Dropdown:Update()
					},
					Example = [[
						local Dropdown = Section:Dropdown({Name = "Dropdown Name Here", Default = "Head", Options = {"Head", "Torso", "Legs", "Arms", "Upper", "Lower", "All", "Yep"}, Max = 5, Callback = function(State) print(State) end, Flag = "Section_Dropdown"})
					]]
					Return = Dropdown

				Sections:Multibox(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "table",
						(min, Min, minimum, Minimum) = "number",
						(max, Max, maximum, Maximum) = "number",
						(options, Options) = "table",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						Multibox:Get(),
						Multibox:Set("string"),
						Multibox:Update()
					},
					Example = [[
						local Multibox = Section:Multibox({Name = "Multibox Name Here", Default = {"Head", "Torso"}, Options = {"Head", "Torso", "Legs", "Arms", "Upper", "Lower", "All", "Yep"}, Min = 2, Max = 5, Callback = function(State) print(State) end, Flag = "Section_Multibox"})
					]]
					Return = Multibox

				Sections:Keybind(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "input",
						(keybindname, Keybindname, keybindName, KeybindName) = "string",
						(mode, Mode) = "string",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						Keybind:Get(),
						Keybind:Set("table"),
						Keybind:Shorten("string"),
						Keybind:Change("input"),
						Keybind:Active(),
						Keybind:Reset()
					},
					Example = [[
						local Keybind = Section:Keybind({Name = "Keybind Name Here yep", Default = Enum.KeyCode.X, KeybindName = "Random Keybind xD", Mode = "Toggle", Callback = function(Input, State) print(Input, State) end, Flag = "Section_Keybind"})
					]]
					Return = Keybind

				Sections:Colorpicker(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "color3",
						(transparency, Transparency, transp, Transp, alpha, Alpha) = "number",
						(info, Info) = "string",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						Colorpicker:Get(),
						Colorpicker:Set("table"),
						Colorpicker:Refresh(),
						Colorpicker:Colorpicker() -- (Window:Colorpicker Derivative)
					},
					Example = [[
						local Colorpicker = Section:Colorpicker({Name = "Colorpicker Name Here", Default = Color3.fromRGB(255, 0, 0), Alpha = 0.25, Info = "colorpciker info 123", Callback = function(Color, Transparency) print(Color, Transparency) end, Flag = "Section_Colorpicker"})
					]]
					Return = Colorpicker

				Sections:List(Properties)
					Properties = {
						(name, Name, title, Title) = "string",
						(def, Def, default, Default) = "number",
						(max, Max, maximum, Maximum) = "number",
						(options, Options) = "table",
						(callback, Callback, callBack, CallBack) = "function",
						(pointer, Pointer, flag, Flag) = "string"
					},
					Functions = {
						List:Get(),
						List:Set("table"),
						List:Refresh(),
						List:UpdateScroll()
					},
					Example = [[
						local List = Section:List({Name = "List Name Here", Default = Color3.fromRGB(255, 0, 0), Alpha = 0.25, Info = "colorpciker info 123", Callback = function(Color, Transparency) print(Color, Transparency) end, Flag = "Section_List"})
					]]
					Return = List

			}
