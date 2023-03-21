local Ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/Akiri%20Lib/Akiri%20Lib%20Source.lua"))()
local Ui = Library
--Window1.SendNotification(Type, "Text Here", Duration) -- Types = Warning, Error

Library.CreateLoader(
    "Loader1", 
    Vector2.new(300, 250)
);
local Window1 = Library.Window(
    "Window1", 
    Vector2.new(524, 550)
);

local Tab1 = Window1:Tab("Tab1")
local Section1 = Tab1:Section("Section1", "Left")

--Tab1:AddPlayerlist()
--Tab1:AddESPPreview()
--Window1:Watermark()

local Label1 = Section1:Label(
    "Label1"
)

local Button1 = Section1:Button({
    Title = "Button1",
    Callback = function(v)
        print(v)
    end
})

local Toggle1 = Section1:Toggle({ -- Toggle1:Set(true)
    Title = "Toggle1",
    Toggled = false,
    Flag = "Toggle_1", 
    Callback = function(v)
        print(v)
    end
})--[[:Keybind({
    Title = "KeyBind1",
    Flag = "Keybind_1",
    Key = Enum.KeyCode.Q,
    StateType = "Toggle", -- Types = Hold, Toggle, Always
    Callback = function(v)
        print(v)
    end
})--]]

local Slider1 = Section1:Slider({
    Title = "Slider1",
    Default = 0, 
    Decimals = 0.01,
    Max = 100,
    Min = 0,
    Symbol = "",
    Flag = "Slider_1",
    Callback = function(v)
        print(v)
    end
})

local Keybind1 = Section1:Keybind({
    Title = "KeyBind1",
    Flag = "Keybind_1",
    Key = Enum.KeyCode.Q,
    StateType = "Toggle", -- Types = Hold, Toggle, Always
    Callback = function(v)
        print(v)
    end
})

local TextBox1 = Section1:TextBox({
    Title = "TextBox1",
    Inputting = true,
    Deleting = true,
    Callback = function(v)
        print(v)
    end
})

Section1:Dropdown({
    Title = "DropDown1",
    List = {
        "", 
        "1", 
        "2", 
        "3",
    },
    Default = "",
    Callback = function(v)
        print(v)
        --[[
        if v == "1" then
            print("1")
        elseif v == "2" then
            print("2")
        elseif v == "3" then
            print("3")
        end
        end
        end
        ]]
    end
});



-- Settings --

local settings = Window1:Tab("Settings");
local localTheme = {
    Accent = Library.Theme.Accent[1],
    Outline = Color3.fromHex("#322850"),
    Inline = Color3.fromHex("#3c3c3c"),
    LightContrast = Color3.fromHex("#231946"),
    DarkContrast = Color3.fromHex("#191432"),
    Text = Color3.fromHex("#c8c8ff"),
    TextInactive = Color3.fromHex("#afafaf")
};

local theme = settings:Section("Theme", "Left");
theme:Colorpicker({Title = "Accent", Color = localTheme.Accent, Flag = "UIAccent", Callback = function(Color)
    Library:UpdateTheme({
        Accent = Color
    });
end});

theme:Colorpicker({Title = "Outline", Color = localTheme.Outline, Flag = "UIOutline", Callback = function(Color)
    Library:UpdateTheme({
        Outline = Color
    });
end});

theme:Colorpicker({Title = "Inline", Color = localTheme.Inline, Flag = "UIInline", Callback = function(Color)
    Library:UpdateTheme({
        Inline = Color
    });
end});

theme:Colorpicker({Title = "Inline Contrast", Color = localTheme.LightContrast, Flag = "UILightContrast", Callback = function(Color)
    Library:UpdateTheme({
        LightContrast = Color
    });
end});

theme:Colorpicker({Title = "Dark Contrast", Color = localTheme.DarkContrast, Flag = "UIDarkContrast", Callback = function(Color)
    Library:UpdateTheme({
        DarkContrast = Color
    });
end});

theme:Colorpicker({Title = "Text", Color = localTheme.Text, Flag = "UIText", Callback = function(Color)
    Library:UpdateTheme({
        Text = Color
    });
end});

theme:Colorpicker({Title = "Text Inactive", Color = localTheme.TextInactive, Flag = "UITextInactive", Callback = function(Color)
    Library:UpdateTheme({
        TextInactive = Color
    });
end});

