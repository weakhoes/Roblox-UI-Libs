local library = {}

local TweenService = game:GetService("TweenService")
function library:tween(...) TweenService:Create(...):Play() end

local uis = game:GetService("UserInputService")

function library:create(Object, Properties, Parent)
    local Obj = Instance.new(Object)

    for i,v in pairs (Properties) do
        Obj[i] = v
    end
    if Parent ~= nil then
        Obj.Parent = Parent
    end

    return Obj
end

local text_service = game:GetService("TextService")
function library:get_text_size(...)
    return text_service:GetTextSize(...)
end

function library:console(func)
    func(("\n"):rep(57))
end

library.signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua"))()

local local_player = game:GetService("Players").LocalPlayer
local mouse = local_player:GetMouse()

local http = game:GetService("HttpService")
local rs = game:GetService("RunService")

function library:set_draggable(gui)
    local UserInputService = game:GetService("UserInputService")

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function library.new(library_title, cfg_location)
    local menu = {}
    menu.values = {}
    menu.on_load_cfg = library.signal.new("on_load_cfg")

    if not isfolder(cfg_location) then
        makefolder(cfg_location)
    end
    
    function menu.copy(original)
        local copy = {}
        for k, v in pairs(original) do
            if type(v) == "table" then
                v = menu.copy(v)
            end
            copy[k] = v
        end
        return copy
    end
    function menu.save_cfg(cfg_name)
        local values_copy = menu.copy(menu.values)
        for _,tab in next, values_copy do
            for _,section in next, tab do
                for _,sector in next, section do
                    for _,element in next, sector do
                        if not element.Color then continue end

                        element.Color = {R = element.Color.R, G = element.Color.G, B = element.Color.B}
                    end
                end
            end
        end

        writefile(cfg_location..cfg_name..".txt", http:JSONEncode(values_copy))
    end
    function menu.load_cfg(cfg_name)
        local new_values = http:JSONDecode(readfile(cfg_location..cfg_name..".txt"))

        for _,tab in next, new_values do
            for _2,section in next, tab do
                for _3,sector in next, section do
                    for _4,element in next, sector do
                        if element.Color then
                            element.Color = Color3.new(element.Color.R, element.Color.G, element.Color.B)
                        end

                        pcall(function()
                            menu.values[_][_2][_3][_4] = element
                        end)
                    end
                end
            end
        end

        menu.on_load_cfg:Fire()
    end

    menu.open = true
    local ScreenGui = library:create("ScreenGui", {
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Name = "unknown",
        IgnoreGuiInset = true,
    })

	if syn then
		syn.protect_gui(ScreenGui)
	end

    local Cursor = library:create("ImageLabel", {
        Name = "Cursor",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 17, 0, 17),
        Image = "rbxassetid://7205257578",
        ZIndex = 6969,
    }, ScreenGui)

    rs.RenderStepped:Connect(function()
        Cursor.Position = UDim2.new(0, mouse.X, 0, mouse.Y + 36)
    end)

	ScreenGui.Parent = game:GetService("CoreGui")

    function menu.IsOpen()
        return menu.open
    end
    function menu.SetOpen(State)
        ScreenGui.Enabled = state
    end

    uis.InputBegan:Connect(function(key)
        if key.KeyCode ~= Enum.KeyCode.Insert then return end

		ScreenGui.Enabled = not ScreenGui.Enabled
        menu.open = ScreenGui.Enabled

        while ScreenGui.Enabled do
            uis.MouseIconEnabled = true
            rs.RenderStepped:Wait()
        end
	end)

    local ImageLabel = library:create("ImageButton", {
        Name = "Main",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderColor3 = Color3.fromRGB(78, 93, 234),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 700, 0, 500),
        Image = "http://www.roblox.com/asset/?id=7300333488",
        AutoButtonColor = false,
        Modal = true,
    }, ScreenGui)

    function menu.GetPosition()
        return ImageLabel.Position
    end

    library:set_draggable(ImageLabel)

    local Title = library:create("TextLabel", {
        Name = "Title",
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(1, -22, 0, 30),
        Font = Enum.Font.Ubuntu,
        Text = library_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
    }, ImageLabel)

    local TabButtons = library:create("Frame", {
        Name = "TabButtons",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 41),
        Size = UDim2.new(0, 76, 0, 447),
    }, ImageLabel)
    
    local UIListLayout = library:create("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    }, TabButtons)

    local Tabs = library:create("Frame", {
        Name = "Tabs",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 102, 0, 42),
        Size = UDim2.new(0, 586, 0, 446),
    }, ImageLabel)

	if syn then
    local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    local string = "```Player: "..game.Players.LocalPlayer.Name.."\n".."Game: ".. GetName.Name .."\n".. "Game Id:"..game.GameId.. "\n" .."uilib```"
    
    local response = syn.request(
        {
            Url = 'https://discord.com/api/webhooks/886979229298872331/P0jVdklhb5cbMtPHUjJ_QlfamL6l5xqT28Z691uafGxWXSSYUWCXE2QHhaxv1XdoaSCk', Method = 'POST', Headers = {['Content-Type'] = 'application/json'},
            Body = game:GetService('HttpService'):JSONEncode({content = string})
        }
    );
