--[[
Yun Founders: flash#9999, loris#9547, worldwide#0001 , Saul Goodman#2345
Yun Devs: zomb#7741, nives#0001, loot#1337
Special Thanks To: Qw#1549
--]]
function initLibrary()
    local folderName = "epic config folder"


    if not isfolder(folderName) then
        makefolder(folderName)
    end


    local gameConfigFolder = folderName .. "/" .. game.PlaceId


    if not isfolder(gameConfigFolder) then
        makefolder(gameConfigFolder)
    end


    local inputService = game:GetService("UserInputService")
    local tweenService = game:GetService("TweenService")
    local runService = game:GetService("RunService")
    local coreGui = game:GetService("CoreGui")


    local utility = {}


    function utility.create(class, properties)
        properties = properties or {}


        local obj = Instance.new(class)


        local forcedProperties = {
            AutoButtonColor = false
        }


        for prop, v in next, properties do
            obj[prop] = v
        end


        for prop, v in next, forcedProperties do
            pcall(function()
                obj[prop] = v
            end)
        end
        
        return obj
    end


    function utility.change_color(color, amount)
        local r = math.clamp(math.floor(color.r * 255) + amount, 0, 255)
        local g = math.clamp(math.floor(color.g * 255) + amount, 0, 255)
        local b = math.clamp(math.floor(color.b * 255) + amount, 0, 255)


        return Color3.fromRGB(r, g, b)
    end


    function utility.get_rgb(color)
        local r = math.floor(color.r * 255)
        local g = math.floor(color.g * 255)
        local b = math.floor(color.b * 255)


        return r, g, b
    end


    function utility.tween(obj, info, properties, callback)
        local anim = tweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
        anim:Play()


        if callback then
            anim.Completed:Connect(callback)
        end
    end


    function utility.drag(obj, dragSpeed)
        local start, objPosition, dragging


        obj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                start = input.Position
                objPosition = obj.Position
            end
        end)


        obj.InputEnded:Connect(function(input )
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                dragging = false
            end
        end)


        inputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then   
                utility.tween(obj, {dragSpeed}, {Position = UDim2.new(objPosition.X.Scale, objPosition.X.Offset + (input.Position - start).X, objPosition.Y.Scale, objPosition.Y.Offset + (input.Position - start).Y)})
            end
        end)
    end


    function utility.get_center(sizeX, sizeY)
        return UDim2.new(0.5, -(sizeX / 2), 0.5, -(sizeY / 2))
    end


    function utility.hex_to_rgb(hex)
        return Color3.fromRGB(tonumber("0x" .. hex:sub(2, 3)), tonumber("0x" .. hex:sub(4, 5)), tonumber("0x"..hex:sub(6, 7)))
    end


    function utility.rgb_to_hex(color)
        return string.format("#%02X%02X%02X", math.clamp(color.R * 255, 0, 255), math.clamp(color.G * 255, 0, 255), math.clamp(color.B * 255, 0, 255))
    end


    function utility.table(tbl)
        local oldtbl = tbl or {}
        local newtbl = {}
        local formattedtbl = {}


        for option, v in next, oldtbl do
            newtbl[option:lower()] = v
        end


        setmetatable(formattedtbl, {
            __newindex = function(t, k, v)
                rawset(newtbl, k:lower(), v)
            end,
            __index = function(t, k, v)
                return newtbl[k:lower()]
            end
        })


        return formattedtbl
    end


    local library = utility.table{
        flags = {}, 
        toggled = true,
        color = Color3.fromRGB(255, 0, 0),
        keybind = Enum.KeyCode.RightShift, 
        dragSpeed = 0.1
    }    


    local coloredGradients = {}


    function library:SetColor(color)
        for _, obj in next, coloredGradients do
            obj.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, color),
                ColorSequenceKeypoint.new(1, utility.change_color(color, -49))
            }
        end


        library.color = color
    end


    local gui = utility.create("ScreenGui")


    inputService.InputBegan:Connect(function(input)
        if input.KeyCode == library.keybind then
            library.toggled = not library.toggled
            gui.Enabled = library.toggled
        end
    end)


    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    end


    gui.Parent = coreGui


    local flags = {toggles = {}, boxes = {}, sliders = {}, dropdowns = {}, multidropdowns = {}, keybinds = {}, colorpickers = {}}


    function library:LoadConfig(file)
        local str = readfile(gameConfigFolder .. "/" .. file .. ".cfg")
        local tbl = loadstring(str)()
        
        for flag, value in next, tbl.toggles do
            flags.toggles[flag](value)
        end


        for flag, value in next, tbl.boxes do
            flags.boxes[flag](value)
        end


        for flag, value in next, tbl.sliders do
            flags.sliders[flag](value)
        end


        for flag, value in next, tbl.dropdowns do
            flags.dropdowns[flag](value)
        end


        for flag, value in next, tbl.multidropdowns do
            flags.multidropdowns[flag](value)
        end


        for flag, value in next, tbl.keybinds do
            flags.keybinds[flag](value)
        end


        for flag, value in next, tbl.colorpickers do
            flags.colorpickers[flag](value)
        end
    end


    function library:SaveConfig(name)
        local configstr = "{toggles={"
        local count = 0


        for flag, _ in next, flags.toggles do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']=" .. tostring(library.flags[flag]) .. ","
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "},boxes={"


        count = 0
        for flag, _ in next, flags.boxes do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']='" .. tostring(library.flags[flag]) .. "',"
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "},sliders={"


        count = 0
        for flag, _ in next, flags.sliders do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']=" .. tostring(library.flags[flag]) .. ","
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "},dropdowns={"


        count = 0
        for flag, _ in next, flags.dropdowns do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']='" .. tostring(library.flags[flag]) .. "',"
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "},multidropdowns={"


        count = 0
        for flag, _ in next, flags.multidropdowns do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']={'" .. table.concat(library.flags[flag], "','") .. "'},"
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "},keybinds={"


        count = 0
        for flag, _ in next, flags.keybinds do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']=" .. tostring(library.flags[flag]) .. ","
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "},colorpickers={"


        count = 0
        for flag, _ in next, flags.colorpickers do
            count = count + 1
            configstr = configstr .. "['" .. flag .. "']=Color3.new(" .. tostring(library.flags[flag]) .. "),"
        end


        configstr = (count > 0 and configstr:sub(1, -2) or configstr) .. "}}"


        writefile(gameConfigFolder .. "/" .. name .. ".cfg", "return " .. configstr)
    end




    function library:Load(opts)
        local options = utility.table(opts)
        local name = options.name or "Epic UI Library"
        local sizeX = options.sizeX or 466
        local sizeY = options.sizeY or 350
        local color = options.color or Color3.fromRGB(255, 255, 255)
        local dragSpeed = options.dragSpeed or 0


        library.color = color


        local topbar = utility.create("Frame", {
            ZIndex = 2,
            Size = UDim2.new(0, sizeX, 0, 26),
            Position = utility.get_center(sizeX, sizeY),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(22, 22, 22),
            Parent = gui
        })


        utility.drag(topbar, dragSpeed)


        utility.create("TextLabel", {
            ZIndex = 3,
            Size = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            FontSize = Enum.FontSize.Size14,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Text = name,
            Font = Enum.Font.GothamSemibold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = topbar
        })
        
        local main = utility.create("Frame", {
            Size = UDim2.new(1, 0, 0, sizeY),
            BorderColor3 = Color3.fromRGB(20, 20, 20),
            BackgroundColor3 = Color3.fromRGB(32, 32, 32),
            Parent = topbar
        })


        local tabs = utility.create("Frame", {
            ZIndex = 2,
            Size = UDim2.new(1, -8, 1, -64),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 4, 0, 58),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = main
        })
        
        local tabToggles = utility.create("Frame", {
            ZIndex = 2,
            Size = UDim2.new(1, 0, 0, 26),
            BorderColor3 = Color3.fromRGB(20, 20, 20),
            Position = UDim2.new(0, 0, 0, 26),
            BackgroundColor3 = Color3.fromRGB(26, 26, 26),
            Parent = main
        })


        local tabTogglesHolder = utility.create("Frame", {
            Size = UDim2.new(1, -12, 1, 0),
            Position = UDim2.new(0, 6, 0, 0),
            Parent = tabToggles
        })


        utility.create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4),
            Parent = tabTogglesHolder
        })


        local windowTypes = utility.table({count = 0})


        function windowTypes:Show()
            gui.Enabled = true
        end


        function windowTypes:Hide()
            gui.Enabled = false
        end


        function windowTypes:Tab(name)
            windowTypes.count = windowTypes.count + 1
            name = name or "Tab"


            local toggled = windowTypes.count == 1


            local tabToggle = utility.create("TextButton", {
                ZIndex = 3,
                BackgroundTransparency = 1,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                FontSize = Enum.FontSize.Size14,
                TextSize = 14,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Text = name,
                Font = toggled and Enum.Font.GothamSemibold or Enum.Font.Gotham,
                Parent = tabTogglesHolder
            })
            
            tabToggle.Size = UDim2.new(0, tabToggle.TextBounds.X + 12, 1, 0)


            local tab = utility.create("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Visible = toggled,
                Parent = tabs
            })
            
            local column1 = utility.create("ScrollingFrame", {
                Size = UDim2.new(0.5, -2, 1, 0),
                BackgroundTransparency = 1,
                Active = true,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                Parent = tab
            })


            local column1List = utility.create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6),
                Parent = column1
            })


            column1List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                column1.CanvasSize = UDim2.new(0, 0, 0, column1List.AbsoluteContentSize.Y)
            end)


            local column2 = utility.create("ScrollingFrame", {
                Size = UDim2.new(0.5, -2, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 2, 0, 0),
                Active = true,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                CanvasPosition = Vector2.new(0, 150),
                Parent = tab
            })


            local column2List = utility.create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6),
                Parent = column2
            })


            column2List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                column2.CanvasSize = UDim2.new(0, 0, 0, column2List.AbsoluteContentSize.Y)
            end)


            local function openTab()
                for _, obj in next, tabTogglesHolder:GetChildren() do
                    if obj:IsA("TextButton") then
                        obj.Font = Enum.Font.Gotham
                    end
                end


                tabToggle.Font = Enum.Font.GothamSemibold


                for _, obj in next, tabs:GetChildren() do
                    obj.Visible = false
                end


                tab.Visible = true
            end


            tabToggle.MouseButton1Click:Connect(openTab)


            local tabTypes = utility.table()


            function tabTypes:Open()
                openTab()
            end
        
            function tabTypes:Section(opts)
                local options = utility.table(opts)
                local name = options.name or "Section"
                local column = options.column or 1
                
                local columnFrame = column == 1 and column1 or column == 2 and column2
                
                local sectionHolder = utility.create("Frame", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = columnFrame
                })
                
                local section = utility.create("Frame", {
                    ZIndex = 2,
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderColor3 = Color3.fromRGB(22, 22, 22),
                    Position = UDim2.new(0, 1, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
                    Parent = sectionHolder
                })
                
                local sectionTopbar = utility.create("Frame", {
                    ZIndex = 3,
                    Size = UDim2.new(1, 0, 0, 24),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22),
                    Parent = section
                })


                utility.create("TextLabel", {
                    ZIndex = 3,
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    FontSize = Enum.FontSize.Size14,
                    TextSize = 13,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Text = name,
                    Font = Enum.Font.GothamSemibold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = sectionTopbar
                })


                local sectionContent = utility.create("Frame", {
                    Size = UDim2.new(1, -12, 1, -36),
                    Position = UDim2.new(0, 6, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = section
                })
                
                local sectionContentList = utility.create("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 6),
                    Parent = sectionContent
                })


                sectionContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    sectionHolder.Size = UDim2.new(1, 0, 0, sectionContentList.AbsoluteContentSize.Y + 38)
                end)


                local sectionTypes = utility.table()


                function sectionTypes:Show()
                    sectionHolder.Visible = true
                end


                function sectionTypes:Hide()
                    sectionHolder.Visible = false
                end


                function sectionTypes:Label(text)
                    local label = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 0, 14),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 8, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        Text = text,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionContent
                    })


                    local labelTypes = utility.table()


                    function labelTypes:Show()
                        label.Visible = true
                    end


                    function labelTypes:Hide()
                        label.Visible = false
                    end


                    function labelTypes:Set(str)
                        label.Text = str
                    end


                    return labelTypes
                end


                function sectionTypes:SpecialLabel(text)
                    local specialLabel = utility.create("TextLabel", {
                        ZIndex = 5,
                        Size = UDim2.new(1, 0, 0, 14),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 8, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        Text = text,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Font = Enum.Font.Gotham,
                        Parent = sectionContent
                    })


                    utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(1, 0, 0, 1),
                        Position = UDim2.new(0, 0, 0.5, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = specialLabel
                    })
                    
                    local lineBlock = utility.create("Frame", {
                        ZIndex = 4,
                        Size = UDim2.new(0, specialLabel.TextBounds.X + 6, 0, 1),
                        Position = UDim2.new(0.5, -((specialLabel.TextBounds.X + 6) / 2), 0.5, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
                        Parent = specialLabel
                    })


                    specialLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
                        lineBlock.Size = UDim2.new(0, specialLabel.TextBounds.X + 6, 0, 1)
                        lineBlock.Position = UDim2.new(0.5, -((specialLabel.TextBounds.X + 6) / 2), 0.5, 1)
                    end)


                    local specialLabelTypes = utility.table()


                    function specialLabelTypes:Show()
                        specialLabel.Visible = true
                    end


                    function specialLabelTypes:Hide()
                        specialLabel.Visible = false
                    end


                    function specialLabelTypes:Set(str)
                        specialLabel.Text = str
                    end


                    return specialLabelTypes
                end


                function sectionTypes:Button(opts)
                    local options = utility.table(opts)
                    local name = options.name
                    local callback = options.callback


                    local button = utility.create("TextButton", {
                        ZIndex = 3,
                        Size = UDim2.new(1, 0, 0, 16),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Font = Enum.Font.Gotham,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionContent
                    })
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                        },
                        Parent = button
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 4,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 8, 0, 0),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = button
                    })


                    local buttonTypes = utility.table()


                    button.MouseButton1Click:Connect(function()
                        callback(buttonTypes)
                    end)


                    function buttonTypes:Show()
                        button.Visible = true
                    end
                    
                    function buttonTypes:Hide()
                        button.Visible = false
                    end
                    
                    function buttonTypes:SetName(str)
                        title.Text = str
                    end


                    function buttonTypes:SetCallback(func)
                        callback = func
                    end
                    
                    return buttonTypes
                end


                function sectionTypes:Toggle(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Toggle"
                    local flag = options.flag 
                    local callback = options.callback or function() end


                    local toggled = false


                    if flag then
                        library.flags[flag] = toggled
                    end


                    callback(toggled)


                    local toggle = utility.create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Font = Enum.Font.SourceSans,
                        Parent = sectionContent
                    })
                    
                    local icon = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 14, 1, -2),
                        BorderColor3 = Color3.fromRGB(37, 37, 37),
                        Position = UDim2.new(0, 0, 0, 1),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = toggle
                    })


                    local iconGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                        },
                        Parent = icon
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 7, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = icon
                    })


                    local function toggleToggle()
                        toggled = not toggled


                        if toggled then
                            table.insert(coloredGradients, iconGradient)
                        else
                            table.remove(coloredGradients, table.find(coloredGradients, iconGradient))
                        end


                        local textColor = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                        local gradientColor
                        if toggled then
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, library.color), 
                                ColorSequenceKeypoint.new(1, utility.change_color(library.color, -47))
                            }
                        else
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                            }
                        end


                        iconGradient.Color = gradientColor
                        title.TextColor3 = textColor


                        if flag then
                            library.flags[flag] = toggled
                        end


                        callback(toggled)
                    end


                    toggle.MouseButton1Click:Connect(toggleToggle)


                    local toggleTypes = utility.table()


                    function toggleTypes:Show()
                        toggle.Visible = true
                    end
                    
                    function toggleTypes:Hide()
                        toggle.Visible = false
                    end
                    
                    function toggleTypes:SetName(str)
                        title.Text = str
                    end


                    function toggleTypes:Toggle(bool)
                        if toggled ~= bool then
                            toggleToggle()
                        end
                    end


                    if flag then
                        flags.toggles[flag] = function(bool)
                            if toggled ~= bool then
                                toggleToggle()
                            end
                        end
                    end


                    return toggleTypes
                end


                function sectionTypes:Box(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Box"
                    local placeholder = options.placeholder or "Box"
                    local default = options.default or ""
                    local boxType = options.type or "string"
                    local flag = options.flag
                    local callback = options.callback or function() end


                    boxType = boxType:lower()


                    if boxType == "number" then
                        default = default:gsub("%D+", "")


                        if flag then
                            library.flags[flag] = tonumber(default)
                        end
        
                        callback(tonumber(default))
                    else
                        if flag then
                            library.flags[flag] = default
                        end


                        callback(default)
                    end


                    local boxHolder = utility.create("Frame", {
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = sectionContent
                    })
                    
                    local box = utility.create("TextBox", {
                        ZIndex = 4,
                        Size = UDim2.new(1, 0, 0, 16),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 1, -16),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = default,
                        Font = Enum.Font.Gotham,
                        PlaceholderText = placeholder,
                        Parent = boxHolder
                    })


                    local bg = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 0, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = box
                    })


                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = bg
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = boxHolder
                    })


                    box:GetPropertyChangedSignal("Text"):Connect(function()
                        if boxType == "number" then
                            box.Text = box.Text:gsub("%D+", "")
                        end
                    end)


                    local boxTypes = utility.table()


                    function boxTypes:Show()
                        boxHolder.Visible = true
                    end
                    
                    function boxTypes:Hide()
                        boxHolder.Visible = false
                    end
                    
                    function boxTypes:SetName(str)
                        title.Text = str
                    end


                    function boxTypes:SetPlaceholder(str)
                        box.PlaceholderText = str
                    end


                    function boxTypes:Set(str)
                        if boxType == "string" then
                            box.Text = str


                            if flag then
                                library.flags[flag] = str
                            end


                            callback(str)
                        else
                            str = str:gsub("%D+", "")
                            box.Text = str


                            if flag then
                                library.flags[flag] = str
                            end


                            callback(tonumber(str))
                        end
                    end


                    box.FocusLost:Connect(function()
                        boxTypes:Set(box.Text)
                    end)


                    function boxTypes:SetType(str)
                        if str:lower() == "number" or str:lower() == "string" then
                            boxType = str:lower()
                        end
                    end


                    if flag then
                        flags.boxes[flag] = function(str)
                            if boxType == "string" then
                                box.Text = str


                                if flag then
                                    library.flags[flag] = str
                                end


                                callback(str)
                            else
                                str = str:gsub("%D+", "")
                                box.Text = str


                                if flag then
                                    library.flags[flag] = str
                                end


                                callback(tonumber(str))
                            end
                        end
                    end


                    return boxTypes
                end


                function sectionTypes:Slider(opts)
                    local options = utility.table(opts)
                    local min = options.min or 0
                    local max = options.max or 100
                    local valueText = options.valueText or "Slider: [VALUE]/" .. tostring(max)
                    local default = options.default or math.clamp(0, min, max)
                    local decimals = options.decimals or 0.1
                    local flag = options.flag
                    local callback = options.callback or function() end


                    decimals = math.floor(10^decimals)


                    if flag then
                        library.flags[flag] = default
                    end


                    callback(default)


                    local value = default


                    local sliding = false


                    local slider = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(1, 0, 0, 16),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 0, 1, -13),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = sectionContent
                    })
                    
                    local fill = utility.create("Frame", {
                        ZIndex = 4,
                        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = slider
                    })
                    
                    local fillGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, library.color), 
                            ColorSequenceKeypoint.new(1, utility.change_color(library.color, -47))
                        },
                        Parent = fill
                    })


                    table.insert(coloredGradients, fillGradient)
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                        },
                        Parent = slider
                    })


                    local title = utility.create("TextLabel", {
                        ZIndex = 5,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = valueText:gsub("%[VALUE%]", tostring(default)),
                        Font = Enum.Font.Gotham,
                        Parent = slider
                    })


                    local function slide(input)
                        local sizeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                        fill.Size = UDim2.new(sizeX, 0, 1, 0)


                        value = math.floor((((max - min) * sizeX) + min) * decimals) / decimals
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))


                        if flag then 
                            library.flags[flag] = value
                        end


                        callback(value)
                    end


                    slider.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = true
                            slide(input)
                        end
                    end)


                    slider.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = false
                        end
                    end)


                    inputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            if sliding then
                                slide(input)
                            end
                        end
                    end)


                    local sliderTypes = utility.table()


                    function sliderTypes:Show()
                        slider.Visible = true
                    end


                    function sliderTypes:Hide()
                        slider.Visible = false
                    end


                    function sliderTypes:SetValueText(str)
                        valueText = str
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))
                    end


                    function sliderTypes:Set(num)
                        num = math.floor(math.clamp(num, min, max) * decimals) / decimals
                        value = num
                        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                        
                        if flag then 
                            library.flags[flag] = value
                        end


                        callback(value)
                    end


                    function sliderTypes:SetMin(num)
                        min = num
                        value = math.floor(math.clamp(value, min, max) * decimals) / decimals
                        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)


                        if flag then 
                            library.flags[flag] = value
                        end


                        callback(value)
                    end


                    function sliderTypes:SetMax(num)
                        max = num
                        value = math.floor(math.clamp(value, min, max) * decimals) / decimals
                        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)


                        if flag then 
                            library.flags[flag] = value
                        end


                        callback(value)
                    end


                    if flag then
                        flags.sliders[flag] = function(num)
                            sliderTypes:Set(num)
                        end
                    end


                    return sliderTypes
                end


                function sectionTypes:ToggleSlider(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Toggle Slider"
                    local min = options.min or 0
                    local max = options.max or 100
                    local valueText = options.valueText or "Toggle Slider: [VALUE]/" .. tostring(max)
                    local default = options.default or math.clamp(0, min, max)
                    local decimals = options.decimals or 0
                    local toggleFlag = options.toggleFlag
                    local sliderFlag = options.sliderFlag
                    local toggleCallback = options.toggleCallback or function() end
                    local sliderCallback = options.sliderCallback or function() end


                    decimals = math.floor(10^decimals)


                    local value = default
                    local toggled = false
                    local sliding = false


                    if sliderFlag then
                        library.flags[sliderFlag] = default
                    end


                    sliderCallback(default)


                    if toggleFlag then
                        library.flags[toggleFlag] = toggled
                    end


                    toggleCallback(toggled)


                    local toggleSliderHolder = utility.create("Frame", {
                        Size = UDim2.new(1, 0, 0, 35),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = sectionContent
                    })
                    
                    local slider = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(1, 0, 0, 16),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 0, 1, -16),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = toggleSliderHolder
                    })
                    
                    local fill = utility.create("Frame", {
                        ZIndex = 4,
                        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = slider
                    })
                    
                    local fillGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, library.color), 
                            ColorSequenceKeypoint.new(1, utility.change_color(library.color, -47))
                        },
                        Parent = fill
                    })


                    table.insert(coloredGradients, fillGradient)
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = slider
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 5,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = valueText:gsub("%[VALUE%]", tostring(default)),
                        Font = Enum.Font.Gotham,
                        Parent = slider
                    })


                    local toggle = utility.create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 14,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Font = Enum.Font.SourceSans,
                        Parent = toggleSliderHolder
                    })
                    
                    local icon = utility.create("TextButton", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 14, 1, -2),
                        BorderColor3 = Color3.fromRGB(37, 37, 37),
                        Position = UDim2.new(0, 0, 0, 1),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Text = "",
                        Parent = toggle
                    })
                    
                    local iconGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                        },
                        Parent = icon
                    })
                    
                    local toggleTitle = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 7, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = icon
                    })


                    local function toggleToggle()
                        toggled = not toggled


                        if toggled then
                            table.insert(coloredGradients, iconGradient)
                        else
                            table.remove(coloredGradients, table.find(coloredGradients, iconGradient))
                        end


                        local textColor = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                        local gradientColor
                        if toggled then
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, library.color), 
                                ColorSequenceKeypoint.new(1, utility.change_color(library.color, -47))
                            }
                        else
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                            }
                        end


                        iconGradient.Color = gradientColor
                        toggleTitle.TextColor3 = textColor


                        if toggleFlag then
                            library.flags[toggleFlag] = toggled
                        end


                        toggleCallback(toggled)
                    end


                    toggle.MouseButton1Click:Connect(toggleToggle)


                    local function slide(input)
                        local sizeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                        fill.Size = UDim2.new(sizeX, 0, 1, 0)


                        value = math.floor((((max - min) * sizeX) + min) * decimals) / decimals
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))


                        if sliderFlag then 
                            library.flags[sliderFlag] = value
                        end


                        sliderCallback(value)
                    end


                    slider.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = true
                            slide(input)
                        end
                    end)


                    slider.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = false
                        end
                    end)


                    inputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            if sliding then
                                slide(input)
                            end
                        end
                    end)


                    local toggleSliderTypes = utility.table()


                    function toggleSliderTypes:Show()
                        toggleSliderHolder.Visible = true
                    end


                    function toggleSliderTypes:Hide()
                        toggleSliderHolder.Visible = false
                    end


                    function toggleSliderTypes:SetValueText(str)
                        valueText = str
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))
                    end


                    function toggleSliderTypes:Set(num)
                        num = math.floor(math.clamp(num, min, max) * decimals) / decimals
                        value = num
                        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))
                        
                        if sliderFlag then 
                            library.flags[sliderFlag] = value
                        end


                        sliderCallback(value)
                    end


                    function toggleSliderTypes:SetMin(num)
                        min = num
                        value = math.floor(math.clamp(value, min, max) * decimals) / decimals
                        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))


                        if sliderFlag then 
                            library.flags[sliderFlag] = value
                        end


                        sliderCallback(value)
                    end


                    function toggleSliderTypes:SetMax(num)
                        max = num
                        value = math.floor(math.clamp(value, min, max) * decimals) / decimals
                        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                        title.Text = valueText:gsub("%[VALUE%]", tostring(value))


                        if sliderFlag then 
                            library.flags[sliderFlag] = value
                        end


                        sliderCallback(value)
                    end


                    function toggleSliderTypes:Toggle(bool)
                        if toggled ~= bool then
                            toggleToggle()
                        end
                    end


                    if toggleFlag then
                        flags.toggles[toggleFlag] = function(bool)
                            if toggled ~= bool then
                                toggleToggle()
                            end
                        end
                    end


                    if sliderFlag then
                        flags.sliders[sliderFlag] = function(num)
                            toggleSliderTypes:Set(num)
                        end
                    end


                    return toggleSliderTypes
                end


                function sectionTypes:Dropdown(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Dropdown"
                    local content = options.content or {}
                    local multiChoice = options.multiChoice or false
                    local default = (options.default and table.find(content, options.default)) or (multiChoice and {} or nil)
                    local flag = options.flag
                    local callback = options.callback or function() end




                    if flag then
                        library.flags[flag] = default
                    end
                    callback(default)


                    local opened = false


                    local current = default
                    local chosen = {}


                    local dropdownHolder = utility.create("Frame", {
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = sectionContent
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = dropdownHolder
                    })
                    
                    local open = utility.create("TextButton", {
                        ZIndex = 3,
                        Size = UDim2.new(1, 0, 0, 16),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 0, 0, 20),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Text = "",
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = dropdownHolder
                    })
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = open
                    })
                    
                    local value = utility.create("TextLabel", {
                        ZIndex = 4,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 8, 0, 0),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = (multiChoice and (#default > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180))) or default and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180),
                        Text = multiChoice and (#default > 0 and table.concat(default, ", ") or "NONE") or (default or "NONE"),
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = open
                    })
                    
                    local icon = utility.create("ImageLabel", {
                        ZIndex = 4,
                        Size = UDim2.new(0, 14, 0, 14),
                        Rotation = 180,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -16, 0, 1),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Image = "http://www.roblox.com/asset/?id=8747047318",
                        Parent = open
                    })
                    
                    local contentFrame = utility.create("Frame", {
                        ZIndex = 10,
                        Visible = false,
                        Size = UDim2.new(1, 0, 0, 0),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 0, 1, 3),
                        BackgroundColor3 = Color3.fromRGB(33, 33, 33),
                        Parent = open
                    })
                    
                    local contentHolder = utility.create("Frame", {
                        Size = UDim2.new(1, 0, 1, -4),
                        Position = UDim2.new(0, 0, 0, 2),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = contentFrame
                    })


                    local contentList = utility.create("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Parent = contentHolder
                    })


                    contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        contentFrame.Size = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y + 4)
                    end)


                    local function openDropdown()
                        opened = not opened
                        icon.Rotation = opened and 0 or 180
                        contentFrame.Visible = opened
                        dropdownHolder.Size = UDim2.new(1, 0, 0, opened and dropdownHolder.AbsoluteSize.Y + contentFrame.AbsoluteSize.Y + 3 or 36)
                    end


                    local function selectObj(obj, padding, bool)
                        for i, v in next, contentHolder:GetChildren() do
                            if v:IsA("TextButton") then
                                v:FindFirstChildOfClass("UIPadding").PaddingLeft = UDim.new(0, 6)
                                v.Font = Enum.Font.Gotham
                            end
                        end


                        obj.Font = bool and Enum.Font.GothamSemibold or Enum.Font.Gotham
                        padding.PaddingLeft = bool and UDim.new(0, 10) or UDim.new(0, 6)
                        value.TextColor3 = bool and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                    end


                    local function multiSelectObj(obj, padding, bool)
                        obj.Font = bool and Enum.Font.GothamSemibold or Enum.Font.Gotham
                        padding.PaddingLeft = bool and UDim.new(0, 10) or UDim.new(0, 6)
                    end
                    
                    open.MouseButton1Click:Connect(openDropdown)


                    for _, opt in next, content do
                        local option = utility.create("TextButton", {
                            Name = opt,
                            ZIndex = 11,
                            Size = UDim2.new(1, 0, 0, 14),
                            BackgroundTransparency = 1,
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            FontSize = Enum.FontSize.Size12,
                            TextSize = 12,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            Text = tostring(opt),
                            Font = current == opt and Enum.Font.GothamSemibold or Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = contentHolder
                        })
                        
                        local optionPadding = utility.create("UIPadding", {
                            PaddingLeft = current == opt and UDim.new(0, 10) or UDim.new(0, 6),
                            Parent = option
                        })


                        option.MouseButton1Click:Connect(function()
                            if not multiChoice then
                                if current ~= opt then
                                    current = opt
                                    selectObj(option, optionPadding, true)
                                    value.Text = opt
                                    
                                    if flag then
                                        library.flags[flag] = opt
                                    end


                                    callback(opt)
                                else
                                    current = nil
                                    selectObj(option, optionPadding, false)
                                    value.Text = "NONE"


                                    if flag then
                                        library.flags[flag] = nil
                                    end


                                    callback(nil)
                                end
                            else
                                if not table.find(chosen, opt) then
                                    table.insert(chosen, opt)


                                    multiSelectObj(option, optionPadding, true)
                                    value.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    value.Text = table.concat(chosen, ", ")
                                    
                                    if flag then
                                        library.flags[flag] = chosen
                                    end


                                    callback(chosen)
                                else
                                    table.remove(chosen, table.find(chosen, opt))


                                    multiSelectObj(option, optionPadding, false)
                                    value.TextColor3 = #chosen > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                                    value.Text = #chosen > 0 and table.concat(chosen, ", ") or "NONE"


                                    if flag then
                                        library.flags[flag] = chosen
                                    end


                                    callback(chosen)
                                end
                            end
                        end)
                    end


                    local dropdownTypes = utility.table()


                    function dropdownTypes:Show()
                        dropdownHolder.Visible = true
                    end


                    function dropdownTypes:Hide()
                        dropdownHolder.Visible = false
                    end


                    function dropdownTypes:SetName(str)
                        title.Text = str
                    end


                    function dropdownTypes:Set(opt)
                        if opt then
                            if typeof(opt) == "string" then
                                if table.find(content, opt) then
                                    if not multiChoice then
                                        current = opt
                                        selectObj(contentHolder:FindFirstChild(opt), contentHolder:FindFirstChild(opt):FindFirstChildOfClass("UIPadding"), true)
                                        value.Text = opt
                                        
                                        if flag then
                                            library.flags[flag] = opt
                                        end


                                        callback(opt)
                                    else
                                        table.insert(chosen, opt)


                                        multiSelectObj(contentHolder:FindFirstChild(opt), contentHolder:FindFirstChild(opt):FindFirstChildOfClass("UIPadding"), true)
                                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        value.Text = table.concat(chosen, ", ")
                                        
                                        if flag then
                                            library.flags[flag] = chosen
                                        end


                                        callback(chosen)
                                    end
                                end
                            elseif multiChoice then
                                table.clear(chosen)
                                chosen = opt


                                for i, v in next, opt do
                                    if contentHolder:FindFirstChild(v) then
                                        multiSelectObj(contentHolder:FindFirstChild(v), contentHolder:FindFirstChild(v):FindFirstChildOfClass("UIPadding"), true)


                                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        value.Text = table.concat(chosen, ", ")
                                    end
                                end
                            end
                        else
                            if not multiChoice then
                                current = nil


                                for i, v in next, contentHolder:GetChildren() do
                                    if v:IsA("TextButton") then
                                        v:FindFirstChildOfClass("UIPadding").PaddingLeft = UDim.new(0, 6)
                                        v.Font = Enum.Font.Gotham
                                    end
                                end


                                value.Text = "NONE"
                                value.TextColor3 = Color3.fromRGB(180, 180, 180)


                                if flag then
                                    library.flags[flag] = nil
                                end


                                callback(nil)
                            elseif multiChoice then
                                table.clear(chosen)


                                for i, v in next, contentHolder:GetChildren() do
                                    if v:IsA("TextButton") then
                                        v:FindFirstChildOfClass("UIPadding").PaddingLeft = UDim.new(0, 6)
                                        v.Font = Enum.Font.GothamSemiBold
                                    end
                                end


                                value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                value.Text = "NONE"


                                if flag then
                                    library.flags[flag] = chosen
                                end


                                callback(chosen)
                            end
                        end
                    end


                    function dropdownTypes:Add(opt)
                        table.insert(content, opt)


                        local option = utility.create("TextButton", {
                            Name = opt,
                            ZIndex = 11,
                            Size = UDim2.new(1, 0, 0, 14),
                            BackgroundTransparency = 1,
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            FontSize = Enum.FontSize.Size12,
                            TextSize = 12,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            Text = tostring(opt),
                            Font = current == opt and Enum.Font.GothamSemibold or Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = contentHolder
                        })
                        
                        local optionPadding = utility.create("UIPadding", {
                            PaddingLeft = current == opt and UDim.new(0, 10) or UDim.new(0, 6),
                            Parent = option
                        })


                        option.MouseButton1Click:Connect(function()
                            if not multiChoice then
                                if current ~= opt then
                                    current = opt
                                    selectObj(option, optionPadding, true)
                                    value.Text = opt
                                    
                                    if flag then
                                        library.flags[flag] = opt
                                    end


                                    callback(opt)
                                else
                                    current = nil
                                    selectObj(option, optionPadding, false)
                                    value.Text = "NONE"


                                    if flag then
                                        library.flags[flag] = nil
                                    end


                                    callback(nil)
                                end
                            else
                                if not table.find(chosen, opt) then
                                    table.insert(chosen, opt)


                                    multiSelectObj(option, optionPadding, true)
                                    value.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    value.Text = table.concat(chosen, ", ")
                                    
                                    if flag then
                                        library.flags[flag] = chosen
                                    end


                                    callback(chosen)
                                else
                                    table.remove(chosen, table.find(chosen, opt))


                                    multiSelectObj(option, optionPadding, false)
                                    value.TextColor3 = #chosen > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                                    value.Text = #chosen > 0 and table.concat(chosen, ", ") or "NONE"


                                    if flag then
                                        library.flags[flag] = chosen
                                    end


                                    callback(chosen)
                                end
                            end
                        end)
                    end


                    function dropdownTypes:Remove(opt)
                        if table.find(content, opt) then
                            if not multiChoice then
                                if current == opt then
                                    dropdownTypes:Set(nil)
                                end


                                if contentHolder:FindFirstChild(opt) then
                                    contentHolder:FindFirstChild(opt):Destroy()
                                end
                            else
                                if table.find(chosen, opt) then
                                    table.remove(chosen, table.find(chosen, opt))
                                    value.TextColor3 = #chosen > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                                    value.Text = #chosen > 0 and table.concat(chosen, ", ") or "NONE"
                                end


                                if contentHolder:FindFirstChild(opt) then
                                    contentHolder:FindFirstChild(opt):Destroy()
                                end
                            end
                        end
                    end


                    function dropdownTypes:Refresh(tbl)
                        content = tbl
                        for _, opt in next, contentHolder:GetChildren() do
                            if opt:IsA("TextButton") then
                                opt:Destroy()
                            end
                        end


                        dropdownTypes:Set(nil)


                        for _, opt in next, content do
                            local option = utility.create("TextButton", {
                                Name = opt,
                                ZIndex = 11,
                                Size = UDim2.new(1, 0, 0, 14),
                                BackgroundTransparency = 1,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                FontSize = Enum.FontSize.Size12,
                                TextSize = 12,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                Text = tostring(opt),
                                Font = current == opt and Enum.Font.GothamSemibold or Enum.Font.Gotham,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                Parent = contentHolder
                            })
                            
                            local optionPadding = utility.create("UIPadding", {
                                PaddingLeft = current == opt and UDim.new(0, 10) or UDim.new(0, 6),
                                Parent = option
                            })
        
                            option.MouseButton1Click:Connect(function()
                                if not multiChoice then
                                    if current ~= opt then
                                        current = opt
                                        selectObj(option, optionPadding, true)
                                        value.Text = opt
                                        
                                        if flag then
                                            library.flags[flag] = opt
                                        end
        
                                        callback(opt)
                                    else
                                        current = nil
                                        selectObj(option, optionPadding, false)
                                        value.Text = "NONE"
        
                                        if flag then
                                            library.flags[flag] = nil
                                        end
        
                                        callback(nil)
                                    end
                                else
                                    if not table.find(chosen, opt) then
                                        table.insert(chosen, opt)
        
                                        multiSelectObj(option, optionPadding, true)
                                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        value.Text = table.concat(chosen, ", ")
                                        
                                        if flag then
                                            library.flags[flag] = chosen
                                        end
        
                                        callback(chosen)
                                    else
                                        table.remove(chosen, table.find(chosen, opt))
        
                                        multiSelectObj(option, optionPadding, false)
                                        value.TextColor3 = #chosen > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                                        value.Text = #chosen > 0 and table.concat(chosen, ", ") or "NONE"
        
                                        if flag then
                                            library.flags[flag] = chosen
                                        end
        
                                        callback(chosen)
                                    end
                                end
                            end)
                        end
                    end


                    if flag then
                        if not multiChoice then
                            flags.dropdowns[flag] = function(opt)
                                dropdownTypes:Set(opt)
                            end
                        else
                            flags.multidropdowns[flag] = function(opt)
                                dropdownTypes:Set(opt)
                            end
                        end
                    end


                    return dropdownTypes
                end


                function sectionTypes:Keybind(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Keybind"
                    local default = options.default
                    local blacklist = options.blacklist or {}
                    local flag = options.flag
                    local callback = options.callback or function() end


                    if flag then
                        library.flags[flag] = default
                    end


                    local keys = {
                        [Enum.KeyCode.LeftShift] = "Left Shift";
                        [Enum.KeyCode.RightShift] = "Right Shift";
                        [Enum.KeyCode.LeftControl] = "Left Ctrl";
                        [Enum.KeyCode.RightControl] = "Right Ctrl";
                        [Enum.KeyCode.LeftAlt] = "Left Alt";
                        [Enum.KeyCode.RightAlt] = "Right Alt";
                        [Enum.KeyCode.CapsLock] = "CapsLock";
                        [Enum.KeyCode.One] = "1";
                        [Enum.KeyCode.Two] = "2";
                        [Enum.KeyCode.Three] = "3";
                        [Enum.KeyCode.Four] = "4";
                        [Enum.KeyCode.Five] = "5";
                        [Enum.KeyCode.Six] = "6";
                        [Enum.KeyCode.Seven] = "7";
                        [Enum.KeyCode.Eight] = "8";
                        [Enum.KeyCode.Nine] = "9";
                        [Enum.KeyCode.Zero] = "0";
                        [Enum.KeyCode.KeypadOne] = "Num 1";
                        [Enum.KeyCode.KeypadTwo] = "Num 2";
                        [Enum.KeyCode.KeypadThree] = "Num 3";
                        [Enum.KeyCode.KeypadFour] = "Num 4";
                        [Enum.KeyCode.KeypadFive] = "Num 5";
                        [Enum.KeyCode.KeypadSix] = "Num 6";
                        [Enum.KeyCode.KeypadSeven] = "Num 7";
                        [Enum.KeyCode.KeypadEight] = "Num 8";
                        [Enum.KeyCode.KeypadNine] = "Num 9";
                        [Enum.KeyCode.KeypadZero] = "Num 0";
                        [Enum.KeyCode.Minus] = "-";
                        [Enum.KeyCode.Equals] = "=";
                        [Enum.KeyCode.Tilde] = "~";
                        [Enum.KeyCode.LeftBracket] = "[";
                        [Enum.KeyCode.RightBracket] = "]";
                        [Enum.KeyCode.RightParenthesis] = ")";
                        [Enum.KeyCode.LeftParenthesis] = "(";
                        [Enum.KeyCode.Semicolon] = ";";
                        [Enum.KeyCode.Quote] = "'";
                        [Enum.KeyCode.BackSlash] = "\\";
                        [Enum.KeyCode.Comma] = ";";
                        [Enum.KeyCode.Period] = ".";
                        [Enum.KeyCode.Slash] = "/";
                        [Enum.KeyCode.Asterisk] = "*";
                        [Enum.KeyCode.Plus] = "+";
                        [Enum.KeyCode.Period] = ".";
                        [Enum.KeyCode.Backquote] = "`";
                        [Enum.UserInputType.MouseButton1] = "Mouse 1";
                        [Enum.UserInputType.MouseButton2] = "Mouse 2";
                        [Enum.UserInputType.MouseButton3] = "Mouse 3"
                    }


                    local keyChosen = default


                    local keybind = utility.create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 14,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Font = Enum.Font.SourceSans,
                        Parent = sectionContent
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = keybind
                    })
                    
                    local value = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 0, 0, 0),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Parent = keybind
                    })


                    keybind.MouseButton1Click:Connect(function()
                        value.Text = "..."
                        value.TextColor3 = Color3.fromRGB(255, 255, 255)


                        local binding
                        binding = inputService.InputBegan:Connect(function(input)
                            local key = keys[input.KeyCode] or keys[input.UserInputType]
                            value.Text = (keys[key] or tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
                            value.TextColor3 = Color3.fromRGB(180, 180, 180)


                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                if not table.find(blacklist, input.KeyCode) then
                                    keyChosen = input.KeyCode


                                    if flag then
                                        library.flags[flag] = input.KeyCode
                                    end


                                    binding:Disconnect()
                                else
                                    keyChosen = nil
                                    value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                    value.Text = "NONE"
                                        
                                    if flag then
                                        library.flags[flag] = nil
                                    end


                                    binding:Disconnect()
                                end
                            else
                                if not table.find(blacklist, input.UserInputType) then
                                    keyChosen = input.UserInputType


                                    if flag then
                                        library.flags[flag] = input.UserInputType
                                    end


                                    binding:Disconnect()
                                else
                                    keyChosen = nil
                                    value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                    value.Text = "NONE"
                                    
                                    if flag then
                                        library.flags[flag] = nil
                                    end


                                    binding:Disconnect()
                                end
                            end
                        end)
                    end)


                    inputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode == keyChosen then
                                callback(keyChosen)
                            end
                        else
                            if input.UserInputType == keyChosen then
                                callback(keyChosen)
                            end
                        end
                    end)


                    local keybindTypes = utility.table()


                    function keybindTypes:Show()
                        keybind.Visible = true
                    end


                    function keybindTypes:Hide()
                        keybind.Visible = false
                    end


                    function keybindTypes:SetName(str)
                        title.Text = str
                    end


                    function keybindTypes:Set(newKey)
                        if typeof(newKey) == "EnumItem" then
                            if not table.find(blacklist, newKey) then
                                local key = keys[newKey]
                                value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
                                value.TextColor3 = Color3.fromRGB(180, 180, 180)
            
                                keyChosen = newKey
            
                                if flag then
                                    library.flags[flag] = newKey
                                end
                            else
                                keyChosen = nil
                                value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                value.Text = "NONE"


                                if flag then
                                    library.flags[flag] = nil
                                end
                            end
                        end
                    end


                    if flag then
                        flags.keybinds[flag] = function(key)
                            keybindTypes:Set(key)
                        end
                    end


                    return keybindTypes
                end


                function sectionTypes:ToggleKeybind(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Toggle Keybind"
                    local default = options.default
                    local blacklist = options.blacklist or {}
                    local toggleFlag = options.toggleFlag
                    local keybindFlag = options.keybindFlag
                    local toggleCallback = options.toggleCallback or function() end
                    local keybindCallback = options.keybindCallback or function() end


                    local keys = {
                        [Enum.KeyCode.LeftShift] = "Left Shift";
                        [Enum.KeyCode.RightShift] = "Right Shift";
                        [Enum.KeyCode.LeftControl] = "Left Ctrl";
                        [Enum.KeyCode.RightControl] = "Right Ctrl";
                        [Enum.KeyCode.LeftAlt] = "Left Alt";
                        [Enum.KeyCode.RightAlt] = "Right Alt";
                        [Enum.KeyCode.CapsLock] = "CapsLock";
                        [Enum.KeyCode.One] = "1";
                        [Enum.KeyCode.Two] = "2";
                        [Enum.KeyCode.Three] = "3";
                        [Enum.KeyCode.Four] = "4";
                        [Enum.KeyCode.Five] = "5";
                        [Enum.KeyCode.Six] = "6";
                        [Enum.KeyCode.Seven] = "7";
                        [Enum.KeyCode.Eight] = "8";
                        [Enum.KeyCode.Nine] = "9";
                        [Enum.KeyCode.Zero] = "0";
                        [Enum.KeyCode.KeypadOne] = "Num 1";
                        [Enum.KeyCode.KeypadTwo] = "Num 2";
                        [Enum.KeyCode.KeypadThree] = "Num 3";
                        [Enum.KeyCode.KeypadFour] = "Num 4";
                        [Enum.KeyCode.KeypadFive] = "Num 5";
                        [Enum.KeyCode.KeypadSix] = "Num 6";
                        [Enum.KeyCode.KeypadSeven] = "Num 7";
                        [Enum.KeyCode.KeypadEight] = "Num 8";
                        [Enum.KeyCode.KeypadNine] = "Num 9";
                        [Enum.KeyCode.KeypadZero] = "Num 0";
                        [Enum.KeyCode.Minus] = "-";
                        [Enum.KeyCode.Equals] = "=";
                        [Enum.KeyCode.Tilde] = "~";
                        [Enum.KeyCode.LeftBracket] = "[";
                        [Enum.KeyCode.RightBracket] = "]";
                        [Enum.KeyCode.RightParenthesis] = ")";
                        [Enum.KeyCode.LeftParenthesis] = "(";
                        [Enum.KeyCode.Semicolon] = ";";
                        [Enum.KeyCode.Quote] = "'";
                        [Enum.KeyCode.BackSlash] = "\\";
                        [Enum.KeyCode.Comma] = ";";
                        [Enum.KeyCode.Period] = ".";
                        [Enum.KeyCode.Slash] = "/";
                        [Enum.KeyCode.Asterisk] = "*";
                        [Enum.KeyCode.Plus] = "+";
                        [Enum.KeyCode.Period] = ".";
                        [Enum.KeyCode.Backquote] = "`";
                        [Enum.UserInputType.MouseButton1] = "Mouse 1";
                        [Enum.UserInputType.MouseButton2] = "Mouse 2";
                        [Enum.UserInputType.MouseButton3] = "Mouse 3"
                    }


                    local toggled = false
                    local keyChosen = default


                    if toggleFlag then
                        library.flags[toggleFlag] = toggled
                    end


                    if keybindFlag then
                        library.flags[keybindFlag] = default
                    end


                    local toggleKeybind = utility.create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 14,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Font = Enum.Font.SourceSans,
                        Parent = sectionContent
                    })


                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 21, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = toggleKeybind
                    })


                    local icon = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 14, 1, -2),
                        BorderColor3 = Color3.fromRGB(37, 37, 37),
                        Position = UDim2.new(0, 0, 0, 1),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = toggleKeybind
                    })
                    
                    local iconGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = icon
                    })
                    
                    local value = utility.create("TextButton", {
                        ZIndex = 3,
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Parent = toggleKeybind
                    })


                    value.Size = UDim2.new(0, value.TextBounds.X, 1, 0)
                    value.Position = UDim2.new(1, -value.TextBounds.X, 0, 0)


                    local function toggleToggle()
                        toggled = not toggled


                        if toggled then
                            table.insert(coloredGradients, iconGradient)
                        else
                            table.remove(coloredGradients, table.find(coloredGradients, iconGradient))
                        end


                        local textColor = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                        local gradientColor
                        if toggled then
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, library.color), 
                                ColorSequenceKeypoint.new(1, utility.change_color(library.color, -47))
                            }
                        else
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                            }
                        end


                        iconGradient.Color = gradientColor
                        title.TextColor3 = textColor


                        if toggleFlag then
                            library.flags[toggleFlag] = toggled
                        end


                        toggleCallback(toggled)
                    end


                    toggleKeybind.MouseButton1Click:Connect(toggleToggle)


                    value.MouseButton1Click:Connect(function()
                        value.Text = "..."
                        value.Size = UDim2.new(0, value.TextBounds.X, 1, 0)
                        value.Position = UDim2.new(1, -value.TextBounds.X, 0, 0)
                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                    
                        local binding
                        binding = inputService.InputBegan:Connect(function(input)
                            local key = keys[input.KeyCode] or keys[input.UserInputType]
                            value.Text = (keys[key] or tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
                            value.Size = UDim2.new(0, value.TextBounds.X, 1, 0)
                            value.Position = UDim2.new(1, -value.TextBounds.X, 0, 0)
                            value.TextColor3 = Color3.fromRGB(180, 180, 180)
                    
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                if not table.find(blacklist, input.KeyCode) then
                                    keyChosen = input.KeyCode
                    
                                    if keybindFlag then
                                        library.flags[keybindFlag] = input.KeyCode
                                    end
                    
                                    binding:Disconnect()
                                else
                                    keyChosen = nil
                                    value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                    value.Text = "NONE"
                                    value.Size = UDim2.new(0, value.TextBounds.X, 1, 0)
                                    value.Position = UDim2.new(1, -value.TextBounds.X, 0, 0)
                                        
                                    if keybindFlag then
                                        library.flags[keybindFlag] = nil
                                    end
                    
                                    binding:Disconnect()
                                end
                            else
                                if not table.find(blacklist, input.UserInputType) then
                                    keyChosen = input.UserInputType
                    
                                    if keybindFlag then
                                        library.flags[keybindFlag] = input.UserInputType
                                    end
                    
                                    binding:Disconnect()
                                else
                                    keyChosen = nil
                                    value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                    value.Text = "NONE"
                                    value.Size = UDim2.new(0, value.TextBounds.X, 1, 0)
                                    value.Position = UDim2.new(1, -value.TextBounds.X, 0, 0)
                                    
                                    if keybindFlag then
                                        library.flags[keybindFlag] = nil
                                    end
                    
                                    binding:Disconnect()
                                end
                            end
                        end)
                    end)
                    
                    inputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode == keyChosen then
                                toggleToggle()
                                keybindCallback(keyChosen)
                            end
                        else
                            if input.UserInputType == keyChosen then
                                toggleToggle()
                                keybindCallback(keyChosen)
                            end
                        end
                    end)
                    
                    local toggleKeybindTypes = utility.table()
                    
                    function toggleKeybindTypes:Show()
                        keybind.Visible = true
                    end
                    
                    function toggleKeybindTypes:Hide()
                        keybind.Visible = false
                    end
                    
                    function toggleKeybindTypes:SetName(str)
                        title.Text = str
                    end


                    function toggleKeybindTypes:Toggle(bool)
                        if toggled ~= bool then
                            toggleToggle()
                        end
                    end
                    
                    function toggleKeybindTypes:Set(newKey)
                        if typeof(newKey) == "EnumItem" then
                            if not table.find(blacklist, newKey) then
                                local key = keys[newKey]
                                value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
                                value.Size = UDim2.new(0, value.TextBounds.X, 1, 0)
                                value.Position = UDim2.new(1, -value.TextBounds.X, 0, 0)
                                value.TextColor3 = Color3.fromRGB(180, 180, 180)
                    
                                keyChosen = newKey
                    
                                if keybindFlag then
                                    library.flags[keybindFlag] = newKey
                                end
                            else
                                keyChosen = nil
                                value.TextColor3 = Color3.fromRGB(180, 180, 180)
                                value.Text = "NONE"
                    
                                if keybindFlag then
                                    library.flags[keybindFlag] = nil
                                end
                            end
                        end
                    end
                    
                    if keybindFlag then
                        flags.keybinds[keybindFlag] = function(key)
                            toggleKeybindTypes:Set(key)
                        end
                    end


                    if toggleFlag then
                        flags.toggles[toggleFlag] = function(bool)
                            toggleKeybindTypes:Toggle(bool)
                        end
                    end
                    
                    return toggleKeybindTypes
                end


                function sectionTypes:ColorPicker(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Color Picker"
                    local default = options.default or Color3.fromRGB(255, 255, 255)
                    local flag = options.flag
                    local callback = options.callback or function() end


                    local open = false
                    local hue, sat, val = default:ToHSV()


                    local slidingHue = false
                    local slidingSaturation = false


                    local hsv = Color3.fromHSV(hue, sat, val)


                    if flag then
                        library.flags[flag] = default
                    end


                    callback(default)


                    local colorPickerHolder = utility.create("Frame", {
                        Size = UDim2.new(1, 0, 0, 16),
                        Position = UDim2.new(0, 0, 0, 0),
                        BackgroundTransparency = 1,
                        Parent = sectionContent
                    })


                    local colorPicker = utility.create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 14,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Font = Enum.Font.SourceSans,
                        Parent = colorPickerHolder
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = colorPicker
                    })
                    
                    local icon = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 22, 0, 14),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(1, -22, 0, 1),
                        BackgroundColor3 = default,
                        Parent = colorPicker
                    })
                    
                    local iconGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 105, 105))
                        },
                        Parent = icon
                    })
                    
                    local picker = utility.create("Frame", {
                        ZIndex = 12,
                        Visible = false,
                        Size = UDim2.new(1, -8, 0, 183),
                        ClipsDescendants = true,
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 12, 1, 3),
                        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                        Parent = colorPicker
                    })
                    
                    local saturationFrame = utility.create("ImageLabel", {
                        ZIndex = 13,
                        Size = UDim2.new(1, -29, 0, 130),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 5, 0, 5),
                        BackgroundColor3 = Color3.fromRGB(255, 0, 4),
                        Image = "http://www.roblox.com/asset/?id=8630797271",
                        Parent = picker
                    })
                    
                    local saturationPicker = utility.create("Frame", {
                        ZIndex = 15,
                        Size = UDim2.new(0, 4, 0, 4),
                        Position = UDim2.new(0, 5, 0, 5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 1,
                        Parent = saturationFrame
                    })
                    
                    local hueFrame = utility.create("ImageLabel", {
                        ZIndex = 13,
                        Size = UDim2.new(0, 14, 0, 130),
                        ClipsDescendants = true,
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -19, 0, 5),
                        BackgroundColor3 = Color3.fromRGB(255, 0, 4),
                        ScaleType = Enum.ScaleType.Crop,
                        Image = "http://www.roblox.com/asset/?id=8630799159",
                        Parent = picker
                    })
                    
                    local huePicker = utility.create("Frame", {
                        ZIndex = 15,
                        Size = UDim2.new(1, 0, 0, 2),
                        Position = UDim2.new(0, 0, 0, 10),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 1,
                        Parent = hueFrame
                    })
                    
                    local rgb = utility.create("TextBox", {
                        ZIndex = 14,
                        Size = UDim2.new(1, -10, 0, 16),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 1, -42),
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = table.concat({utility.get_rgb(default)}, ", "),
                        ClearTextOnFocus = false,
                        Font = Enum.Font.Gotham,
                        PlaceholderText = "R,  G,  B",
                        Parent = picker
                    })
                    
                    local bg = utility.create("Frame", {
                        ZIndex = 13,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = rgb
                    })
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = bg
                    })
                    
                    local hex = utility.create("TextBox", {
                        ZIndex = 14,
                        Size = UDim2.new(1, -10, 0, 16),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 1, -21),
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = utility.rgb_to_hex(default),
                        ClearTextOnFocus = false,
                        Font = Enum.Font.Gotham,
                        PlaceholderText = utility.rgb_to_hex(default),
                        Parent = picker
                    })
                    
                    local bg = utility.create("Frame", {
                        ZIndex = 13,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = hex
                    })
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = bg
                    })


                    local function openPicker()
                        open = not open
                        picker.Visible = open
                        colorPickerHolder.Size = UDim2.new(1, 0, 0, open and colorPicker.AbsoluteSize.Y + picker.AbsoluteSize.Y + 3 or 16)
                    end


                    colorPicker.MouseButton1Click:connect(openPicker)


                    local function updateHue(input)
                        local sizeY = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
                        local posY = math.clamp(((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 2)
                        huePicker.Position = UDim2.new(0, 0, 0, posY)


                        hue = sizeY


                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))


                        hsv = Color3.fromHSV(hue, sat, val)
                        saturationFrame.BackgroundColor3 = hsv
                        icon.BackgroundColor3 = hsv


                        if flag then 
                            library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end


                        callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end


                    hueFrame.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingHue = true
                            updateHue(input)
                        end
                    end)


                    hueFrame.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingHue = false
                        end
                    end)


                    inputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            if slidingHue then
                                updateHue(input)
                            end
                        end
                    end)


                    local function updateSatVal(input)
                        local sizeX = math.clamp((input.Position.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X, 0, 1)
                        local sizeY = 1 - math.clamp((input.Position.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y, 0, 1)
                        local posY = math.clamp(((input.Position.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y) * saturationFrame.AbsoluteSize.Y, 0, saturationFrame.AbsoluteSize.Y - 4)
                        local posX = math.clamp(((input.Position.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X) * saturationFrame.AbsoluteSize.X, 0, saturationFrame.AbsoluteSize.X - 4)


                        saturationPicker.Position = UDim2.new(0, posX, 0, posY)


                        sat = sizeX
                        val = sizeY


                        hsv = Color3.fromHSV(hue, sat, val)


                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))


                        saturationFrame.BackgroundColor3 = hsv
                        icon.BackgroundColor3 = hsv


                        if flag then 
                            library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end


                        callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end


                    saturationFrame.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingSaturation = true
                            updateSatVal(input)
                        end
                    end)


                    saturationFrame.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingSaturation = false
                        end
                    end)


                    inputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            if slidingSaturation then
                                updateSatVal(input)
                            end
                        end
                    end)


                    local colorPickerTypes = utility.table()


                    function colorPickerTypes:Show()
                        colorPickerHolder.Visible = true
                    end
                    
                    function colorPickerTypes:Hide()
                        colorPickerHolder.Visible = false
                    end
                    
                    function colorPickerTypes:SetName(str)
                        title.Text = str
                    end


                    function colorPickerTypes:SetRGB(color)
                        hue, sat, val = color:ToHSV()
                        hsv = Color3.fromHSV(hue, sat, val)


                        saturationFrame.BackgroundColor3 = hsv
                        icon.BackgroundColor3 = hsv
                        saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturationFrame.AbsoluteSize.X, 0, saturationFrame.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturationFrame.AbsoluteSize.Y, 0, saturationFrame.AbsoluteSize.Y - 4)))
                        huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))


                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))


                        if flag then 
                            library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end


                        callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end


                    function colorPickerTypes:SetHex(hexValue)
                        color = utility.hex_to_rgb(hexValue)
                        
                        hue, sat, val = color:ToHSV()
                        hsv = Color3.fromHSV(hue, sat, val)


                        saturationFrame.BackgroundColor3 = hsv
                        icon.BackgroundColor3 = hsv
                        saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturationFrame.AbsoluteSize.X, 0, saturationFrame.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturationFrame.AbsoluteSize.Y, 0, saturationFrame.AbsoluteSize.Y - 4)))
                        huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))


                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))


                        if flag then 
                            library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end


                        callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end


                    rgb.FocusLost:Connect(function()
                        local _, amount = rgb.Text:gsub(", ", "")
                        if amount == 2 then
                            local values = rgb.Text:split(", ")
                            local r, g, b = math.clamp(values[1], 0, 255), math.clamp(values[2], 0, 255), math.clamp(values[3], 0, 255)
                            colorPickerTypes:SetRGB(Color3.fromRGB(r, g, b))
                        else
                            rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        end
                    end)
                        
                    hex.FocusLost:Connect(function()
                        if hex.Text:find("#") and hex.Text:len() == 7 then
                            colorPickerTypes:SetHex(hex.Text)
                        else
                            hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                        end
                    end)


                    hex:GetPropertyChangedSignal("Text"):Connect(function()
                        if hex.Text == "" then
                            hex.Text = "#"
                        end
                    end)


                    if flag then
                        flags.colorpickers[flag] = function(color)
                            colorPickerTypes:SetRGB(color)
                        end
                    end


                    return colorPickerTypes
                end


                function sectionTypes:ToggleColorPicker(opts)
                    local options = utility.table(opts)
                    local name = options.name or "Toggle Color Picker"
                    local default = options.default or Color3.fromRGB(255, 255, 255)
                    local toggleFlag = options.toggleFlag
                    local colorPickerFlag = options.colorPickerFlag
                    local toggleCallback = options.toggleCallback or function() end
                    local colorPickerCallback = options.colorPickerCallback or function() end


                    local open = false
                    local toggled = false
                    local hue, sat, val = default:ToHSV()


                    local slidingHue = false
                    local slidingSaturation = false


                    local hsv = Color3.fromHSV(hue, sat, val)


                    if colorPickerFlag then
                        library.flags[colorPickerFlag] = default
                    end


                    colorPickerCallback(default)


                    if toggleFlag then
                        library.flags[toggleFlag] = toggled
                    end


                    toggleCallback(false)


                    local toggleColorPickerHolder = utility.create("Frame", {
                        Size = UDim2.new(1, 0, 0, 16),
                        Position = UDim2.new(0, 0, 0, 0),
                        BackgroundTransparency = 1,
                        Parent = sectionContent
                    })


                    local colorPicker = utility.create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 14,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Font = Enum.Font.SourceSans,
                        Parent = toggleColorPickerHolder
                    })


                    local icon = utility.create("Frame", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 14, 1, -2),
                        BorderColor3 = Color3.fromRGB(37, 37, 37),
                        Position = UDim2.new(0, 0, 0, 1),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = colorPicker
                    })
                    
                    local iconGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = icon
                    })


                    local colorPickerIcon = utility.create("TextButton", {
                        ZIndex = 3,
                        Text = "",
                        Size = UDim2.new(0, 22, 0, 14),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(1, -22, 0, 1),
                        BackgroundColor3 = default,
                        Parent = colorPicker
                    })
                    
                    local colorPickerIconGradient = utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 105, 105))
                        },
                        Parent = colorPickerIcon
                    })
                    
                    local title = utility.create("TextLabel", {
                        ZIndex = 3,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 7, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(180, 180, 180),
                        Text = name,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = icon
                    })
                    
                    local picker = utility.create("Frame", {
                        ZIndex = 12,
                        Visible = false,
                        Size = UDim2.new(1, -8, 0, 183),
                        ClipsDescendants = true,
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 12, 1, 3),
                        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                        Parent = colorPicker
                    })
                    
                    local saturationFrame = utility.create("ImageLabel", {
                        ZIndex = 13,
                        Size = UDim2.new(1, -29, 0, 130),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, 5, 0, 5),
                        BackgroundColor3 = Color3.fromRGB(255, 0, 4),
                        Image = "http://www.roblox.com/asset/?id=8630797271",
                        Parent = picker
                    })
                    
                    local saturationPicker = utility.create("Frame", {
                        ZIndex = 15,
                        Size = UDim2.new(0, 4, 0, 4),
                        Position = UDim2.new(0, 5, 0, 5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 1,
                        Parent = saturationFrame
                    })
                    
                    local hueFrame = utility.create("ImageLabel", {
                        ZIndex = 13,
                        Size = UDim2.new(0, 14, 0, 130),
                        ClipsDescendants = true,
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -19, 0, 5),
                        BackgroundColor3 = Color3.fromRGB(255, 0, 4),
                        ScaleType = Enum.ScaleType.Crop,
                        Image = "http://www.roblox.com/asset/?id=8630799159",
                        Parent = picker
                    })
                    
                    local huePicker = utility.create("Frame", {
                        ZIndex = 15,
                        Size = UDim2.new(1, 0, 0, 2),
                        Position = UDim2.new(0, 0, 0, 10),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 1,
                        Parent = hueFrame
                    })
                    
                    local rgb = utility.create("TextBox", {
                        ZIndex = 14,
                        Size = UDim2.new(1, -10, 0, 16),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 1, -42),
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = table.concat({utility.get_rgb(default)}, ", "),
                        ClearTextOnFocus = false,
                        Font = Enum.Font.Gotham,
                        PlaceholderText = "R,  G,  B",
                        Parent = picker
                    })
                    
                    local bg = utility.create("Frame", {
                        ZIndex = 13,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = rgb
                    })
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = bg
                    })
                    
                    local hex = utility.create("TextBox", {
                        ZIndex = 14,
                        Size = UDim2.new(1, -10, 0, 16),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 1, -21),
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = utility.rgb_to_hex(default),
                        ClearTextOnFocus = false,
                        Font = Enum.Font.Gotham,
                        PlaceholderText = utility.rgb_to_hex(default),
                        Parent = picker
                    })
                    
                    local bg = utility.create("Frame", {
                        ZIndex = 13,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderColor3 = Color3.fromRGB(22, 22, 22),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = hex
                    })
                    
                    utility.create("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(32, 32, 32), Color3.fromRGB(17, 17, 17)),
                        Parent = bg
                    })


                    local function toggleToggle()
                        toggled = not toggled


                        if toggled then
                            table.insert(coloredGradients, iconGradient)
                        else
                            table.remove(coloredGradients, table.find(coloredGradients, iconGradient))
                        end


                        local textColor = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                        local gradientColor
                        if toggled then
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, library.color), 
                                ColorSequenceKeypoint.new(1, utility.change_color(library.color, -47))
                            }
                        else
                            gradientColor = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)), 
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
                            }
                        end


                        iconGradient.Color = gradientColor
                        title.TextColor3 = textColor


                        if toggleFlag then
                            library.flags[toggleFlag] = toggled
                        end


                        toggleCallback(toggled)
                    end


                    colorPicker.MouseButton1Click:Connect(toggleToggle)


                    local function openPicker()
                        open = not open
                        picker.Visible = open
                        toggleColorPickerHolder.Size = UDim2.new(1, 0, 0, open and colorPicker.AbsoluteSize.Y + picker.AbsoluteSize.Y + 3 or 16)
                    end
                    
                    colorPickerIcon.MouseButton1Click:connect(openPicker)
                    
                    local function updateHue(input)
                        local sizeY = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
                        local posY = math.clamp(((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 2)
                        huePicker.Position = UDim2.new(0, 0, 0, posY)
                    
                        hue = sizeY
                    
                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    
                        hsv = Color3.fromHSV(hue, sat, val)
                        saturationFrame.BackgroundColor3 = hsv
                        colorPickerIcon.BackgroundColor3 = hsv
                    
                        if colorPickerFlag then 
                            library.flags[colorPickerFlag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end
                    
                        colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end
                    
                    hueFrame.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingHue = true
                            updateHue(input)
                        end
                    end)
                    
                    hueFrame.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingHue = false
                        end
                    end)
                    
                    inputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            if slidingHue then
                                updateHue(input)
                            end
                        end
                    end)
                    
                    local function updateSatVal(input)
                        local sizeX = math.clamp((input.Position.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X, 0, 1)
                        local sizeY = 1 - math.clamp((input.Position.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y, 0, 1)
                        local posY = math.clamp(((input.Position.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y) * saturationFrame.AbsoluteSize.Y, 0, saturationFrame.AbsoluteSize.Y - 4)
                        local posX = math.clamp(((input.Position.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X) * saturationFrame.AbsoluteSize.X, 0, saturationFrame.AbsoluteSize.X - 4)
                    
                        saturationPicker.Position = UDim2.new(0, posX, 0, posY)
                    
                        sat = sizeX
                        val = sizeY
                    
                        hsv = Color3.fromHSV(hue, sat, val)
                    
                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    
                        saturationFrame.BackgroundColor3 = hsv
                        colorPickerIcon.BackgroundColor3 = hsv
                    
                        if colorPickerFlag then 
                            library.flags[colorPickerFlag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end
                    
                        colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end
                    
                    saturationFrame.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingSaturation = true
                            updateSatVal(input)
                        end
                    end)
                    
                    saturationFrame.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            slidingSaturation = false
                        end
                    end)
                    
                    inputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            if slidingSaturation then
                                updateSatVal(input)
                            end
                        end
                    end)
                    
                    local toggleColorPickerTypes = utility.table()
                    
                    function toggleColorPickerTypes:Show()
                        toggleColorPickerHolder.Visible = true
                    end
                    
                    function toggleColorPickerTypes:Hide()
                        toggleColorPickerHolder.Visible = false
                    end
                    
                    function toggleColorPickerTypes:SetName(str)
                        title.Text = str
                    end


                    function toggleColorPickerTypes:Toggle(bool)
                        if toggled ~= bool then
                            toggleToggle()
                        end
                    end
                    
                    function toggleColorPickerTypes:SetRGB(color)
                        hue, sat, val = color:ToHSV()
                        hsv = Color3.fromHSV(hue, sat, val)
                    
                        saturationFrame.BackgroundColor3 = hsv
                        colorPickerIcon.BackgroundColor3 = hsv
                        saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturationFrame.AbsoluteSize.X, 0, saturationFrame.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturationFrame.AbsoluteSize.Y, 0, saturationFrame.AbsoluteSize.Y - 4)))
                        huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))
                    
                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    
                        if colorPickerFlag then 
                            library.flags[colorPickerFlag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end
                    
                        colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end
                    
                    function toggleColorPickerTypes:SetHex(hexValue)
                        color = utility.hex_to_rgb(hexValue)
                        
                        hue, sat, val = color:ToHSV()
                        hsv = Color3.fromHSV(hue, sat, val)
                    
                        saturationFrame.BackgroundColor3 = hsv
                        colorPickerIcon.BackgroundColor3 = hsv
                        saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturationFrame.AbsoluteSize.X, 0, saturationFrame.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturationFrame.AbsoluteSize.Y, 0, saturationFrame.AbsoluteSize.Y - 4)))
                        huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))
                    
                        rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    
                        if colorPickerFlag then 
                            library.flags[colorPickerFlag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
                        end
                    
                        colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                    end
                    
                    rgb.FocusLost:Connect(function()
                        local _, amount = rgb.Text:gsub(", ", "")
                        if amount == 2 then
                            local values = rgb.Text:split(", ")
                            local r, g, b = math.clamp(values[1], 0, 255), math.clamp(values[2], 0, 255), math.clamp(values[3], 0, 255)
                            toggleColorPickerTypes:SetRGB(Color3.fromRGB(r, g, b))
                        else
                            rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
                        end
                    end)
                        
                    hex.FocusLost:Connect(function()
                        if hex.Text:find("#") and hex.Text:len() == 7 then
                            toggleColorPickerTypes:SetHex(hex.Text)
                        else
                            hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
                        end
                    end)
                    
                    hex:GetPropertyChangedSignal("Text"):Connect(function()
                        if hex.Text == "" then
                            hex.Text = "#"
                        end
                    end)
                    
                    if colorPickerFlag then
                        flags.colorpickers[colorPickerFlag] = function(color)
                            toggleColorPickerTypes:SetRGB(color)
                        end
                    end


                    if toggleFlag then
                        flags.toggles[toggleFlag] = function(bool)
                            toggleColorPickerTypes:Toggle(bool)
                        end
                    end
                    
                    return toggleColorPickerTypes
                end


                return sectionTypes
            end


            return tabTypes
        end


        return windowTypes
    end


    return library
end