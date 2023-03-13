--Credit to xz#1111 for source
local Ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Other/main/abyssoruce%40eayz.lua"))()
local Ui = Library

local LoadTime = tick()

local Loader = Library.CreateLoader(
    "Title Here", 
    Vector2.new(300, 300)
)

local Window = Library.Window(
    "Text Here", 
    Vector2.new(500, 620)
)

Window.SendNotification(
    "Normal", -- Normal, Warning, Error 
    "Press RightShift to open menu and close menu!", 
    10
)

Window.Watermark(
    "Text Here"
)
-- Window:Visible = true

-- // UI Main \\ --
local Tab1 = Window:Tab("Tab1")
local Section1 = Tab1:Section(
    "Section1", 
    "Left"
)


Section1:Toggle({
    Title = "Toggle1", 
    Flag = "Toggle_1",
    Type = "Dangerous",
    Callback = function(v)
        print("Value = "..v)
    end
}): -- Toggle Keybind Below
    Keybind({
    Title = "KeybindToggle1",
    Flag = "Keybind_Toggle_1", 
    Key = Enum.UserInputType.MouseButton2, 
    StateType = "Toggle"
})

Section1:Toggle({
    Title = "Toggle2", 
    Flag = "Toggle_2"
    
}):
Colorpicker({
    Color = Library.Theme.Accent[2], 
    Flag = "Toggle2Color"
})


Section1:Slider({
    Title = "Slider1", 
    Flag = "Slider_1", 
    Symbol = "", 
    Default = 0, 
    Min = 0, 
    Max = 20, 
    Decimals = 1,
    Callback = function(v)
        print("Value = "..v)
    end
})
Section1:Dropdown({
    Title = "Dropdown1", 
    List = {"1", "2" ,"3"}, 
    Default = "1", 
    Flag = "DropDown_1",
    Callback = function(v)
        print("Value = "..v)
    end
})

Section1:Button({
    Title = "Button1",
    Callback = function()
        print("Pressed!")
    end
})

--Section1:Colorpicker({
    --Title = "ColorPicker1"
--})

--Section1:Label({
    --Title = "Label1"
--})

--Tab1:AddPlayerlist()
Window:AddSettingsTab()
Window:SwitchTab(Tab1)
Window.ToggleAnime(false)
LoadTime = math.floor((tick() - LoadTime) * 1000)