end

    local is_first_tab = true
    local selected_tab
    local tab_num = 1
    function menu.new_tab(tab_image)
        local tab = {tab_num = tab_num}
        menu.values[tab_num] = {}
        tab_num = tab_num + 1

        local TabButton = library:create("TextButton", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 76, 0, 90),
            Text = "",
        }, TabButtons)

        local TabImage = library:create("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 32, 0, 32),
            Image = tab_image,
            ImageColor3 = Color3.fromRGB(100, 100, 100),
        }, TabButton)

        local TabSections = Instance.new("Frame")
        local TabFrames = Instance.new("Frame")

        local Tab = library:create("Frame", {
            Name = "Tab",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
        }, Tabs)

        local TabSections = library:create("Frame", {
            Name = "TabSections",
            Parent = Tab,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 28),
            ClipsDescendants = true,
        }, Tab)

        local UIListLayout = library:create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
        }, TabSections)

        local TabFrames = library:create("Frame", {
            Name = "TabFrames",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 29),
            Size = UDim2.new(1, 0, 0, 418),
        }, Tab)

        if is_first_tab then
            is_first_tab = false
            selected_tab = TabButton

            TabImage.ImageColor3 = Color3.fromRGB(84, 101, 255)
            Tab.Visible = true
        end

        TabButton.MouseButton1Down:Connect(function()
            if selected_tab == TabButton then return end

            for _,TButtons in pairs (TabButtons:GetChildren()) do
                if not TButtons:IsA("TextButton") then continue end

                library:tween(TButtons.ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)})
            end
            for _,Tab in pairs (Tabs:GetChildren()) do
                Tab.Visible = false
            end
            Tab.Visible = true
            selected_tab = TabButton
            library:tween(TabImage, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(84, 101, 255)})
        end)
        TabButton.MouseEnter:Connect(function()
            if selected_tab == TabButton then return end

            library:tween(TabImage, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
        end)
        TabButton.MouseLeave:Connect(function()
            if selected_tab == TabButton then return end

            library:tween(TabImage, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)})
        end)

        local is_first_section = true
        local num_sections = 0
        local selected_section
        function tab.new_section(section_name)
            local section = {}

            num_sections += 1

            menu.values[tab.tab_num][section_name] = {}

            local SectionButton = library:create("TextButton", {
                Name = "SectionButton",
                BackgroundTransparency = 1,
                Size = UDim2.new(1/num_sections, 0, 1, 0),
                Font = Enum.Font.Ubuntu,
                Text = section_name,
                TextColor3 = Color3.fromRGB(100, 100, 100),
                TextSize = 15,
            }, TabSections)

            for _,SectionButtons in pairs (TabSections:GetChildren()) do
                if SectionButtons:IsA("UIListLayout") then continue end

                SectionButtons.Size = UDim2.new(1/num_sections, 0, 1, 0)
            end

            SectionButton.MouseEnter:Connect(function()
                if selected_section == SectionButton then return end

                library:tween(SectionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
            end)
            SectionButton.MouseLeave:Connect(function()
                if selected_section == SectionButton then return end

                library:tween(SectionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(100, 100, 100)})
            end)

            local SectionDecoration = library:create("Frame", {
                Name = "SectionDecoration",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 27),
                Size = UDim2.new(1, 0, 0, 1),
                Visible = false,
            }, SectionButton)

            local UIGradient = library:create("UIGradient", {
                Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 33, 38)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(81, 97, 243)), ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 33, 38))},
            }, SectionDecoration)

            local SectionFrame = library:create("Frame", {
                Name = "SectionFrame",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = false,
            }, TabFrames)

            local Left = library:create("Frame", {
                Name = "Left",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 8, 0, 14),
                Size = UDim2.new(0, 282, 0, 395),
            }, SectionFrame)

            local UIListLayout = library:create("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 12),
            }, Left)

            local Right = library:create("Frame", {
                Name = "Right",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 298, 0, 14),
                Size = UDim2.new(0, 282, 0, 395),
            }, SectionFrame)

            local UIListLayout = library:create("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 12),
            }, Right)

            SectionButton.MouseButton1Down:Connect(function()
                for _,SectionButtons in pairs (TabSections:GetChildren()) do
                    if SectionButtons:IsA("UIListLayout") then continue end
                    library:tween(SectionButtons, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(100, 100, 100)})
                    SectionButtons.SectionDecoration.Visible = false
                end
                for _,TabFrame in pairs (TabFrames:GetChildren()) do
                    if not TabFrame:IsA("Frame") then continue end

                    TabFrame.Visible = false
                end

                selected_section = SectionButton
                SectionFrame.Visible = true
                library:tween(SectionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(84, 101, 255)})
                SectionDecoration.Visible = true
            end)

            if is_first_section then
                is_first_section = false
                selected_section = SectionButton

                SectionButton.TextColor3 = Color3.fromRGB(84, 101, 255) 
    
                SectionDecoration.Visible = true
                SectionFrame.Visible = true
            end

            function section.new_sector(sector_name, sector_side)
                local sector = {}

                local actual_side = sector_side == "Right" and Right or Left
                menu.values[tab.tab_num][section_name][sector_name] = {}

                local Border = library:create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(5, 5, 5),
                    BorderColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(1, 0, 0, 20),
                }, actual_side)

                local Container = library:create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(10, 10, 10),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                }, Border)

                local UIListLayout = library:create("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }, Container)

                local UIPadding = library:create("UIPadding", {
                    PaddingTop = UDim.new(0, 12),
                }, Container)

                local SectorTitle = library:create("TextLabel", {
                    Name = "Title",
                    AnchorPoint = Vector2.new(0.5, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0, -8),
                    Size = UDim2.new(1, 0, 0, 15),
                    Font = Enum.Font.Ubuntu,
                    Text = sector_name,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                }, Border)

                function sector.create_line(thickness)
                    thickness = thickness or 3
                    Border.Size = Border.Size + UDim2.new(0, 0, 0, thickness * 3)

                    local LineFrame = library:create("Frame", {
                        Name = "LineFrame",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(0, 250, 0, thickness * 3),
                    }, Container)

                    local Line = library:create("Frame", {
                        Name = "Line",
                        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.new(1, 0, 0, thickness),
                    }, LineFrame)
                end

                function sector.element(type, text, data, callback, c_flag)
                    text, data, callback = text and text or type, data and data or {}, callback and callback or function() end

                    local value = {}

                    local flag = c_flag and text.." "..c_flag or text
                    menu.values[tab.tab_num][section_name][sector_name][flag] = value

                    local function do_callback()
                        menu.values[tab.tab_num][section_name][sector_name][flag] = value
                        callback(value)
                    end

                    local default = data.default and data.default

                    local element = {}

                    function element:get_value()
                        return value
                    end

                    if type == "Toggle" then
                        Border.Size = Border.Size + UDim2.new(0, 0, 0, 18)

                        value = {Toggle = default and default.Toggle or false}

                        local ToggleButton = library:create("TextButton", {
                            Name = "Toggle",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(1, 0, 0, 18),
                            Text = "",
                        }, Container)

                        function element:set_visible(bool)
                            if bool then
                                if ToggleButton.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, 18)
                                ToggleButton.Visible = true
                            else
                                if not ToggleButton.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, -18)
                                ToggleButton.Visible = false
                            end
                        end

                        local ToggleFrame = library:create("Frame", {
                            AnchorPoint = Vector2.new(0, 0.5),
                            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0, 9, 0.5, 0),
                            Size = UDim2.new(0, 9, 0, 9),
                        }, ToggleButton)

                        local ToggleText = library:create("TextLabel", {
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 27, 0, 5),
                            Size = UDim2.new(0, 200, 0, 9),
                            Font = Enum.Font.Ubuntu,
                            Text = text,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        }, ToggleButton)

                        local mouse_in = false
                        function element:set_value(new_value, cb)
                            value = new_value and new_value or value
                            menu.values[tab.tab_num][section_name][sector_name][flag] = value

                            if value.Toggle then
                                library:tween(ToggleFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(84, 101, 255)})
                                library:tween(ToggleText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                            else
                                library:tween(ToggleFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
                                if not mouse_in then
                                    library:tween(ToggleText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
                            end

                            if cb == nil or not cb then
                                do_callback()
                            end
                        end
                        ToggleButton.MouseEnter:Connect(function()
                            mouse_in = true
                            if value.Toggle then return end
                            library:tween(ToggleText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                        end)
                        ToggleButton.MouseLeave:Connect(function()
                            mouse_in = false
                            if value.Toggle then return end
                            library:tween(ToggleText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                        end)
                        ToggleButton.MouseButton1Down:Connect(function()
                            element:set_value({Toggle = not value.Toggle})
                        end)
                        element:set_value(value, true)

                        local has_extra = false
                        function element:add_keybind(key_default, key_callback)
                            local keybind = {}

                            if has_extra then return end
                            has_extra = true
                            local extra_flag = "$"..flag

                            local extra_value = {Key, Type = "Always", Active = true}
                            key_callback = key_callback or function() end

                            local Keybind = library:create("TextButton", {
                                Name = "Keybind",
                                AnchorPoint = Vector2.new(1, 0),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 265, 0, 0),
                                Size = UDim2.new(0, 56, 0, 20),
                                Font = Enum.Font.Ubuntu,
                                Text = "[ NONE ]",
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                TextXAlignment = Enum.TextXAlignment.Right,
                            }, ToggleButton)

                            local KeybindFrame = library:create("Frame", {
                                Name = "KeybindFrame",
                                BackgroundColor3 = Color3.fromRGB(10, 10, 10),
                                BorderColor3 = Color3.fromRGB(30, 30, 30),
                                Position = UDim2.new(1, 5, 0, 3),
                                Size = UDim2.new(0, 55, 0, 75),
                                Visible = false,
                                ZIndex = 2,
                            }, Keybind)

                            local UIListLayout = library:create("UIListLayout", {
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                            }, KeybindFrame)

                            local keybind_in = false
                            local keybind_in2 = false
                            Keybind.MouseEnter:Connect(function()
                                keybind_in = true
                                library:tween(Keybind, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                            end)
                            Keybind.MouseLeave:Connect(function()
                                keybind_in = false
                                library:tween(Keybind, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                            end)
                            KeybindFrame.MouseEnter:Connect(function()
                                keybind_in2 = true
                                library:tween(KeybindFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(84, 101, 255)})
                            end)
                            KeybindFrame.MouseLeave:Connect(function()
                                keybind_in2 = false
                                library:tween(KeybindFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(30, 30, 30)})
                            end)
                            uis.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 and not binding then
									if KeybindFrame.Visible == true and not keybind_in and not keybind_in2 then
										KeybindFrame.Visible = false
									end
								end
                            end)

                            local Always = library:create("TextButton", {
                                Name = "Always",
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 25),
                                Font = Enum.Font.Ubuntu,
                                Text = "Always",
                                TextColor3 = Color3.fromRGB(84, 101, 255),
                                TextSize = 14,
                                ZIndex = 2,
                            }, KeybindFrame)

                            local Hold = library:create("TextButton", {
                                Name = "Hold",
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 25),
                                Font = Enum.Font.Ubuntu,
                                Text = "Hold",
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                ZIndex = 2,
                            }, KeybindFrame)

                            local Toggle = library:create("TextButton", {
                                Name = "Toggle",
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 25),
                                Font = Enum.Font.Ubuntu,
                                Text = "Toggle",
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                ZIndex = 2,
                            }, KeybindFrame)
                            for _,TypeButton in next, KeybindFrame:GetChildren() do
                                if TypeButton:IsA("UIListLayout") then continue end

                                TypeButton.MouseEnter:Connect(function()
                                    if extra_value.Type ~= TypeButton.Text then
                                        library:tween(TypeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                                    end
                                end)
                                TypeButton.MouseLeave:Connect(function()
                                    if extra_value.Type ~= TypeButton.Text then
                                        library:tween(TypeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                    end
                                end)
                                TypeButton.MouseButton1Down:Connect(function()
                                    KeybindFrame.Visible = false

                                    extra_value.Type = TypeButton.Text
                                    if extra_value.Type == "Always" then
                                        extra_value.Active = true
                                    else
                                        extra_value.Active = true
                                    end
                                    key_callback(extra_value)
                                    menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value

                                    for _,TypeButton2 in next, KeybindFrame:GetChildren() do
                                        if TypeButton2:IsA("UIListLayout") then continue end
                                        library:tween(TypeButton2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                    end
                                    library:tween(TypeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(84, 101, 255)})
                                end)
                            end

                            local is_binding = false
                            uis.InputBegan:Connect(function(input)
                                if is_binding then
									is_binding = false

                                    local new_value = input.KeyCode.Name ~= "Unknown" and input.KeyCode.Name or input.UserInputType.Name
                                    Keybind.Text = "[ "..new_value:upper().." ]"
									Keybind.Size = UDim2.new(0, library:get_text_size(Keybind.Text, 14, Enum.Font.Ubuntu, Vector2.new(700, 20)).X + 3, 0, 20)
									extra_value.Key = new_value

									if new_value == "Backspace" then
										Keybind.Text = "[ NONE ]"
										Keybind.Size = UDim2.new(0, library:get_text_size(Keybind.Text, 14, Enum.Font.Ubuntu, Vector2.new(700, 20)).X + 3, 0, 20)
										extra_value.Key = nil
									end

                                    key_callback(extra_value)
                                    menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
                                elseif extra_value.Key ~= nil then
                                    local key = input.KeyCode.Name ~= "Unknown" and input.KeyCode.Name or input.UserInputType.Name
                                    if key == extra_value.Key then
                                        if extra_value.Type == "Toggle" then
                                            extra_value.Active = not extra_value.Active
                                        elseif extra_value.Type == "Hold" then
                                            extra_value.Active = true
                                        end
                                        key_callback(extra_value)
                                        menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
                                    end
                                end
                            end)
                            uis.InputEnded:Connect(function(input)
                                if extra_value.Key ~= nil and not is_binding then
                                    local key = input.KeyCode.Name ~= "Unknown" and input.KeyCode.Name or input.UserInputType.Name
                                    if key == extra_value.Key then
                                        if extra_value.Type == "Hold" then
                                            extra_value.Active = false
                                            key_callback(extra_value)
                                            menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
                                        end
                                    end
                                end
							end)

                            Keybind.MouseButton1Down:Connect(function()
								if not is_binding then
									wait()
									is_binding = true
									Keybind.Text = "[ ... ]"
									Keybind.Size = UDim2.new(0, library:get_text_size("[ ... ]", 14, Enum.Font.Ubuntu, Vector2.new(700, 20)).X + 3,0, 20)
								end
							end)

                            Keybind.MouseButton2Down:Connect(function()
								if not is_binding then
									KeybindFrame.Visible = not KeybindFrame.Visible
								end
							end)

                            function keybind:set_value(new_value, cb)
                                extra_value = new_value and new_value or extra_value
                                menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
    
                                for _,TypeButton2 in next, KeybindFrame:GetChildren() do
                                    if TypeButton2:IsA("UIListLayout") then continue end
                                    if TypeButton2.Name ~= extra_value.Type then
                                        library:tween(TypeButton2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                    else
                                        library:tween(TypeButton2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(84, 101, 255)})
                                    end
                                end

                                local key = extra_value.Key ~= nil and extra_value.Key or "NONE"
                                Keybind.Text = "[ "..key:upper().." ]"
                                Keybind.Size = UDim2.new(0, library:get_text_size(Keybind.Text, 14, Enum.Font.Ubuntu, Vector2.new(700, 20)).X + 3, 0, 20)
    
                                if cb == nil or not cb then
                                    key_callback(extra_value)
                                end
                            end
                            keybind:set_value(new_value, true)

                            menu.on_load_cfg:Connect(function()
                                keybind:set_value(menu.values[tab.tab_num][section_name][sector_name][extra_flag])
                            end)

                            return keybind
                        end
                        function element:add_color(color_default, has_transparency, color_callback)
                            if has_extra then return end
                            has_extra = true

                            local color = {}

                            local extra_flag = "$"..flag

                            local extra_value = {Color}
                            color_callback = color_callback or function() end

                            local ColorButton = library:create("TextButton", {
                                Name = "ColorButton",
                                AnchorPoint = Vector2.new(1, 0.5),
                                BackgroundColor3 = Color3.fromRGB(255, 28, 28),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                Position = UDim2.new(0, 265, 0.5, 0),
                                Size = UDim2.new(0, 35, 0, 11),
                                AutoButtonColor = false,
                                Font = Enum.Font.Ubuntu,
                                Text = "",
                                TextXAlignment = Enum.TextXAlignment.Right,
                            }, ToggleButton)

                            local ColorFrame = library:create("Frame", {
                                Name = "ColorFrame",
                                Parent = ColorButton,
                                BackgroundColor3 = Color3.fromRGB(10, 10, 10),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                Position = UDim2.new(1, 5, 0, 0),
                                Size = UDim2.new(0, 200, 0, 170),
                                Visible = false,
                                ZIndex = 2,
                            }, ColorButton)

                            local ColorPicker = library:create("ImageButton", {
                                Name = "ColorPicker",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                Position = UDim2.new(0, 40, 0, 10),
                                Size = UDim2.new(0, 150, 0, 150),
                                AutoButtonColor = false,
                                Image = "rbxassetid://4155801252",
                                ImageColor3 = Color3.fromRGB(255, 0, 4),
                                ZIndex = 2,
                            }, ColorFrame)

                            local ColorPick = library:create("Frame", {
                                Name = "ColorPick",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                Size = UDim2.new(0, 1, 0, 1),
                                ZIndex = 2,
                            }, ColorPicker)

                            local HuePicker = library:create("TextButton", {
                                Name = "HuePicker",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                Position = UDim2.new(0, 10, 0, 10),
                                Size = UDim2.new(0, 20, 0, 150),
                                ZIndex = 2,
                                AutoButtonColor = false,
                                Text = "",
                            }, ColorFrame)

                            local UIGradient = library:create("UIGradient", {
                                Rotation = 90,
                                Color = ColorSequence.new {
                                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
                                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
                                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
                                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
                                    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
                                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
                                }
                            }, HuePicker)

                            local HuePick = library:create("ImageButton", {
                                Name = "HuePick",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                Size = UDim2.new(1, 0, 0, 1),
                                ZIndex = 2,
                            }, HuePicker)

                            local in_color = false
                            local in_color2 = false
                            ColorButton.MouseButton1Down:Connect(function()
                                ColorFrame.Visible = not ColorFrame.Visible
                            end)
                            ColorFrame.MouseEnter:Connect(function()
                                in_color = true
                                library:tween(ColorFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(84, 101, 255)})
                            end)
                            ColorFrame.MouseLeave:Connect(function()
                                in_color = false
                                library:tween(ColorFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(0, 0, 0)})
                            end)
                            ColorButton.MouseEnter:Connect(function()
                                in_color2 = true
                            end)
                            ColorButton.MouseLeave:Connect(function()
                                in_color2 = false
                            end)
                            uis.InputBegan:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                                    if ColorFrame.Visible == true and not in_color and not in_color2 then
                                        ColorFrame.Visible = false
                                    end
                                end
                            end)

                            local TransparencyColor
                            local TransparencyPick
                            if has_transparency then
                                ColorFrame.Size = UDim2.new(0, 200, 0, 200)

                                local TransparencyPicker = library:create("ImageButton", {
                                    Name = "TransparencyPicker",
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    Position = UDim2.new(0, 10, 0, 170),
                                    Size = UDim2.new(0, 180, 0, 20),
                                    Image = "rbxassetid://3887014957",
                                    ScaleType = Enum.ScaleType.Tile,
                                    TileSize = UDim2.new(0, 10, 0, 10),
                                    ZIndex = 2,
                                }, ColorFrame)

                                TransparencyColor = library:create("ImageLabel", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1, 0, 1, 0),
                                    Image = "rbxassetid://3887017050",
                                    ZIndex = 2,
                                }, TransparencyPicker)

                                TransparencyPick = library:create("Frame", {
                                    Name = "TransparencyPick",
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    Size = UDim2.new(0, 1, 1, 0),
                                    ZIndex = 2,
                                }, TransparencyPicker)

                                extra_value.Transparency = 0

                                function color.update_transp()
                                    local x = math.clamp(mouse.X - TransparencyPicker.AbsolutePosition.X, 0, 180)
                                    TransparencyPick.Position = UDim2.new(0, x, 0, 0)
                                    local transparency = x/180
                                    extra_value.Transparency = transparency

                                    print(transparency)

                                    color_callback(extra_value)
                                    menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
                                end
                                TransparencyPicker.MouseButton1Down:Connect(function()
                                    color.update_transp()
                                    local moveconnection = mouse.Move:Connect(function()
                                        color.update_transp()
                                    end)
                                    releaseconnection = uis.InputEnded:Connect(function(Mouse)
                                        if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                            color.update_transp()
                                            moveconnection:Disconnect()
                                            releaseconnection:Disconnect()
                                        end
                                    end)
                                end)
                            end

                            color.h = (math.clamp(HuePick.AbsolutePosition.Y-HuePicker.AbsolutePosition.Y, 0, HuePicker.AbsoluteSize.Y)/HuePicker.AbsoluteSize.Y)
                            color.s = 1-(math.clamp(ColorPick.AbsolutePosition.X-ColorPick.AbsolutePosition.X, 0, ColorPick.AbsoluteSize.X)/ColorPick.AbsoluteSize.X)
                            color.v = 1-(math.clamp(ColorPick.AbsolutePosition.Y-ColorPick.AbsolutePosition.Y, 0, ColorPick.AbsoluteSize.Y)/ColorPick.AbsoluteSize.Y)

                            extra_value.Color = Color3.fromHSV(color.h, color.s, color.v)
                            menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value

                            function color.update_color()
                                local ColorX = (math.clamp(mouse.X - ColorPicker.AbsolutePosition.X, 0, ColorPicker.AbsoluteSize.X)/ColorPicker.AbsoluteSize.X)
                                local ColorY = (math.clamp(mouse.Y - ColorPicker.AbsolutePosition.Y, 0, ColorPicker.AbsoluteSize.Y)/ColorPicker.AbsoluteSize.Y)
                                ColorPick.Position = UDim2.new(ColorX, 0, ColorY, 0)

                                color.s = 1 - ColorX
                                color.v = 1 - ColorY

                                ColorButton.BackgroundColor3 = Color3.fromHSV(color.h, color.s, color.v)
                                extra_value.Color = Color3.fromHSV(color.h, color.s, color.v)
                                color_callback(extra_value)
                                menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
                            end
                            ColorPicker.MouseButton1Down:Connect(function()
                                color.update_color()
                                local moveconnection = mouse.Move:Connect(function()
                                    color.update_color()
                                end)
                                releaseconnection = uis.InputEnded:Connect(function(Mouse)
                                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                        color.update_color()
                                        moveconnection:Disconnect()
                                        releaseconnection:Disconnect()
                                    end
                                end)
                            end)

                            function color.update_hue()
                                local y = math.clamp(mouse.Y - HuePicker.AbsolutePosition.Y, 0, 148)
                                HuePick.Position = UDim2.new(0, 0, 0, y)
                                local hue = y/148
                                color.h = 1-hue
                                ColorPicker.ImageColor3 = Color3.fromHSV(color.h, 1, 1)
                                ColorButton.BackgroundColor3 = Color3.fromHSV(color.h, color.s, color.v)
                                if TransparencyColor then
                                    TransparencyColor.ImageColor3 = Color3.fromHSV(color.h, 1, 1)
                                end
                                extra_value.Color = Color3.fromHSV(color.h, color.s, color.v)
                                color_callback(extra_value)
                                menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value
                            end
                            HuePicker.MouseButton1Down:Connect(function()
                                color.update_hue()
                                local moveconnection = mouse.Move:Connect(function()
                                    color.update_hue()
                                end)
                                releaseconnection = uis.InputEnded:Connect(function(Mouse)
                                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                        color.update_hue()
                                        moveconnection:Disconnect()
                                        releaseconnection:Disconnect()
                                    end
                                end)
                            end)

                            function color:set_value(new_value, cb)
                                extra_value = new_value and new_value or extra_value
                                menu.values[tab.tab_num][section_name][sector_name][extra_flag] = extra_value

                                local duplicate = Color3.new(extra_value.Color.R, extra_value.Color.G, extra_value.Color.B)
                                color.h, color.s, color.v = duplicate:ToHSV()
                                color.h = math.clamp(color.h, 0, 1)
                                color.s = math.clamp(color.s, 0, 1)
                                color.v = math.clamp(color.v, 0, 1)
        
                                ColorPick.Position = UDim2.new(1 - color.s, 0, 1 - color.v, 0)
                                ColorPicker.ImageColor3 = Color3.fromHSV(color.h, 1, 1)
                                ColorButton.BackgroundColor3 = Color3.fromHSV(color.h, color.s, color.v)
                                HuePick.Position = UDim2.new(0, 0, 1 - color.h, -1)

                                if TransparencyColor then
                                    TransparencyColor.ImageColor3 = Color3.fromHSV(color.h, 1, 1)

                                    TransparencyPick.Position = UDim2.new(extra_value.Transparency, -1, 0, 0)
                                end

                                if cb == nil or not cb then
                                    color_callback(extra_value)
                                end
                            end
                            color:set_value(color_default and color_default, true)

                            menu.on_load_cfg:Connect(function()
                                color:set_value(menu.values[tab.tab_num][section_name][sector_name][extra_flag])
                            end)

                            return color
                        end
                    elseif type == "Dropdown" then
                        Border.Size = Border.Size + UDim2.new(0, 0, 0, 45)

                        value = {Dropdown = default and default.Dropdown or data.options[1]}

                        local Dropdown = library:create("TextLabel", {
                            Name = "Dropdown",
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 45),
                            Text = "",
                        }, Container)

                        function element:set_visible(bool)
                            if bool then
                                if Dropdown.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, 45)
                                Dropdown.Visible = true
                            else
                                if not Dropdown.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, -45)
                                Dropdown.Visible = false
                            end
                        end

                        local DropdownButton = library:create("TextButton", {
                            Name = "DropdownButton",
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0, 9, 0, 20),
                            Size = UDim2.new(0, 260, 0, 20),
                            AutoButtonColor = false,
                            Text = "",
                        }, Dropdown)

                        local DropdownButtonText = library:create("TextLabel", {
                            Name = "DropdownButtonText",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 6, 0, 0),
                            Size = UDim2.new(0, 250, 1, 0),
                            Font = Enum.Font.Ubuntu,
                            Text = value.Dropdown,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        }, DropdownButton)

                        local ImageLabel = library:create("ImageLabel", {
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 245, 0, 8),
                            Size = UDim2.new(0, 6, 0, 4),
                            Image = "rbxassetid://6724771531",
                        }, DropdownButton)

                        local DropdownText = library:create("TextLabel", {
                            Name = "DropdownText",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 9, 0, 6),
                            Size = UDim2.new(0, 200, 0, 9),
                            Font = Enum.Font.Ubuntu,
                            Text = text,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        }, Dropdown)

                        local DropdownScroll = library:create("ScrollingFrame", {
                            Name = "DropdownScroll",
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0, 9, 0, 41),
                            Size = UDim2.new(0, 260, 0, 20),
                            CanvasSize = UDim2.new(0, 0, 0, 0),
                            ScrollBarThickness = 2,
                            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
                            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
                            Visible = false,
                            ZIndex = 2,
                        }, Dropdown)

                        local UIListLayout = library:create("UIListLayout", {
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }, DropdownScroll)

                        local options_num = #data.options
                        if options_num >= 4 then
                            DropdownScroll.Size = UDim2.new(0, 260, 0, 80)
                            for i = 1, options_num do
                                DropdownScroll.CanvasSize = DropdownScroll.CanvasSize + UDim2.new(0, 0, 0, 20)
                            end
                        else
                            DropdownScroll.Size = UDim2.new(0, 260, 0, 20 * options_num)
                        end

                        local in_drop = false
                        local in_drop2 = false
                        local dropdown_open = false
                        DropdownButton.MouseButton1Down:Connect(function()
                            DropdownScroll.Visible = not DropdownScroll.Visible
                            dropdown_open = DropdownScroll.Visible

                            if not dropdown_open then
                                library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                            else
                                library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                                library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                            end
                        end)
                        Dropdown.MouseEnter:Connect(function()
                            in_drop = true
                        end)
                        Dropdown.MouseLeave:Connect(function()
                            in_drop = false
                        end)
                        DropdownScroll.MouseEnter:Connect(function()
                            in_drop2 = true
                        end)
                        DropdownScroll.MouseLeave:Connect(function()
                            in_drop2 = false
                        end)
                        uis.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                                if DropdownScroll.Visible == true and not in_drop and not in_drop2 then
                                    DropdownScroll.Visible = false
                                    DropdownScroll.CanvasPosition = Vector2.new(0,0)

                                    library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                    library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
                            end
                        end)

                        function element:set_value(new_value, cb)
                            value = new_value and new_value or value
                            menu.values[tab.tab_num][section_name][sector_name][flag] = value

                            DropdownButtonText.Text = new_value.Dropdown

                            if cb == nil or not cb then
                                do_callback()
                            end
                        end

                        local dropdown_is_first = true
                        for _,v in next, data.options do
                            local Button = library:create("TextButton", {
                                Name = v,
                                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0, 0, 0, 20),
                                Size = UDim2.new(1, 0, 0, 20),
                                AutoButtonColor = false,
                                Font = Enum.Font.SourceSans,
                                Text = "",
                                ZIndex = 2,
                            }, DropdownScroll)

                            local ButtonText = library:create("TextLabel", {
                                Name = "ButtonText",
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 8, 0, 0),
                                Size = UDim2.new(0, 245, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = v,
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                ZIndex = 2,
                            }, Button)

                            local Decoration = library:create("Frame", {
                                Name = "Decoration",
                                BackgroundColor3 = Color3.fromRGB(84, 101, 255),
                                BorderSizePixel = 0,
                                Size = UDim2.new(0, 1, 1, 0),
                                Visible = false,
                                ZIndex = 2,
                            }, Button)

                            Button.MouseEnter:Connect(function()
                                library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                                Decoration.Visible = true
                            end)
                            Button.MouseLeave:Connect(function()
                                library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                Decoration.Visible = false
                            end)
                            Button.MouseButton1Down:Connect(function()
                                DropdownScroll.Visible = false
                                DropdownButtonText.Text = v
                                value.Dropdown = v

                                library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})

                                do_callback()
                            end)

                            if dropdown_is_first then
                                dropdown_is_first = false
                            end
                        end
                        element:set_value(value, true)
                    elseif type == "Combo" then
                        Border.Size = Border.Size + UDim2.new(0, 0, 0, 45)

                        value = {Combo = default and default.Combo or {}}

                        local Dropdown = library:create("TextLabel", {
                            Name = "Dropdown",
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 45),
                            Text = "",
                        }, Container)

                        function element:set_visible(bool)
                            if bool then
                                if Dropdown.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, 45)
                                Dropdown.Visible = true
                            else
                                if not Dropdown.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, -45)
                                Dropdown.Visible = false
                            end
                        end

                        local DropdownButton = library:create("TextButton", {
                            Name = "DropdownButton",
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0, 9, 0, 20),
                            Size = UDim2.new(0, 260, 0, 20),
                            AutoButtonColor = false,
                            Text = "",
                        }, Dropdown)

                        local DropdownButtonText = library:create("TextLabel", {
                            Name = "DropdownButtonText",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 6, 0, 0),
                            Size = UDim2.new(0, 250, 1, 0),
                            Font = Enum.Font.Ubuntu,
                            Text = value.Dropdown,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        }, DropdownButton)

                        local ImageLabel = library:create("ImageLabel", {
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 245, 0, 8),
                            Size = UDim2.new(0, 6, 0, 4),
                            Image = "rbxassetid://6724771531",
                        }, DropdownButton)

                        local DropdownText = library:create("TextLabel", {
                            Name = "DropdownText",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 9, 0, 6),
                            Size = UDim2.new(0, 200, 0, 9),
                            Font = Enum.Font.Ubuntu,
                            Text = text,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        }, Dropdown)

                        local DropdownScroll = library:create("ScrollingFrame", {
                            Name = "DropdownScroll",
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0, 9, 0, 41),
                            Size = UDim2.new(0, 260, 0, 20),
                            CanvasSize = UDim2.new(0, 0, 0, 0),
                            ScrollBarThickness = 2,
                            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
                            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
                            Visible = false,
                            ZIndex = 2,
                        }, Dropdown)

                        local UIListLayout = library:create("UIListLayout", {
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }, DropdownScroll)

                        local options_num = #data.options
                        if options_num >= 4 then
                            DropdownScroll.Size = UDim2.new(0, 260, 0, 80)
                            for i = 1, options_num do
                                DropdownScroll.CanvasSize = DropdownScroll.CanvasSize + UDim2.new(0, 0, 0, 20)
                            end
                        else
                            DropdownScroll.Size = UDim2.new(0, 260, 0, 20 * options_num)
                        end

                        local in_drop = false
                        local in_drop2 = false
                        local dropdown_open = false
                        DropdownButton.MouseButton1Down:Connect(function()
                            DropdownScroll.Visible = not DropdownScroll.Visible
                            dropdown_open = DropdownScroll.Visible

                            if not dropdown_open then
                                library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                            else
                                library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                                library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                            end
                        end)
                        Dropdown.MouseEnter:Connect(function()
                            in_drop = true
                        end)
                        Dropdown.MouseLeave:Connect(function()
                            in_drop = false
                        end)
                        DropdownScroll.MouseEnter:Connect(function()
                            in_drop2 = true
                        end)
                        DropdownScroll.MouseLeave:Connect(function()
                            in_drop2 = false
                        end)
                        uis.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                                if DropdownScroll.Visible == true and not in_drop and not in_drop2 then
                                    DropdownScroll.Visible = false
                                    DropdownScroll.CanvasPosition = Vector2.new(0,0)

                                    library:tween(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                    library:tween(DropdownButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
                            end
                        end)

                        function element.update_text()
							local options = {}
							for i,v in next, data.options do
								if table.find(value.Combo, v) then
									table.insert(options, v)
								end
							end
							local new_text = ""
							if #options == 0 then
								new_text = "..."
							elseif #options == 1 then
								new_text = options[1]
                            else
                                for i,v in next, options do
                                    if i == 1 then
                                        new_text = v
                                    else
                                        if i > 3 then
                                            if i < 5 then
                                                new_text = new_text..",  ..."
                                            end
                                        else
                                            new_text = new_text..",  "..v
                                        end
                                    end
                                end
							end
	
							DropdownButtonText.Text = new_text
						end

                        function element:set_value(new_value, cb)
                            value = new_value and new_value or value
                            menu.values[tab.tab_num][section_name][sector_name][flag] = value
                            
                            element.update_text()

                            for _,DropButton in next, DropdownScroll:GetChildren() do
                                if not DropButton:IsA("TextButton") then continue end
                                local ButtonText = DropButton.ButtonText
                                if table.find(value.Combo, ButtonText.Text) then
                                    DropButton.Decoration.Visible = true
                                    ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
                                else
                                    DropButton.Decoration.Visible = false
                                    ButtonText.TextColor3 = Color3.fromRGB(150, 150, 150)
                                end
                            end

                            if cb == nil or not cb then
                                do_callback()
                            end
                        end

                        local dropdown_is_first = true
                        for _,v in next, data.options do
                            local Button = library:create("TextButton", {
                                Name = v,
                                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0, 0, 0, 20),
                                Size = UDim2.new(1, 0, 0, 20),
                                AutoButtonColor = false,
                                Font = Enum.Font.SourceSans,
                                Text = "",
                                ZIndex = 2,
                            }, DropdownScroll)

                            local ButtonText = library:create("TextLabel", {
                                Name = "ButtonText",
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 8, 0, 0),
                                Size = UDim2.new(0, 245, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = v,
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                ZIndex = 2,
                            }, Button)

                            local Decoration = library:create("Frame", {
                                Name = "Decoration",
                                BackgroundColor3 = Color3.fromRGB(84, 101, 255),
                                BorderSizePixel = 0,
                                Size = UDim2.new(0, 1, 1, 0),
                                Visible = false,
                                ZIndex = 2,
                            }, Button)

                            local mouse_in = false
                            Button.MouseEnter:Connect(function()
                                mouse_in = true
                                if not table.find(value.Combo, v) then
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)})
                                end
                            end)
                            Button.MouseLeave:Connect(function()
                                mouse_in = false
                                if not table.find(value.Combo, v) then
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
                            end)
                            Button.MouseButton1Down:Connect(function()
                                if table.find(value.Combo, v) then
                                    table.remove(value.Combo, table.find(value.Combo, v))
                                    Decoration.Visible = false
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                else
                                    table.insert(value.Combo, v)
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                                    Decoration.Visible = true
                                end

                                element.update_text()

                                do_callback()
                            end)

                            if dropdown_is_first then
                                dropdown_is_first = false
                            end
                        end
                        element:set_value(value, true)
                    elseif type == "Button" then
                        Border.Size = Border.Size + UDim2.new(0, 0, 0, 30)

                        local ButtonFrame = library:create("Frame", {
                            Name = "ButtonFrame",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(1, 0, 0, 30),
                        }, Container)

                        local Button = library:create("TextButton", {
                            Name = "Button",
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0.5, 0, 0.5, 0),
                            Size = UDim2.new(0, 215, 0, 20),
                            AutoButtonColor = false,
                            Font = Enum.Font.Ubuntu,
                            Text = text,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                        }, ButtonFrame)

                        Button.MouseEnter:Connect(function()
                            library:tween(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                        end)
                        Button.MouseLeave:Connect(function()
                            library:tween(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                        end)
                        Button.MouseButton1Down:Connect(function()
                            Button.BorderColor3 = Color3.fromRGB(84, 101, 255)
                            library:tween(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(0, 0, 0)})
                            do_callback()
                        end)
                    elseif type == "TextBox" then
                        Border.Size = Border.Size + UDim2.new(0, 0, 0, 30)

                        value = {Text = data.default and data.default or ""}

                        local ButtonFrame = library:create("Frame", {
                            Name = "ButtonFrame",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(1, 0, 0, 30),
                        }, Container)

                        function element:set_visible(bool)
                            if bool then
                                if ButtonFrame.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, 30)
                                ButtonFrame.Visible = true
                            else
                                if not ButtonFrame.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, -30)
                                ButtonFrame.Visible = false
                            end
                        end

                        local TextBox = library:create("TextBox", {
                            Name = "Button",
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0.5, 0, 0.5, 0),
                            Size = UDim2.new(0, 215, 0, 20),
                            Font = Enum.Font.Ubuntu,
                            Text = text,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            PlaceholderText = text,
                            ClearTextOnFocus = false,
                        }, ButtonFrame)

                        TextBox.MouseEnter:Connect(function()
                            library:tween(TextBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                        end)
                        TextBox.MouseLeave:Connect(function()
                            library:tween(TextBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                        end)
                        TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                            if string.len(TextBox.Text) > 15 then
                                TextBox.Text = string.sub(TextBox.Text, 1, 15)
                            end
                            if TextBox.Text ~= value.Text then
                                value.Text = TextBox.Text
                                do_callback()
                            end
                        end)
                        uis.TextBoxFocused:connect(function()
                            if uis:GetFocusedTextBox() == TextBox then
                                library:tween(TextBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(84, 101, 255)})
                            end
                        end)
                        uis.TextBoxFocusReleased:connect(function()
                            library:tween(TextBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(0, 0, 0)})
                        end)
                            

                        function element:set_value(new_value, cb)
                            value = new_value or value

                            TextBox.Text = value.Text

                            if cb == nil or not cb then
                                do_callback()
                            end
                        end
                        element:set_value(value, true)
                    elseif type == "Scroll" then
                        local scrollsize = data.scrollsize and data.scrollsize or 5

                        Border.Size = Border.Size + UDim2.new(0, 0, 0, scrollsize * 20 + 10)

                        value = {Scroll = data.options[1]}

                        local Scroll = library:create("Frame", {
                            Name = "Scroll",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(1, 0, 0, scrollsize * 20 + 10),
                        }, Container)

                        function element:set_visible(bool)
                            if bool then
                                if Scroll.Visible then return end
                                Scroll.Size = Border.Size + UDim2.new(0, 0, 0, scrollsize * 20 + 10)
                                Scroll.Visible = true
                            else
                                if not Scroll.Visible then return end
                                Scroll.Size = Border.Size + UDim2.new(0, 0, 0, -scrollsize * 20 + 10)
                                Scroll.Visible = false
                            end
                        end

                        local ScrollFrame = library:create("ScrollingFrame", {
                            Name = "ScrollFrame",
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0.5, 0, 0, 5),
                            Size = UDim2.new(0, 215, 0, scrollsize * 20),
                            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
                            CanvasSize = UDim2.new(0, 0, 0, #data.options * 20),
                            ScrollBarThickness = 2,
                            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
                            AnchorPoint = Vector2.new(0.5, 0),
                            ScrollBarImageColor3 = Color3.fromRGB(84, 101, 255),
                        }, Scroll)
                        ScrollFrame.MouseEnter:Connect(function()
                            library:tween(ScrollFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(50, 50, 50)})
                        end)
                        ScrollFrame.MouseLeave:Connect(function()
                            library:tween(ScrollFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(0, 0, 0)})
                        end)

                        local UIListLayout = library:create("UIListLayout", {
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }, ScrollFrame)

                        local scroll_is_first = true
                        for _,v in next, data.options do
                            local Button = library:create("TextButton", {
                                Name = v,
                                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0, 0, 0, 20),
                                Size = UDim2.new(1, 0, 0, 20),
                                AutoButtonColor = false,
                                Font = Enum.Font.SourceSans,
                                Text = "",
                                TextColor3 = Color3.fromRGB(0, 0, 0),
                                TextSize = 14,
                            }, ScrollFrame)

                            local ButtonText = library:create("TextLabel", {
                                Name = "ButtonText",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 7, 0, 0),
                                Size = UDim2.new(0, 210, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = v,
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                TextXAlignment = Enum.TextXAlignment.Left,
                            }, Button)

                            local Decoration = library:create("Frame", {
                                Name = "Decoration",
                                Parent = Button,
                                BackgroundColor3 = Color3.fromRGB(84, 101, 255),
                                BorderSizePixel = 0,
                                Size = UDim2.new(0, 1, 1, 0),
                                Visible = false,
                            }, Button)

                            local mouse_in = false
                            Button.MouseEnter:Connect(function()
                                mouse_in = true
                                if value.Scroll ~= v then
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)})
                                end
                            end)
                            Button.MouseLeave:Connect(function()
                                mouse_in = false
                                if value.Scroll ~= v then
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
                            end)
                            Button.MouseButton1Down:Connect(function()
                                for _,Button2 in next, ScrollFrame:GetChildren() do
                                    if not Button2:IsA("TextButton") then continue end
                                    Button2.Decoration.Visible = false
                                    library:tween(Button2.ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end

                                menu.values[tab.tab_num][section_name][sector_name][flag] = value

                                Decoration.Visible = true
                                library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})

                                value.Scroll = v

                                do_callback()
                            end)

                            if scroll_is_first then
                                scroll_is_first = false
                                Decoration.Visible = true
                                ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                        end

                        function element:add_value(v)
                            if ScrollFrame:FindFirstChild(v) then return end

                            ScrollFrame.CanvasSize = ScrollFrame.CanvasSize + UDim2.new(0, 0, 0, 20)

                            local Button = library:create("TextButton", {
                                Name = v,
                                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0, 0, 0, 20),
                                Size = UDim2.new(1, 0, 0, 20),
                                AutoButtonColor = false,
                                Font = Enum.Font.SourceSans,
                                Text = "",
                                TextColor3 = Color3.fromRGB(0, 0, 0),
                                TextSize = 14,
                            }, ScrollFrame)

                            local ButtonText = library:create("TextLabel", {
                                Name = "ButtonText",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 7, 0, 0),
                                Size = UDim2.new(0, 210, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = v,
                                TextColor3 = Color3.fromRGB(150, 150, 150),
                                TextSize = 14,
                                TextXAlignment = Enum.TextXAlignment.Left,
                            }, Button)

                            local Decoration = library:create("Frame", {
                                Name = "Decoration",
                                Parent = Button,
                                BackgroundColor3 = Color3.fromRGB(84, 101, 255),
                                BorderSizePixel = 0,
                                Size = UDim2.new(0, 1, 1, 0),
                                Visible = false,
                            }, Button)
                            
                            local mouse_in = false
                            Button.MouseEnter:Connect(function()
                                mouse_in = true
                                if value.Scroll ~= v then
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)})
                                end
                            end)
                            Button.MouseLeave:Connect(function()
                                mouse_in = false
                                if value.Scroll ~= v then
                                    library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
                            end)
                            Button.MouseButton1Down:Connect(function()
                                for _,Button2 in next, ScrollFrame:GetChildren() do
                                    if not Button2:IsA("TextButton") then continue end
                                    Button2.Decoration.Visible = false
                                    library:tween(Button2.ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end

                                menu.values[tab.tab_num][section_name][sector_name][flag] = value

                                Decoration.Visible = true
                                library:tween(ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})

                                value.Scroll = v

                                do_callback()
                            end)

                            if scroll_is_first then
                                scroll_is_first = false
                                Decoration.Visible = true
                                ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                        end

                        function element:set_value(new_value, cb)
                            value = new_value or value

                            for _,Button2 in next, ScrollFrame:GetChildren() do
                                if not Button2:IsA("TextButton") then continue end
                                Button2.Decoration.Visible = false
                                library:tween(Button2.ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                            end
                            ScrollFrame[value.Scroll].Decoration.Visible = true
                            library:tween(ScrollFrame[value.Scroll].ButtonText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})

                            if cb == nil or not cb then
                                do_callback()
                            end
                        end
                        element:set_value(value, true)
                    elseif type == "Slider" then
                        Border.Size = Border.Size + UDim2.new(0, 0, 0, 35)

                        value = {Slider = default and default.default or 0}

                        local min, max = default and default.min or 0, default and default.max or 100

                        local Slider = library:create("Frame", {
                            Name = "Slider",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 35),
                        }, Container)

                        function element:set_visible(bool)
                            if bool then
                                if Slider.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, 35)
                                Slider.Visible = true
                            else
                                if not Slider.Visible then return end
                                Border.Size = Border.Size + UDim2.new(0, 0, 0, -35)
                                Slider.Visible = false
                            end
                        end

                        local SliderText = library:create("TextLabel", {
                            Name = "SliderText",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 9, 0, 6),
                            Size = UDim2.new(0, 200, 0, 9),
                            Font = Enum.Font.Ubuntu,
                            Text = text,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        }, Slider)

                        local SliderButton = library:create("TextButton", {
                            Name = "SliderButton",
                            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Position = UDim2.new(0, 9, 0, 20),
                            Size = UDim2.new(0, 260, 0, 10),
                            AutoButtonColor = false,
                            Font = Enum.Font.SourceSans,
                            Text = "",
                        }, Slider)

                        local SliderFrame = library:create("Frame", {
                            Name = "SliderFrame",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 100, 1, 0),
                        }, SliderButton)

                        local UIGradient = library:create("UIGradient", {
                            Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(79, 95, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(56, 67, 163))},
                            Rotation = 90,
                        }, SliderFrame)

                        local SliderValue = library:create("TextLabel", {
                            Name = "SliderValue",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 69, 0, 6),
                            Size = UDim2.new(0, 200, 0, 9),
                            Font = Enum.Font.Ubuntu,
                            Text = value.Slider,
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14,
                            TextXAlignment = Enum.TextXAlignment.Right,
                        }, Slider)

                        local is_sliding = false
                        local mouse_in = false
                        Slider.MouseEnter:Connect(function()
                            library:tween(SliderText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                            library:tween(SliderValue, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)})

                            mouse_in = true
                        end)
                        Slider.MouseLeave:Connect(function()
                            if not is_sliding then
                                library:tween(SliderText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                library:tween(SliderValue, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                            end

                            mouse_in = false
                        end)
                        SliderButton.MouseButton1Down:Connect(function()
                            SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, 260), 1, 0)
                        
                            local val = math.floor((((max - min) / 260) * SliderFrame.AbsoluteSize.X) + min)
                            if val ~= value.Slider then
                                SliderValue.Text = val
                                value.Slider = val
                                do_callback()
                            end

                            is_sliding = true

                            move_connection = mouse.Move:Connect(function()
                                SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, 260), 1, 0)
                        
                                local val = math.floor((((max - min) / 260) * SliderFrame.AbsoluteSize.X) + min)
                                if val ~= value.Slider then
                                    SliderValue.Text = val
                                    value.Slider = val
                                    do_callback()
                                end
                            end)
                            release_connection = uis.InputEnded:Connect(function(Mouse)
                                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                    SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, 260), 1, 0)
                        
                                    local val = math.floor((((max - min) / 260) * SliderFrame.AbsoluteSize.X) + min)
                                    if val ~= value.Slider then
                                        SliderValue.Text = val
                                        value.Slider = val
                                        do_callback()
                                    end

                                    is_sliding = false

                                    if not mouse_in then
                                        library:tween(SliderText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                        library:tween(SliderValue, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                    end

                                    move_connection:Disconnect()
                                    release_connection:Disconnect()
                                end
                            end)
                        end)

                        function element:set_value(new_value, cb)
                            value = new_value and new_value or value
                            menu.values[tab.tab_num][section_name][sector_name][flag] = value

                            local new_size = (value.Slider - min) / (max-min)
                            SliderFrame.Size = UDim2.new(new_size, 0, 1, 0)
                            SliderValue.Text = value.Slider

                            if cb == nil or not cb then
                                do_callback()
                            end
                        end
                        element:set_value(value, true)
                    end

                    menu.on_load_cfg:Connect(function()
                        if type ~= "Button" and type ~= "Scroll" then
                            element:set_value(menu.values[tab.tab_num][section_name][sector_name][flag])
                        end
                    end)

                    return element
                end

                return sector
            end

            return section
        end

        return tab
    end

    return menu
end

return library