-- // EngoUI V2
local mouse = game.Players.LocalPlayer:GetMouse()
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Keys = loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/roblox/main/AlphanumericKeys.lua"))()
local rainbowvalue = 0.01

-- Themes
EngoThemes = {
    Engo = {
        TextColor = Color3.fromRGB(255, 255, 255),
        DescriptionTextColor = Color3.fromRGB(150, 150, 150),
        DarkTextColor = Color3.fromRGB(100, 100, 100),
        DarkContrast = Color3.fromRGB(4, 4, 22),
        LightContrast = Color3.fromRGB(15, 16, 41),
        BackgroundGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(3, 5, 16)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(4, 4, 22))},
        Darkness = Color3.fromRGB(0, 0, 0),
    },
    Swamp = {
        TextColor = Color3.fromRGB(255, 255, 255),
        DescriptionTextColor = Color3.fromRGB(150, 150, 150),
        DarkTextColor = Color3.fromRGB(100, 100, 100),
        DarkContrast = Color3.fromRGB(10, 29, 6),
        LightContrast = Color3.fromRGB(28, 80, 43),
        BackgroundGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(5, 27, 10)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(6, 37, 17))},
        Darkness = Color3.fromRGB(0, 0, 0),
    },
    Sky = {
        TextColor = Color3.fromRGB(255, 255, 255),
        DescriptionTextColor = Color3.fromRGB(212, 212, 212),
        DarkTextColor = Color3.fromRGB(161, 161, 161),
        DarkContrast = Color3.fromRGB(32, 119, 177),
        LightContrast = Color3.fromRGB(56, 137, 175),
        BackgroundGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(63, 127, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 118, 155))},
        Darkness = Color3.fromRGB(0, 0, 0),
    },
    Crimson = {
        TextColor = Color3.fromRGB(255, 255, 255),
        DescriptionTextColor = Color3.fromRGB(212, 212, 212),
        DarkTextColor = Color3.fromRGB(161, 161, 161),
        DarkContrast = Color3.fromRGB(54, 11, 11),
        LightContrast = Color3.fromRGB(167, 50, 50),
        BackgroundGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(83, 30, 30)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(138, 45, 45))},
        Darkness = Color3.fromRGB(0, 0, 0),
    },
    Gray = {
        TextColor = Color3.fromRGB(255, 255, 255),
        DescriptionTextColor = Color3.fromRGB(212, 212, 212),
        DarkTextColor = Color3.fromRGB(161, 161, 161),
        DarkContrast = Color3.fromRGB(24, 24, 24),
        LightContrast = Color3.fromRGB(58, 58, 58),
        BackgroundGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(29, 29, 29)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))},
        Darkness = Color3.fromRGB(0, 0, 0),
    },
    Discord = {
        TextColor = Color3.fromRGB(255, 255, 255),
        DescriptionTextColor = Color3.fromRGB(212, 212, 212),
        DarkTextColor = Color3.fromRGB(161, 161, 161),
        DarkContrast = Color3.fromRGB(41, 43, 47),
        LightContrast = Color3.fromRGB(54, 57, 63),
        BackgroundGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(64, 68, 75)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(64, 68, 75))},
        Darkness = Color3.fromRGB(0, 0, 0),
    },
}
local theme = EngoThemes.Engo

-- Functions
local old_err = error
local function error(message)
    old_err("[EngoUILib] "..tostring(message))
end


function getTextFromKeyCode(keycode)
    for i,v in pairs(Keys) do
        if v == keycode then
            return tostring(i), true
        end
    end
    return (keycode.Name)
end

function isValidKey(keycode)
    local x, bool = getTextFromKeyCode(keycode)
    if bool then
        return true
    end
end

local function RelativeXY(GuiObject, location)
	local x, y = location.X - GuiObject.AbsolutePosition.X, location.Y - GuiObject.AbsolutePosition.Y
	local x2 = 0
	local xm, ym = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	x2 = math.clamp(x, 4, xm - 6)
	x = math.clamp(x, 0, xm)
	y = math.clamp(y, 0, ym)
	return x, y, x/xm, y/ym, x2/xm
end

spawn(function()
	repeat
		for i = 0, 1, 0.01 do
			wait(0.01)
			rainbowvalue = i
		end
	until true == false
end)

local library = {}
function library:SetTheme(themeSel)
    if EngoThemes[themeSel] then 
        theme = EngoThemes[themeSel]
    elseif typeof(themeSel) == "table" then
        for i,v in pairs(EngoThemes.Engo) do
            if not themeSel[i] then
                error("Custom themes needs "..tostring(i).." to work properly!")
            end
        end
        theme = themeSel
    else
        error("Invalid theme!, please use correct name or custom theme.")
    end