theme:Dropdown({
    Title = "Theme",
    List = {"Default", "Octohook", "Neverlose", "Fatality", "Aimware", "Onetap", "Vape", "Gamesense", "OldAbyss"},
    Default = "Default",
    Callback = function(Choosen)
        if Choosen == "Default" then
            Library:UpdateTheme(localTheme);
        elseif Choosen == "Neverlose" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#000005"),
                Inline = Color3.fromHex("#0a1e28"),
                Accent = Color3.fromHex("#00b4f0"),
                Text = Color3.fromHex("#ffffff"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#000f1e"),
                DarkContrast = Color3.fromHex("#050514"),
            });
        elseif Choosen == "Octohook" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#000000"),
                Inline = Color3.fromHex("#3c3c3c"),
                Accent = Color3.fromHex("#8f4b67"),
                Text = Color3.fromHex("#ffffff"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#171717"),
                DarkContrast = Color3.fromHex("#121112"),
            });
        elseif Choosen == "Fatality" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#322850"),
                Inline = Color3.fromHex("#3c3c3c"),
                Accent = Color3.fromHex("#f00f50"),
                Text = Color3.fromHex("#c8c8ff"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#231946"),
                DarkContrast = Color3.fromHex("#191432"),
            });
        elseif Choosen == "Aimware" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#000005"),
                Inline = Color3.fromHex("#373737"),
                Accent = Color3.fromHex("#c82828"),
                Text = Color3.fromHex("#e8e8e8"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#2b2b2b"),
                DarkContrast = Color3.fromHex("#191919"),
            });
        elseif Choosen == "Onetap" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#000000"),
                Inline = Color3.fromHex("#4e5158"),
                Accent = Color3.fromHex("#dda85d"),
                Text = Color3.fromHex("#d6d9e0"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#2c3037"),
                DarkContrast = Color3.fromHex("#1f2125"),
            });
        elseif Choosen == "Vape" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#0a0a0a"),
                Inline = Color3.fromHex("#363636"),
                Accent = Color3.fromHex("#26866a"),
                Text = Color3.fromHex("#d6d9e0"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#1f1f1f"),
                DarkContrast = Color3.fromHex("#1a1a1a"),
            });
        elseif Choosen == "Gamesense" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#000000"),
                Inline = Color3.fromHex("#4e5158"),
                Accent = Color3.fromHex("#a7d94d"),
                Text = Color3.fromHex("#ffffff"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#171717"),
                DarkContrast = Color3.fromHex("#0c0c0c"),
            });
        elseif Choosen == "OldAbyss" then
            Library:UpdateTheme({
                Outline = Color3.fromHex("#0a0a0a"),
                Inline = Color3.fromHex("#322850"),
                Accent = Color3.fromHex("#8c87b4"),
                Text = Color3.fromHex("#ffffff"),
                TextInactive = Color3.fromHex("#afafaf"),
                LightContrast = Color3.fromHex("#1e1e1e"),
                DarkContrast = Color3.fromHex("#141414"),
            });
        end
    end
});

local menu = settings:Section("Menu", "Right"); do
    menu:Keybind({
        Title = "Menu Key",
        Flag = "Menu Key",
        Key = Enum.KeyCode.RightShift,
        StateType = "Toggle",
        Callback = function()
            Library:ChangeVisible(not Library.WindowVisible);
        end
    });

    menu:Button({
        Title = "Unload",
    });
end

local config = settings:Section("Config", "Right")

config:TextBox({Title = "Name", Current = "", Flag = "lmao"})

config:Button({Title = "Create", Callback = function()
    if Library.Flags["lmao"] ~= nil and Library.Flags["lmao"] ~= "" then
        Utility.SaveConfig(Library.Flags["lmao"])
        window.SendNotification("Normal", ("Created %s Config"):format(Library.Flags["lmao"]), 4)
    end
end})

config:Button({Title = "Load", Callback = function()
    if Library.Flags["lmao"] ~= nil and Library.Flags["lmao"] ~= "" then
        Utility.LoadConfig(Library.Flags["lmao"])
        window.SendNotification("Normal", ("Loaded %s Config"):format(Library.Flags["lmao"]), 4)
    end
end})

config:Button({Title = "Save", Callback = function()
    if Library.Flags["lmao"] ~= nil and Library.Flags["lmao"] ~= "" then
        Utility.SaveConfig(Library.Flags["lmao"])
        window.SendNotification("Normal", ("Saved %s Config"):format(Library.Flags["lmao"]), 4)
    end
end})

config:Button({Title = "Delete", Callback = function()
    if Library.Flags["lmao"] ~= nil and Library.Flags["lmao"] ~= "" then
        Utility.DeleteConfig(Library.Flags["lmao"])
        window.SendNotification("Normal", ("Deleted %s Config"):format(Library.Flags["lmao"]), 4)
    end
end})

Window1:SwitchTab(Tab1);
Window1.SendNotification(Warning, "Loaded", 5) -- Types = Warning, Error
return Library