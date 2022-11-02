-- ui lib
local Library = {}

function Library:GetColor(color, table)
    table = table or false
    if (color.R == nil) then return Color3.fromRGB(19, 119, 255) end

    local ColorRed = math.round(color.R * 255)
    local ColorGreen = math.round(color.G * 255)
    local ColorBlue = math.round(color.B * 255)

    if (table) then
        return {
            Red = ColorRed,
            Green = ColorGreen,
            Blue = ColorBlue,
        }
    else
        return Color3.fromRGB(ColorRed, ColorGreen, ColorBlue)
    end
end

function Library:GetSide(LeftSize, RightSize)
    if LeftSize - 1 > RightSize - 1 then
        return "Right"
    else
        return "Left"
    end
end

function Library:CreateWindow(title, color)
    title = title or "Bracket Lib V2"
    color = color and Library:GetColor(color) or Color3.fromRGB(19, 119, 255)

    -- Window Main
    local WinTypes = {}
    local WindowDragging, SliderDragging, ColorPickerDragging = false, false, false
    local oldcolor = nil
    local keybind = "RightControl"
    local cancbind = false

    -- Window Instances
    local BracketV2 = Instance.new("ScreenGui")
    local core = Instance.new("Frame")
    local title_18 = Instance.new("TextLabel")
    local outlinecore = Instance.new("Frame")
    local inline = Instance.new("Frame")
    local inlineoutline = Instance.new("Frame")
    local inlinecore = Instance.new("Frame")
    local tabbar = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local container = Instance.new("Frame")

    -- Window Properties
    BracketV2.Name = title
    BracketV2.Parent = game.CoreGui
    BracketV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    core.Name = "core"
    core.Parent = BracketV2
    core.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    core.BorderColor3 = Color3.fromRGB(8, 8, 8)
    core.Position = UDim2.new(0.156000003, 0, 0.140000001, 0)
    core.Size = UDim2.new(0, 540, 0, 531)

    outlinecore.Name = "outlinecore"
    outlinecore.Parent = core
    outlinecore.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    outlinecore.BorderSizePixel = 0
    outlinecore.Position = UDim2.new(0, 1, 0, 1)
    outlinecore.Size = UDim2.new(0, 538, 0, 529)

    title_18.Name = "title"
    title_18.Parent = outlinecore
    title_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title_18.BackgroundTransparency = 1.000
    title_18.Position = UDim2.new(0.0185185187, 0, 0.00188323914, 0)
    title_18.Size = UDim2.new(0, 521, 0, 23)
    title_18.Font = Enum.Font.SourceSans
    title_18.Text = title
    title_18.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_18.TextSize = 18.000
    title_18.TextStrokeTransparency = 0.000
    title_18.TextXAlignment = Enum.TextXAlignment.Left

    inline.Name = "inline"
    inline.Parent = outlinecore
    inline.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    inline.BorderSizePixel = 0
    inline.Position = UDim2.new(0, 7, 0, 23)
    inline.Size = UDim2.new(0, 525, 0, 500)

    inlineoutline.Name = "inlineoutline"
    inlineoutline.Parent = inline
    inlineoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    inlineoutline.BorderSizePixel = 0
    inlineoutline.Position = UDim2.new(0, 1, 0, 1)
    inlineoutline.Size = UDim2.new(0, 523, 0, 498)

    inlinecore.Name = "inlinecore"
    inlinecore.Parent = inlineoutline
    inlinecore.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    inlinecore.BorderSizePixel = 0
    inlinecore.Position = UDim2.new(0, 1, 0, 1)
    inlinecore.Size = UDim2.new(0, 521, 0, 496)

    tabbar.Name = "tabbar"
    tabbar.Parent = inlinecore
    tabbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    tabbar.BorderColor3 = Color3.fromRGB(8, 8, 8)
    tabbar.Size = UDim2.new(0, 521, 0, 25)

    UIListLayout.Parent = tabbar
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    container.Name = "container"
    container.Parent = inlinecore
    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    container.BackgroundTransparency = 1.000
    container.BorderSizePixel = 0
    container.Position = UDim2.new(0, 0, 0.0504032262, 0)
    container.Size = UDim2.new(1, 0, 0.949596763, 0)

    -- Window Dragging
    local userinputservice = game:GetService("UserInputService")
    local dragInput, dragStart, startPos = nil, nil, nil

    core.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
            dragStart = input.Position
            startPos = core.Position
            WindowDragging = true
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    WindowDragging = false
                end
            end)
        end
    end)

    core.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    userinputservice.InputChanged:Connect(function(input)
        if input == dragInput and WindowDragging and not SliderDragging and not ColorPickerDragging then
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            core.Position = Position
        end
    end)

    userinputservice.InputBegan:Connect(function(input)
        if (cancbind) then
            if (input.KeyCode == Enum.KeyCode[keybind]) then
                BracketV2.Enabled = not BracketV2.Enabled
            end
        else
            if (input.KeyCode == Enum.KeyCode.RightControl) then
                BracketV2.Enabled = not BracketV2.Enabled
            end
        end
    end)

    -- Window Types
    function WinTypes:Destroy()
        BracketV2:Destory()
    end

    function WinTypes:UpdateColor(newcolor)
        color = Library:GetColor(newcolor)
    end

    function WinTypes:UpdateBind(bind, custombind)
        keybind = bind
        cancbind = custombind
    end

    function WinTypes:CreateTab(name, players)
        name = name or "NewTab"
        players = players or false

        -- Tab Main
        local TabTypes = {}

        -- Tab Instances
        local tab = Instance.new("TextButton")
        local title = Instance.new("TextLabel")
        local UIGradient = Instance.new("UIGradient")
        local Pattern = Instance.new("ImageLabel")
        local Left = Instance.new("ScrollingFrame")
        local UIPadding = Instance.new("UIPadding")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local Right = Instance.new("ScrollingFrame")
        local UIPadding_3 = Instance.new("UIPadding")
        local UIListLayout_5 = Instance.new("UIListLayout")

        -- Tab Properties
        tab.Name = "tab"
        tab.Parent = tabbar
        tab.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        tab.BorderColor3 = Color3.fromRGB(35, 35, 35)
        tab.BorderSizePixel = 0
        tab.Size = UDim2.new(0, tabbar.AbsoluteSize.X / (#tabbar:GetChildren() - 1), 0, 25)
        tab.Font = Enum.Font.SourceSans
        tab.Text = ""
        tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.TextSize = 18.000
        tab.TextStrokeTransparency = 0.000
        tab.TextWrapped = true
        
        title.Name = "title"
        title.Parent = tab
        title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        title.BackgroundTransparency = 1.000
        title.Size = UDim2.new(1, 0, 1, 0)
        title.Font = Enum.Font.SourceSans
        title.Text = name
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 18.000
        title.TextStrokeTransparency = 0.000
        
        UIGradient.Enabled = false
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
        UIGradient.Rotation = 90
        UIGradient.Parent = tab
        UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 0.00)}

        Pattern.Name = "container"
        Pattern.Parent = container
        Pattern.AnchorPoint = Vector2.new(0.5, 0.5)
        Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Pattern.BackgroundTransparency = 1.000
        Pattern.Position = UDim2.new(0.499520153, 0, 0.499957234, 0)
        Pattern.Size = UDim2.new(0, 521, 0, 471)
        Pattern.ZIndex = 9
        Pattern.Image = "rbxassetid://2151741365"
        Pattern.ImageTransparency = 0.600
        Pattern.ScaleType = Enum.ScaleType.Tile
        Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
        Pattern.TileSize = UDim2.new(0, 250, 0, 250)
        Pattern.Visible = false

        if (not players) then
            Left.Name = "Left"
            Left.Parent = Pattern
            Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Left.BackgroundTransparency = 1.000
            Left.Size = UDim2.new(0, 260, 0, 471)
            Left.BottomImage = ""
            Left.CanvasSize = UDim2.new(0, 0, 0, 0)
            Left.ScrollBarThickness = 0
            Left.TopImage = ""
            
            UIPadding.Parent = Left
            UIPadding.PaddingLeft = UDim.new(0, 3)
            UIPadding.PaddingTop = UDim.new(0, 8)
            
            UIListLayout_2.Parent = Left
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.Padding = UDim.new(0, 8)

            Right.Name = "Right"
            Right.Parent = Pattern
            Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Right.BackgroundTransparency = 1.000
            Right.Position = UDim2.new(0.499040306, 0, 0, 0)
            Right.Size = UDim2.new(0, 260, 0, 471)
            Right.BottomImage = ""
            Right.CanvasSize = UDim2.new(0, 0, 0, 0)
            Right.ScrollBarThickness = 0
            Right.TopImage = ""
            
            UIPadding_3.Parent = Right
            UIPadding_3.PaddingLeft = UDim.new(0, 3)
            UIPadding_3.PaddingTop = UDim.new(0, 8)
            
            UIListLayout_5.Parent = Right
            UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_5.Padding = UDim.new(0, 8)

            UIListLayout_5:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Right.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_5.AbsoluteContentSize.Y + 15)
            end)

            UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Left.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 15)
            end)
        end

        -- Tab Code
        for i,v in pairs(tabbar:GetChildren()) do
            if (v.Name:find("tab")) then
                v.Size = UDim2.new(0, tabbar.AbsoluteSize.X / (#tabbar:GetChildren() - 1), 0, 25)
            end
        end

        tab.MouseButton1Click:Connect(function()
            tab.BackgroundColor3 = color
            UIGradient.Enabled = true
            Pattern.Visible = true

            for i,v in pairs(tabbar:GetChildren()) do
                if (v.Name:find("tab") and v ~= tab) then
                    v.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    v.UIGradient.Enabled = false
                end
            end

            for i,v in pairs(container:GetChildren()) do
                if (v.Name:find("container") and v ~= Pattern) then
                    v.Visible = false
                end
            end
        end)

        -- Tab Types
        function TabTypes:CreateGroupbox(name, side)
            name = name or "NewGroupbox"
            side = side and side or Library:GetSide(#Left:GetChildren(), #Right:GetChildren())

            -- Groupbox Main
            local GroupTypes = {}

            -- Groupbox Instances
            local groupboxoutline = Instance.new("Frame")
            local groupboxinline = Instance.new("Frame")
            local background = Instance.new("Frame")
            local title_2 = Instance.new("TextLabel")
            local container_2 = Instance.new("Frame")
            local UIPadding_2 = Instance.new("UIPadding")
            local UIListLayout_3 = Instance.new("UIListLayout")

            -- Groupbox Properties
            groupboxoutline.Name = "groupboxoutline"
            groupboxoutline.Parent = Pattern[side]
            groupboxoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            groupboxoutline.BorderSizePixel = 0
            groupboxoutline.Position = UDim2.new(0.0115384618, 0, 0.0169851389, 0)
            groupboxoutline.Size = UDim2.new(0, 254, 0, 40)
            
            groupboxinline.Name = "groupboxinline"
            groupboxinline.Parent = groupboxoutline
            groupboxinline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            groupboxinline.BorderSizePixel = 0
            groupboxinline.Position = UDim2.new(0, 1, 0, 1)
            groupboxinline.Size = UDim2.new(0, 252, 0, 38)
            
            background.Name = "background"
            background.Parent = groupboxinline
            background.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            background.BorderSizePixel = 0
            background.Position = UDim2.new(0, 1, 0, 1)
            background.Size = UDim2.new(0, 250, 0, 36)
            
            title_2.Name = "title"
            title_2.Parent = background
            title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            title_2.BackgroundTransparency = 1.000
            title_2.Position = UDim2.new(0, 15, 0, -10)
            title_2.Size = UDim2.new(0, 240, 0, 20)
            title_2.Font = Enum.Font.SourceSans
            title_2.Text = name
            title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            title_2.TextSize = 15.000
            title_2.TextStrokeTransparency = 0.000
            title_2.TextXAlignment = Enum.TextXAlignment.Left
            
            container_2.Name = "container"
            container_2.Parent = background
            container_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            container_2.BackgroundTransparency = 1.000
            container_2.Position = UDim2.new(0, 0, 0, 10)
            container_2.Size = UDim2.new(0, 250, 0, 26)
            
            UIPadding_2.Parent = container_2
            UIPadding_2.PaddingLeft = UDim.new(0, 10)
            UIPadding_2.PaddingTop = UDim.new(0, 5)
            
            UIListLayout_3.Parent = container_2
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_3.Padding = UDim.new(0, 7)

            UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                groupboxoutline.Size = UDim2.new(0, 254, 0, (UIListLayout_3.AbsoluteContentSize.Y) + 30)
                groupboxinline.Size = UDim2.new(0, 252, 0, (UIListLayout_3.AbsoluteContentSize.Y - 2)  + 30)
                background.Size = UDim2.new(0, 250, 0, (UIListLayout_3.AbsoluteContentSize.Y - 4)  + 30)
                container_2.Size = UDim2.new(0, 250, 0, (UIListLayout_3.AbsoluteContentSize.Y - 14) + 30)
            end)

            -- Groupbox Types
            function GroupTypes:CreateToggle(name, callback)
                name = name or "New Toggle"
                callback = callback or function(v) print(v) end

                -- Toggle Main
                local ToggleTypes = {}
                local Enabled = false

                -- Toggle Instances
                local checkbox = Instance.new("Frame")
                local UIGradient_2 = Instance.new("UIGradient")
                local title_3 = Instance.new("TextLabel")
                local main = Instance.new("TextButton")

                -- Toggle Properties
                checkbox.Name = "checkbox"
                checkbox.Parent = container_2
                checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                checkbox.BorderColor3 = Color3.fromRGB(8, 8, 8)
                checkbox.Size = UDim2.new(0, 12, 0, 12)
                checkbox.ZIndex = 0
                
                UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_2.Rotation = 90
                UIGradient_2.Parent = checkbox
                
                title_3.Name = "title"
                title_3.Parent = checkbox
                title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_3.BackgroundTransparency = 1.000
                title_3.Position = UDim2.new(1.58333337, 0, 0, 0)
                title_3.Size = UDim2.new(0, 215, 0, 12)
                title_3.Font = Enum.Font.SourceSans
                title_3.Text = name
                title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_3.TextSize = 15.000
                title_3.TextStrokeTransparency = 0.000
                title_3.TextXAlignment = Enum.TextXAlignment.Left
                
                main.Name = "main"
                main.Parent = checkbox
                main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                main.BackgroundTransparency = 1.000
                main.Size = UDim2.new(19.5, 0, 1, 0)
                main.Font = Enum.Font.SourceSans
                main.Text = ""
                main.TextColor3 = Color3.fromRGB(0, 0, 0)
                main.TextSize = 14.000

                -- Toggle Code
                local ToggleCallback = callback

                game.RunService.Heartbeat:Connect(function()
                    if (checkbox.BackgroundColor3 == oldcolor) then
                        checkbox.BackgroundColor3 = color
                    end
                end)

                main.MouseButton1Click:Connect(function()
                    Enabled = not Enabled

                    if (Enabled) then
                        checkbox.BackgroundColor3 = color
                    else
                        checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end

                    callback(Enabled)
                end)

                -- Toggle Types
                function ToggleTypes:SetState(state)
                    state = state or false
                    Enabled = state

                    if (Enabled) then
                        checkbox.BackgroundColor3 = color
                    else
                        checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end

                    callback(Enabled)
                end

                function ToggleTypes:GetState()
                    return Enabled
                end

                function ToggleTypes:CreateKeyBind(def, callback)
                    def = def or "NONE"

                    -- Keybind Main
                    local keytypes = {}

                    -- Keybind Instances
                    local bindtext = Instance.new("TextLabel")
                    local keymain = Instance.new("TextButton")

                    -- Keybind Properties
                    bindtext.Name = "bindtext"
                    bindtext.Parent = checkbox
                    bindtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bindtext.BackgroundTransparency = 1.000
                    bindtext.BorderSizePixel = 0
                    bindtext.Position = UDim2.new(13.5, 0, 0, 0)
                    bindtext.Size = UDim2.new(0, 71, 0, 12)
                    bindtext.Font = Enum.Font.SourceSans
                    bindtext.Text = "[ " .. def .. " ]"
                    bindtext.TextColor3 = Color3.fromRGB(176, 176, 176)
                    bindtext.TextSize = 14.000
                    bindtext.TextStrokeTransparency = 0.000
                    bindtext.TextXAlignment = Enum.TextXAlignment.Right

                    keymain.Name = "keymain"
                    keymain.Parent = bindtext
                    keymain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keymain.BackgroundTransparency = 1.000
                    keymain.Size = UDim2.new(1, 0, 1, 0)
                    keymain.Font = Enum.Font.SourceSans
                    keymain.TextColor3 = Color3.fromRGB(0, 0, 0)
                    keymain.TextSize = 14.000
                    keymain.Text = ""

                    -- Keybind Codes
                    local WaitingForBind = false
                    local Clicked = false
                    local Sel = def
                    local Blacklisted = { "W", "A", "S", "D", "Slash", "Tab", "Backspace", "Escape", "Space", "Delete", "Unknown" }

                    keymain.MouseButton1Click:Connect(function()
                        Clicked = true
                        bindtext.Text = "[ ... ]"
                    end)

                    game.RunService.Heartbeat:Connect(function()
                        if (WaitingForBind == false) then
                            if (Clicked == true) then
                                WaitingForBind = true
                                Clicked = false
                            end
                        end
                    end)

                    userinputservice.InputBegan:Connect(function(Input)
                        if (WaitingForBind and Input.UserInputType == Enum.UserInputType.Keyboard) then
                            local Key = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")

                            if (not table.find(Blacklisted, Key)) then
                                bindtext.Text = "[ " .. Key .. " ]"
                            else
                                bindtext.Text = "[ NONE ]"
                            end

                            Sel = Key
                            WaitingForBind = false
                        else
                            if (Input.UserInputType == Enum.UserInputType.Keyboard) then
                                local Key = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")

                                if (Key == Sel) then
                                    Enabled = not Enabled

                                    if (Enabled) then
                                        checkbox.BackgroundColor3 = color
                                    else
                                        checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                                    end

                                    if (callback) then
                                        callback(Key)
                                    else
                                        ToggleCallback(Enabled)
                                    end
                                end
                            end
                        end
                    end)

                    function keytypes:SetBind(key)
                        bindtext.Text = "[ " .. key .. " ]"
                        Sel = key
                    end

                    function keytypes:GetBind()
                        return Sel
                    end

                    return keytypes
                end

                return ToggleTypes
            end

            function GroupTypes:CreateSlider(name, min, max, def, callback)
                name = name or "New Slider"
                min = min or 0
                max = max or 100
                def = def or 50
                callback = callback or function(s) print(s) end

                -- Slider Main
                local SliderTypes = {}
                local Dragging = false
                local Value = 0

                -- Slider Instances
                local title_15 = Instance.new("TextLabel")
                local slider = Instance.new("Frame")
                local UIGradient_15 = Instance.new("UIGradient")
                local bar = Instance.new("Frame")
                local UIGradient_16 = Instance.new("UIGradient")
                local value = Instance.new("TextLabel")

                -- Slider Properties
                title_15.Name = "title"
                title_15.Parent = container_2
                title_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_15.BackgroundTransparency = 1.000
                title_15.Position = UDim2.new(0, 10, 0, 51)
                title_15.Size = UDim2.new(0, 234, 0, 37)
                title_15.ZIndex = 0
                title_15.Font = Enum.Font.SourceSans
                title_15.Text = name
                title_15.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_15.TextSize = 15.000
                title_15.TextStrokeTransparency = 0.000
                title_15.TextXAlignment = Enum.TextXAlignment.Left
                title_15.TextYAlignment = Enum.TextYAlignment.Top

                slider.Name = "slider"
                slider.Parent = title_15
                slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                slider.BorderColor3 = Color3.fromRGB(8, 8, 8)
                slider.Position = UDim2.new(0, 0, 0, 22)
                slider.Size = UDim2.new(0, 234, 0, 15)
                
                UIGradient_15.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_15.Rotation = 90
                UIGradient_15.Parent = slider
                
                bar.Name = "bar"
                bar.Parent = slider
                bar.BackgroundColor3 = color
                bar.BorderColor3 = Color3.fromRGB(27, 42, 53)
                bar.BorderSizePixel = 0
                bar.Size = UDim2.new(0, 50, 1, 0)
                
                UIGradient_16.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_16.Rotation = 90
                UIGradient_16.Parent = bar
                
                value.Name = "value"
                value.Parent = slider
                value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                value.BackgroundTransparency = 1.000
                value.Size = UDim2.new(1, 0, 1, 0)
                value.Font = Enum.Font.SourceSans
                value.Text = min .. "/" .. max
                value.TextColor3 = Color3.fromRGB(255, 255, 255)
                value.TextSize = 14.000
                value.TextStrokeTransparency = 0.000

                -- Slider Code
                bar.Size = UDim2.new(def / max, 0, 1, 0)
                value.Text = def .. "/" .. max
                
                local function Slide(input)
                    local pos = UDim2.new(math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1), 0, 1, 0)
                    bar.Size = pos
                    local s = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                    Value = s
                    value.Text = tostring(s) .. "/" .. max
                    callback(Value)
                end

                slider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Slide(input)
                        Dragging = true
                        SliderDragging = true
                    end
                end)
    
                slider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                        SliderDragging = false
                    end
                end)
    
                userinputservice.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        Slide(input)
                    end
                end)

                -- Slider Types
                function SliderTypes:SetValue(s)
                    s = s or 0
                    Value = s
                    bar.Size = UDim2.new(Value / max, 0, 1, 0)
                    value.Text = tostring(Value) .. "/" .. max
                    callback(Value)
                end

                function SliderTypes:GetValue()
                    return Value
                end

                return SliderTypes
            end

            function GroupTypes:CreateDropdown(name, options, callback)
                name = name or "Dropdown"
                options = options or {}
                callback = callback or function(o) print(o) end

                -- Dropdown Main
                local DropTypes = {}
                local Selected = ""

                -- Dropdown Instances
                local title_15 = Instance.new("TextLabel")
                local combobox = Instance.new("Frame")
                local main_2 = Instance.new("TextButton")
                local UIGradient_3 = Instance.new("UIGradient")
                local title_4 = Instance.new("TextLabel")
                local list = Instance.new("Frame")
                local UIGradient_4 = Instance.new("UIGradient")
                local UIListLayout_4 = Instance.new("UIListLayout")

                -- Dropdown Properties
                title_15.Name = "title"
                title_15.Parent = container_2
                title_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_15.BackgroundTransparency = 1.000
                title_15.Position = UDim2.new(0, 10, 0, 51)
                title_15.Size = UDim2.new(0, 234, 0, 42)
                title_15.ZIndex = 0
                title_15.Font = Enum.Font.SourceSans
                title_15.Text = name
                title_15.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_15.TextSize = 15.000
                title_15.TextStrokeTransparency = 0.000
                title_15.TextXAlignment = Enum.TextXAlignment.Left
                title_15.TextYAlignment = Enum.TextYAlignment.Top

                combobox.Name = "combobox"
                combobox.Parent = title_15
                combobox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                combobox.BorderColor3 = Color3.fromRGB(8, 8, 8)
                combobox.Position = UDim2.new(0, 0, 0, 22)
                combobox.Size = UDim2.new(0, 234, 0, 20)

                main_2.Name = "main"
                main_2.Parent = combobox
                main_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                main_2.BackgroundTransparency = 1.000
                main_2.Size = UDim2.new(1, 0, 1, 0)
                main_2.Font = Enum.Font.SourceSans
                main_2.Text = ""
                main_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                main_2.TextSize = 14.000
                
                UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_3.Rotation = 90
                UIGradient_3.Parent = combobox
                
                title_4.Name = "title"
                title_4.Parent = combobox
                title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_4.BackgroundTransparency = 1.000
                title_4.Position = UDim2.new(0, 11, 0, 0)
                title_4.Size = UDim2.new(0, 223, 0, 20)
                title_4.Font = Enum.Font.SourceSans
                title_4.Text = "..."
                title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_4.TextSize = 15.000
                title_4.TextStrokeTransparency = 0.000
                title_4.TextXAlignment = Enum.TextXAlignment.Left
                
                list.Name = "list"
                list.Parent = combobox
                list.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                list.BorderColor3 = Color3.fromRGB(8, 8, 8)
                list.Position = UDim2.new(0, 0, 1, 0)
                list.Size = UDim2.new(0, 234, 0, 5)
                list.Visible = false
                
                UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_4.Rotation = 90
                UIGradient_4.Parent = list
                
                UIListLayout_4.Parent = list
                UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

                UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    list.Size = UDim2.new(0, 234, 0, UIListLayout_4.AbsoluteContentSize.Y)
                end)

                -- Dropdown Code
                main_2.MouseButton1Click:Connect(function()
                    title_15.ZIndex = 9
                    list.Visible = not list.Visible

                    for i,v in pairs(container_2:GetChildren()) do
                        if (v ~= title_15 and not v.Name:find("UI")) then
                            v.ZIndex = 0
                        end
                    end
                end)

                if (#options > 0) then
                    for i,v in pairs(options) do
                        local item = Instance.new("TextButton")
                        local UIGradient_5 = Instance.new("UIGradient")
                        local title_5 = Instance.new("TextLabel")
                        
                        item.Name = "item"
                        item.Parent = list
                        item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        item.BorderSizePixel = 0
                        item.Size = UDim2.new(1, 0, 0, 19)
                        item.Font = Enum.Font.SourceSans
                        item.Text = ""
                        item.TextColor3 = Color3.fromRGB(0, 0, 0)
                        item.TextSize = 14.000
                        
                        UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                        UIGradient_5.Rotation = 90
                        UIGradient_5.Parent = item
                        UIGradient_5.Enabled = false

                        title_5.Name = "title"
                        title_5.Parent = item
                        title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        title_5.BackgroundTransparency = 1.000
                        title_5.Size = UDim2.new(1, 0, 1, 0)
                        title_5.Font = Enum.Font.SourceSans
                        title_5.Text = v
                        title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
                        title_5.TextSize = 14.000
                        title_5.TextStrokeTransparency = 0.000

                        item.MouseButton1Click:Connect(function()
                            UIGradient_5.Enabled = true
                            item.BackgroundColor3 = color

                            for i,v in pairs(list:GetChildren()) do
                                if (v.Name:find("item") and v ~= item) then
                                    v.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                    v.UIGradient.Enabled = false
                                end
                            end

                            Selected = v
                            title_4.Text = Selected
                            callback(Selected)
                        end)
                    end
                end

                -- Dropdown Types
                function DropTypes:SetOption(option)
                    option = option or options[1]
                    Selected = tostring(option)
                    
                    for i,v in pairs(list:GetChildren()) do
                        if (v.Name:find("item")) then
                            if (v.Text == Selected) then
                                v.BackgroundColor3 = color
                                v.UIGradient.Enabled = true
                            else
                                v.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                v.UIGradient.Enabled = false
                            end
                        end
                    end

                    title_4.Text = Selected
                    callback(Selected)
                end

                function DropTypes:GetOption()
                    return Selected
                end

                return DropTypes
            end

            function GroupTypes:CreateButton(name, callback)
                name = name or "New Button"
                callback = callback or function() print("clicked") end

                -- Button Instances
                local Button = Instance.new("TextButton")
                local UIGradient_17 = Instance.new("UIGradient")
                local title_16 = Instance.new("TextLabel")

                -- Button Properties
                Button.Name = "Button"
                Button.Parent = container_2
                Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Button.BorderColor3 = Color3.fromRGB(8, 8, 8)
                Button.Position = UDim2.new(0.0399999991, 0, 0.273542613, 0)
                Button.Size = UDim2.new(0, 234, 0, 20)
                Button.ZIndex = 0
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14.000
                
                UIGradient_17.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_17.Rotation = 90
                UIGradient_17.Parent = Button
                
                title_16.Name = "title"
                title_16.Parent = Button
                title_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_16.BackgroundTransparency = 1.000
                title_16.Size = UDim2.new(1, 0, 1, 0)
                title_16.Font = Enum.Font.SourceSans
                title_16.Text = name
                title_16.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_16.TextSize = 15.000
                title_16.TextStrokeTransparency = 0.000

                -- Button Code
                Button.MouseButton1Click:Connect(function()
                    callback()
                end)
            end

            function GroupTypes:CreateColorPicker(name, def, callback)
                name = name or "New ColorPicker"
                def = def or Color3.fromRGB(255, 255, 255)
                callback = callback or function(s) print(s) end

                -- ColorPicker Main
                local ColorTypes = {}
                local Dragging = false
                local ColorInput = nil
                local HueInput = nil
                local ColorH = 5
                local ColorS = 1
                local ColorV = 1
                local SelectedColor = def

                -- ColorPicker Instances
                local colorpicker = Instance.new("Frame")
                local UIGradient_18 = Instance.new("UIGradient")
                local title_17 = Instance.new("TextLabel")
                local main_3 = Instance.new("TextButton")
                local colorframe = Instance.new("Frame")
                local inline_2 = Instance.new("Frame")
                local bg = Instance.new("Frame")
                local gradient = Instance.new("ImageLabel")
                local colorselection = Instance.new("ImageLabel")
                local colorslider = Instance.new("Frame")
                local UIGradient_20 = Instance.new("UIGradient")
                local bar_2 = Instance.new("Frame")

                -- ColorPicker Properties
                colorpicker.Name = "colorpicker"
                colorpicker.Parent = container_2
                colorpicker.BackgroundColor3 = def
                colorpicker.BorderColor3 = Color3.fromRGB(8, 8, 8)
                colorpicker.Position = UDim2.new(0.0399999991, 0, 0.734939754, 0)
                colorpicker.Size = UDim2.new(0, 19, 0, 19)
                colorpicker.ZIndex = 0
                
                UIGradient_18.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_18.Rotation = 90
                UIGradient_18.Parent = colorpicker
                
                title_17.Name = "title"
                title_17.Parent = colorpicker
                title_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_17.BackgroundTransparency = 1.000
                title_17.Position = UDim2.new(1.5833323, 0, 0, 0)
                title_17.Size = UDim2.new(0, 203, 0, 19)
                title_17.Font = Enum.Font.SourceSans
                title_17.Text = name
                title_17.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_17.TextSize = 15.000
                title_17.TextStrokeTransparency = 0.000
                title_17.TextXAlignment = Enum.TextXAlignment.Left
                
                main_3.Name = "main"
                main_3.Parent = colorpicker
                main_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                main_3.BackgroundTransparency = 1.000
                main_3.Size = UDim2.new(12.3157892, 0, 1, 0)
                main_3.Font = Enum.Font.SourceSans
                main_3.Text = ""
                main_3.TextColor3 = Color3.fromRGB(0, 0, 0)
                main_3.TextSize = 14.000
                
                colorframe.Name = "colorframe"
                colorframe.Parent = BracketV2
                colorframe.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                colorframe.BorderColor3 = Color3.fromRGB(8, 8, 8)
                colorframe.BorderSizePixel = 0
                colorframe.Position = UDim2.new(0, 0, 0, 0)
                colorframe.Size = UDim2.new(0, 178, 0, 151)
                colorframe.Visible = false
                colorframe.ZIndex = 1
                
                inline_2.Name = "inline"
                inline_2.Parent = colorframe
                inline_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                inline_2.BorderSizePixel = 0
                inline_2.Position = UDim2.new(0, 1, 0, 1)
                inline_2.Size = UDim2.new(0, 176, 0, 149)
                
                bg.Name = "bg"
                bg.Parent = inline_2
                bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                bg.BorderSizePixel = 0
                bg.Position = UDim2.new(0, 1, 0, 1)
                bg.Size = UDim2.new(0, 174, 0, 147)
                
                gradient.Name = "gradient"
                gradient.Parent = bg
                gradient.BackgroundColor3 = def
                gradient.BorderColor3 = Color3.fromRGB(8, 8, 8)
                gradient.Position = UDim2.new(0, 10, 0, 10)
                gradient.Size = UDim2.new(0, 154, 0, 104)
                gradient.ZIndex = 10
                gradient.Image = "rbxassetid://4155801252"

                colorselection.Name = "colorselection"
                colorselection.Parent = gradient
                colorselection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorselection.BackgroundTransparency = 1.000
                colorselection.ZIndex = 25
                colorselection.AnchorPoint = Vector2.new(0.5, 0.5)
                colorselection.Position = UDim2.new(def and select(3, Color3.toHSV(def)))
                colorselection.Size = UDim2.new(0, 18, 0, 18)
                colorselection.Image = "rbxassetid://4953646208"
                colorselection.ScaleType = Enum.ScaleType.Fit
                
                colorslider.Name = "colorslider"
                colorslider.Parent = bg
                colorslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorslider.BorderColor3 = Color3.fromRGB(8, 8, 8)
                colorslider.Position = UDim2.new(0.0574712642, 0, 0.84353739, 0)
                colorslider.Size = UDim2.new(0, 154, 0, 15)
                
                UIGradient_20.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 0, 251)),
                    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 17, 255)),
                    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(21, 255, 0)),
                    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(234, 255, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
                }
                UIGradient_20.Parent = colorslider
                
                bar_2.Name = "bar"
                bar_2.Parent = colorslider
                bar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                bar_2.BorderColor3 = Color3.fromRGB(8, 8, 8)
                bar_2.Size = UDim2.new(0, 1, 1, 0)

                -- ColorPicker Code
                local function UpdateColor()
                    colorpicker.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                    gradient.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                    SelectedColor = colorpicker.BackgroundColor3
                    callback(SelectedColor)
                end

                UpdateColor()

                local ColorDragging = false
                local dragInput, dragStart, startPos = nil, nil, nil
                local Mouse = game.Players.LocalPlayer:GetMouse()

                colorframe.InputBegan:Connect(function(input)
                    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
                        dragStart = input.Position
                        startPos = colorframe.Position
                        ColorDragging = true
                        ColorPickerDragging = true
                        input.Changed:Connect(function()
                            if (input.UserInputState == Enum.UserInputState.End) then
                                ColorDragging = false
                                ColorPickerDragging = false
                            end
                        end)
                    end
                end)
            
                colorframe.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        dragInput = input
                    end
                end)
            
                userinputservice.InputChanged:Connect(function(input)
                    if input == dragInput and ColorDragging and not SliderDragging and not Dragging then
                        local Delta = input.Position - dragStart
                        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
                        colorframe.Position = Position
                    end
                end)

                main_3.MouseButton1Click:Connect(function()
                    colorframe.Visible = not colorframe.Visible
                end)

                gradient.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (ColorInput) then
                            ColorInput:Disconnect()
                        end

                        ColorInput = game.RunService.RenderStepped:Connect(function()
                            local ColorX = (math.clamp(Mouse.X - colorslider.AbsolutePosition.X, 0, colorslider.AbsoluteSize.X) / colorslider.AbsoluteSize.X)
                            local ColorY = (math.clamp(Mouse.Y - gradient.AbsolutePosition.Y, 0, gradient.AbsoluteSize.Y) / gradient.AbsoluteSize.Y)

                            ColorS = ColorX
                            ColorV = 1 - ColorY

                            colorselection.Position = UDim2.new(ColorX, 0, ColorY, 0)

                            UpdateColor()
                        end)

                        Dragging = true
                    end
                end)

                gradient.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (ColorInput) then
                            ColorInput:Disconnect()
                        end

                        Dragging = false
                    end
                end)

                colorslider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (HueInput) then
                            HueInput:Disconnect()
                        end

                        HueInput = game.RunService.RenderStepped:Connect(function()
                            local HueY = (math.clamp(Mouse.X - colorslider.AbsolutePosition.X, 0, colorslider.AbsoluteSize.X) / colorslider.AbsoluteSize.X)

                            bar_2.Position = UDim2.new(HueY, 0, 0, 0)
                            ColorH = 1 - HueY

                            UpdateColor()
                        end)

                        Dragging = true
                    end
                end)

                colorslider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (HueInput) then
                            HueInput:Disconnect()
                        end

                        Dragging = false
                    end
                end)

                -- ColorPicker Types
                function ColorTypes:SetColor(color)
                    color = color or Color3.fromRGB(255, 255, 255)
                    colorpicker.BackgroundColor3 = color
                    gradient.BackgroundColor3 = color
                    SelectedColor = colorpicker.BackgroundColor3
                    callback(SelectedColor)
                end

                return ColorTypes
            end

            return GroupTypes
        end

        function TabTypes:CratePlayerList(showbuttons, events)
            showbuttons = showbuttons or false
            events = events or {}
            events.onwhitelist = events.onwhitelist or function() end
            events.onblacklist = events.onblacklist or function() end
            events.onprioritize = events.onprioritize or function() end
            events.onunprioritize = events.onunprioritize or function() end

            -- PlayerList Main
            local PlayerListTypes = {}

            -- PlayerList Instances
            local main = Instance.new("Frame")
            local UIPadding = Instance.new("UIPadding")
            local UIListLayout = Instance.new("UIListLayout")
            local groupboxoutline = Instance.new("Frame")
            local groupboxinline = Instance.new("Frame")
            local background = Instance.new("Frame")
            local title = Instance.new("TextLabel")
            local players = Instance.new("Frame")
            local container_players = Instance.new("ScrollingFrame")
            local UIListLayout_2 = Instance.new("UIListLayout")

            -- PlayerList Properties
            main.Name = "main"
            main.Parent = Pattern
            main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            main.BackgroundTransparency = 1.000
            main.Size = UDim2.new(0, 520, 0, 471)
            
            UIPadding.Parent = main
            UIPadding.PaddingLeft = UDim.new(0, 3)
            UIPadding.PaddingTop = UDim.new(0, 8)
            
            UIListLayout.Parent = main
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 8)
            
            groupboxoutline.Name = "groupboxoutline"
            groupboxoutline.Parent = main
            groupboxoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            groupboxoutline.BorderSizePixel = 0
            groupboxoutline.Position = UDim2.new(0.00576923089, 0, 0.0169851389, 0)
            groupboxoutline.Size = UDim2.new(0, 513, 0, 460)
            
            groupboxinline.Name = "groupboxinline"
            groupboxinline.Parent = groupboxoutline
            groupboxinline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            groupboxinline.BorderSizePixel = 0
            groupboxinline.Position = UDim2.new(0, 1, 0, 1)
            groupboxinline.Size = UDim2.new(0, 511, 0, 458)
            
            background.Name = "background"
            background.Parent = groupboxinline
            background.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            background.BorderSizePixel = 0
            background.Position = UDim2.new(0, 1, 0, 1)
            background.Size = UDim2.new(0, 509, 0, 456)
            
            title.Name = "title"
            title.Parent = background
            title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            title.BackgroundTransparency = 1.000
            title.Position = UDim2.new(0, 15, 0, -10)
            title.Size = UDim2.new(0, 240, 0, 20)
            title.Font = Enum.Font.SourceSans
            title.Text = "Player List"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextSize = 15.000
            title.TextStrokeTransparency = 0.000
            title.TextXAlignment = Enum.TextXAlignment.Left
            
            players.Name = "players"
            players.Parent = background
            players.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
            players.BorderColor3 = Color3.fromRGB(8, 8, 8)
            players.Position = UDim2.new(0, 7, 0, 17)
            players.Size = UDim2.new(0, 494, 0, 430)
            
            container_players.Name = "container"
            container_players.Parent = players
            container_players.Active = true
            container_players.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            container_players.BackgroundTransparency = 1.000
            container_players.BorderSizePixel = 0
            container_players.Size = UDim2.new(0, 494, 0, 430)
            container_players.BottomImage = ""
            container_players.ScrollBarThickness = 3
            container_players.TopImage = ""
            
            UIListLayout_2.Parent = container_players
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

            UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                container_players.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 40)
            end)
            
            -- PlayerList Code
            local insertedplayers = {}

            local function CreatePlayerCard(Name, UserId, MemberShipType, TeamColor)
                local playercard = Instance.new("Frame")
                local UIGradient = Instance.new("UIGradient")
                local pfp = Instance.new("ImageLabel")
                local info = Instance.new("TextLabel")
                local whitelist = Instance.new("TextButton")
                local UIGradient_2 = Instance.new("UIGradient")
                local title_2 = Instance.new("TextLabel")
                local blacklist = Instance.new("TextButton")
                local UIGradient_3 = Instance.new("UIGradient")
                local title_3 = Instance.new("TextLabel")
                local prioritize = Instance.new("TextButton")
                local UIGradient_4 = Instance.new("UIGradient")
                local title_4 = Instance.new("TextLabel")
                local unprioritize = Instance.new("TextButton")
                local UIGradient_5 = Instance.new("UIGradient")
                local title_5 = Instance.new("TextLabel")

                local Pfp = game.Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

                playercard.Name = "playercard"
                playercard.Parent = container_players
                playercard.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                playercard.BorderSizePixel = 0
                playercard.Size = UDim2.new(1, 0, 0, 60)
                
                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient.Rotation = 90
                UIGradient.Parent = playercard
                
                pfp.Name = "pfp"
                pfp.Parent = playercard
                pfp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                pfp.BackgroundTransparency = 1.000
                pfp.Position = UDim2.new(0, 5, 0, 5)
                pfp.Size = UDim2.new(0, 48, 0, 48)
                pfp.Image = Pfp
                
                info.Name = "info"
                info.Parent = playercard
                info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                info.BackgroundTransparency = 1.000
                info.Position = UDim2.new(0.119433202, 0, 0.111111142, 0)
                info.Size = UDim2.new(0, 435, 0, 18)
                info.Font = Enum.Font.SourceSans
                info.Text = "Username: " .. Name .. " | UserId: " .. UserId .. " | MembeShipType: " .. MemberShipType
                info.TextColor3 = TeamColor
                info.TextSize = 15.000
                info.TextStrokeTransparency = 0.000
                info.TextWrapped = true
                info.TextXAlignment = Enum.TextXAlignment.Left
                
                if (showbuttons) then
                    whitelist.Name = "whitelist"
                    whitelist.Parent = playercard
                    whitelist.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    whitelist.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    whitelist.Position = UDim2.new(0.119433202, 0, 0.511111259, 0)
                    whitelist.Size = UDim2.new(0, 100, 0, 19)
                    whitelist.Font = Enum.Font.SourceSans
                    whitelist.Text = ""
                    whitelist.TextColor3 = Color3.fromRGB(255, 255, 255)
                    whitelist.TextSize = 14.000
                    whitelist.TextStrokeTransparency = 0.000
                    
                    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_2.Rotation = 90
                    UIGradient_2.Parent = whitelist
                    
                    title_2.Name = "title"
                    title_2.Parent = whitelist
                    title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_2.BackgroundTransparency = 1.000
                    title_2.BorderSizePixel = 0
                    title_2.Size = UDim2.new(1, 0, 1, 0)
                    title_2.Font = Enum.Font.SourceSans
                    title_2.Text = "Whitelist"
                    title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_2.TextSize = 14.000
                    title_2.TextStrokeTransparency = 0.000
                    
                    blacklist.Name = "blacklist"
                    blacklist.Parent = playercard
                    blacklist.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    blacklist.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    blacklist.Position = UDim2.new(0.338999987, 0, 0.510999978, 0)
                    blacklist.Size = UDim2.new(0, 100, 0, 19)
                    blacklist.Font = Enum.Font.SourceSans
                    blacklist.Text = ""
                    blacklist.TextColor3 = Color3.fromRGB(255, 255, 255)
                    blacklist.TextSize = 14.000
                    blacklist.TextStrokeTransparency = 0.000
                    
                    UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_3.Rotation = 90
                    UIGradient_3.Parent = blacklist
                    
                    title_3.Name = "title"
                    title_3.Parent = blacklist
                    title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_3.BackgroundTransparency = 1.000
                    title_3.BorderSizePixel = 0
                    title_3.Size = UDim2.new(1, 0, 1, 0)
                    title_3.Font = Enum.Font.SourceSans
                    title_3.Text = "Blacklist"
                    title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_3.TextSize = 14.000
                    title_3.TextStrokeTransparency = 0.000
                    
                    prioritize.Name = "prioritize"
                    prioritize.Parent = playercard
                    prioritize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    prioritize.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    prioritize.Position = UDim2.new(0.559000015, 0, 0.510999978, 0)
                    prioritize.Size = UDim2.new(0, 100, 0, 19)
                    prioritize.Font = Enum.Font.SourceSans
                    prioritize.Text = ""
                    prioritize.TextColor3 = Color3.fromRGB(255, 255, 255)
                    prioritize.TextSize = 14.000
                    prioritize.TextStrokeTransparency = 0.000
                    
                    UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_4.Rotation = 90
                    UIGradient_4.Parent = prioritize
                    
                    title_4.Name = "title"
                    title_4.Parent = prioritize
                    title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_4.BackgroundTransparency = 1.000
                    title_4.BorderSizePixel = 0
                    title_4.Size = UDim2.new(1, 0, 1, 0)
                    title_4.Font = Enum.Font.SourceSans
                    title_4.Text = "Prioritize"
                    title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_4.TextSize = 14.000
                    title_4.TextStrokeTransparency = 0.000
                    
                    unprioritize.Name = "unprioritize"
                    unprioritize.Parent = playercard
                    unprioritize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    unprioritize.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    unprioritize.Position = UDim2.new(0.778999984, 0, 0.510999978, 0)
                    unprioritize.Size = UDim2.new(0, 100, 0, 19)
                    unprioritize.Font = Enum.Font.SourceSans
                    unprioritize.Text = ""
                    unprioritize.TextColor3 = Color3.fromRGB(255, 255, 255)
                    unprioritize.TextSize = 14.000
                    unprioritize.TextStrokeTransparency = 0.000
                    
                    UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_5.Rotation = 90
                    UIGradient_5.Parent = unprioritize
                    
                    title_5.Name = "title"
                    title_5.Parent = unprioritize
                    title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_5.BackgroundTransparency = 1.000
                    title_5.BorderSizePixel = 0
                    title_5.Size = UDim2.new(1, 0, 1, 0)
                    title_5.Font = Enum.Font.SourceSans
                    title_5.Text = "Unprioritize"
                    title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_5.TextSize = 14.000
                    title_5.TextStrokeTransparency = 0.000

                    whitelist.MouseButton1Click:Connect(function()
                        events.onwhitelist(UserId)
                    end)

                    blacklist.MouseButton1Click:Connect(function()
                        events.onblacklist(UserId)
                    end)

                    prioritize.MouseButton1Click:Connect(function()
                        events.onprioritize(UserId)
                    end)

                    unprioritize.MouseButton1Click:Connect(function()
                        events.onunprioritize(UserId)
                    end)
                end

                insertedplayers[UserId] = playercard
            end

            for i,v in pairs(game.Players:GetPlayers()) do
                if (v.Name ~= game.Players.LocalPlayer.Name) then
                    local MemberShip = tostring(v.MembershipType):gsub("Enum.MembershipType.", "")
                    CreatePlayerCard(v.Name, v.UserId, MemberShip, v.TeamColor.Color)
                end
            end

            game.Players.ChildAdded:Connect(function(Plr)
                local MemberShip = tostring(Plr.MembershipType):gsub("Enum.MembershipType.", "")
                CreatePlayerCard(Plr.Name, Plr.UserId, MemberShip, Plr.TeamColor.Color)
            end)

            game.Players.ChildRemoved:Connect(function(Plr)
                insertedplayers[Plr.UserId]:Destroy()
            end)
        end

        return TabTypes
    end

    return WinTypes, BracketV2
end

return Library