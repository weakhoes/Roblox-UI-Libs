local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Other/main/RAHH"))()

local Window = Library:New({Name = "Title here", Style = 1, PageAmmount = 7, Size = Vector2.new(554, 629)})

local Page = Window:Page({Name = "Page Name Here"})

local Section = Page:Section({Name = "Section Name Here", Fill = true, Side = "Right"})

local Main, Extra, Yes = Page:Section({Sections = {"Main", "Extra", "Yes"}, Fill = true, Side = "Right"})

local Label = Section:Label({Name = "Label Name Here", Center = true, Flag = "Section_Label"})

local Toggle = Section:Toggle({Name = "Toggle Here", Default = true, Callback = function(State) print(State) end, Flag = "Section_Toggle"})

local Button = Section:Button({Name = "Button Name Here", Callback = function(State) print(State) end, Flag = "Section_Button"})




Window:Initialize()