end
function library:CreateMain(title, description, keycode)
    library["OriginalBind"] = keycode
    library["Bind"] = keycode
    local closeconnection 
    function onSelfDestroy()
        if getgenv().userInputConnection then
            getgenv().userInputConnection:Disconnect()
            getgenv().userInputConnection = nil
        end
        if closeconnection then
            closeconnection:Disconnect()
        end
    end
    if getgenv().EngoUILib then 
        getgenv().EngoUILib:Destroy() 
        onSelfDestroy()
    end
    local firstTab
    local EngoUI = Instance.new("ScreenGui")
    if syn then 
        syn.protect_gui(EngoUI)
    end
    EngoUI.Parent = gethui and gethui() or game.CoreGui
    getgenv().EngoUILib = EngoUI
    closeconnection = UIS.InputEnded:Connect(function(input,yes)
        local TextBoxFocused = UIS:GetFocusedTextBox()
        if TextBoxFocused then return end
        if input.KeyCode == library["Bind"] and not yes and not library["IsBinding"] then
            EngoUI.Enabled = not EngoUI.Enabled
        end
    end)

    local Main = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local UICorner = Instance.new("UICorner")
    local Sidebar = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local Topbar = Instance.new("Frame")
    local Info = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Description = Instance.new("TextLabel")

    EngoUI.Name = "EngoUI"
    EngoUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = EngoUI
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.Position = UDim2.new(0.54207927, 0, 0.307602346, 0)
    Main.Size = UDim2.new(0, 550, 0, 397)
    Main.Active = true
    Main.Draggable = true

    UIGradient.Color = theme.BackgroundGradient
    UIGradient.Offset = Vector2.new(-0.25, 0)
    UIGradient.Parent = Main

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.Active = true
    Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Sidebar.BackgroundTransparency = 1.000
    Sidebar.Position = UDim2.new(0.043636363, 0, 0.158690169, 0)
    Sidebar.Size = UDim2.new(0, 93, 0, 314)
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    Sidebar.ScrollBarThickness = 0
    Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y

    UIListLayout.Parent = Sidebar
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 15)

    Topbar.Name = "Topbar"
    Topbar.Parent = Main
    Topbar.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
    Topbar.BackgroundTransparency = 1.000
    Topbar.Size = UDim2.new(0, 550, 0, 53)

    Info.Name = "Info"
    Info.Parent = Topbar
    Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Info.BackgroundTransparency = 1.000
    Info.Position = UDim2.new(0, 0, 0.113207549, 0)
    Info.Size = UDim2.new(0, 151, 0, 47)

    Title.Name = "Title"
    Title.Parent = Info
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.158940405, 0, 0.132075474, 0)
    Title.Size = UDim2.new(0, 116, 0, 21)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 =  theme.TextColor
    Title.TextSize = 18.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Description.Name = "Description"
    Description.Parent = Info
    Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Description.BackgroundTransparency = 1.000
    Description.Position = UDim2.new(0.158940405, 0, 0.528301895, 0)
    Description.Size = UDim2.new(0, 116, 0, 16)
    Description.Font = Enum.Font.Gotham
    Description.Text = description
    Description.TextColor3 = theme.DescriptionTextColor
    Description.TextSize = 11.000
    Description.TextXAlignment = Enum.TextXAlignment.Left

    local library2 = {}
    library2["Tabs"] = {}
    function library2:CreateTab(name)

        local library3 = {}

        local UIListLayout_2 = Instance.new("UIListLayout") 
        local TabButton = Instance.new("TextButton")
        local Tab = Instance.new("ScrollingFrame")

        TabButton.Parent = Sidebar
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Size = UDim2.new(0, 121, 0, 26)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 =  theme.DarkTextColor
        TabButton.TextSize = 14.000
        TabButton.TextWrapped = true
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Name = name.."TabButton"

        Tab.Name = name.."Tab"
        Tab.Parent = Main
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.289090902, 0, 0.151133507, 0)
        Tab.Size = UDim2.new(0, 375, 0, 309)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 0
        Tab.TopImage = ""
        Tab.AutomaticCanvasSize = Enum.AutomaticSize.Y

        UIListLayout_2.Parent = Tab
        UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Padding = UDim.new(0, 3)

        library2["Tabs"][name] = {
            Instance = Tab,
            Button = TabButton,
        }

        if not firstTab then 
            firstTab = library2["Tabs"][name]
            TabButton.TextColor3 = theme.TextColor
        else
            Tab.Visible = false
            TabButton.TextColor3 = theme.DarkTextColor
        end

        function library2:OpenTab(tab)
            for i,v in pairs(library2["Tabs"]) do 
                if i ~= tab then
                    v.Instance.Visible = false
                    v.Button.TextColor3 = theme.DarkTextColor
                else
                    v.Instance.Visible = true
                    v.Button.TextColor3 =  theme.TextColor
                end
            end
        end

        TabButton.MouseButton1Click:Connect(function()
            library2:OpenTab(name)
        end)

        function library3:CreateButton(text, callback)
            callback = callback or function() end
            local Button = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local Title_2 = Instance.new("TextLabel")
            local Icon = Instance.new("ImageLabel")

            Button.Name = text.."Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = theme.LightContrast
            Button.BackgroundTransparency = 0
            Button.Size = UDim2.new(0, 375, 0, 49)
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = Button

            Title_2.Name = "Title"
            Title_2.Parent = Button
            Title_2.AnchorPoint = Vector2.new(0, 0.5)
            Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_2.BackgroundTransparency = 1.000
            Title_2.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title_2.Size = UDim2.new(0, 263, 0, 21)
            Title_2.Font = Enum.Font.GothamSemibold
            Title_2.Text = text
            Title_2.TextColor3 =  theme.TextColor
            Title_2.TextSize = 14.000
            Title_2.TextXAlignment = Enum.TextXAlignment.Left

            Icon.Name = "Icon"
            Icon.Parent = Button
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.ClipsDescendants = true
            Icon.Position = UDim2.new(0.0400000028, 0, 0.5, 0)
            Icon.Size = UDim2.new(0, 19, 0, 24)
            Icon.Image = "rbxassetid://8284791761"
            Icon.ScaleType = Enum.ScaleType.Stretch
            Icon.ImageColor3 = theme.TextColor

            Button.MouseButton1Click:Connect(function() 
                spawn(function() pcall(callback) end)
            end)
            local obj = {
                ["Type"] = "Button",
                ["Instance"] = Button,
                ["Api"] = nil
            }
            table.insert(library2["Tabs"][name], obj)
        end

        function library3:CreateToggle(text, callback)
            local library4 = {}
            library4["Enabled"] = false
            callback = callback or function() end
            local Toggle = Instance.new("TextButton")
            local UICorner_3 = Instance.new("UICorner")
            local Title_3 = Instance.new("TextLabel")
            local Icon = Instance.new("ImageLabel")

            Toggle.Name = text.."Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = theme.LightContrast
            Toggle.BackgroundTransparency = 0
            Toggle.Size = UDim2.new(0, 375, 0, 49)
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            UICorner_3.CornerRadius = UDim.new(0, 6)
            UICorner_3.Parent = Toggle

            Title_3.Name = "Title"
            Title_3.Parent = Toggle
            Title_3.AnchorPoint = Vector2.new(0, 0.5)
            Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_3.BackgroundTransparency = 1.000
            Title_3.Position = UDim2.new(0.138999999, 0, 0.520408154, 0)
            Title_3.Size = UDim2.new(0, 264, 0, 21)
            Title_3.Font = Enum.Font.GothamSemibold
            Title_3.Text = text
            Title_3.TextColor3 =  theme.TextColor
            Title_3.TextSize = 14.000
            Title_3.TextXAlignment = Enum.TextXAlignment.Left

            Icon.Name = "Icon"
            Icon.Parent = Toggle
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.ClipsDescendants = true
            Icon.Position = UDim2.new(0.0320000015, 0, 0.5, 0)
            Icon.Size = UDim2.new(0, 26, 0, 26)
            Icon.ImageColor3 = theme.TextColor
            Icon.Image = "rbxassetid://3926311105"
            Icon.ImageRectOffset = Vector2.new(940, 784)
            Icon.ImageRectSize = Vector2.new(48, 48)
            Icon.SliceScale = 0.500

            function library4:Toggle(bool)
                bool = bool or (not library4["Enabled"])
                library4["Enabled"] = bool
                if not bool then 
                    Icon.ImageRectOffset = Vector2.new(940, 784)
                    Icon.ImageRectSize = Vector2.new(48, 48)
                    spawn(function() callback(false) end)
                else
                    spawn(function() callback(true) end)
                    Icon.ImageRectOffset = Vector2.new(4, 836)
                    Icon.ImageRectSize = Vector2.new(48, 48)
                end
            end

            Toggle.MouseButton1Click:Connect(function()
                library4:Toggle()
            end)

            local obj = {
                ["Type"] = "Toggle",
                ["Instance"] = Toggle,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        function library3:CreateTextbox(text, callback)
            local library4 = {}
            library4["Text"] = ""

            local Textbox = Instance.new("TextLabel")
            local UICorner = Instance.new("UICorner")
            local Icon = Instance.new("ImageLabel")
            local Title = Instance.new("TextLabel")
            local Textbox_2 = Instance.new("TextBox")
            local UICorner_2 = Instance.new("UICorner")

            Textbox.Name = text.."Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = theme.LightContrast
            Textbox.BackgroundTransparency = 0
            Textbox.Position = UDim2.new(0, 0, 0.326860845, 0)
            Textbox.Size = UDim2.new(0, 375, 0, 50)
            Textbox.Font = Enum.Font.SourceSans
            Textbox.Text = ""
            Textbox.TextColor3 = Color3.fromRGB(0, 0, 0)
            Textbox.TextSize = 14.000

            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = Textbox

            Icon.Name = "Icon"
            Icon.Parent = Textbox
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.ClipsDescendants = true
            Icon.Position = UDim2.new(0.032333333, 0, 0.5, 0)
            Icon.Size = UDim2.new(0, 25, 0, 24)
            Icon.Image = "rbxassetid://3926305904"
            Icon.ImageRectOffset = Vector2.new(244, 44)
            Icon.ImageRectSize = Vector2.new(36, 36)
            Icon.ScaleType = Enum.ScaleType.Crop
            Icon.SliceScale = 0.500
            Icon.ImageColor3 = theme.TextColor

            Title.Name = "Title"
            Title.Parent = Textbox
            Title.AnchorPoint = Vector2.new(0, 0.5)
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title.Size = UDim2.new(0, 101, 0, 21)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = text
            Title.TextColor3 =  theme.TextColor
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            Textbox_2.Name = "Textbox"
            Textbox_2.Parent = Textbox
            Textbox_2.AnchorPoint = Vector2.new(0, 0.5)
            Textbox_2.BackgroundColor3 = theme.DarkContrast
            Textbox_2.BorderSizePixel = 0
            Textbox_2.Position = UDim2.new(0.43233332, 0, 0.5, 0)
            Textbox_2.Size = UDim2.new(0, 201, 0, 20)
            Textbox_2.Font = Enum.Font.Gotham
            Textbox_2.PlaceholderColor3 = theme.DarkTextColor
            Textbox_2.PlaceholderText = "Value"
            Textbox_2.Text = ""
            Textbox_2.TextColor3 = theme.DescriptionTextColor
            Textbox_2.TextSize = 14.000
            Textbox_2.TextWrapped = true
            Textbox_2.FocusLost:Connect(function()
                spawn(function() callback(Textbox_2.Text) end)
                library4["Text"] = Textbox_2.Text
            end)

            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = Textbox_2
            local obj = {
                ["Type"] = "Textbox",
                ["Instance"] = Textbox,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        function library3:CreateSlider(text, min, max, callback)
            local library4 = {}
            library4["Value"] = nil
            callback = callback or function() end

            local Slider = Instance.new("TextButton")
            local UICorner_4 = Instance.new("UICorner")
            local Icon_3 = Instance.new("ImageLabel")
            local Title_4 = Instance.new("TextLabel")
            local SliderBar = Instance.new("Frame")
            local UICorner_5 = Instance.new("UICorner")
            local Value = Instance.new("TextLabel")
            local Slider_2 = Instance.new("Frame")
            local UICorner_6 = Instance.new("UICorner")

            Slider.Name = text.."Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = theme.LightContrast
            Slider.BackgroundTransparency = 0
            Slider.Position = UDim2.new(0, 0, 0.336569577, 0)
            Slider.Size = UDim2.new(0, 375, 0, 50)
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000
            Slider.AutoButtonColor = false

            UICorner_4.CornerRadius = UDim.new(0, 6)
            UICorner_4.Parent = Slider

            Icon_3.Name = "Icon"
            Icon_3.Parent = Slider
            Icon_3.AnchorPoint = Vector2.new(0, 0.5)
            Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon_3.BackgroundTransparency = 1.000
            Icon_3.ClipsDescendants = true
            Icon_3.Position = UDim2.new(0.032333333, 0, 0.5, 0)
            Icon_3.Size = UDim2.new(0, 25, 0, 24)
            Icon_3.Image = "rbxassetid://3926305904"
            Icon_3.ImageRectOffset = Vector2.new(4, 124)
            Icon_3.ImageRectSize = Vector2.new(36, 36)
            Icon_3.SliceScale = 0.500
            Icon_3.ImageColor3 = theme.TextColor

            Title_4.Name = "Title"
            Title_4.Parent = Slider
            Title_4.AnchorPoint = Vector2.new(0, 0.5)
            Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_4.BackgroundTransparency = 1.000
            Title_4.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title_4.Size = UDim2.new(0, 101, 0, 21)
            Title_4.Font = Enum.Font.GothamSemibold
            Title_4.Text = text
            Title_4.TextColor3 =  theme.TextColor
            Title_4.TextSize = 14.000
            Title_4.TextXAlignment = Enum.TextXAlignment.Left

            SliderBar.Name = "SliderBar"
            SliderBar.Parent = Slider
            SliderBar.AnchorPoint = Vector2.new(0, 0.5)
            SliderBar.BackgroundColor3 = theme.DarkContrast
            SliderBar.BorderSizePixel = 0
            SliderBar.Position = UDim2.new(-0.0666666701, 170, 0.5, 0)
            SliderBar.Size = UDim2.new(0, 219, 0, 15)

            UICorner_5.CornerRadius = UDim.new(0, 6)
            UICorner_5.Parent = SliderBar

            Value.Name = "Value"
            Value.Parent = SliderBar
            Value.AnchorPoint = Vector2.new(0.5, 0.5)
            Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Value.BackgroundTransparency = 1.000
            Value.Position = UDim2.new(0.5, 0, 0.5, 0)
            Value.Size = UDim2.new(0, 37, 0, 16)
            Value.ZIndex = 2
            Value.Font = Enum.Font.GothamSemibold
            Value.Text = ""
            Value.TextColor3 =  theme.TextColor
            Value.TextSize = 10.000
            Value.TextStrokeTransparency = 0.000
            Value.TextStrokeColor3 = theme.Darkness
            Value.TextXAlignment = Enum.TextXAlignment.Left

            Slider_2.Name = "Slider"
            Slider_2.Parent = SliderBar
            Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider_2.Size = UDim2.new(0, 53, 0, 15)

            UICorner_6.CornerRadius = UDim.new(0, 6)
            UICorner_6.Parent = Slider_2
			
            local value
			local dragging
			function library4:SetValue(input)
				local pos = UDim2.new(math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1), 0, 0, (SliderBar.AbsoluteSize.Y))
				Slider_2:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
				local value = math.floor(( ((pos.X.Scale * max) / max) * (max - min) + min ))
				Value.Text = tostring(value)
                library4["Value"] = value
				spawn(function() callback(value) end)
			end;
			
			SliderBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)

			SliderBar.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			SliderBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					library4:SetValue(input)
				end
			end)

			UIS.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					library4:SetValue(input)
				end
			end)

            local obj = {
                ["Type"] = "Slider",
                ["Instance"] = Slider,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        function library3:CreateLabel(text)
            local library4 = {}
            local Label = Instance.new("TextLabel")
            local UICorner_7 = Instance.new("UICorner")
            local Icon_4 = Instance.new("ImageLabel")
            local Title_5 = Instance.new("TextLabel")
        
            Label.Name = text.."Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = theme.LightContrast
            Label.BackgroundTransparency = 0
            Label.Position = UDim2.new(0, 0, 0.336569577, 0)
            Label.Size = UDim2.new(0, 375, 0, 50)
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000

            UICorner_7.CornerRadius = UDim.new(0, 6)
            UICorner_7.Parent = Label

            Icon_4.Name = "Icon"
            Icon_4.Parent = Label
            Icon_4.AnchorPoint = Vector2.new(0, 0.5)
            Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon_4.BackgroundTransparency = 1.000
            Icon_4.ClipsDescendants = true
            Icon_4.Position = UDim2.new(0.032333333, 0, 0.5, 0)
            Icon_4.Size = UDim2.new(0, 25, 0, 24)
            Icon_4.Image = "rbxassetid://3926305904"
            Icon_4.ImageRectOffset = Vector2.new(584, 4)
            Icon_4.ImageRectSize = Vector2.new(36, 36)
            Icon_4.ScaleType = Enum.ScaleType.Crop
            Icon_4.SliceScale = 0.500
            Icon_4.ImageColor3 = theme.TextColor

            Title_5.Name = "Title"
            Title_5.Parent = Label
            Title_5.AnchorPoint = Vector2.new(0, 0.5)
            Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_5.BackgroundTransparency = 1.000
            Title_5.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title_5.Size = UDim2.new(0, 101, 0, 21)
            Title_5.Font = Enum.Font.GothamSemibold
            Title_5.TextColor3 =  theme.TextColor
            Title_5.TextSize = 14.000
            Title_5.TextXAlignment = Enum.TextXAlignment.Left
            Title_5.Text = text

            function library4:Update(textnew) 
                Title_5.Text = textnew
            end

            local obj = {
                ["Type"] = "Label",
                ["Instance"] = Label,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        function library3:CreateBind(text, originalBind, callback)
            local library4 = {}
            local o, a = getTextFromKeyCode(originalBind)
            library["IsBinding"] = false
            library4["IsBinding"] = false
            library4["Bind"] = originalBind
            callback = callback or function() end

            local Keybind = Instance.new("TextLabel")
            local UICorner_8 = Instance.new("UICorner")
            local Title_6 = Instance.new("TextLabel")
            local Icon_5 = Instance.new("TextLabel")
            local UICorner_9 = Instance.new("UICorner")
            local Edit = Instance.new("ImageButton")
            local BindText = Instance.new("TextLabel")

            Keybind.Name = text.."Bind"
            Keybind.Parent = Tab
            Keybind.BackgroundColor3 = theme.LightContrast
            Keybind.BackgroundTransparency = 0
            Keybind.Position = UDim2.new(0, 0, 0.336569577, 0)
            Keybind.Size = UDim2.new(0, 375, 0, 50)
            Keybind.Font = Enum.Font.SourceSans
            Keybind.Text = ""
            Keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.TextSize = 14.000

            UICorner_8.CornerRadius = UDim.new(0, 6)
            UICorner_8.Parent = Keybind

            Title_6.Name = "Title"
            Title_6.Parent = Keybind
            Title_6.AnchorPoint = Vector2.new(0, 0.5)
            Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_6.BackgroundTransparency = 1.000
            Title_6.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title_6.Size = UDim2.new(0, 101, 0, 21)
            Title_6.Font = Enum.Font.GothamSemibold
            Title_6.Text = text
            Title_6.TextColor3 =  theme.TextColor
            Title_6.TextSize = 14.000
            Title_6.TextXAlignment = Enum.TextXAlignment.Left

            Icon_5.Name = "Icon"
            Icon_5.Parent = Keybind
            Icon_5.AnchorPoint = Vector2.new(0, 0.5)
            Icon_5.Position = UDim2.new(0.0320000015, 0, 0.5, 0)
            Icon_5.Size = UDim2.new(0, 25, 0, 24)
            Icon_5.Font = Enum.Font.GothamBold
            Icon_5.Text = a and o or " "
            Icon_5.TextColor3 = theme.Darkness
            Icon_5.TextSize = 14.000
            Icon_5.BackgroundColor3 = theme.TextColor

            UICorner_9.CornerRadius = UDim.new(0, 4)
            UICorner_9.Parent = Icon_5

            Edit.Name = "Edit"
            Edit.Parent = Keybind
            Edit.BackgroundTransparency = 1.000
            Edit.LayoutOrder = 5
            Edit.Position = UDim2.new(0.903674901, 0, 0.248771951, 0)
            Edit.Size = UDim2.new(0, 25, 0, 25)
            Edit.ZIndex = 2
            Edit.Image = "rbxassetid://3926305904"
            Edit.ImageRectOffset = Vector2.new(284, 644)
            Edit.ImageRectSize = Vector2.new(36, 36)
            Edit.ImageColor3 = theme.TextColor

            BindText.Name = "BindText"
            BindText.Parent = Keybind
            BindText.AnchorPoint = Vector2.new(0, 0.5)
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.594333351, 0, 0.5, 0)
            BindText.Size = UDim2.new(0, 93, 0, 21)
            BindText.Font = Enum.Font.GothamSemibold
            BindText.Text = o
            BindText.TextColor3 =  theme.TextColor
            BindText.TextSize = 14.000
            BindText.TextXAlignment = Enum.TextXAlignment.Right
            Edit.MouseButton1Click:Connect(function()
                library4["IsBinding"] = true
                library["IsBinding"] = true
                BindText.Text = "Press a key..."
            end)

            getgenv().userInputConnection = UIS.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Unknown then return end
                local TextBoxFocused = UIS:GetFocusedTextBox()
                if TextBoxFocused then return end
                if input.KeyCode == Enum.KeyCode.Backspace then 
                    library4["IsBinding"] = false
                    library["IsBinding"] = false
                    library4["Bind"] = nil
                    BindText.Text = getTextFromKeyCode(originalBind)
                    Icon_5.Text = "␀"
                end
                if library4["IsBinding"] then 
                    library4["Bind"] = input.KeyCode
                    library4["IsBinding"] = false
                    library["IsBinding"] = false
                    local t, b = getTextFromKeyCode(library4["Bind"])
                    BindText.Text = t
                    Icon_5.Text = (b and t) or " "
                else
                    if input.KeyCode == library4["Bind"] then 
                        spawn(function() callback(library4["Bind"]) end)
                    end
                end
            end)
            local obj = {
                ["Type"] = "Bind",
                ["Instance"] = Keybind,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        function library3:CreateDropdown(text, list, callback)
            local library4 = {}
            library4["Options"] = {}
            library4["Expanded"] = false

            local Dropdown = Instance.new("TextButton")
            local UICorner_10 = Instance.new("UICorner")
            local Title_7 = Instance.new("TextLabel")
            local Icon_6 = Instance.new("ImageLabel")

            Dropdown.Name = text.."Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = theme.LightContrast
            Dropdown.BackgroundTransparency = 0
            Dropdown.Position = UDim2.new(0, 0, 0.158576056, 0)
            Dropdown.Size = UDim2.new(0, 375, 0, 50)
            Dropdown.Font = Enum.Font.SourceSans
            Dropdown.Text = ""
            Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown.TextSize = 14.000

            UICorner_10.CornerRadius = UDim.new(0, 6)
            UICorner_10.Parent = Dropdown

            Title_7.Name = "Title"
            Title_7.Parent = Dropdown
            Title_7.AnchorPoint = Vector2.new(0, 0.5)
            Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_7.BackgroundTransparency = 1.000
            Title_7.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title_7.Size = UDim2.new(0, 263, 0, 21)
            Title_7.Font = Enum.Font.GothamSemibold
            Title_7.Text = text
            Title_7.TextColor3 =  theme.TextColor
            Title_7.TextSize = 14.000
            Title_7.TextXAlignment = Enum.TextXAlignment.Left

            Icon_6.Name = "Icon"
            Icon_6.Parent = Dropdown
            Icon_6.AnchorPoint = Vector2.new(0, 0.5)
            Icon_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon_6.BackgroundTransparency = 1.000
            Icon_6.ClipsDescendants = true
            Icon_6.Position = UDim2.new(0.031, 0 ,0.5, 0)
            Icon_6.Size = UDim2.new(0, 27, 0, 27)
            Icon_6.Image = "rbxassetid://3926305904"
            Icon_6.ImageRectOffset = Vector2.new(484, 204)
            Icon_6.ImageRectSize = Vector2.new(36, 36)
            Icon_6.ImageColor3 = theme.TextColor

            function library4:CreateOption(text)  
                local Option = Instance.new("TextButton")
                local UICorner_11 = Instance.new("UICorner")
                local Title_8 = Instance.new("TextLabel")
                
                local ending = "Option"
                for i = 1,100 do
                    if i == 1 then i = "" end
                    if not Tab:FindFirstChild(tostring(text).."Option"..tostring(i)) then
                        ending = "Option"..tostring(i)
                        break
                    end
                end
                library4["Options"][tostring(text)..ending] = {
                    ["Value"] = text,
                    ["Instance"] = Option
                }
                library4["Connections"] = {}
                Option.Name = tostring(text)..ending
                Option.Parent = Tab
                Option.BackgroundColor3 = theme.LightContrast
                Option.BackgroundTransparency = 0
                Option.Position = UDim2.new(0, 0, 0.666666687, 0)
                Option.Size = UDim2.new(0, 354, 0, 50)
                Option.Font = Enum.Font.SourceSans
                Option.Text = ""
                Option.TextColor3 = Color3.fromRGB(0, 0, 0)
                Option.TextSize = 14.000
                Option.Visible = false

                UICorner_11.CornerRadius = UDim.new(0, 6)
                UICorner_11.Parent = Option

                Title_8.Name = "Title"
                Title_8.Parent = Option
                Title_8.AnchorPoint = Vector2.new(0, 0.5)
                Title_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title_8.BackgroundTransparency = 1.000
                Title_8.Position = UDim2.new(0.0441919193, 0, 0.5, 0)
                Title_8.Size = UDim2.new(0, 291, 0, 21)
                Title_8.Font = Enum.Font.GothamSemibold
                Title_8.Text = "• "..tostring(text)
                Title_8.TextColor3 =  theme.TextColor
                Title_8.TextSize = 14.000
                Title_8.TextXAlignment = Enum.TextXAlignment.Left

                local isFound = false
                for i,v in pairs(library2["Tabs"][name]) do 
                    if type(v) == "table" then
                        if v.Instance == Option then 
                            isFound = true
                        end
                        if isFound and v.Instance ~= Option then 
                            spawn(function()
                                local old = v.Instance.Parent
                                v.Instance.Parent = nil
                                v.Instance.Parent = old
                            end)
                        end
                    end
                end

                return Option
            end

            function library4:CreateOptions(options)
                for i,v in pairs(options) do 
                    local option = library4:CreateOption(v)
                end
            end
            function library4:RefreshOptions(options)
                options = options or {}
                for i,v in pairs(library4["Options"]) do 
                    v.Instance:Destroy()
                end
                Tab.CanvasSize = UDim2.new(0, Tab.AbsoluteSize.X, 0, UIListLayout_2.AbsoluteContentSize.Y)
                library4["Expanded"] = false
                library4:CreateOptions(options)
            end
            library4:CreateOptions(list)
            Dropdown.MouseButton1Click:Connect(function()
                if library4["Expanded"] then 
                    for i,v in pairs(library4["Options"]) do
                        v.Instance.Visible = false
                    end
                    for i,v in pairs(library4["Connections"]) do
                        v:Disconnect()
                    end
                else
                    for i,v in pairs(library4["Options"]) do 
                        v.Instance.Visible = true
                        library4["Connections"][i] = v.Instance.MouseButton1Click:Connect(function()
                            spawn(function() callback(v.Value) end)
                            library4["Value"] = v.Value
                            library4["Expanded"] = false
                            for i,v in pairs(library4["Connections"]) do
                                v:Disconnect()
                            end
                            Dropdown.Title.Text = text.." - "..tostring(v.Value)
                            for i2, v2 in pairs(library4["Options"]) do 
                                v2.Instance.Visible = false
                            end
                            Tab.CanvasSize = UDim2.new(0, Tab.AbsoluteSize.X, 0, UIListLayout_2.AbsoluteContentSize.Y)
                        end)
                    end
                end
                library4["Expanded"] = not library4["Expanded"]
                Tab.CanvasSize = UDim2.new(0, Tab.AbsoluteSize.X, 0, UIListLayout_2.AbsoluteContentSize.Y)
            end)
            local obj = {
                ["Type"] = "Dropdown",
                ["Instance"] = Dropdown,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        function library3:CreateTextList(text, callback)
            local library4 = {}
            library4["List"] = {}
            library4["ListValues"] = {}
            library4["Expanded"] = true

            local Textlist = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            local Title = Instance.new("TextLabel")
            local Icon = Instance.new("ImageLabel")
            local Add = Instance.new("ImageButton")

            Textlist.Name = text.."Textlist"
            Textlist.Parent = Tab
            Textlist.BackgroundColor3 = theme.LightContrast
            Textlist.BackgroundTransparency = 0
            Textlist.Position = UDim2.new(0, 0, 0.158576056, 0)
            Textlist.Size = UDim2.new(0, 375, 0, 50)
            Textlist.Font = Enum.Font.SourceSans
            Textlist.Text = ""
            Textlist.TextColor3 = Color3.fromRGB(0, 0, 0)
            Textlist.TextSize = 14.000

            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = Textlist

            Title.Name = "Title"
            Title.Parent = Textlist
            Title.AnchorPoint = Vector2.new(0, 0.5)
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title.Size = UDim2.new(0, 263, 0, 21)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = text
            Title.TextColor3 =  theme.TextColor
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            Icon.Name = "Icon"
            Icon.Parent = Textlist
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.ClipsDescendants = true
            Icon.Position = UDim2.new(0.032333333, 0, 0.5, 0)
            Icon.Size = UDim2.new(0, 25, 0, 24)
            Icon.Image = "rbxassetid://3926305904"
            Icon.ImageRectOffset = Vector2.new(44, 204)
            Icon.ImageRectSize = Vector2.new(36, 36)
            Icon.ScaleType = Enum.ScaleType.Crop
            Icon.SliceScale = 0.500
            Icon.ImageColor3 = theme.TextColor

            Add.Name = "Add"
            Add.Parent = Textlist
            Add.AnchorPoint = Vector2.new(0.5, 0.5)
            Add.BackgroundTransparency = 1.000
            Add.LayoutOrder = 3
            Add.Position = UDim2.new(0.934666634, 0, 0.5, 0)
            Add.Size = UDim2.new(0, 25, 0, 25)
            Add.ZIndex = 2
            Add.Image = "rbxassetid://3926307971"
            Add.ImageRectOffset = Vector2.new(324, 364)
            Add.ImageRectSize = Vector2.new(36, 36)

            function library4:CreateTextOption()
                local TextOption = Instance.new("TextLabel")
                local UICorner_2 = Instance.new("UICorner")
                local Textbox6 = Instance.new("TextBox")
                local UICorner_3 = Instance.new("UICorner")
                local Remove = Instance.new("TextButton")

                local ending = "TextOption"
                for i = 1,100 do
                    if i == 1 then i = "" end
                    if not Tab:FindFirstChild(tostring(text).."TextOption"..tostring(i)) then
                        ending = "TextOption"..tostring(i)
                        break
                    end
                end
                library4["List"][text..ending] = TextOption
                TextOption.Name = text..ending
                TextOption.Parent = Tab
                TextOption.BackgroundColor3 = theme.LightContrast
                TextOption.BackgroundTransparency = 0
                TextOption.Position = UDim2.new(0.0506666675, 0, 0.514563084, 0)
                TextOption.Size = UDim2.new(0, 356, 0, 50)
                TextOption.Font = Enum.Font.SourceSans
                TextOption.Text = ""
                TextOption.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextOption.TextSize = 14.000

                UICorner_2.CornerRadius = UDim.new(0, 6)
                UICorner_2.Parent = TextOption

                Textbox6.Name = "Textbox"
                Textbox6.Parent = TextOption
                Textbox6.AnchorPoint = Vector2.new(0.5, 0.5)
                Textbox6.BackgroundColor3 = theme.DarkContrast
                Textbox6.BorderSizePixel = 0
                Textbox6.Position = UDim2.new(0.5, 0, 0.5, 0)
                Textbox6.Size = UDim2.new(0, 288, 0, 20)
                Textbox6.Font = Enum.Font.Gotham
                Textbox6.PlaceholderColor3 = theme.DarkTextColor
                Textbox6.PlaceholderText = "Value"
                Textbox6.Text = ""
                Textbox6.TextColor3 = theme.DescriptionTextColor
                Textbox6.TextSize = 14.000
                Textbox6.TextWrapped = true
                Textbox6.FocusLost:Connect(function()
                    local text = Textbox6.Text
                    library4["ListValues"][TextOption.Name] = text
                    spawn(function() callback(library4["ListValues"]) end)
                end)
                Textbox6.Focused:Connect(function()
                    if library4["ListValues"][TextOption.Name] then library4["ListValues"][TextOption.Name] = nil end
                end)

                Remove.Name = "Remove"
                Remove.Parent = TextOption
                Remove.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Remove.BackgroundTransparency = 1.000
                Remove.Position = UDim2.new(0.934339881, 0, 0.339999974, 0)
                Remove.Size = UDim2.new(0, 15, 0, 15)
                Remove.Font = Enum.Font.SourceSans
                Remove.Text = "X"
                Remove.TextColor3 = theme.TextColor
                Remove.TextSize = 18.000
                Remove.TextStrokeColor3 = Color3.fromRGB(4, 4, 21)
                Remove.MouseButton1Click:Connect(function()
                    if library4["ListValues"][TextOption.Name] then library4["ListValues"][TextOption.Name] = nil end
                    if library4["List"][TextOption.Name] then library4["List"][TextOption.Name] = nil end
                    TextOption:Remove()
                    spawn(function() callback(library4["ListValues"]) end)
                end)

                UICorner_3.CornerRadius = UDim.new(0, 6)
                UICorner_3.Parent = Textbox
            end

            function library4:Expand(bool)
                bool = bool or not library4["Expanded"]
                library4["Expanded"] = bool
                Tab.CanvasSize = UDim2.new(0, Tab.AbsoluteSize.X, 0, UIListLayout_2.AbsoluteContentSize.Y)
                for i,v in pairs(library4["List"]) do 
                    v.Visible = library4["Expanded"]
                end
            end
            Textlist.MouseButton1Click:Connect(function()
                library4:Expand()
            end)
            
            Add.MouseButton1Click:Connect(function()
                Tab.CanvasSize = UDim2.new(0, Tab.AbsoluteSize.X, 0, UIListLayout_2.AbsoluteContentSize.Y)
                library4:CreateTextOption()
                library4:Expand(true)
                local isFound = false
                for i,v in pairs(library2["Tabs"][name]) do 
                    if type(v) == "table" then
                        if v.Instance == Textlist then 
                            isFound = true
                        end
                        if isFound and v.Instance ~= Textlist then 
                            spawn(function()
                                local old = v.Instance.Parent
                                v.Instance.Parent = nil
                                v.Instance.Parent = old
                            end)
                        end
                    end
                end
            end)

            local obj = {
                ["Type"] = "TextList",
                ["Instance"] = Textlist,
                ["Api"] = library4,
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end 

        function library3:CreateColorSlider(text, callback)
            callback = callback or function() end
            local min,max = 0, 1
            local library4 = {}

            local ColorSlider = Instance.new("TextLabel")
            local UICorner = Instance.new("UICorner")
            local Icon = Instance.new("ImageLabel")
            local Title = Instance.new("TextLabel")
            local SliderBar = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local Slider = Instance.new("TextButton")
            local UICorner_3 = Instance.new("UICorner")
            local UIGradient = Instance.new("UIGradient")
            local Preview = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")

            ColorSlider.Name = text.."ColorSlider"
            ColorSlider.Parent = Tab
            ColorSlider.BackgroundColor3 = theme.LightContrast
            ColorSlider.BackgroundTransparency = 0
            ColorSlider.Position = UDim2.new(0, 0, 0.336569577, 0)
            ColorSlider.Size = UDim2.new(0, 375, 0, 50)
            ColorSlider.Font = Enum.Font.SourceSans
            ColorSlider.Text = ""
            ColorSlider.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorSlider.TextSize = 14.000

            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = ColorSlider

            Icon.Name = "Icon"
            Icon.Parent = ColorSlider
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.ClipsDescendants = true
            Icon.Position = UDim2.new(0.032333333, 0, 0.5, 0)
            Icon.Size = UDim2.new(0, 25, 0, 24)
            Icon.Image = "rbxassetid://3926305904"
            Icon.ImageRectOffset = Vector2.new(804, 924)
            Icon.ImageRectSize = Vector2.new(36, 36)
            Icon.SliceScale = 0.500
            Icon.ImageColor3 = theme.TextColor

            Title.Name = "Title"
            Title.Parent = ColorSlider
            Title.AnchorPoint = Vector2.new(0, 0.5)
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.141000003, 0, 0.5, 0)
            Title.Size = UDim2.new(0, 101, 0, 21)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = text
            Title.TextColor3 =  theme.TextColor
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            SliderBar.Name = "SliderBar"
            SliderBar.Parent = ColorSlider
            SliderBar.AnchorPoint = Vector2.new(0, 0.5)
            SliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderBar.BorderSizePixel = 0
            SliderBar.Position = UDim2.new(-0.0693333372, 170, 0.5, 0)
            SliderBar.Size = UDim2.new(0, 200, 0, 15)
            SliderBar.AutoButtonColor = false
            SliderBar.Text = ""

            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = SliderBar

            Slider.Name = "Slider"
            Slider.Parent = SliderBar
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider.Position = UDim2.new(0.05, 0, 0.5, 0)
            Slider.Size = UDim2.new(0, 20, 0, 20)
            Slider.AnchorPoint = Vector2.new(0, 0.5)
            Slider.AutoButtonColor = false
            Slider.Text = ""
            Slider.BorderSizePixel = 0

            UICorner_3.CornerRadius = UDim.new(0, 10000000)
            UICorner_3.Parent = Slider
            local seq = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)), ColorSequenceKeypoint.new(0.1, Color3.fromHSV(0.1, 1, 1)), ColorSequenceKeypoint.new(0.2, Color3.fromHSV(0.2, 1, 1)), ColorSequenceKeypoint.new(0.3, Color3.fromHSV(0.3, 1, 1)), ColorSequenceKeypoint.new(0.4, Color3.fromHSV(0.4, 1, 1)), ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)), ColorSequenceKeypoint.new(0.6, Color3.fromHSV(0.6, 1, 1)), ColorSequenceKeypoint.new(0.7, Color3.fromHSV(0.7, 1, 1)), ColorSequenceKeypoint.new(0.8, Color3.fromHSV(0.8, 1, 1)), ColorSequenceKeypoint.new(0.9, Color3.fromHSV(0.9, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))})
            UIGradient.Color = seq
            UIGradient.Parent = SliderBar

            Preview.Name = "Preview"
            Preview.Parent = ColorSlider
            Preview.AnchorPoint = Vector2.new(0, 0.5)
            Preview.BackgroundColor3 = Color3.fromRGB(238, 7, 7)
            Preview.BorderSizePixel = 0
            Preview.Position = UDim2.new(0.480000019, 170, 0.5, 0)
            Preview.Size = UDim2.new(0, 15, 0, 15)

            UICorner_4.CornerRadius = UDim.new(0, 6)
            UICorner_4.Parent = Preview
            function library4:SetValue(val)
                val = math.clamp(val, min, max)
                Preview.BackgroundColor3 = Color3.fromHSV(val, 1, 1)
                library4["Value"] = val
                Slider.Position = UDim2.new(math.clamp(val, 0.02, 0.95), -9, 0.5, 0)
                pcall(function()
                    spawn(function() callback(val) end)
                end)
            end

            function library4:SetRainbow(val)
                library4["RainbowValue"] = val
                if library4["RainbowValue"] then
                    local heh
                    heh = coroutine.resume(coroutine.create(function()
                        repeat
                            wait()
                            if library4["RainbowValue"] then
                                library4:SetValue(rainbowvalue)
                            else
                                coroutine.yield(heh)
                            end
                        until library4["RainbowValue"] == false or getgenv().EngoUILib == nil
                    end))
                end
            end
            
            SliderBar.MouseButton1Down:Connect(function()
                spawn(function()
                    click = true
                    wait(0.25)
                    click = false
                end)
                if click then
                    library4:SetRainbow(not library4["RainbowValue"])
                end
                local x,y,xscale,yscale,xscale2 = RelativeXY(SliderBar, UIS:GetMouseLocation())
                library4:SetValue(min + ((max - min) * xscale))
                Slider.Position = UDim2.new(math.clamp(xscale2, 0.02, 0.95), -9, 0.5, 0)
                local move
                local kill
                move = UIS.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local x,y,xscale,yscale,xscale2 = RelativeXY(SliderBar, UIS:GetMouseLocation())
                        library4:SetValue(min + ((max - min) * xscale))
                        Slider.Position = UDim2.new(math.clamp(xscale2, 0.02, 0.95), -9, 0.5, 0)
                    end
                end)
                kill = UIS.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        move:Disconnect()
                        kill:Disconnect()
                    end
                end)
            end)

            Slider.MouseButton1Down:Connect(function()
                spawn(function()
                    click = true
                    wait(0.25)
                    click = false
                end)
                if click then
                    library4:SetRainbow(not library4["RainbowValue"])
                end
                local x,y,xscale,yscale,xscale2 = RelativeXY(SliderBar, UIS:GetMouseLocation())
                library4:SetValue(min + ((max - min) * xscale))
                Slider.Position = UDim2.new(math.clamp(xscale2, 0.02, 0.95), -9, 0.5, 0)
                local move
                local kill
                move = UIS.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local x,y,xscale,yscale,xscale2 = RelativeXY(SliderBar, UIS:GetMouseLocation())
                        library4:SetValue(min + ((max - min) * xscale))
                        Slider.Position = UDim2.new(math.clamp(xscale2, 0.02, 0.95), -9, 0.5, 0)
                    end
                end)
                kill = UIS.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        move:Disconnect()
                        kill:Disconnect()
                    end
                end)
            end)


            local obj = {
                ["Type"] = "ColorSlider",
                ["Instance"] = ColorSlider,
                ["Api"] = library4
            }
            table.insert(library2["Tabs"][name], obj)
            library4["Object"] = obj
            return library4
        end

        return library3
    end
    function library2:CreateSettings()
        local settings = library2:CreateTab("Settings")
        local hidegui = settings:CreateBind("HideGUI", Enum.KeyCode.RightControl, function(value)
            library["Bind"] = value
        end)
        hidegui.Object.Instance.Icon:Destroy()
        local Icon = Instance.new("ImageLabel")
        Icon.Name = "Icon"
        Icon.Parent = hidegui.Object.Instance
        Icon.AnchorPoint = Vector2.new(0, 0.5)
        Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Icon.BackgroundTransparency = 1.000
        Icon.ClipsDescendants = true
        Icon.Position = UDim2.new(0.032333333, 0, 0.5, 0)
        Icon.Size = UDim2.new(0, 25, 0, 24)
        Icon.Image = "rbxassetid://3926307971"
        Icon.ImageRectOffset = Vector2.new(4, 484)
        Icon.ImageRectSize = Vector2.new(36, 36)
        Icon.SliceScale = 0.500

        local uninject = settings:CreateButton("RemoveGUI", function() 
            if getgenv().EngoUILib then 
                onSelfDestroy()
                getgenv().EngoUILib:Destroy()
            end
        end)
        return settings
    end

    function library2:CreateNotification(title, description, callback)
        callback = callback or function() end
        if EngoUI:FindFirstChild("Notification") then 
            EngoUI:FindFirstChild("Notification"):Destroy()
        end

        local Notification = Instance.new("TextLabel")
        local UICorner = Instance.new("UICorner")
        local Title = Instance.new("TextLabel")
        local Description = Instance.new("TextLabel")
        local TextButton = Instance.new("TextButton")
        local UICorner_2 = Instance.new("UICorner")
        local Cancel = Instance.new("TextButton")
        local UICorner_3 = Instance.new("UICorner")

        Notification.Name = "Notification"
        Notification.Parent = EngoUI
        Notification.BackgroundColor3 = theme.DarkContrast
        Notification.Position = UDim2.new(0.865, 0, 1.5, 0)
        Notification.Size = UDim2.new(0, 212, 0, 106)
        Notification.Font = Enum.Font.SourceSans
        Notification.Text = ""
        Notification.TextColor3 = Color3.fromRGB(0, 0, 0)
        Notification.TextSize = 14.000

        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Notification

        Title.Name = "Title"
        Title.Parent = Notification
        Title.AnchorPoint = Vector2.new(0, 0.5)
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.224436641, 0, 0.0993146822, 0)
        Title.Size = UDim2.new(0, 116, 0, 21)
        Title.Font = Enum.Font.GothamBold
        Title.Text = title
        Title.TextColor3 =  theme.TextColor
        Title.TextSize = 14.000

        Description.Name = "Description"
        Description.Parent = Notification
        Description.AnchorPoint = Vector2.new(0.5, 0.5)
        Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Description.BackgroundTransparency = 1.000
        Description.Position = UDim2.new(0.501638174, 0, 0.412353516, 0)
        Description.Size = UDim2.new(0, 186, 0, 44)
        Description.Font = Enum.Font.Gotham
        Description.Text = description
        Description.TextColor3 = theme.DescriptionTextColor
        Description.TextSize = 14.000
        Description.TextWrapped = true
        Description.TextYAlignment = Enum.TextYAlignment.Top

        TextButton.Parent = Notification
        TextButton.BackgroundColor3 = theme.LightContrast
        TextButton.BorderSizePixel = 0
        TextButton.Position = UDim2.new(0.0605381206, 0, 0.710715532, 0)
        TextButton.Size = UDim2.new(0, 89, 0, 22)
        TextButton.Font = Enum.Font.SourceSans
        TextButton.Text = "OK"
        TextButton.TextColor3 =  theme.TextColor
        TextButton.TextSize = 14.000
        TextButton.MouseButton1Click:Connect(function()
            spawn(function() callback(true) end)
            spawn(function()
                local goal,timing = UDim2.new(1.5, 0, 0.8, 0), 3
                Notification:TweenPosition(goal, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, timing)
                wait(timing)
                Notification:Destroy()
            end)
        end)

        UICorner_2.CornerRadius = UDim.new(0, 6)
        UICorner_2.Parent = TextButton

        Cancel.Name = "Cancel"
        Cancel.Parent = Notification
        Cancel.BackgroundColor3 = theme.LightContrast
        Cancel.BorderSizePixel = 0
        Cancel.Position = UDim2.new(0.53629154, 0, 0.710715532, 0)
        Cancel.Size = UDim2.new(0, 85, 0, 22)
        Cancel.Font = Enum.Font.SourceSans
        Cancel.Text = "CANCEL"
        Cancel.TextColor3 =  theme.TextColor
        Cancel.TextSize = 14.000
        Cancel.MouseButton1Click:Connect(function()
            spawn(function() callback(false) end)
            spawn(function()
                local goal,timing = UDim2.new(1.5, 0, 0.8, 0), 3
                Notification:TweenPosition(goal, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, timing)
                wait(timing)
                Notification:Destroy()
            end)
        end)

        UICorner_3.CornerRadius = UDim.new(0, 6)
        UICorner_3.Parent = Cancel
        -- Animation:
        spawn(function()
            local goal = UDim2.new(0.865, 0, 0.8, 0)
            Notification:TweenPosition(goal, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5)
        end)
    end

    return library2
end

return library