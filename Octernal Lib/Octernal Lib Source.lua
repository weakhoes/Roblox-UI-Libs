--[[ Credits
    Matas#3535 @matas - Created UI
    bored#9316 @wally hub user - Helped make library
]]
-- // Variables
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local hs = game:GetService("HttpService")
local plrs = game:GetService("Players")
local stats = game:GetService("Stats")
-- UI Variables
local library = {
    drawings = {},
    hidden = {},
    connections = {},
    pointers = {},
    began = {},
    changed = {},
    ended = {},
    colors = {},
    folders = {
        main = "Linux",
        assets = "Linux/assets",
        configs = "Linux/configs"
    },
    shared = {
        initialized = false,
        fps = 0,
        ping = 0
    }
}
--
for i,v in pairs(library.folders) do
    makefolder(v)
end
--
local utility = {}
local pages = {}
local sections = {}
local theme = {
    accent = Color3.fromRGB(55, 175, 225),
    lightcontrast = Color3.fromRGB(30, 30, 30),
    darkcontrast = Color3.fromRGB(25, 25, 25),
    outline = Color3.fromRGB(0, 0, 0),
    inline = Color3.fromRGB(50, 50, 50),
    textcolor = Color3.fromRGB(255, 255, 255),
    textborder = Color3.fromRGB(0, 0, 0),
    cursoroutline = Color3.fromRGB(10, 10, 10),
    font = Drawing.Fonts.Plex,
    textsize = 13
}
-- // Utility Functions
do
    function utility:Size(xScale,xOffset,yScale,yOffset,instance)
        if instance then
            local x = xScale*instance.Size.x+xOffset
            local y = yScale*instance.Size.y+yOffset
            --
            return Vector2.new(x,y)
        else
            local vx,vy = ws.CurrentCamera.ViewportSize.x,ws.CurrentCamera.ViewportSize.y
            --
            local x = xScale*vx+xOffset
            local y = yScale*vy+yOffset
            --
            return Vector2.new(x,y)
        end
    end
    --
    function utility:Position(xScale,xOffset,yScale,yOffset,instance)
        if instance then
            local x = instance.Position.x+xScale*instance.Size.x+xOffset
            local y = instance.Position.y+yScale*instance.Size.y+yOffset
            --
            return Vector2.new(x,y)
        else
            local vx,vy = ws.CurrentCamera.ViewportSize.x,ws.CurrentCamera.ViewportSize.y
            --
            local x = xScale*vx+xOffset
            local y = yScale*vy+yOffset
            --
            return Vector2.new(x,y)
        end
    end
    --
    function utility:CreateInstance(instanceType, properties)
        local instance = Instance.new(instanceType)
        if type(properties) == "table" then
            for property, value in next, properties do
                instance[property] = value
            end
        end
        return instance
    end
    --
	function utility:Create(instanceType, instanceOffset, instanceProperties, instanceParent)
        local instanceType = instanceType or "Frame"
        local instanceOffset = instanceOffset or {Vector2.new(0,0)}
        local instanceProperties = instanceProperties or {}
        local instanceHidden = false
        local instance = nil
        --
		if instanceType == "Frame" or instanceType == "frame" then
            local frame = Drawing.new("Square")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.Size = Vector2.new(100,100)
            frame.Position = Vector2.new(0,0)
            frame.ZIndex = 1000
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "TextLabel" or instanceType == "textlabel" then
            local text = Drawing.new("Text")
            text.Font = 3
            text.Visible = true
            text.Outline = true
            text.Center = false
            text.Color = Color3.fromRGB(255,255,255)
            text.ZIndex = 1000
            text.Transparency = library.shared.initialized and 1 or 0
            instance = text
        elseif instanceType == "Triangle" or instanceType == "triangle" then
            local frame = Drawing.new("Triangle")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.ZIndex = 1000
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "Image" or instanceType == "image" then
            local image = Drawing.new("Image")
            image.Size = Vector2.new(12,19)
            image.Position = Vector2.new(0,0)
            image.Visible = true
            image.ZIndex = 1000
            image.Transparency = library.shared.initialized and 1 or 0
            instance = image
        elseif instanceType == "Circle" or instanceType == "circle" then
            local circle = Drawing.new("Circle")
            circle.Visible = false
            circle.Color = Color3.fromRGB(255, 0, 0)
            circle.Thickness = 1
            circle.NumSides = 30
            circle.Filled = true
            circle.Transparency = 1
            circle.ZIndex = 1000
            circle.Radius = 50
            circle.Transparency = library.shared.initialized and 1 or 0
            instance = circle
        elseif instanceType == "Quad" or instanceType == "quad" then
            local quad = Drawing.new("Quad")
            quad.Visible = false
            quad.Color = Color3.fromRGB(255, 255, 255)
            quad.Thickness = 1.5
            quad.Transparency = 1
            quad.ZIndex = 1000
            quad.Filled = false
            quad.Transparency = library.shared.initialized and 1 or 0
            instance = quad
        elseif instanceType == "Line" or instanceType == "line" then
            local line = Drawing.new("Line")
            line.Visible = false
            line.Color = Color3.fromRGB(255, 255, 255)
            line.Thickness = 1.5
            line.Transparency = 1
            line.Thickness = 1.5
            line.ZIndex = 1000
            line.Transparency = library.shared.initialized and 1 or 0
            instance = line
        end
        --
        if instance then
            for i, v in pairs(instanceProperties) do
                if (i == "Hidden" or i == "hidden") then
                    instanceHidden = v
                else
                    if library.shared.initialized then
                        instance[i] = v
                    elseif i ~= "Transparency" then
                        instance[i] = v
                    end
                end
                --[[if typeof(v) == "Color3" then
                    local found_theme = utility:Find(theme, v)
                    if found_theme then
                        themes[found_theme] = themes[found_theme] or {}
                        themes[found_theme][i] = themes[found_theme][i]
                        table.insert(themes[found_theme][i], instance)
                    end
                end]]
            end
            --
            if not instanceHidden then
                library.drawings[#library.drawings + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            else
                library.hidden[#library.hidden + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            end
            --
            if instanceParent then
                instanceParent[#instanceParent + 1] = instance
            end
            --
            return instance
        end
	end
    --
    function utility:UpdateOffset(instance, instanceOffset)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[2] = instanceOffset
                return
            end
        end
    end
    --
    function utility:UpdateTransparency(instance, instanceTransparency)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[3] = instanceTransparency
                return
            end
        end
    end
    --
    function utility:Remove(instance, hidden)
        library.colors[instance] = nil
        --
        local ind = 0
        --
        for i,v in pairs(hidden and library.hidden or library.drawings) do
            if v[1] == instance then
                v[1] = nil
                v[2] = nil
                table.remove(hidden and library.hidden or library.drawings, i)
                break
            end
        end
        if instance.__OBJECT_EXISTS then
            instance:Remove()
        end
    end
    --
    function utility:GetSubPrefix(str)
        local str = tostring(str):gsub(" ","")
        local var = ""
        --
        if #str == 2 then
            local sec = string.sub(str,#str,#str+1)
            var = sec == "1" and "st" or sec == "2" and "nd" or sec == "3" and "rd" or "th"
        end
        --
        return var
    end
    --
    function utility:Connection(connectionType, connectionCallback)
        local connection = connectionType:Connect(connectionCallback)
        library.connections[#library.connections + 1] = connection
        --
        return connection
    end
    --
    function utility:Disconnect(connection)
        for i,v in pairs(library.connections) do
            if v == connection then
                library.connections[i] = nil
                v:Disconnect()
            end
        end
    end
    --
    function utility:MouseLocation()
        return uis:GetMouseLocation()
    end
    --
    function utility:MouseOverDrawing(values, valuesAdd)
        local valuesAdd = valuesAdd or {}
        local values = {
            (values[1] or 0) + (valuesAdd[1] or 0),
            (values[2] or 0) + (valuesAdd[2] or 0),
            (values[3] or 0) + (valuesAdd[3] or 0),
            (values[4] or 0) + (valuesAdd[4] or 0)
        }
        --
        local mouseLocation = utility:MouseLocation()
	    return (mouseLocation.x >= values[1] and mouseLocation.x <= (values[1] + (values[3] - values[1]))) and (mouseLocation.y >= values[2] and mouseLocation.y <= (values[2] + (values[4] - values[2])))
    end
    --
    function utility:GetTextBounds(text, textSize, font)
        local textbounds = Vector2.new(0, 0)
        --
        local textlabel = utility:Create("TextLabel", {Vector2.new(0, 0)}, {
            Text = text,
            Size = textSize,
            Font = font,
            Hidden = true
        })
        --
        textbounds = textlabel.TextBounds
        utility:Remove(textlabel, true)
        --
        return textbounds
    end
    --
    function utility:GetScreenSize()
        return ws.CurrentCamera.ViewportSize
    end
    --
    function utility:LoadImage(instance, imageName, imageLink)
        local data
        --
        if isfile(library.folders.assets.."/"..imageName..".png") then
            data = readfile(library.folders.assets.."/"..imageName..".png")
        else
            if imageLink then
                data = game:HttpGet(imageLink)
                writefile(library.folders.assets.."/"..imageName..".png", data)
            else
                return
            end
        end
        --
        if data and instance then
            instance.Data = data
        end
    end
    --
    function utility:Lerp(instance, instanceTo, instanceTime)
        local currentTime = 0
        local currentIndex = {}
        local connection
        --
        for i,v in pairs(instanceTo) do
            currentIndex[i] = instance[i]
        end
        --
        local function lerp()
            for i,v in pairs(instanceTo) do
                if instance.__OBJECT_EXISTS then
                    instance[i] = ((v - currentIndex[i]) * currentTime / instanceTime) + currentIndex[i]
                end
            end
        end
        --
        connection = rs.RenderStepped:Connect(function(delta)
            if currentTime < instanceTime then
                currentTime = currentTime + delta
                lerp()
            else
                connection:Disconnect()
            end
        end)
    end
    --
    function utility:Combine(table1, table2)
        local table3 = {}
        for i,v in pairs(table1) do table3[i] = v end
        local t = #table3
        for z,x in pairs(table2) do table3[z + t] = x end
        return table3
    end
    --
    function utility:WrapText(Text, Size)
        local Max = (Size / 7)
        --
        return Text:sub(0, Max)
    end
end
-- // Library Functions
do
    library.__index = library
	pages.__index = pages
	sections.__index = sections
    --
    function library:New(info)
		local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "UI Title"
        local size = info.size or info.Size or Vector2.new(504,604)
        local accent = info.accent or info.Accent or info.color or info.Color or theme.accent
        --
        theme.accent = accent
        --
        local window = {pages = {}, isVisible = false, uibind = Enum.KeyCode.Z, currentPage = nil, fading = false, dragging = false, drag = Vector2.new(0,0), currentContent = {frame = nil, dropdown = nil, multibox = nil, colorpicker = nil, keybind = nil}}
        --
        local main_frame = utility:Create("Frame", {Vector2.new(0,0)}, {
            Size = utility:Size(0, size.X, 0, size.Y),
            Position = utility:Position(0.5, -(size.X/2) ,0.5, -(size.Y/2)),
            Color = theme.outline
        });window["main_frame"] = main_frame
        --
        library.colors[main_frame] = {
            Color = "outline"
        }
        --
        local frame_inline = utility:Create("Frame", {Vector2.new(1,1), main_frame}, {
            Size = utility:Size(1, -2, 1, -2, main_frame),
            Position = utility:Position(0, 1, 0, 1, main_frame),
            Color = theme.accent
        })
        --
        library.colors[frame_inline] = {
            Color = "accent"
        }
        --
        local inner_frame = utility:Create("Frame", {Vector2.new(1,1), frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, frame_inline),
            Position = utility:Position(0, 1, 0, 1, frame_inline),
            Color = theme.lightcontrast
        })
        --
        library.colors[inner_frame] = {
            Color = "lightcontrast"
        }
        --
        local title = utility:Create("TextLabel", {Vector2.new(4,2), inner_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, 2, inner_frame)
        })
        --
        library.colors[title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local inner_frame_inline = utility:Create("Frame", {Vector2.new(4,18), inner_frame}, {
            Size = utility:Size(1, -8, 1, -22, inner_frame),
            Position = utility:Position(0, 4, 0, 18, inner_frame),
            Color = theme.inline
        })
        --
        library.colors[inner_frame_inline] = {
            Color = "inline"
        }
        --
        local inner_frame_inline2 = utility:Create("Frame", {Vector2.new(1,1), inner_frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, inner_frame_inline),
            Position = utility:Position(0, 1, 0, 1, inner_frame_inline),
            Color = theme.outline
        })
        --
        library.colors[inner_frame_inline2] = {
            Color = "outline"
        }
        --
        local back_frame = utility:Create("Frame", {Vector2.new(1,1), inner_frame_inline2}, {
            Size = utility:Size(1, -2, 1, -2, inner_frame_inline2),
            Position = utility:Position(0, 1, 0, 1, inner_frame_inline2),
            Color = theme.darkcontrast
        });window["back_frame"] = back_frame
        --
        library.colors[back_frame] = {
            Color = "darkcontrast"
        }
        --
        local tab_frame_inline = utility:Create("Frame", {Vector2.new(4,24), back_frame}, {
            Size = utility:Size(1, -8, 1, -28, back_frame),
            Position = utility:Position(0, 4, 0, 24, back_frame),
            Color = theme.outline
        })
        --
        library.colors[tab_frame_inline] = {
            Color = "outline"
        }
        --
        local tab_frame_inline2 = utility:Create("Frame", {Vector2.new(1,1), tab_frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, tab_frame_inline),
            Position = utility:Position(0, 1, 0, 1, tab_frame_inline),
            Color = theme.inline
        })
        --
        library.colors[tab_frame_inline2] = {
            Color = "inline"
        }
        --
        local tab_frame = utility:Create("Frame", {Vector2.new(1,1), tab_frame_inline2}, {
            Size = utility:Size(1, -2, 1, -2, tab_frame_inline2),
            Position = utility:Position(0, 1, 0, 1, tab_frame_inline2),
            Color = theme.lightcontrast
        });window["tab_frame"] = tab_frame
        --
        library.colors[tab_frame] = {
            Color = "lightcontrast"
        }
        --
        function window:GetConfig()
            local config = {}
            --
            if not pcall(function()
                for i,v in pairs(library.pointers) do
                    if type(v:get()) == "table" and v:get().Transparency then
                        local hue, sat, val = v:get().Color:ToHSV()
                        config[i] = {Color = {hue, sat, val}, Transparency = v:get().Transparency}
                    elseif v.keybindname then
                        local key, mode = v:get(), v.mode
                        config[i] = {Key = key, Mode = mode}
                    elseif typeof(v:get()) == "Color3" then
                        local hue, sat, val = v:get():ToHSV()
                        config[i] = {Color = {hue, sat, val}, Transparency = v.current[4] or 1}
                    else
                        config[i] = v:get()
                    end
                end
            end) then
                print("BROOOOOO WHAT")
                table.foreach(v, print)
            end
            --
            return hs:JSONEncode(config)
        end
        --
        function window:LoadConfig(config)
            local config = hs:JSONDecode(config)
            --
            for i,v in next, config do
                if library.pointers[i] then
                    library.pointers[i]:set(v)
                end
            end
        end
        --
        function window:Move(vector)
            for i,v in pairs(library.drawings) do
                if v[2][2] then
                    v[1].Position = utility:Position(0, v[2][1].X, 0, v[2][1].Y, v[2][2])
                else
                    v[1].Position = utility:Position(0, vector.X, 0, vector.Y)
                end
            end
        end
        --
        function window:CloseContent()
            if window.currentContent.dropdown and window.currentContent.dropdown.open then
                local dropdown = window.currentContent.dropdown
                dropdown.open = not dropdown.open
                utility:LoadImage(dropdown.dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(dropdown.holder.drawings) do
                    utility:Remove(v)
                end
                --
                dropdown.holder.drawings = {}
                dropdown.holder.buttons = {}
                dropdown.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.dropdown = nil
            elseif window.currentContent.multibox and window.currentContent.multibox.open then
                local multibox = window.currentContent.multibox
                multibox.open = not multibox.open
                utility:LoadImage(multibox.multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(multibox.holder.drawings) do
                    utility:Remove(v)
                end
                --
                multibox.holder.drawings = {}
                multibox.holder.buttons = {}
                multibox.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.multibox = nil
            elseif window.currentContent.colorpicker and window.currentContent.colorpicker.open then
                local colorpicker = window.currentContent.colorpicker
                colorpicker.open = not colorpicker.open
                --
                for i,v in pairs(colorpicker.holder.drawings) do
                    utility:Remove(v)
                end
                --
                colorpicker.holder.drawings = {}
                --
                window.currentContent.frame = nil
                window.currentContent.colorpicker = nil
            elseif window.currentContent.keybind and window.currentContent.keybind.open then
                local modemenu = window.currentContent.keybind.modemenu
                window.currentContent.keybind.open = not window.currentContent.keybind.open
                --
                for i,v in pairs(modemenu.drawings) do
                    utility:Remove(v)
                end
                --
                modemenu.drawings = {}
                modemenu.buttons = {}
                modemenu.frame = nil
                --
                window.currentContent.frame = nil
                window.currentContent.keybind = nil
            end
        end
        --
        function window:IsOverContent()
            local isOver = false
            --
            if window.currentContent.frame and utility:MouseOverDrawing({window.currentContent.frame.Position.X,window.currentContent.frame.Position.Y,window.currentContent.frame.Position.X + window.currentContent.frame.Size.X,window.currentContent.frame.Position.Y + window.currentContent.frame.Size.Y}) then
                isOver = true
            end
            --
            return isOver
        end
        --
        function window:Unload()
            for i,v in pairs(library.connections) do
                v:Disconnect()
                v = nil
            end
            --
            for i,v in next, library.hidden do
                coroutine.wrap(function()
                    if v[1] and v[1].Remove and v[1].__OBJECT_EXISTS then
                        local instance = v[1]
                        v[1] = nil
                        v = nil
                        --
                        instance:Remove()
                    end
                end)()
            end
            --
            for i,v in pairs(library.drawings) do
                coroutine.wrap(function()
                    if v[1] and v[1].Remove and v[1].__OBJECT_EXISTS then
                        local instance = v[1]
                        v[2] = nil
                        v[1] = nil
                        v = nil
                        --
                        instance:Remove()
                    end
                end)()
            end
            --
            for i,v in pairs(library.began) do
                v = nil
            end
            --
            for i,v in pairs(library.changed) do
                v = nil
            end
            --
            for i,v in pairs(library.ended) do
                v = nil
            end
            --
            for i,v in pairs(library.changed) do
                v = nil
            end
            --
            library.drawings = nil
            library.hidden = nil
            library.connections = nil
            library.began = nil
            library.ended = nil
            library.changed = nil
        end
        --
        function window:Watermark(info)
            window.watermark = {visible = false}
            --
            local info = info or {}
            local watermark_name = info.name or info.Name or info.title or info.Title or string.format("$$ Splix || uid : %u || ping : %u || fps : %u", 1, 100, 200)
            --
            local text_bounds = utility:GetTextBounds(watermark_name, theme.textsize, theme.font)
            --
            local watermark_outline = utility:Create("Frame", {Vector2.new(100,38/2-10)}, {
                Size = utility:Size(0, text_bounds.X+20, 0, 21),
                Position = utility:Position(0, 100, 0, 38/2-10),
                Hidden = true,
                ZIndex = 1010,
                Color = theme.outline,
                Visible = window.watermark.visible
            })window.watermark.outline = watermark_outline
            --
            library.colors[watermark_outline] = {
                Color = "outline"
            }
            --
            local watermark_inline = utility:Create("Frame", {Vector2.new(1,1), watermark_outline}, {
                Size = utility:Size(1, -2, 1, -2, watermark_outline),
                Position = utility:Position(0, 1, 0, 1, watermark_outline),
                Hidden = true,
                ZIndex = 1010,
                Color = theme.inline,
                Visible = window.watermark.visible
            })
            --
            library.colors[watermark_inline] = {
                Color = "inline"
            }
            --
            local watermark_frame = utility:Create("Frame", {Vector2.new(1,1), watermark_inline}, {
                Size = utility:Size(1, -2, 1, -2, watermark_inline),
                Position = utility:Position(0, 1, 0, 1, watermark_inline),
                Hidden = true,
                ZIndex = 1010,
                Color = theme.lightcontrast,
                Visible = window.watermark.visible
            })
            --
            library.colors[watermark_frame] = {
                Color = "lightcontrast"
            }
            --
            local watermark_accent = utility:Create("Frame", {Vector2.new(0,0), watermark_frame}, {
                Size = utility:Size(1, 0, 0, 1, watermark_frame),
                Position = utility:Position(0, 0, 0, 0, watermark_frame),
                Hidden = true,
                ZIndex = 1010,
                Color = theme.accent,
                Visible = window.watermark.visible
            })
            --
            library.colors[watermark_accent] = {
                Color = "accent"
            }
            --
            local watermark_title = utility:Create("TextLabel", {Vector2.new(2 + 6,4), watermark_outline}, {
                Text = string.format("crip scrip - fps : %u - uid : %u", 35, 2),
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Hidden = true,
                ZIndex = 1010,
                Position = utility:Position(0, 2 + 6, 0, 4, watermark_outline),
                Visible = window.watermark.visible
            })
            --
            library.colors[watermark_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.watermark:UpdateSize()
                watermark_outline.Size = utility:Size(0, watermark_title.TextBounds.X + 4 + (6*2), 0, 21)
                watermark_inline.Size = utility:Size(1, -2, 1, -2, watermark_outline)
                watermark_frame.Size = utility:Size(1, -2, 1, -2, watermark_inline)
                watermark_accent.Size = utility:Size(1, 0, 0, 1, watermark_frame)
            end
            --
            function window.watermark:Visibility()
                watermark_outline.Visible = window.watermark.visible
                watermark_inline.Visible = window.watermark.visible
                watermark_frame.Visible = window.watermark.visible
                watermark_accent.Visible = window.watermark.visible
                watermark_title.Visible = window.watermark.visible
            end
            --
            function window.watermark:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.watermark.visible = updateValue
                    window.watermark:Visibility()
                end
            end
            --
            window.watermark:UpdateSize()
            --
            local Tick = tick()

            task.spawn(function()
                local count = 0
                utility:Connection(rs.RenderStepped, function()
                    count = count + 1
                end)

                while true do
                    library.shared.fps = count
                    count = 0
                    task.wait(1)
                end
            end)
            --
            utility:Connection(rs.RenderStepped, function(FPS)
                library.shared.ping = stats.Network:FindFirstChild("ServerStatsItem") and tostring(math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())) or "Unknown"
                --
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
                if (tick() - Tick) > 0.15 then
                    watermark_title.Text = string.format("ZeeBot |%s,  Fps = %u,  | "..GameName, library.shared.ping, library.shared.fps)
                    window.watermark:UpdateSize()
                    --
                    Tick = tick()
                end
            end)
            --
            return window.watermark
        end
        --
        function window:NotificationList(info)
            window.notificationlist = {notifications = {}}
            --
            local info = info or {}
            --
            function window.notificationlist:AddNotification(info)
                local info = info or {}
                local text = info.text or "label"
                local lifetime = info.lifetime or 5
                --
                local notification = {pressed = false}
                --
                local notify_outline = utility:Create("Frame", {Vector2.new(0, 0)}, {
                    Size = utility:Size(0, 18 + (7 * #text), 0, 29),
                    Position = utility:Position(0, 29, 0, 34 + (#window.notificationlist.notifications * 35)),
                    Color = theme.outline,
                    ZIndex = 1,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_outline"] = notify_outline
                --
                local notify_inline = utility:Create("Frame", {Vector2.new(1, 1), notify_outline}, {
                    Size = utility:Size(1, -2, 1, -2, notify_outline),
                    Position = utility:Position(0, 1, 0, 1, notify_outline),
                    Color = theme.inline,
                    ZIndex = 2,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_inline"] = notify_inline
                --
                local notify_frame = utility:Create("Frame", {Vector2.new(1, 1), notify_inline}, {
                    Size = utility:Size(1, -2, 1, -2, notify_inline),
                    Position = utility:Position(0, 1, 0, 1, notify_inline),
                    Color = theme.lightcontrast,
                    ZIndex = 3,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_frame"] = notify_frame
                --
                local notify_accent = utility:Create("Frame", {Vector2.new(0, 0), notify_frame}, {
                    Size = utility:Size(0, 5, 0, 25),
                    Position = utility:Position(0, 0, 0, 0, notify_frame),
                    Color = theme.accent,
                    ZIndex = 3,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_accent"] = notify_accent
                --
                local notify_title = utility:Create("TextLabel", {Vector2.new(8, 5), notify_frame}, {
                    Size = 13,
                    Position = utility:Position(0, 10, 0, 5, notify_frame),
                    Font = Drawing.Fonts.Plex,
                    Color = theme.textcolor,
                    Outline = true,
                    ZIndex = 5,
                    Text = text,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_title"] = notify_title
                --
                local notify__gradient = utility:Create("Image", {Vector2.new(0, 0), notify_frame}, {
                    Size = utility:Size(1, 0, 1, 0, notify_frame),
                    Position = utility:Position(0, 0, 0, 0, notify_frame),
                    Transparency = 0,
                    ZIndex = 4,
                    Hidden = true,
                    Visible = true,
                })notification["notify__gradient"] = notify__gradient
                --
                utility:LoadImage(notify__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
                --
                utility:Lerp(notify_outline, {Transparency = 1}, 0.25)
                utility:Lerp(notify_inline, {Transparency = 1}, 0.25)
                utility:Lerp(notify_frame, {Transparency = 1}, 0.25)
                utility:Lerp(notify_accent, {Transparency = 10}, 0.25)
                utility:Lerp(notify_title, {Transparency = 1}, 0.25)
                utility:Lerp(notify__gradient, {Transparency = 0.5}, 0.25)
                --
                window.notificationlist.notifications[#window.notificationlist.notifications + 1] = notification
                --
                local function began_function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and utility:MouseOverDrawingInstance(notify_outline) and not notification.pressed then
                        notification.Remove()
                    end
                end
                --
                library.began[#library.began + 1] = began_function
                --
                local function changed_function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement and not notification.pressed then
                        if utility:MouseOverDrawingInstance(notify_outline) then
                            local h, s, v = theme.accent:ToHSV()
                            notify_inline.Color = Color3.fromHSV(h, 0.44, v)
                        else
                            notify_inline.Color = theme.inline
                        end
                    end
                end
                --
                library.changed[#library.changed + 1] = changed_function
                --
                function notification.Remove()
                    if notification.pressed then return end
                    notification.pressed = true
                    --
                    utility:Lerp(notify_outline, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_inline, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_frame, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_accent, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_title, {Transparency = 0}, 0.25)
                    utility:Lerp(notify__gradient, {Transparency = 0}, 0.25)
                    --
                    task.wait(0.25)
                    --
                    notify_outline:Remove()
                    notify_inline:Remove()
                    notify_frame:Remove()
                    notify_accent:Remove()
                    notify_title:Remove()
                    notify__gradient:Remove()
                    --
                    for index, notify in next, window.notificationlist.notifications do
                        if notify == notification then
                            window.notificationlist.notifications[index] = nil
                        end
                    end
                    --
                    for index, func in next, library.changed do
                        if func == changed_function then
                            library.changed[index] = nil
                        end
                    end
                    --
                    for index, func in next, library.began do
                        if func == began_function then
                            library.began[index] = nil
                        end
                    end
                    --
                    window.notificationlist:SortNotifications()
                end
                --
                delay(lifetime + 0.25, notification.Remove)
            end
            --
            function window.notificationlist:SortNotifications()
                for index, notification in next, window.notificationlist.notifications do
                    notification["notify_outline"].Position = utility:Position(0, 0, 0, -34, notification["notify_outline"])
                    notification["notify_inline"].Position = utility:Position(0, 1, 0, 1, notification["notify_outline"])
                    notification["notify_frame"].Position = utility:Position(0, 1, 0, 1, notification["notify_inline"])
                    notification["notify_accent"].Position = utility:Position(0, 0, 0, 0, notification["notify_frame"])
                    notification["notify_title"].Position = utility:Position(0, 8, 0, 5, notification["notify_frame"])
                    notification["notify__gradient"].Position = utility:Position(0, 0, 0, 0, notification["notify_frame"])
                end
            end
        end
        --
        function window:KeybindsList(info)
            window.keybindslist = {visible = false, keybinds = {}}
            --
            local info = info or {}
            --
            local keybindslist_outline = utility:Create("Frame", {Vector2.new(10,(utility:GetScreenSize().Y/2)-200)}, {
                Size = utility:Size(0, 180, 0, 22),
                Position = utility:Position(0, 10, 0.4, 0),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.outline,
                Visible = window.keybindslist.visible
            })window.keybindslist.outline = keybindslist_outline
            --
            library.colors[keybindslist_outline] = {
                Color = "outline"
            }
            --
            local keybindslist_inline = utility:Create("Frame", {Vector2.new(1,1), keybindslist_outline}, {
                Size = utility:Size(1, -2, 1, -2, keybindslist_outline),
                Position = utility:Position(0, 1, 0, 1, keybindslist_outline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.inline,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_inline] = {
                Color = "inline"
            }
            --
            local keybindslist_frame = utility:Create("Frame", {Vector2.new(1,1), keybindslist_inline}, {
                Size = utility:Size(1, -2, 1, -2, keybindslist_inline),
                Position = utility:Position(0, 1, 0, 1, keybindslist_inline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.lightcontrast,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_frame] = {
                Color = "lightcontrast"
            }
            --
            local keybindslist_accent = utility:Create("Frame", {Vector2.new(0,0), keybindslist_frame}, {
                Size = utility:Size(1, 0, 0, 1, keybindslist_frame),
                Position = utility:Position(0, 0, 0, 0, keybindslist_frame),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.accent,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_accent] = {
                Color = "accent"
            }
            --
            local keybindslist_title = utility:Create("TextLabel", {Vector2.new(keybindslist_outline.Size.X/2,4), keybindslist_outline}, {
                Text = "Keybinds",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 1005,
                Position = utility:Position(0.5, 0, 0, 5, keybindslist_outline),
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.keybindslist:Resort()
                local index = 0
                for i,v in pairs(window.keybindslist.keybinds) do
                    v:Move(0 + (index*17))
                    --
                    index = index + 1
                end
            end
            --
            function window.keybindslist:Add(keybindname, keybindvalue)
                if keybindname and keybindvalue and not window.keybindslist.keybinds[keybindname] then
                    local keybindTable = {}
                    --
                    local keybind_outline = utility:Create("Frame", {Vector2.new(0,keybindslist_outline.Size.Y-1), keybindslist_outline}, {
                        Size = utility:Size(1, 0, 0, 18, keybindslist_outline),
                        Position = utility:Position(0, 0, 1, -1, keybindslist_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.outline,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_outline] = {
                        Color = "outline"
                    }
                    --
                    local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
                        Size = utility:Size(1, -2, 1, -2, keybind_outline),
                        Position = utility:Position(0, 1, 0, 1, keybind_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.inline,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_inline] = {
                        Color = "inline"
                    }
                    --
                    local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
                        Size = utility:Size(1, -2, 1, -2, keybind_inline),
                        Position = utility:Position(0, 1, 0, 1, keybind_inline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.darkcontrast,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    local keybind_title = utility:Create("TextLabel", {Vector2.new(4,3), keybind_outline}, {
                        Text = keybindname,
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(0, 4, 0, 3, keybind_outline),
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_title] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X - 4 - utility:GetTextBounds(keybindname, theme.textsize, theme.font).X,3), keybind_outline}, {
                        Text = "["..keybindvalue.."]",
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(1, -4 - utility:GetTextBounds(keybindname, theme.textsize, theme.font).X, 0, 3, keybind_outline),
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_value] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    function keybindTable:Move(yPos)
                        keybind_outline.Position = utility:Position(0, 0, 1, -1 + yPos, keybindslist_outline)
                        keybind_inline.Position = utility:Position(0, 1, 0, 1, keybind_outline)
                        keybind_frame.Position = utility:Position(0, 1, 0, 1, keybind_inline)
                        keybind_title.Position = utility:Position(0, 4, 0, 3, keybind_outline)
                        keybind_value.Position = utility:Position(1, -4 - keybind_value.TextBounds.X, 0, 3, keybind_outline)
                    end
                    --
                    function keybindTable:Remove()
                        utility:Remove(keybind_outline, true)
                        utility:Remove(keybind_inline, true)
                        utility:Remove(keybind_frame, true)
                        utility:Remove(keybind_title, true)
                        utility:Remove(keybind_value, true)
                        --
                        window.keybindslist.keybinds[keybindname] = nil
                        keybindTable = nil
                    end
                    --
                    function keybindTable:Visibility()
                        keybind_outline.Visible = window.keybindslist.visible
                        keybind_inline.Visible = window.keybindslist.visible
                        keybind_frame.Visible = window.keybindslist.visible
                        keybind_title.Visible = window.keybindslist.visible
                        keybind_value.Visible = window.keybindslist.visible
                    end
                    --
                    window.keybindslist.keybinds[keybindname] = keybindTable
                    window.keybindslist:Resort()
                end
            end
            --
            function window.keybindslist:Remove(keybindname)
                if keybindname and window.keybindslist.keybinds[keybindname] then
                    window.keybindslist.keybinds[keybindname]:Remove()
                    window.keybindslist.keybinds[keybindname] = nil
                    window.keybindslist:Resort()
                end
            end
            --
            function window.keybindslist:Visibility()
                keybindslist_outline.Visible = window.keybindslist.visible
                keybindslist_inline.Visible = window.keybindslist.visible
                keybindslist_frame.Visible = window.keybindslist.visible
                keybindslist_accent.Visible = window.keybindslist.visible
                keybindslist_title.Visible = window.keybindslist.visible
                --
                for i,v in pairs(window.keybindslist.keybinds) do
                    v:Visibility()
                end
            end
            --
            function window.keybindslist:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.keybindslist.visible = updateValue
                    window.keybindslist:Visibility()
                end
            end
            --
            utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
                keybindslist_outline.Position = utility:Position(0, 10, 0.4, 0)
                keybindslist_inline.Position = utility:Position(0, 1, 0, 1, keybindslist_outline)
                keybindslist_frame.Position = utility:Position(0, 1, 0, 1, keybindslist_inline)
                keybindslist_accent.Position = utility:Position(0, 0, 0, 0, keybindslist_frame)
                keybindslist_title.Position = utility:Position(0.5, 0, 0, 5, keybindslist_outline)
                --
                window.keybindslist:Resort()
            end)
        end
        --
        function window:StatusList(info)
            window.statuslist = {visible = false, statuses = {}}
            --
            local info = info or {}
            --
            local statuslist_outline = utility:Create("Frame", {Vector2.new(10,(utility:GetScreenSize().Y/2)-200)}, {
                Size = utility:Size(0, 150, 0, 22),
                Position = utility:Position(1, -160, 0.4, 0),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.outline,
                Visible = window.statuslist.visible
            })window.statuslist.outline = statuslist_outline
            --
            library.colors[statuslist_outline] = {
                Color = "outline"
            }
            --
            local statuslist_inline = utility:Create("Frame", {Vector2.new(1,1), statuslist_outline}, {
                Size = utility:Size(1, -2, 1, -2, statuslist_outline),
                Position = utility:Position(0, 1, 0, 1, statuslist_outline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.inline,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_inline] = {
                Color = "inline"
            }
            --
            local statuslist_frame = utility:Create("Frame", {Vector2.new(1,1), statuslist_inline}, {
                Size = utility:Size(1, -2, 1, -2, statuslist_inline),
                Position = utility:Position(0, 1, 0, 1, statuslist_inline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.lightcontrast,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_frame] = {
                Color = "lightcontrast"
            }
            --
            local statuslist_accent = utility:Create("Frame", {Vector2.new(0,0), statuslist_frame}, {
                Size = utility:Size(1, 0, 0, 1, statuslist_frame),
                Position = utility:Position(0, 0, 0, 0, statuslist_frame),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.accent,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_accent] = {
                Color = "accent"
            }
            --
            local statuslist_title = utility:Create("TextLabel", {Vector2.new(statuslist_outline.Size.X/2,4), statuslist_outline}, {
                Text = "Status",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 1005,
                Position = utility:Position(0.5, 0, 0, 5, statuslist_outline),
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.statuslist:Resort()
                local index = 0
                for i,v in pairs(window.statuslist.statuses) do
                    v:Move(0 + (index*17))
                    --
                    index = index + 1
                end
            end
            --
            function window.statuslist:Add(statusname)
                if statusname and not window.statuslist.statuses[statusname] then
                    local statusTable = {}
                    --
                    local status_outline = utility:Create("Frame", {Vector2.new(0,statuslist_outline.Size.Y-1), statuslist_outline}, {
                        Size = utility:Size(1, 0, 0, 18, statuslist_outline),
                        Position = utility:Position(0, 0, 1, -1, statuslist_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.outline,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_outline] = {
                        Color = "outline"
                    }
                    --
                    local status_inline = utility:Create("Frame", {Vector2.new(1,1), status_outline}, {
                        Size = utility:Size(1, -2, 1, -2, status_outline),
                        Position = utility:Position(0, 1, 0, 1, status_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.inline,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_inline] = {
                        Color = "inline"
                    }
                    --
                    local status_frame = utility:Create("Frame", {Vector2.new(1,1), status_inline}, {
                        Size = utility:Size(1, -2, 1, -2, status_inline),
                        Position = utility:Position(0, 1, 0, 1, status_inline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.darkcontrast,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    local status_title = utility:Create("TextLabel", {Vector2.new(4,3), status_outline}, {
                        Text = statusname,
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(0, 4, 0, 3, status_outline),
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_title] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    function statusTable:Move(yPos)
                        status_outline.Position = utility:Position(0, 0, 1, -1 + yPos, statuslist_outline)
                        status_inline.Position = utility:Position(0, 1, 0, 1, status_outline)
                        status_frame.Position = utility:Position(0, 1, 0, 1, status_inline)
                        status_title.Position = utility:Position(0, 4, 0, 3, status_outline)
                    end
                    --
                    function statusTable:Remove()
                        utility:Remove(status_outline, true)
                        utility:Remove(status_inline, true)
                        utility:Remove(status_frame, true)
                        utility:Remove(status_title, true)
                        --
                        window.statuslist.statuses[statusname] = nil
                        statusTable = nil
                    end
                    --
                    function statusTable:Visibility()
                        status_outline.Visible = window.statuslist.visible
                        status_inline.Visible = window.statuslist.visible
                        status_frame.Visible = window.statuslist.visible
                        status_title.Visible = window.statuslist.visible
                    end
                    --
                    window.statuslist.statuses[statusname] = statusTable
                    window.statuslist:Resort()
                end
            end
            --
            function window.statuslist:Remove(statusname)
                if statusname and window.statuslist.statuses[statusname] then
                    window.statuslist.statuses[statusname]:Remove()
                    window.statuslist.statuses[statusname] = nil
                    window.statuslist:Resort()
                end
            end
            --
            function window.statuslist:Visibility()
                statuslist_outline.Visible = window.statuslist.visible
                statuslist_inline.Visible = window.statuslist.visible
                statuslist_frame.Visible = window.statuslist.visible
                statuslist_accent.Visible = window.statuslist.visible
                statuslist_title.Visible = window.statuslist.visible
                --
                for i,v in pairs(window.statuslist.statuses) do
                    v:Visibility()
                end
            end
            --
            function window.statuslist:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.statuslist.visible = updateValue
                    window.statuslist:Visibility()
                end
            end
            --
            utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
                statuslist_outline.Position = utility:Position(1, -160, 0.4, 0)
                statuslist_inline.Position = utility:Position(0, 1, 0, 1, statuslist_outline)
                statuslist_frame.Position = utility:Position(0, 1, 0, 1, statuslist_inline)
                statuslist_accent.Position = utility:Position(0, 0, 0, 0, statuslist_frame)
                statuslist_title.Position = utility:Position(0.5, 0, 0, 5, statuslist_outline)
                --
                window.statuslist:Resort()
            end)
        end
        --
        function window:Cursor(info)
            window.cursor = {}
            --
            local cursor = utility:Create("Triangle", nil, {
                Color = theme.cursoroutline,
                Thickness = 2.5,
                Filled = false,
                ZIndex = 2000,
                Hidden = true
            });window.cursor["cursor"] = cursor
            --
            library.colors[cursor] = {
                Color = "cursoroutline"
            }
            --
            local cursor_inline = utility:Create("Triangle", nil, {
                Color = theme.accent,
                Filled = true,
                Thickness = 0,
                ZIndex = 2000,
                Hidden = true
            });window.cursor["cursor_inline"] = cursor_inline
            --
            library.colors[cursor_inline] = {
                Color = "accent"
            }
            --
            utility:Connection(rs.RenderStepped, function()
                local mouseLocation = utility:MouseLocation()
                --
                cursor.PointA = Vector2.new(mouseLocation.X, mouseLocation.Y)
                cursor.PointB = Vector2.new(mouseLocation.X + 12, mouseLocation.Y + 4)
                cursor.PointC = Vector2.new(mouseLocation.X + 4, mouseLocation.Y + 12)
                --
                cursor_inline.PointA = Vector2.new(mouseLocation.X, mouseLocation.Y)
                cursor_inline.PointB = Vector2.new(mouseLocation.X + 12, mouseLocation.Y + 4)
                cursor_inline.PointC = Vector2.new(mouseLocation.X + 4, mouseLocation.Y + 12)
            end)
            --
            return window.cursor
        end
        --
        function window:AllowClickThrough()

        end
        --
        function window:PreventClickThrough()
            
        end
        --
        local originalMouseBehavior = uis.MouseBehavior
        --
        function window:Fade()
            window.fading = true
            window.isVisible = not window.isVisible
            --
            spawn(function()
                for i, v in pairs(library.drawings) do
                    utility:Lerp(v[1], {Transparency = window.isVisible and v[3] or 0}, 0.25)
                end
            end)
            --
            window.cursor["cursor"].Transparency = window.isVisible and 1 or 0
            window.cursor["cursor_inline"].Transparency = window.isVisible and 1 or 0

            if window.isVisible then
                local set_back = false
                library.connections.mouse_unlock = uis:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
                    if uis.MouseBehavior == Enum.MouseBehavior.Default and set_back then
                        set_back = false
                    end

                    if not set_back then
                        originalMouseBehavior = uis.MouseBehavior
                    end

                    if uis.MouseBehavior ~= Enum.MouseBehavior.Default then
                        set_back = true
                        uis.MouseBehavior = Enum.MouseBehavior.Default
                    end
                end)
                uis.MouseBehavior = Enum.MouseBehavior.Default
                window:PreventClickThrough()
            else
                library.connections.mouse_unlock:Disconnect()
                uis.MouseBehavior = originalMouseBehavior
                window:AllowClickThrough()
            end
            --
            window.fading = false
        end
        --
        function window:Initialize()
            window.pages[1]:Show()
            --
            for i,v in pairs(window.pages) do
                v:Update()
            end
            --
            library.shared.initialized = true
            --
            window:Watermark()
            window:KeybindsList()
            window:StatusList()
            window:Cursor()
            --
            window:Fade()
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and window.isVisible and utility:MouseOverDrawing({main_frame.Position.X,main_frame.Position.Y,main_frame.Position.X + main_frame.Size.X,main_frame.Position.Y + 20}) then
                local mouseLocation = utility:MouseLocation()
                --
                window.dragging = true
                window.drag = Vector2.new(mouseLocation.X - main_frame.Position.X, mouseLocation.Y - main_frame.Position.Y)
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and window.dragging then
                window.dragging = false
                window.drag = Vector2.new(0, 0)
            end
        end
        --
        library.changed[#library.changed + 1] = function(Input)
            if window.dragging and window.isVisible then
                local mouseLocation = utility:MouseLocation()
                if utility:GetScreenSize().Y-main_frame.Size.Y-5 > 5 then
                    local move = Vector2.new(math.clamp(mouseLocation.X - window.drag.X, 5, utility:GetScreenSize().X-main_frame.Size.X-5), math.clamp(mouseLocation.Y - window.drag.Y, 5, utility:GetScreenSize().Y-main_frame.Size.Y-5))
                    window:Move(move)
                else
                    local move = Vector2.new(mouseLocation.X - window.drag.X, mouseLocation.Y - window.drag.Y)
                    window:Move(move)
                end
            end
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.KeyCode == window.uibind then
                window:Fade()
            end
            --[[
            if Input.KeyCode == Enum.KeyCode.P then
                local plrs = game:GetService("Players")
                local plr = plrs.LocalPlayer
                if #plrs:GetPlayers() <= 1 then
                    plr:Kick("\nRejoining...")
                    wait()
                    game:GetService('TeleportService'):Teleport(game.PlaceId, plr)
                else
                    game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
                end
            end]]
        end
        --
        utility:Connection(uis.InputBegan,function(Input)
            for _, func in pairs(library.began) do
                if not window.dragging then
                    local e,s = pcall(function()
                        func(Input)
                    end)
                else
                    break
                end
            end
        end)
        --
        utility:Connection(uis.InputChanged,function(Input)
            for _, func in pairs(library.changed) do
                if not window.dragging then
                    local e,s = pcall(function()
                        func(Input)
                    end)
                else
                    break
                end
            end
        end)
        --
        utility:Connection(uis.InputEnded,function(Input)
            for _, func in pairs(library.ended) do
                local e,s = pcall(function()
                    func(Input)
                end)
            end
        end)
        --
        utility:Connection(uis.InputChanged,function()
            for _, func in pairs(library.changed) do
                local e,s = pcall(function()
                    func()
                end)
            end
        end)
        --
        utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
            window:Move(Vector2.new((utility:GetScreenSize().X/2) - (size.X/2), (utility:GetScreenSize().Y/2) - (size.Y/2)))
        end)
        --
		return setmetatable(window, library)
	end
    --
    function library:Page(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Page"
        --
        local window = self
        --
        local page = {open = false, sections = {}, sectionOffset = {left = 0, right = 0}, window = window}
        --
        local position = 4
        --
        for i,v in pairs(window.pages) do
            position = position + (v.page_button.Size.X+2)
        end
        --
        local textbounds = utility:GetTextBounds(name, theme.textsize, theme.font)
        --
        local page_button = utility:Create("Frame", {Vector2.new(position,4), window.back_frame}, {
            Size = utility:Size(0, info.size or textbounds.X+41.6, 0, 21),
            Position = utility:Position(0, position, 0, 4, window.back_frame),
            Color = theme.outline
        });page["page_button"] = page_button
        --
        library.colors[page_button] = {
            Color = "outline"
        }
        --
        local page_button_inline = utility:Create("Frame", {Vector2.new(1,1), page_button}, {
            Size = utility:Size(1, -2, 1, -1, page_button),
            Position = utility:Position(0, 1, 0, 1, page_button),
            Color = theme.inline
        });page["page_button_inline"] = page_button_inline
        --
        library.colors[page_button_inline] = {
            Color = "inline"
        }
        --
        local page_button_color = utility:Create("Frame", {Vector2.new(1,1), page_button_inline}, {
            Size = utility:Size(1, -2, 1, -1, page_button_inline),
            Position = utility:Position(0, 1, 0, 1, page_button_inline),
            Color = theme.darkcontrast
        });page["page_button_color"] = page_button_color
        --
        library.colors[page_button_color] = {
            Color = "darkcontrast"
        }
        --
        local page_button_title = utility:Create("TextLabel", {Vector2.new(utility:Position(0.5, 0, 0, 2, page_button_color).X - page_button_color.Position.X,2), page_button_color}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            Center = true,
            OutlineColor = theme.textborder,
            Position = utility:Position(0.5, 0, 0, 2, page_button_color)
        })
        --
        library.colors[page_button_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        window.pages[#window.pages + 1] = page
        --
        function page:Update()
            page.sectionOffset["left"] = 0
            page.sectionOffset["right"] = 0
            --
            for i,v in pairs(page.sections) do
                utility:UpdateOffset(v.section_inline, {Vector2.new(v.side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][v.side]), window.tab_frame})
                page.sectionOffset[v.side] = page.sectionOffset[v.side] + v.section_inline.Size.Y + 5
            end
            --
            window:Move(window.main_frame.Position)
        end
        --
        function page:Show()
            if window.currentPage then
                window.currentPage.page_button_color.Size = utility:Size(1, -2, 1, -1, window.currentPage.page_button_inline)
                window.currentPage.page_button_color.Color = theme.darkcontrast
                window.currentPage.open = false
                --
                library.colors[window.currentPage.page_button_color] = {
                    Color = "darkcontrast"
                }
                --
                for i,v in pairs(window.currentPage.sections) do
                    for z,x in pairs(v.visibleContent) do
                        x.Visible = false
                    end
                end
                --
                window:CloseContent()
            end
            --
            window.currentPage = page
            page_button_color.Size = utility:Size(1, -2, 1, 0, page_button_inline)
            page_button_color.Color = theme.lightcontrast
            page.open = true
            --
            library.colors[page_button_color] = {
                Color = "lightcontrast"
            }
            --
            for i,v in pairs(page.sections) do
                for z,x in pairs(v.visibleContent) do
                    x.Visible = true
                end
            end
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and utility:MouseOverDrawing({page_button.Position.X,page_button.Position.Y,page_button.Position.X + page_button.Size.X,page_button.Position.Y + page_button.Size.Y}) and window.currentPage ~= page then
                page:Show()
            end
        end
        --
        return setmetatable(page, pages)
    end
    --
    function pages:Section(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Section"
        local side = info.side or info.Side or "left"
        side = side:lower()
        local window = self.window
        local page = self
        local section = {window = window, page = page, visibleContent = {}, currentAxis = 20, side = side}
        --
        local section_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(0.5, -7, 0, 22, window.tab_frame),
            Position = utility:Position(side == "right" and 0.5 or 0, side == "right" and 2 or 5, 0, 5 + page.sectionOffset[side], window.tab_frame),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent);section["section_inline"] = section_inline
        --
        library.colors[section_inline] = {
            Color = "inline"
        }
        --
        local section_outline = utility:Create("Frame", {Vector2.new(1,1), section_inline}, {
            Size = utility:Size(1, -2, 1, -2, section_inline),
            Position = utility:Position(0, 1, 0, 1, section_inline),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent);section["section_outline"] = section_outline
        --
        library.colors[section_outline] = {
            Color = "outline"
        }
        --
        local section_frame = utility:Create("Frame", {Vector2.new(1,1), section_outline}, {
            Size = utility:Size(1, -2, 1, -2, section_outline),
            Position = utility:Position(0, 1, 0, 1, section_outline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, section.visibleContent);section["section_frame"] = section_frame
        --
        library.colors[section_frame] = {
            Color = "darkcontrast"
        }
        --
        local section_accent = utility:Create("Frame", {Vector2.new(0,0), section_frame}, {
            Size = utility:Size(1, 0, 0, 1, section_frame),
            Position = utility:Position(0, 0, 0, 0, section_frame),
            Color = theme.accent,
            Visible = page.open
        }, section.visibleContent);section["section_accent"] = section_accent
        --
        library.colors[section_accent] = {
            Color = "accent"
        }
        --
        local section_title = utility:Create("TextLabel", {Vector2.new(3,3), section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, 3, section_frame),
            Visible = page.open
        }, section.visibleContent);section["section_title"] = section_title
        --
        library.colors[section_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        function section:Update()
            section_inline.Size = utility:Size(0.5, -7, 0, section.currentAxis+4, window.tab_frame)
            section_outline.Size = utility:Size(1, -2, 1, -2, section_inline)
            section_frame.Size = utility:Size(1, -2, 1, -2, section_outline)
        end
        --
        page.sectionOffset[side] = page.sectionOffset[side] + 100 + 5
        page.sections[#page.sections + 1] = section
        --
        return setmetatable(section, sections)
    end
    --
    function pages:MultiSection(info)
        local info = info or {}
        local msections = info.sections or info.Sections or {}
        local side = info.side or info.Side or "left"
        local size = info.size or info.Size or 150
        side = side:lower()
        local window = self.window
        local page = self
        local multiSection = {window = window, page = page, sections = {}, backup = {}, visibleContent = {}, currentSection = nil, xAxis = 0, side = side}
        --
        local multiSection_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(0.5, -7, 0, size, window.tab_frame),
            Position = utility:Position(side == "right" and 0.5 or 0, side == "right" and 2 or 5, 0, 5 + page.sectionOffset[side], window.tab_frame),
            Color = theme.inline,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_inline"] = multiSection_inline
        --
        library.colors[multiSection_inline] = {
            Color = "inline"
        }
        --
        local multiSection_outline = utility:Create("Frame", {Vector2.new(1,1), multiSection_inline}, {
            Size = utility:Size(1, -2, 1, -2, multiSection_inline),
            Position = utility:Position(0, 1, 0, 1, multiSection_inline),
            Color = theme.outline,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_outline"] = multiSection_outline
        --
        library.colors[multiSection_outline] = {
            Color = "outline"
        }
        --
        local multiSection_frame = utility:Create("Frame", {Vector2.new(1,1), multiSection_outline}, {
            Size = utility:Size(1, -2, 1, -2, multiSection_outline),
            Position = utility:Position(0, 1, 0, 1, multiSection_outline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_frame"] = multiSection_frame
        --
        library.colors[multiSection_frame] = {
            Color = "darkcontrast"
        }
        --
        local multiSection_backFrame = utility:Create("Frame", {Vector2.new(0,2), multiSection_frame}, {
            Size = utility:Size(1, 0, 0, 17, multiSection_frame),
            Position = utility:Position(0, 0, 0, 2, multiSection_frame),
            Color = theme.lightcontrast,
            Visible = page.open
        }, multiSection.visibleContent)
        --
        library.colors[multiSection_backFrame] = {
            Color = "lightcontrast"
        }
        --
        local multiSection_bottomFrame = utility:Create("Frame", {Vector2.new(0,multiSection_backFrame.Size.Y - 1), multiSection_backFrame}, {
            Size = utility:Size(1, 0, 0, 1, multiSection_backFrame),
            Position = utility:Position(0, 0, 1, -1, multiSection_backFrame),
            Color = theme.outline,
            Visible = page.open
        }, multiSection.visibleContent)
        --
        library.colors[multiSection_bottomFrame] = {
            Color = "outline"
        }
        --
        local multiSection_accent = utility:Create("Frame", {Vector2.new(0,0), multiSection_frame}, {
            Size = utility:Size(1, 0, 0, 2, multiSection_frame),
            Position = utility:Position(0, 0, 0, 0, multiSection_frame),
            Color = theme.accent,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_accent"] = multiSection_accent
        --
        library.colors[multiSection_accent] = {
            Color = "accent"
        }
        --
        for i,v in pairs(msections) do
            local msection = {window = window, page = page, currentAxis = 24, sections = {}, visibleContent = {}, section_inline = multiSection_inline, section_outline = multiSection_outline, section_frame = multiSection_frame, section_accent = multiSection_accent}
            --
            local textBounds = utility:GetTextBounds(v, theme.textsize, theme.font)
            --
            local msection_frame = utility:Create("Frame", {Vector2.new(multiSection.xAxis,0), multiSection_backFrame}, {
                Size = utility:Size(0, textBounds.X + 14, 1, -1, multiSection_backFrame),
                Position = utility:Position(0, multiSection.xAxis, 0, 0, multiSection_backFrame),
                Color = i == 1 and theme.darkcontrast or theme.lightcontrast,
                Visible = page.open
            }, multiSection.visibleContent);msection["msection_frame"] = msection_frame
            --
            library.colors[msection_frame] = {
                Color = i == 1 and "darkcontrast" or "lightcontrast"
            }
            --
            local msection_line = utility:Create("Frame", {Vector2.new(msection_frame.Size.X,0), msection_frame}, {
                Size = utility:Size(0, 1, 1, 0, msection_frame),
                Position = utility:Position(1, 0, 0, 0, msection_frame),
                Color = theme.outline,
                Visible = page.open
            }, multiSection.visibleContent)
            --
            library.colors[msection_line] = {
                Color = "outline"
            }
            --
            local msection_title = utility:Create("TextLabel", {Vector2.new(msection_frame.Size.X * 0.5,1), msection_frame}, {
                Text = v,
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 1, msection_frame),
                Visible = page.open
            }, multiSection.visibleContent)
            --
            library.colors[msection_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local msection_bottomline = utility:Create("Frame", {Vector2.new(0,msection_frame.Size.Y), msection_frame}, {
                Size = utility:Size(1, 0, 0, 1, msection_frame),
                Position = utility:Position(0, 0, 1, 0, msection_frame),
                Color = i == 1 and theme.darkcontrast or theme.outline,
                Visible = page.open
            }, multiSection.visibleContent);msection["msection_bottomline"] = msection_bottomline
            --
            library.colors[msection_bottomline] = {
                Color = i == 1 and "darkcontrast" or "outline"
            }
            --
            function msection:Update()
                if multiSection.currentSection == msection then
                    multiSection.visibleContent = utility:Combine(multiSection.backup, multiSection.currentSection.visibleContent)
                else
                    for z,x in pairs(msection.visibleContent) do
                        x.Visible = false
                    end
                end
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and page.open and  utility:MouseOverDrawing({msection_frame.Position.X,msection_frame.Position.Y,msection_frame.Position.X + msection_frame.Size.X,msection_frame.Position.Y + msection_frame.Size.Y}) and multiSection.currentSection ~= msection and not window:IsOverContent() then
                    multiSection.currentSection.msection_frame.Color = theme.lightcontrast
                    multiSection.currentSection.msection_bottomline.Color = theme.outline
                    --
                    library.colors[multiSection.currentSection.msection_frame] = {
                        Color = "lightcontrast"
                    }
                    --
                    library.colors[multiSection.currentSection.msection_bottomline] = {
                        Color = "outline"
                    }
                    --
                    for i,v in pairs(multiSection.currentSection.visibleContent) do
                        v.Visible = false
                    end
                    --
                    multiSection.currentSection = msection
                    msection_frame.Color = theme.darkcontrast
                    msection_bottomline.Color = theme.darkcontrast
                    --
                    library.colors[msection_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    library.colors[msection_bottomline] = {
                        Color = "darkcontrast"
                    }
                    --
                    for i,v in pairs(multiSection.currentSection.visibleContent) do
                        v.Visible = true
                    end
                    --
                    multiSection.visibleContent = utility:Combine(multiSection.backup, multiSection.currentSection.visibleContent)
                end
            end
            --
            if i == 1 then
                multiSection.currentSection = msection
            end
            --
            multiSection.sections[#multiSection.sections + 1] = setmetatable(msection, sections)
            multiSection.xAxis = multiSection.xAxis + textBounds.X + 15
        end
        --
        for z,x in pairs(multiSection.visibleContent) do
            multiSection.backup[z] = x
        end
        --
        page.sectionOffset[side] = page.sectionOffset[side] + 100 + 5
        page.sections[#page.sections + 1] = multiSection
        --
        return table.unpack(multiSection.sections)
    end
    --
    function sections:Label(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Label"
        local middle = info.middle or info.Middle or false
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local color = info.textcolor or Color3.fromRGB(255, 255, 255)
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local label = {axis = section.currentAxis}
        --
        local label_title = utility:Create("TextLabel", {Vector2.new(middle and (section.section_frame.Size.X/2) or 4,label.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = info.textcolor,
            OutlineColor = theme.textborder,
            Center = middle,
            Position = utility:Position(middle and 0.5 or 0, middle and 0 or 4, 0, 0, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[label_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = label
        end
        --
        section.currentAxis = section.currentAxis + label_title.TextBounds.Y + 4
        section:Update()
        --
        return label
    end
    --
    function sections:Textbox(info)
        local info = info or {}
        local placeholder = info.placeholder or info.PlaceHolder or ""
        local text = info.text or info.Text or ""
        local middle = info.middle or info.Middle or false
        local resetonfocus = info.reset_on_focus or info.ResetOnFocus or false
        local pointer = info.pointer or info.Pointer or nil
        local callback = info.callback or info.Callback or function() end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local textbox = {axis = section.currentAxis, current = text}
        --
        local textbox_outline = utility:Create("Frame", {Vector2.new(4, textbox.axis), section.section_frame}, {
            Size = utility:Size(0, section.section_frame.Size.X - 8, 0, 20),
            Position = utility:Position(0.5, 0, 0, textbox.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_outline] = {
            Color = "outline"
        }
        --
        local textbox_inline = utility:Create("Frame", {Vector2.new(1, 1), textbox_outline}, {
            Size = utility:Size(1, -2, 1, -2, textbox_outline),
            Position = utility:Position(0, 1, 0, 1, textbox_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_inline] = {
            Color = "inline"
        }
        --
        local textbox_frame = utility:Create("Frame", {Vector2.new(1, 1), textbox_inline}, {
            Size = utility:Size(1, -2, 1, -2, textbox_inline),
            Position = utility:Position(0, 1, 0, 1, textbox_inline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_frame] = {
            Color = "darkconstrast"
        }
        --
        local placeholder_text = utility:Create("TextLabel", {Vector2.new(middle and textbox_frame.Size.X / 2 or 4, 0), textbox_frame}, {
            Text = placeholder,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Center = middle,
            Transparency = text == "" and 0.25 or 0,
            Position = utility:Position(1, 0, 0, 0, textbox_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        local text = utility:Create("TextLabel", {Vector2.new(middle and textbox_frame.Size.X / 2 or 4, 0), textbox_frame}, {
            Text = text,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Center = middle,
            Transparency = 1,
            Position = utility:Position(1, 0, 0, 0, textbox_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[placeholder_text] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        function textbox:get()
            return self.current
        end
        --
        function textbox:set(value, final)
            if value ~= "" then
                utility:UpdateTransparency(placeholder_text, 0)
                placeholder_text.Transparency = 0
            end

            self.current = value
            if final then
                task.spawn(callback, value)
            end
            text.Text = value
        end
        --
        function textbox:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        library.began[#library.began + 1] = function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and textbox_outline.Visible and window.isVisible and utility:MouseOverDrawing({
                section.section_frame.Position.X + 10,
                section.section_frame.Position.Y + textbox.axis,
                section.section_frame.Position.X + section.section_frame.Size.X - 10,
                section.section_frame.Position.Y + textbox.axis + 16
            }) then
                local inputcapture = utility:CreateInstance("TextBox", {
                    Parent = game.CoreGui,
                    ClearTextOnFocus = false
                })
                --
                inputcapture.FocusLost:Connect(function()
                    textbox:set(inputcapture.Text, true)
                    if textbox.current == "" then
                        utility:UpdateTransparency(placeholder_text, 0.25)
                        placeholder_text.Transparency = 0.25
                    end
                    inputcapture:Destroy()
                end)
                --
                inputcapture:GetPropertyChangedSignal("Text"):Connect(function()
                    textbox:set(inputcapture.Text, false)
                end)

                utility:UpdateTransparency(placeholder_text, 0)
                placeholder_text.Transparency = 0

                inputcapture.Text = resetonfocus and "" or textbox:get()
                inputcapture:CaptureFocus()
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = textbox
        end
        --
        section.currentAxis += textbox_outline.Size.Y + 4
        section:Update()
        --
        return textbox
    end
    --
    function sections:Toggle(info)
        local info = info or {}
        local name = info.name or info.Name or "New Toggle"
        local def = info.default or info.Default or false
        local pointer = info.pointer or info.Pointer or nil
        local callback = info.callback or info.Callback or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local toggle = {axis = section.currentAxis, current = def, addedAxis = 0, colorpickers = 0, keybind = nil}
        --
        local toggle_outline = utility:Create("Frame", {Vector2.new(4,toggle.axis), section.section_frame}, {
            Size = utility:Size(0, 15, 0, 15),
            Position = utility:Position(0, 4, 0, toggle.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_outline] = {
            Color = "outline"
        }
        --
        local toggle_inline = utility:Create("Frame", {Vector2.new(1,1), toggle_outline}, {
            Size = utility:Size(1, -2, 1, -2, toggle_outline),
            Position = utility:Position(0, 1, 0, 1, toggle_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_inline] = {
            Color = "inline"
        }
        --
        local toggle_frame = utility:Create("Frame", {Vector2.new(1,1), toggle_inline}, {
            Size = utility:Size(1, -2, 1, -2, toggle_inline),
            Position = utility:Position(0, 1, 0, 1, toggle_inline),
            Color = toggle.current == true and theme.accent or theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_frame] = {
            Color = toggle.current == true and "accent" or "lightcontrast"
        }
        --
        local toggle__gradient = utility:Create("Image", {Vector2.new(0,0), toggle_frame}, {
            Size = utility:Size(1, 0, 1, 0, toggle_frame),
            Position = utility:Position(0, 0, 0 , 0, toggle_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local toggle_title = utility:Create("TextLabel", {Vector2.new(23,toggle.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2)), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 23, 0, toggle.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2), section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        utility:LoadImage(toggle__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function toggle:get()
            return toggle.current
        end
        --
        function toggle:set(bool)
            if bool or not bool then
                toggle.current = bool
                toggle_frame.Color = toggle.current == true and theme.accent or theme.lightcontrast
                --
                library.colors[toggle_frame] = {
                    Color = toggle.current == true and "accent" or "lightcontrast"
                }
                --
                callback(toggle.current)
            end
        end
        --
        function toggle:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        library.colors[toggle_frame] = {
            Color = toggle.current == true and "accent" or "lightcontrast"
        }
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and toggle_outline.Visible and window.isVisible and page.open and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + toggle.axis, section.section_frame.Position.X + section.section_frame.Size.X - toggle.addedAxis, section.section_frame.Position.Y + toggle.axis + 15}) and not window:IsOverContent() then
                toggle.current = not toggle.current
                toggle_frame.Color = toggle.current == true and theme.accent or theme.lightcontrast
                --
                library.colors[toggle_frame] = {
                    Color = toggle.current == true and "accent" or "lightcontrast"
                }
                --
                callback(toggle.current)
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = toggle
        end
        --
        section.currentAxis = section.currentAxis + 15 + 4
        section:Update()
        --
        function toggle:Colorpicker(info)
            local info = info or {}
            local cpinfo = info.info or info.Info or name
            local def = info.def or info.Def or info.default or info.Default or Color3.fromRGB(255, 0, 0)
            local transp = info.transparency or info.Transparency or info.transp or info.Transp or info.alpha or info.Alpha or nil
            local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
            local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
            --
            local hh, ss, vv = def:ToHSV()
            local colorpicker = {toggle, axis = toggle.axis, index = toggle.colorpickers, current = {hh, ss, vv , (transp or 0)}, holding = {picker = false, huepicker = false, transparency = false}, holder = {inline = nil, picker = nil, picker_cursor = nil, huepicker = nil, huepicker_cursor = {}, transparency = nil, transparencybg = nil, transparency_cursor = {}, drawings = {}}}
            --
            local colorpicker_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(toggle.colorpickers == 0 and (30+4) or (64 + 4)),colorpicker.axis), section.section_frame}, {
                Size = utility:Size(0, 30, 0, 15),
                Position = utility:Position(1, -(toggle.colorpickers == 0 and (30+4) or (64 + 4)), 0, colorpicker.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker__transparency
            if transp then
                colorpicker__transparency = utility:Create("Image", {Vector2.new(1,1), colorpicker_inline}, {
                    Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                    Position = utility:Position(0, 1, 0 , 1, colorpicker_inline),
                    Visible = page.open
                }, section.visibleContent)
            end
            --
            local colorpicker_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_inline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_inline),
                Color = def,
                Transparency = transp and (1 - transp) or 1,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker__gradient = utility:Create("Image", {Vector2.new(0,0), colorpicker_frame}, {
                Size = utility:Size(1, 0, 1, 0, colorpicker_frame),
                Position = utility:Position(0, 0, 0 , 0, colorpicker_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            if transp then
                utility:LoadImage(colorpicker__transparency, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            utility:LoadImage(colorpicker__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
            --
            function colorpicker:Set(color, transp_val)
                if typeof(color) == "table" then
                    if color.Color and color.Transparency then
                        local h, s, v = table.unpack(color.Color)
                        colorpicker.current = {h, s, v , color.Transparency}
                        colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                        colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                        callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                    else
                        colorpicker.current = color
                        colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                        colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                        callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                    end
                elseif typeof(color) == "color3" then
                    local h, s, v = color:ToHSV()
                    colorpicker.current = {h, s, v, (transp_val or 0)}
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4]) 
                end
            end
            --
            function colorpicker:Refresh()
                local mouseLocation = utility:MouseLocation()
                if colorpicker.open and colorpicker.holder.picker and colorpicker.holding.picker then
                    colorpicker.current[2] = math.clamp(mouseLocation.X - colorpicker.holder.picker.Position.X, 0, colorpicker.holder.picker.Size.X) / colorpicker.holder.picker.Size.X
                    --
                    colorpicker.current[3] = 1-(math.clamp(mouseLocation.Y - colorpicker.holder.picker.Position.Y, 0, colorpicker.holder.picker.Size.Y) / colorpicker.holder.picker.Size.Y)
                    --
                    colorpicker.holder.picker_cursor.Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker.holder.picker)
                    --
                    utility:UpdateOffset(colorpicker.holder.picker_cursor, {Vector2.new((colorpicker.holder.picker.Size.X*colorpicker.current[2])-3,(colorpicker.holder.picker.Size.Y*(1-colorpicker.current[3]))-3), colorpicker.holder.picker})
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.huepicker and colorpicker.holding.huepicker then
                    colorpicker.current[1] = (math.clamp(mouseLocation.Y - colorpicker.holder.huepicker.Position.Y, 0, colorpicker.holder.huepicker.Size.Y) / colorpicker.holder.huepicker.Size.Y)
                    --
                    colorpicker.holder.huepicker_cursor[1].Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker.holder.huepicker)
                    colorpicker.holder.huepicker_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[1])
                    colorpicker.holder.huepicker_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[2])
                    colorpicker.holder.huepicker_cursor[3].Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    utility:UpdateOffset(colorpicker.holder.huepicker_cursor[1], {Vector2.new(-3,(colorpicker.holder.huepicker.Size.Y*colorpicker.current[1])-3), colorpicker.holder.huepicker})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    if colorpicker.holder.transparency_cursor and colorpicker.holder.transparency_cursor[3] then
                        colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    end
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.transparency and colorpicker.holding.transparency then
                    colorpicker.current[4] = 1 - (math.clamp(mouseLocation.X - colorpicker.holder.transparency.Position.X, 0, colorpicker.holder.transparency.Size.X) / colorpicker.holder.transparency.Size.X)
                    --
                    colorpicker.holder.transparency_cursor[1].Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker.holder.transparency)
                    colorpicker.holder.transparency_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[1])
                    colorpicker.holder.transparency_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[2])
                    colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    colorpicker_frame.Transparency = (1 - colorpicker.current[4])
                    --
                    utility:UpdateTransparency(colorpicker_frame, (1 - colorpicker.current[4]))
                    utility:UpdateOffset(colorpicker.holder.transparency_cursor[1], {Vector2.new((colorpicker.holder.transparency.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker.holder.transparency})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                end
                --
                colorpicker:Set(colorpicker.current)
            end
            --
            function colorpicker:Get()
                return {Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), Transparency = colorpicker.current[4]}
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and colorpicker_outline.Visible then
                    if colorpicker.open and colorpicker.holder.inline and utility:MouseOverDrawing({colorpicker.holder.inline.Position.X, colorpicker.holder.inline.Position.Y, colorpicker.holder.inline.Position.X + colorpicker.holder.inline.Size.X, colorpicker.holder.inline.Position.Y + colorpicker.holder.inline.Size.Y}) then
                        if colorpicker.holder.picker and utility:MouseOverDrawing({colorpicker.holder.picker.Position.X - 2, colorpicker.holder.picker.Position.Y - 2, colorpicker.holder.picker.Position.X - 2 + colorpicker.holder.picker.Size.X + 4, colorpicker.holder.picker.Position.Y - 2 + colorpicker.holder.picker.Size.Y + 4}) then
                            colorpicker.holding.picker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.huepicker and utility:MouseOverDrawing({colorpicker.holder.huepicker.Position.X - 2, colorpicker.holder.huepicker.Position.Y - 2, colorpicker.holder.huepicker.Position.X - 2 + colorpicker.holder.huepicker.Size.X + 4, colorpicker.holder.huepicker.Position.Y - 2 + colorpicker.holder.huepicker.Size.Y + 4}) then
                            colorpicker.holding.huepicker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.transparency and utility:MouseOverDrawing({colorpicker.holder.transparency.Position.X - 2, colorpicker.holder.transparency.Position.Y - 2, colorpicker.holder.transparency.Position.X - 2 + colorpicker.holder.transparency.Size.X + 4, colorpicker.holder.transparency.Position.Y - 2 + colorpicker.holder.transparency.Size.Y + 4}) then
                            colorpicker.holding.transparency = true
                            colorpicker:Refresh()
                        end
                    elseif utility:MouseOverDrawing({section.section_frame.Position.X + (section.section_frame.Size.X - (colorpicker.index == 0 and (30 + 4 + 2) or (64 + 4 + 2))), section.section_frame.Position.Y + colorpicker.axis, section.section_frame.Position.X + section.section_frame.Size.X - (colorpicker.index == 1 and 36 or 0), section.section_frame.Position.Y + colorpicker.axis + 15}) and not window:IsOverContent() then
                        if not colorpicker.open then
                            window:CloseContent()
                            colorpicker.open = not colorpicker.open
                            --
                            local colorpicker_open_outline = utility:Create("Frame", {Vector2.new(4,colorpicker.axis + 19), section.section_frame}, {
                                Size = utility:Size(1, -8, 0, transp and 219 or 200, section.section_frame),
                                Position = utility:Position(0, 4, 0, colorpicker.axis + 19, section.section_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.inline = colorpicker_open_outline
                            --
                            local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                                Color = theme.darkcontrast
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                                Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                                Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                                Color = theme.accent
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,2), colorpicker_open_frame}, {
                                Text = cpinfo,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, 4, 0, 2, colorpicker_open_frame),
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_picker_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_inline),
                                Color = Color3.fromHSV(colorpicker.current[1],1,1)
                            }, colorpicker.holder.drawings);colorpicker.holder.background = colorpicker_open_picker_bg
                            --
                            local colorpicker_open_picker_image = utility:Create("Image", {Vector2.new(0,0), colorpicker_open_picker_bg}, {
                                Size = utility:Size(1, 0, 1, 0, colorpicker_open_picker_bg),
                                Position = utility:Position(0, 0, 0 , 0, colorpicker_open_picker_bg),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker = colorpicker_open_picker_image
                            --
                            local colorpicker_open_picker_cursor = utility:Create("Image", {Vector2.new((colorpicker_open_picker_image.Size.X*colorpicker.current[2])-3,(colorpicker_open_picker_image.Size.Y*(1-colorpicker.current[3]))-3), colorpicker_open_picker_image}, {
                                Size = utility:Size(0, 6, 0, 6, colorpicker_open_picker_image),
                                Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker_open_picker_image),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker_cursor = colorpicker_open_picker_cursor
                            --
                            local colorpicker_open_huepicker_outline = utility:Create("Frame", {Vector2.new(colorpicker_open_frame.Size.X-19,17), colorpicker_open_frame}, {
                                Size = utility:Size(0, 15, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(1, -19, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_huepicker_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_huepicker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_inline),
                                Position = utility:Position(0, 1, 0 , 1, colorpicker_open_huepicker_inline),
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker = colorpicker_open_huepicker_image
                            --
                            local colorpicker_open_huepicker_cursor_outline = utility:Create("Frame", {Vector2.new(-3,(colorpicker_open_huepicker_image.Size.Y*colorpicker.current[1])-3), colorpicker_open_huepicker_image}, {
                                Size = utility:Size(1, 6, 0, 6, colorpicker_open_huepicker_image),
                                Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker_open_huepicker_image),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[1] = colorpicker_open_huepicker_cursor_outline
                            --
                            local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                            --
                            local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                            --
                            if transp then
                                local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.X-19), colorpicker_open_frame}, {
                                    Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                    Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings)
                                --
                                local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                    Color = theme.inline
                                }, colorpicker.holder.drawings)
                                --
                                local colorpicker_open_transparency_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_inline),
                                    Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                                }, colorpicker.holder.drawings);colorpicker.holder.transparencybg = colorpicker_open_transparency_bg
                                --
                                local colorpicker_open_transparency_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0 , 1, colorpicker_open_transparency_inline),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency = colorpicker_open_transparency_image
                                --
                                local colorpicker_open_transparency_cursor_outline = utility:Create("Frame", {Vector2.new((colorpicker_open_transparency_image.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker_open_transparency_image}, {
                                    Size = utility:Size(0, 6, 1, 6, colorpicker_open_transparency_image),
                                    Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker_open_transparency_image),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[1] = colorpicker_open_transparency_cursor_outline
                                --
                                local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                    Color = theme.textcolor
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                                --
                                local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                    Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                                --
                                utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
                                --utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/VcMAYjL.png")
                            end
                            --
                            utility:LoadImage(colorpicker_open_picker_image, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            utility:LoadImage(colorpicker_open_picker_cursor, "valsat_cursor", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                            utility:LoadImage(colorpicker_open_huepicker_image, "hue", "https://i.imgur.com/iEOsHFv.png")
                            --
                            window.currentContent.frame = colorpicker_open_inline
                            window.currentContent.colorpicker = colorpicker
                        else
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    else
                        if colorpicker.open then
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    end
                elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and colorpicker.open then
                    colorpicker.open = not colorpicker.open
                    --
                    for i,v in pairs(colorpicker.holder.drawings) do
                        utility:Remove(v)
                    end
                    --
                    colorpicker.holder.drawings = {}
                    colorpicker.holder.inline = nil
                    --
                    window.currentContent.frame = nil
                    window.currentContent.colorpicker = nil
                end
            end
            --
            library.ended[#library.ended + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if colorpicker.holding.picker then
                        colorpicker.holding.picker = not colorpicker.holding.picker
                    end
                    if colorpicker.holding.huepicker then
                        colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                    end
                    if colorpicker.holding.transparency then
                        colorpicker.holding.transparency = not colorpicker.holding.transparency
                    end
                end
            end
            --
            library.changed[#library.changed + 1] = function()
                if colorpicker.open and colorpicker.holding.picker or colorpicker.holding.huepicker or colorpicker.holding.transparency then
                    if window.isVisible then
                        colorpicker:Refresh()
                    else
                        if colorpicker.holding.picker then
                            colorpicker.holding.picker = not colorpicker.holding.picker
                        end
                        if colorpicker.holding.huepicker then
                            colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                        end
                        if colorpicker.holding.transparency then
                            colorpicker.holding.transparency = not colorpicker.holding.transparency
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = colorpicker
            end
            --
            toggle.addedAxis = toggle.addedAxis + 30 + 4 + 2
            toggle.colorpickers = toggle.colorpickers + 1
            section:Update()
            --
            return colorpicker, toggle
        end
        --
        function toggle:Keybind(info)
            local info = info or {}
            local def = info.default or info.Default or nil
            local pointer = info.pointer or info.Pointer or nil
            local mode = info.mode or info.Mode or "Always"
            local keybindname = info.keybind_name or info.KeybindName or nil
            local callback = info.callback or info.Callback or function()end
            --
            toggle.addedaxis = toggle.addedAxis + 40 + 4 + 2
            --
            local keybind = {keybindname = keybindname or name, axis = toggle.axis, current = {}, selecting = false, mode = mode, open = false, modemenu = {buttons = {}, drawings = {}}, active = false}
            --
            toggle.keybind = keybind
            --
            local allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","Zero","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock"}
            local allowedInputTypes = {"MouseButton1","MouseButton2","MouseButton3"}
            local shortenedInputs = {["MouseButton1"] = "MB1", ["MouseButton2"] = "MB2", ["MouseButton3"] = "MB3", ["Insert"] = "Ins", ["LeftAlt"] = "LAlt", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RAlt", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "Caps"}
            --
            local keybind_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(40+4),keybind.axis), section.section_frame}, {
                Size = utility:Size(0, 40, 0, 17),
                Position = utility:Position(1, -(40+4), 0, keybind.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_outline] = {
                Color = "outline"
            }
            --
            local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
                Size = utility:Size(1, -2, 1, -2, keybind_outline),
                Position = utility:Position(0, 1, 0, 1, keybind_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_inline] = {
                Color = "inline"
            }
            --
            local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
                Size = utility:Size(1, -2, 1, -2, keybind_inline),
                Position = utility:Position(0, 1, 0, 1, keybind_inline),
                Color = theme.lightcontrast,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_frame] = {
                Color = "lightcontrast"
            }
            --
            local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), keybind_frame}, {
                Size = utility:Size(1, 0, 1, 0, keybind_frame),
                Position = utility:Position(0, 0, 0 , 0, keybind_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X/2,1), keybind_outline}, {
                Text = "...",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder, 
                Center = true,
                Position = utility:Position(0.5, 0, 1, 0, keybind_outline),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_value] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            utility:LoadImage(keybind__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
            --
            function keybind:Shorten(string)
                for i,v in pairs(shortenedInputs) do
                    string = string.gsub(string, i, v)
                end
                return string
            end
            --
            function keybind:Change(input)
                input = input or "..."
                local inputTable = {}
                --
                if input.EnumType then
                    if input.EnumType == Enum.KeyCode or input.EnumType == Enum.UserInputType then
                        if table.find(allowedKeyCodes, input.Name) or table.find(allowedInputTypes, input.Name) then
                            inputTable = {input.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", input.Name}
                            --
                            keybind.current = inputTable
                            keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                            --
                            return true
                        end
                    end
                end
                --
                return false
            end
            --
            function keybind:get()
                return keybind.current
            end
            --
            function keybind:set(tbl)
                keybind.current = tbl.Key
                keybind.mode = tbl.Mode or "Always"
                keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."

                keybind.active = keybind.mode == "Always" and true or false
            end
            --
            function keybind:set_callback(p_callback)
                callback = p_callback
                callback(self:get())
            end
            --
            function keybind:is_active()
                return keybind.active
            end
            --
            function keybind:Reset()
                for i,v in pairs(keybind.modemenu.buttons) do
                    v.Color = v.Text == keybind.mode and theme.accent or theme.textcolor
                    --
                    library.colors[v] = {
                        Color = v.Text == keybind.mode and "accent" or "textcolor"
                    }
                end
                --
                keybind.active = keybind.mode == "Always" and true or false
                if keybind.current[1] and keybind.current[2] then
                    callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            --
            keybind:Change(def)
            --
            library.began[#library.began + 1] = function(Input)
                if keybind.current[1] and keybind.current[2] then
                    if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                        if keybind.mode == "Hold" then
                            local old = keybind.active
                            keybind.active = toggle:get()
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            if keybind.active ~= old then callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active) end
                        elseif keybind.mode == "Toggle" then
                            local old = keybind.active
                            keybind.active = not keybind.active == true and toggle:get() or false
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            if keybind.active ~= old then callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active) end
                        end
                    end
                end
                --
                if keybind.selecting and window.isVisible then
                    local done = keybind:Change(Input.KeyCode.Name ~= "Unknown" and Input.KeyCode or Input.UserInputType)
                    if done then
                        keybind.selecting = false
                        keybind.active = keybind.mode == "Always" and true or false
                        keybind_frame.Color = theme.lightcontrast
                        --
                        library.colors[keybind_frame] = {
                            Color = "lightcontrast"
                        }
                        --
                        window.keybindslist:Remove(keybindname or name)
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
                --
                if not window.isVisible and keybind.selecting then
                    keybind.selecting = false
                    keybind_frame.Color = theme.lightcontrast
                    --
                    library.colors[keybind_frame] = {
                        Color = "lightcontrast"
                    }
                end
                --
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and keybind_outline.Visible then
                    if utility:MouseOverDrawing({section.section_frame.Position.X + (section.section_frame.Size.X - (40+4+2)), section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                        keybind.selecting = true
                        keybind_frame.Color = theme.darkcontrast
                        --
                        library.colors[keybind_frame] = {
                            Color = "darkcontrast"
                        }
                    end
                    if keybind.open and keybind.modemenu.frame then
                        if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y, keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                            local changed = false
                            --
                            for i,v in pairs(keybind.modemenu.buttons) do
                                if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)), keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)) + 15}) then
                                    keybind.mode = v.Text
                                    changed = true
                                end
                            end
                            --
                            if changed then keybind:Reset() end
                        else
                            keybind.open = not keybind.open
                            --
                            for i,v in pairs(keybind.modemenu.drawings) do
                                utility:Remove(v)
                            end
                            --
                            keybind.modemenu.drawings = {}
                            keybind.modemenu.buttons = {}
                            keybind.modemenu.frame = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.keybind = nil
                        end
                    end
                end
                --
                if Input.UserInputType == Enum.UserInputType.MouseButton2 and window.isVisible and keybind_outline.Visible then
                    if utility:MouseOverDrawing({section.section_frame.Position.X  + (section.section_frame.Size.X - (40+4+2)), section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                        window:CloseContent()
                        keybind.open = not keybind.open
                        --
                        local modemenu = utility:Create("Frame", {Vector2.new(keybind_outline.Size.X + 2,0), keybind_outline}, {
                            Size = utility:Size(0, 64, 0, 49),
                            Position = utility:Position(1, 2, 0, 0, keybind_outline),
                            Color = theme.outline,
                            Visible = page.open
                        }, keybind.modemenu.drawings);keybind.modemenu.frame = modemenu
                        --
                        library.colors[modemenu] = {
                            Color = "outline"
                        }
                        --
                        local modemenu_inline = utility:Create("Frame", {Vector2.new(1,1), modemenu}, {
                            Size = utility:Size(1, -2, 1, -2, modemenu),
                            Position = utility:Position(0, 1, 0, 1, modemenu),
                            Color = theme.inline,
                            Visible = page.open
                        }, keybind.modemenu.drawings)
                        --
                        library.colors[modemenu_inline] = {
                            Color = "inline"
                        }
                        --
                        local modemenu_frame = utility:Create("Frame", {Vector2.new(1,1), modemenu_inline}, {
                            Size = utility:Size(1, -2, 1, -2, modemenu_inline),
                            Position = utility:Position(0, 1, 0, 1, modemenu_inline),
                            Color = theme.lightcontrast,
                            Visible = page.open
                        }, keybind.modemenu.drawings)
                        --
                        library.colors[modemenu_frame] = {
                            Color = "lightcontrast"
                        }
                        --
                        local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), modemenu_frame}, {
                            Size = utility:Size(1, 0, 1, 0, modemenu_frame),
                            Position = utility:Position(0, 0, 0 , 0, modemenu_frame),
                            Transparency = 0.5,
                            Visible = page.open
                        }, keybind.modemenu.drawings)
                        --
                        utility:LoadImage(keybind__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
                        --
                        for i,v in pairs({"Always", "Toggle", "Hold"}) do
                            local button_title = utility:Create("TextLabel", {Vector2.new(modemenu_frame.Size.X/2,15 * (i-1)), modemenu_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = v == keybind.mode and theme.accent or theme.textcolor,
                                Center = true,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0.5, 0, 0, 15 * (i-1), modemenu_frame),
                                Visible = page.open
                            }, keybind.modemenu.drawings);keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = button_title
                            --
                            library.colors[button_title] = {
                                OutlineColor = "textborder",
                                Color = v == keybind.mode and "accent" or "textcolor"
                            }
                        end
                        --
                        window.currentContent.frame = modemenu
                        window.currentContent.keybind = keybind
                    end
                end
            end
            --
            library.ended[#library.ended + 1] = function(Input)
                if keybind.active and keybind.mode == "Hold" then
                    if keybind.current[1] and keybind.current[2] then
                        if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                            keybind.active = false
                            window.keybindslist:Remove(keybindname or name)
                            callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = keybind
            end
            --
            keybind.active = keybind.mode == "Always" and true or false
            --
            toggle.addedAxis = 40+4+2
            section:Update()
            --
            return keybind
        end
        --
        return toggle
    end
    --
    function sections:Slider(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Slider"
        local def = info.def or info.Def or info.default or info.Default or 10
        local min = info.min or info.Min or info.minimum or info.Minimum or 0
        local max = info.max or info.Max or info.maximum or info.Maximum or 100
        local sub = info.suffix or info.Suffix or info.ending or info.Ending or info.prefix or info.Prefix or info.measurement or info.Measurement or ""
        local decimals = info.decimals or info.Decimals or 1
        decimals = 1 / decimals
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        def = math.clamp(def, min, max)
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local slider = {min = min, max = max, sub = sub, decimals = decimals, axis = section.currentAxis, current = def, holding = false}
        --
        local slider_title = utility:Create("TextLabel", {Vector2.new(4,slider.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, slider.axis, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local slider_outline = utility:Create("Frame", {Vector2.new(4,slider.axis + 15), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 12, section.section_frame),
            Position = utility:Position(0, 4, 0, slider.axis + 15, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_outline] = {
            Color = "outline"
        }
        --
        local slider_inline = utility:Create("Frame", {Vector2.new(1,1), slider_outline}, {
            Size = utility:Size(1, -2, 1, -2, slider_outline),
            Position = utility:Position(0, 1, 0, 1, slider_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_inline] = {
            Color = "inline"
        }
        --
        local slider_frame = utility:Create("Frame", {Vector2.new(1,1), slider_inline}, {
            Size = utility:Size(1, -2, 1, -2, slider_inline),
            Position = utility:Position(0, 1, 0, 1, slider_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_frame] = {
            Color = "lightcontrast"
        }
        --
        local slider_slide = utility:Create("Frame", {Vector2.new(1,1), slider_inline}, {
            Size = utility:Size(0, (slider_frame.Size.X / (slider.max - slider.min) * (slider.current - slider.min)), 1, -2, slider_inline),
            Position = utility:Position(0, 1, 0, 1, slider_inline),
            Color = theme.accent,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_slide] = {
            Color = "accent"
        }
        --
        local slider__gradient = utility:Create("Image", {Vector2.new(0,0), slider_frame}, {
            Size = utility:Size(1, 0, 1, 0, slider_frame),
            Position = utility:Position(0, 0, 0 , 0, slider_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local textBounds = utility:GetTextBounds(name, theme.textsize, theme.font)
        local slider_value = utility:Create("TextLabel", {Vector2.new(slider_outline.Size.X/2,(slider_outline.Size.Y/2) - (textBounds.Y/2)), slider_outline}, {
            Text = slider.current..slider.sub.."/"..slider.max..slider.sub,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            Center = true,
            OutlineColor = theme.textborder,
            Position = utility:Position(0.5, 0, 0, (slider_outline.Size.Y/2) - (textBounds.Y/2), slider_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        utility:LoadImage(slider__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function slider:set(value)
            slider.current = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
            local percent = 1 - ((slider.max - slider.current) / (slider.max - slider.min))
            slider_value.Text = slider.current..slider.sub.."/"..slider.max..slider.sub
            slider_slide.Size = utility:Size(0, percent * slider_frame.Size.X, 1, -2, slider_inline)
            callback(slider.current)
        end
        --
        function slider:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function slider:Refresh()
            local mouseLocation = utility:MouseLocation()
            local percent = math.clamp(mouseLocation.X - slider_slide.Position.X, 0, slider_frame.Size.X) / slider_frame.Size.X
            local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
            value = math.clamp(value, slider.min, slider.max)
            slider:set(value)
        end
        --
        function slider:get()
            return slider.current
        end
        --
        slider:set(slider.current)
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and slider_outline.Visible and window.isVisible and page.open and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + slider.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + slider.axis + 27}) and not window:IsOverContent() then
                slider.holding = true
                slider:Refresh()
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and slider.holding and window.isVisible then
                slider.holding = false
            end
        end
        --
        library.changed[#library.changed + 1] = function(Input)
            if slider.holding and window.isVisible then
                slider:Refresh()
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = slider
        end
        --
        section.currentAxis = section.currentAxis + 27 + 4
        section:Update()
        --
        return slider
    end
    --
    function sections:Button(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Button"
        local confirmation = info.confirmation or info.Confirmation or false
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local button = {axis = section.currentAxis, pressed = false}
        --
        local button_outline = utility:Create("Frame", {Vector2.new(4,button.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, button.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_outline] = {
            Color = "outline"
        }
        --
        local button_inline = utility:Create("Frame", {Vector2.new(1,1), button_outline}, {
            Size = utility:Size(1, -2, 1, -2, button_outline),
            Position = utility:Position(0, 1, 0, 1, button_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_inline] = {
            Color = "inline"
        }
        --
        local button_frame = utility:Create("Frame", {Vector2.new(1,1), button_inline}, {
            Size = utility:Size(1, -2, 1, -2, button_inline),
            Position = utility:Position(0, 1, 0, 1, button_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_frame] = {
            Color = "lightcontrast"
        }
        --
        local button_gradient = utility:Create("Image", {Vector2.new(0,0), button_frame}, {
            Size = utility:Size(1, 0, 1, 0, button_frame),
            Position = utility:Position(0, 0, 0 , 0, button_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local button_title = utility:Create("TextLabel", {Vector2.new(button_frame.Size.X/2,1), button_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Center = true,
            Position = utility:Position(0.5, 0, 0, 1, button_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        function button:get()
            return nil
        end
        --
        function button:set_callback(p_callback)
            callback = p_callback
        end
        --
        utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and button_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + button.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + button.axis + 20}) and not window:IsOverContent() then
                if confirmation then
                    if button.confirmable then
                        button.confirmable = false
                        button_title.Text = name
                        button_title.Color = theme.textcolor
                        --
                        callback()
                    else
                        button.confirmable = true
                        button_title.Text = "Confirm? [3]"
                        button_title.Color = theme.accent

                        task.spawn(function()
                            for i = 2, 0, -1 do
                                task.wait(1)
                                --
                                if not button.confirmable then
                                    return
                                end
                                if button_title.__OBJECT_EXISTS then
                                    button_title.Text = ("Confirm? [%s]"):format(i)
                                end
                            end
                            --
                            if button_title.__OBJECT_EXISTS then
                                button.confirmable = false
                                --
                                button_title.Text = name
                                button_title.Color = theme.textcolor
                            end
                        end)
                    end
                else
                    callback()
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = button
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
        section:Update()
        --
        return button
    end
    --
    function sections:ButtonHolder(info)
        local info = info or {}
        local buttons = info.buttons or info.Buttons or {}
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local buttonHolder = {buttons = {}}
        --
        for i=1, 2 do
            local button = {axis = section.currentAxis}
            --
            local button_outline = utility:Create("Frame", {Vector2.new(i == 2 and ((section.section_frame.Size.X / 2) + 2) or 4,button.axis), section.section_frame}, {
                Size = utility:Size(0.5, -6, 0, 20, section.section_frame),
                Position = utility:Position(0, i == 2 and 2 or 4, 0, button.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_outline] = {
                Color = "outline"
            }
            --
            local button_inline = utility:Create("Frame", {Vector2.new(1,1), button_outline}, {
                Size = utility:Size(1, -2, 1, -2, button_outline),
                Position = utility:Position(0, 1, 0, 1, button_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_inline] = {
                Color = "inline"
            }
            --
            local button_frame = utility:Create("Frame", {Vector2.new(1,1), button_inline}, {
                Size = utility:Size(1, -2, 1, -2, button_inline),
                Position = utility:Position(0, 1, 0, 1, button_inline),
                Color = theme.lightcontrast,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_frame] = {
                Color = "lightcontrast"
            }
            --
            local button_gradient = utility:Create("Image", {Vector2.new(0,0), button_frame}, {
                Size = utility:Size(1, 0, 1, 0, button_frame),
                Position = utility:Position(0, 0, 0 , 0, button_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            local button_title = utility:Create("TextLabel", {Vector2.new(button_frame.Size.X/2,1), button_frame}, {
                Text = buttons[i][1],
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 1, button_frame),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and button_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X + (i == 2 and (section.section_frame.Size.X/2) or 0), section.section_frame.Position.Y + button.axis, section.section_frame.Position.X + section.section_frame.Size.X - (i == 1 and (section.section_frame.Size.X/2) or 0), section.section_frame.Position.Y + button.axis + 20}) and not window:IsOverContent() then
                    buttons[i][2]()
                end
            end
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
        section:Update()
    end
    --
    function sections:Dropdown(info)
        local info = info or {}
        local name = info.name or info.Name or "New Dropdown"
        local options = info.options or info.Options or {"1", "2", "3"}
        local def = info.default or info.Default or options[1]
        local pointer = info.pointer or info.Pointer or nil
        local callback = info.callback or info.Callback or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local dropdown = {open = false, current = tostring(def), holder = {buttons = {}, drawings = {}}, axis = section.currentAxis}
        --
        local dropdown_outline = utility:Create("Frame", {Vector2.new(4,dropdown.axis + 15), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, dropdown.axis + 15, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_outline] = {
            Color = "outline"
        }
        --
        local dropdown_inline = utility:Create("Frame", {Vector2.new(1,1), dropdown_outline}, {
            Size = utility:Size(1, -2, 1, -2, dropdown_outline),
            Position = utility:Position(0, 1, 0, 1, dropdown_outline),
            Color = theme.inline,
            Visible = page.open,
        }, section.visibleContent)
        --
        library.colors[dropdown_inline] = {
            Color = "inline"
        }
        --
        local dropdown_frame = utility:Create("Frame", {Vector2.new(1,1), dropdown_inline}, {
            Size = utility:Size(1, -2, 1, -2, dropdown_inline),
            Position = utility:Position(0, 1, 0, 1, dropdown_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_frame] = {
            Color = "lightcontrast"
        }
        --
        local dropdown_title = utility:Create("TextLabel", {Vector2.new(4,dropdown.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, dropdown.axis, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local dropdown__gradient = utility:Create("Image", {Vector2.new(0,0), dropdown_frame}, {
            Size = utility:Size(1, 0, 1, 0, dropdown_frame),
            Position = utility:Position(0, 0, 0 , 0, dropdown_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local dropdown_value = utility:Create("TextLabel", {Vector2.new(3,dropdown_frame.Size.Y/2 - 7), dropdown_frame}, {
            Text = dropdown.current,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, (dropdown_frame.Size.Y/2) - 7, dropdown_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local dropdown_image = utility:Create("Image", {Vector2.new(dropdown_frame.Size.X - 15,dropdown_frame.Size.Y/2 - 3), dropdown_frame}, {
            Size = utility:Size(0, 9, 0, 6, dropdown_frame),
            Position = utility:Position(1, -15, 0.5, -3, dropdown_frame),
            Visible = page.open
        }, section.visibleContent);dropdown["dropdown_image"] = dropdown_image
        --
        utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        utility:LoadImage(dropdown__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function dropdown:Update()
            if dropdown.open and dropdown.holder.inline then
                for i,v in pairs(dropdown.holder.buttons) do
                    v[1].Color = v[1].Text == tostring(dropdown.current) and theme.accent or theme.textcolor
                    v[1].Position = utility:Position(0, v[1].Text == tostring(dropdown.current) and 8 or 6, 0, 2, v[2])
                    library.colors[v[1]] = {
                        Color = v[1].Text == tostring(dropdown.current) and "accent" or "textcolor"
                    }
                    utility:UpdateOffset(v[1], {Vector2.new(v[1].Text == tostring(dropdown.current) and 8 or 6, 2), v[2]})
                end
            end
        end
        --
        function dropdown:set(value)
            if typeof(value) == "string" and table.find(options, value) then
                dropdown.current = value
                dropdown_value.Text = value
                task.spawn(callback, dropdown.current)
            end
        end
        --
        function dropdown:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function dropdown:get()
            return dropdown.current
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and dropdown_outline.Visible then
                if dropdown.open and dropdown.holder.inline and utility:MouseOverDrawing({dropdown.holder.inline.Position.X, dropdown.holder.inline.Position.Y, dropdown.holder.inline.Position.X + dropdown.holder.inline.Size.X, dropdown.holder.inline.Position.Y + dropdown.holder.inline.Size.Y}) then
                    for i,v in pairs(dropdown.holder.buttons) do
                        if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and v[1].Text ~= dropdown.current then
                            dropdown.current = v[1].Text
                            dropdown_value.Text = dropdown.current
                            dropdown:Update()
                            task.spawn(callback, dropdown.current)
                        end
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + dropdown.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + dropdown.axis + 15 +  20}) and not window:IsOverContent() then
                    if not dropdown.open then
                        window:CloseContent()
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        --
                        local dropdown_open_outline = utility:Create("Frame", {Vector2.new(0,19), dropdown_outline}, {
                            Size = utility:Size(1, 0, 0, 3 + (#options * 19), dropdown_outline),
                            Position = utility:Position(0, 0, 0, 19, dropdown_outline),
                            Color = theme.outline,
                            Visible = page.open,
                            ZIndex = 1306
                        }, dropdown.holder.drawings);dropdown.holder.outline = dropdown_open_outline
                        --
                        library.colors[dropdown_open_outline] = {
                            Color = "outline"
                        }
                        --
                        local dropdown_open_inline = utility:Create("Frame", {Vector2.new(1,1), dropdown_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, dropdown_open_outline),
                            Position = utility:Position(0, 1, 0, 1, dropdown_open_outline),
                            Color = theme.inline,
                            Visible = page.open,
                            ZIndex = 1307
                        }, dropdown.holder.drawings);dropdown.holder.inline = dropdown_open_inline
                        --
                        library.colors[dropdown_open_inline] = {
                            Color = "inline"
                        }
                        --
                        for i,v in pairs(options) do
                            local dropdown_value_frame = utility:Create("Frame", {Vector2.new(1,1 + (19 * (i-1))), dropdown_open_inline}, {
                                Size = utility:Size(1, -2, 0, 18, dropdown_open_inline),
                                Position = utility:Position(0, 1, 0, 1 + (19 * (i-1)), dropdown_open_inline),
                                Color = theme.lightcontrast,
                                Visible = page.open,
                                ZIndex = 1308
                            }, dropdown.holder.drawings)
                            --
                            library.colors[dropdown_value_frame] = {
                                Color = "lightcontrast"
                            }
                            --
                            local dropdown_value = utility:Create("TextLabel", {Vector2.new(v == tostring(dropdown.current) and 8 or 6,2), dropdown_value_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = v == tostring(dropdown.current) and theme.accent or theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, v == tostring(dropdown.current) and 8 or 6, 0, 2, dropdown_value_frame),
                                Visible = page.open,
                                ZIndex = 1309
                            }, dropdown.holder.drawings);dropdown.holder.buttons[#dropdown.holder.buttons + 1] = {dropdown_value, dropdown_value_frame}
                            --
                            library.colors[dropdown_value] = {
                                OutlineColor = "textborder",
                                Color = v == tostring(dropdown.current) and "accent" or "textcolor"
                            }
                        end
                        --
                        window.currentContent.frame = dropdown_open_inline
                        window.currentContent.dropdown = dropdown
                    else
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(dropdown.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        dropdown.holder.drawings = {}
                        dropdown.holder.buttons = {}
                        dropdown.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.dropdown = nil
                    end
                else
                    if dropdown.open then
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(dropdown.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        dropdown.holder.drawings = {}
                        dropdown.holder.buttons = {}
                        dropdown.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.dropdown = nil
                    end
                end
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and dropdown.open then
                dropdown.open = not dropdown.open
                utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(dropdown.holder.drawings) do
                    utility:Remove(v)
                end
                --
                dropdown.holder.drawings = {}
                dropdown.holder.buttons = {}
                dropdown.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.dropdown = nil
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = dropdown
        end
        --
        section.currentAxis = section.currentAxis + 35 + 4
        section:Update()
        --
        return dropdown
    end
    --
    function sections:Multibox(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Multibox"
        local options = info.options or info.Options or {"1", "2", "3"}
        local def = info.def or info.Def or info.default or info.Default or {options[1]}
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        local min = info.min or info.Min or info.minimum or info.Minimum or 0
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local multibox = {open = false, current = def, holder = {buttons = {}, drawings = {}}, axis = section.currentAxis}
        --
        local multibox_outline = utility:Create("Frame", {Vector2.new(4,multibox.axis + 15), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, multibox.axis + 15, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_outline] = {
            Color = "outline"
        }
        --
        local multibox_inline = utility:Create("Frame", {Vector2.new(1,1), multibox_outline}, {
            Size = utility:Size(1, -2, 1, -2, multibox_outline),
            Position = utility:Position(0, 1, 0, 1, multibox_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_inline] = {
            Color = "inline"
        }
        --
        local multibox_frame = utility:Create("Frame", {Vector2.new(1,1), multibox_inline}, {
            Size = utility:Size(1, -2, 1, -2, multibox_inline),
            Position = utility:Position(0, 1, 0, 1, multibox_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_frame] = {
            Color = "lightcontrast"
        }
        --
        local multibox_title = utility:Create("TextLabel", {Vector2.new(4,multibox.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, multibox.axis, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local multibox__gradient = utility:Create("Image", {Vector2.new(0,0), multibox_frame}, {
            Size = utility:Size(1, 0, 1, 0, multibox_frame),
            Position = utility:Position(0, 0, 0 , 0, multibox_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local multibox_value = utility:Create("TextLabel", {Vector2.new(3,multibox_frame.Size.Y/2 - 7), multibox_frame}, {
            Text = "",
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, (multibox_frame.Size.Y/2) - 7, multibox_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local multibox_image = utility:Create("Image", {Vector2.new(multibox_frame.Size.X - 15,multibox_frame.Size.Y/2 - 3), multibox_frame}, {
            Size = utility:Size(0, 9, 0, 6, multibox_frame),
            Position = utility:Position(1, -15, 0.5, -3, multibox_frame),
            Visible = page.open
        }, section.visibleContent);multibox["multibox_image"] = multibox_image
        --
        utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        utility:LoadImage(multibox__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function multibox:Update()
            if multibox.open and multibox.holder.inline then
                for i,v in pairs(multibox.holder.buttons) do
                    v[1].Color = table.find(multibox.current, v[1].Text) and theme.accent or theme.textcolor
                    v[1].Position = utility:Position(0, table.find(multibox.current, v[1].Text) and 8 or 6, 0, 2, v[2])
                    --
                    library.colors[v[1]] = {
                        Color = table.find(multibox.current, v[1].Text) and "accent" or "textcolor"
                    }
                    --
                    utility:UpdateOffset(v[1], {Vector2.new(table.find(multibox.current, v[1].Text) and 8 or 6, 2), v[2]})
                end
            end
        end
        --
        function multibox:Serialize(tbl)
            local str = ""
            --
            for i,v in pairs(tbl) do
                str = str..v..", "
            end
            --
            return string.sub(str, 0, #str - 2)
        end
        --
        function multibox:Resort(tbl,original)
            local newtbl = {}
            --
            for i,v in pairs(original) do
                if table.find(tbl, v) then
                    newtbl[#newtbl + 1] = v
                end
            end
            --
            return newtbl
        end
        --
        function multibox:set(tbl)
            if typeof(tbl) == "table" then
                multibox.current = tbl
                multibox_value.Text =  utility:WrapText(multibox:Serialize(multibox:Resort(multibox.current, options)), multibox_frame.Size.X - 23)
            end
        end
        --
        function multibox:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function multibox:get()
            return multibox.current
        end
        --
        multibox_value.Text = multibox:Serialize(multibox:Resort(multibox.current, options))
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and multibox_outline.Visible then
                if multibox.open and multibox.holder.inline and utility:MouseOverDrawing({multibox.holder.inline.Position.X, multibox.holder.inline.Position.Y, multibox.holder.inline.Position.X + multibox.holder.inline.Size.X, multibox.holder.inline.Position.Y + multibox.holder.inline.Size.Y}) then
                    for i,v in pairs(multibox.holder.buttons) do
                        if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and v[1].Text ~= multibox.current then
                            if not table.find(multibox.current, v[1].Text) then
                                multibox.current[#multibox.current + 1] = v[1].Text
                                multibox_value.Text = multibox:Serialize(multibox:Resort(multibox.current, options))
                                multibox:Update()
                            else
                                if #multibox.current > min then
                                    table.remove(multibox.current, table.find(multibox.current, v[1].Text))
                                    multibox_value.Text = multibox:Serialize(multibox:Resort(multibox.current, options))
                                    multibox:Update()
                                end
                            end
                        end
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + multibox.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + multibox.axis + 15 +  20}) and not window:IsOverContent() then
                    if not multibox.open then
                        window:CloseContent()
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        --
                        local multibox_open_outline = utility:Create("Frame", {Vector2.new(0,19), multibox_outline}, {
                            Size = utility:Size(1, 0, 0, 3 + (#options * 19), multibox_outline),
                            Position = utility:Position(0, 0, 0, 19, multibox_outline),
                            Color = theme.outline,
                            Visible = page.open
                        }, multibox.holder.drawings);multibox.holder.outline = multibox_open_outline
                        --
                        library.colors[multibox_open_outline] = {
                            Color = "outline"
                        }
                        --
                        local multibox_open_inline = utility:Create("Frame", {Vector2.new(1,1), multibox_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, multibox_open_outline),
                            Position = utility:Position(0, 1, 0, 1, multibox_open_outline),
                            Color = theme.inline,
                            Visible = page.open
                        }, multibox.holder.drawings);multibox.holder.inline = multibox_open_inline
                        --
                        library.colors[multibox_open_inline] = {
                            Color = "inline"
                        }
                        --
                        for i,v in pairs(options) do
                            local multibox_value_frame = utility:Create("Frame", {Vector2.new(1,1 + (19 * (i-1))), multibox_open_inline}, {
                                Size = utility:Size(1, -2, 0, 18, multibox_open_inline),
                                Position = utility:Position(0, 1, 0, 1 + (19 * (i-1)), multibox_open_inline),
                                Color = theme.lightcontrast,
                                Visible = page.open
                            }, multibox.holder.drawings)
                            --
                            library.colors[multibox_value_frame] = {
                                Color = "lightcontrast"
                            }
                            --[[
                            local multibox_value_gradient = utility:Create("Image", {Vector2.new(0,0), multibox_value_frame}, {
                                Size = utility:Size(1, 0, 1, 0, multibox_value_frame),
                                Position = utility:Position(0, 0, 0 , 0, multibox_value_frame),
                                Transparency = 0.5,
                                Visible = page.open
                            }, multibox.holder.drawings)
                            --
                            utility:LoadImage(multibox_value_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")]]
                            --
                            local multibox_value = utility:Create("TextLabel", {Vector2.new(table.find(multibox.current, v) and 8 or 6,2), multibox_value_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = table.find(multibox.current, v) and theme.accent or theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, table.find(multibox.current, v) and 8 or 6, 0, 2, multibox_value_frame),
                                Visible = page.open
                            }, multibox.holder.drawings);multibox.holder.buttons[#multibox.holder.buttons + 1] = {multibox_value, multibox_value_frame}
                            --
                            library.colors[multibox_value] = {
                                OutlineColor = "textborder",
                                Color = table.find(multibox.current, v) and "accent" or "textcolor"
                            }
                        end
                        --
                        window.currentContent.frame = multibox_open_inline
                        window.currentContent.multibox = multibox
                    else
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(multibox.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        multibox.holder.drawings = {}
                        multibox.holder.buttons = {}
                        multibox.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.multibox = nil
                    end
                else
                    if multibox.open then
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(multibox.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        multibox.holder.drawings = {}
                        multibox.holder.buttons = {}
                        multibox.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.multibox = nil
                    end
                end
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and multibox.open then
                multibox.open = not multibox.open
                utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(multibox.holder.drawings) do
                    utility:Remove(v)
                end
                --
                multibox.holder.drawings = {}
                multibox.holder.buttons = {}
                multibox.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.multibox = nil
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = multibox
        end
        --
        section.currentAxis = section.currentAxis + 35 + 4
        section:Update()
        --
        return multibox
    end
    --
    function sections:Keybind(info)
        local info = info or {}
        local name = info.name or info.Name or "New Keybind"
        local def = info.default or info.Default or nil
        local pointer = info.pointer or info.Pointer or nil
        local mode = info.mode or info.Mode or "Always"
        local keybindname = info.keybind_name or info.KeybindName or nil
        local callback = info.callback or info.Callback or function() end
        local changed = info.changed or info.Changed or function() end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local keybind = {keybindname = keybindname or name, axis = section.currentAxis, current = {}, selecting = false, mode = mode, open = false, modemenu = {buttons = {}, drawings = {}}, active = false}
        --
        local allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","Zero","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock"}
        local allowedInputTypes = {"MouseButton1","MouseButton2","MouseButton3"}
        local shortenedInputs = {["MouseButton1"] = "MB1", ["MouseButton2"] = "MB2", ["MouseButton3"] = "MB3", ["Insert"] = "Ins", ["LeftAlt"] = "LAlt", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RAlt", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "Caps"}
        --
        local keybind_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(40+4),keybind.axis), section.section_frame}, {
            Size = utility:Size(0, 40, 0, 17),
            Position = utility:Position(1, -(40+4), 0, keybind.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_outline] = {
            Color = "outline"
        }
        --
        local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
            Size = utility:Size(1, -2, 1, -2, keybind_outline),
            Position = utility:Position(0, 1, 0, 1, keybind_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_inline] = {
            Color = "inline"
        }
        --
        local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
            Size = utility:Size(1, -2, 1, -2, keybind_inline),
            Position = utility:Position(0, 1, 0, 1, keybind_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_frame] = {
            Color = "lightcontrast"
        }
        --
        local keybind_title = utility:Create("TextLabel", {Vector2.new(4,keybind.axis + (17/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2)), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, keybind.axis + (17/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2), section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), keybind_frame}, {
            Size = utility:Size(1, 0, 1, 0, keybind_frame),
            Position = utility:Position(0, 0, 0 , 0, keybind_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X/2,1), keybind_outline}, {
            Text = "[None]",
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder, 
            Center = true,
            Position = utility:Position(0.5, 0, 1, 0, keybind_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        utility:LoadImage(keybind__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function keybind:Shorten(string)
            for i,v in pairs(shortenedInputs) do
                string = string.gsub(string, i, v)
            end
            return string
        end
        --
        function keybind:Change(input)
            local inputTable = {}
            
            if not input or input.Name == "Backspace" then
                keybind.current = {}
                keybind_value.Text = "None"
                changed(keybind.current)
                return true
            end

            if input.EnumType then
                if input.EnumType == Enum.KeyCode or input.EnumType == Enum.UserInputType then
                    if table.find(allowedKeyCodes, input.Name) or table.find(allowedInputTypes, input.Name) then
                        inputTable = {input.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", input.Name}
                        --
                        keybind.current = inputTable
                        keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                        --
                        changed(keybind.current)
                        return true
                    end
                end
            end
            --
            return false
        end
        --
        function keybind:get()
            return keybind.current
        end
        --
        function keybind:set(tbl)
            keybind.current = tbl.Key
            keybind.mode = tbl.Mode or "Always"
            keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."

            keybind.active = keybind.mode == "Always" and true or false
        end
        --
        function keybind:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function keybind:is_active()
            return keybind.active
        end
        --
        function keybind:Reset()
            for i,v in pairs(keybind.modemenu.buttons) do
                v.Color = v.Text == keybind.mode and theme.accent or theme.textcolor
                --
                library.colors[v] = {
                    Color = v.Text == keybind.mode and "accent" or "textcolor"
                }
            end
            --
            keybind.active = keybind.mode == "Always" and true or false
            if keybind.current[1] and keybind.current[2] then
                callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
            end
        end
        --
        keybind:Change(def)
        --
        library.began[#library.began + 1] = function(Input)
            if keybind.current[1] and keybind.current[2] then
                if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                    if keybind.mode == "Hold" then
                        keybind.active = true
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    elseif keybind.mode == "Toggle" then
                        keybind.active = not keybind.active
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end

            if keybind.selecting and window.isVisible then
                local done = keybind:Change(Input.KeyCode.Name ~= "Unknown" and Input.KeyCode or Input.UserInputType)
                if done then
                    keybind.selecting = false
                    keybind.active = keybind.mode == "Always" and true or false
                    keybind_frame.Color = theme.lightcontrast
                    --
                    library.colors[keybind_frame] = {
                        Color = "lightcontrast"
                    }
                    --
                    window.keybindslist:Remove(keybindname or name)
                    --
                    callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            --
            if not window.isVisible and keybind.selecting then
                keybind.selecting = false
                keybind_frame.Color = theme.lightcontrast
                --
                library.colors[keybind_frame] = {
                    Color = "lightcontrast"
                }
            end
            --
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and keybind_outline.Visible then
                if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                    keybind.selecting = true
                    keybind_frame.Color = theme.darkcontrast
                    --
                    library.colors[keybind_frame] = {
                        Color = "darkcontrast"
                    }
                end
                if keybind.open and keybind.modemenu.frame then
                    if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y, keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                        local changed = false
                        --
                        for i,v in pairs(keybind.modemenu.buttons) do
                            if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)), keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)) + 15}) then
                                keybind.mode = v.Text
                                changed = true
                            end
                        end
                        --
                        if changed then keybind:Reset() end
                    else
                        keybind.open = not keybind.open
                        --
                        for i,v in pairs(keybind.modemenu.drawings) do
                            utility:Remove(v)
                        end
                        --
                        keybind.modemenu.drawings = {}
                        keybind.modemenu.buttons = {}
                        keybind.modemenu.frame = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.keybind = nil
                    end
                end
            end
            --
            if Input.UserInputType == Enum.UserInputType.MouseButton2 and window.isVisible and keybind_outline.Visible then
                if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                    window:CloseContent()
                    keybind.open = not keybind.open
                    --
                    local modemenu = utility:Create("Frame", {Vector2.new(keybind_outline.Size.X + 2,0), keybind_outline}, {
                        Size = utility:Size(0, 64, 0, 49),
                        Position = utility:Position(1, 2, 0, 0, keybind_outline),
                        Color = theme.outline,
                        Visible = page.open
                    }, keybind.modemenu.drawings);keybind.modemenu.frame = modemenu
                    --
                    library.colors[modemenu] = {
                        Color = "outline"
                    }
                    --
                    local modemenu_inline = utility:Create("Frame", {Vector2.new(1,1), modemenu}, {
                        Size = utility:Size(1, -2, 1, -2, modemenu),
                        Position = utility:Position(0, 1, 0, 1, modemenu),
                        Color = theme.inline,
                        Visible = page.open
                    }, keybind.modemenu.drawings)
                    --
                    library.colors[modemenu_inline] = {
                        Color = "inline"
                    }
                    --
                    local modemenu_frame = utility:Create("Frame", {Vector2.new(1,1), modemenu_inline}, {
                        Size = utility:Size(1, -2, 1, -2, modemenu_inline),
                        Position = utility:Position(0, 1, 0, 1, modemenu_inline),
                        Color = theme.lightcontrast,
                        Visible = page.open
                    }, keybind.modemenu.drawings)
                    --
                    library.colors[modemenu_frame] = {
                        Color = "lightcontrast"
                    }
                    --
                    local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), modemenu_frame}, {
                        Size = utility:Size(1, 0, 1, 0, modemenu_frame),
                        Position = utility:Position(0, 0, 0 , 0, modemenu_frame),
                        Transparency = 0.5,
                        Visible = page.open
                    }, keybind.modemenu.drawings)
                    --
                    utility:LoadImage(keybind__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
                    --
                    for i,v in pairs({"Always", "Toggle", "Hold"}) do
                        local button_title = utility:Create("TextLabel", {Vector2.new(modemenu_frame.Size.X/2,15 * (i-1)), modemenu_frame}, {
                            Text = v,
                            Size = theme.textsize,
                            Font = theme.font,
                            Color = v == keybind.mode and theme.accent or theme.textcolor,
                            Center = true,
                            OutlineColor = theme.textborder,
                            Position = utility:Position(0.5, 0, 0, 15 * (i-1), modemenu_frame),
                            Visible = page.open
                        }, keybind.modemenu.drawings);keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = button_title
                        --
                        library.colors[button_title] = {
                            OutlineColor = "textborder",
                            Color = v == keybind.mode and "accent" or "textcolor"
                        }
                    end
                    --
                    window.currentContent.frame = modemenu
                    window.currentContent.keybind = keybind
                end
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if keybind.active and keybind.mode == "Hold" then
                if keybind.current[1] and keybind.current[2] then
                    if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                        keybind.active = false
                        window.keybindslist:Remove(keybindname or name)
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = keybind
        end
        --
        section.currentAxis = section.currentAxis + 17 + 4
        section:Update()
        --
        return keybind
    end
    --
    function sections:Colorpicker(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Colorpicker"
        local cpinfo = info.info or info.Info or name
        local def = info.def or info.Def or info.default or info.Default or Color3.fromRGB(255, 0, 0)
        local transp = info.transparency or info.Transparency or info.transp or info.Transp or info.alpha or info.Alpha or nil
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local hh, ss, vv = def:ToHSV()
        local colorpicker = {axis = section.currentAxis, secondColorpicker = false, current = {hh, ss, vv , (transp or 0)}, holding = {picker = false, huepicker = false, transparency = false}, holder = {inline = nil, picker = nil, picker_cursor = nil, huepicker = nil, huepicker_cursor = {}, transparency = nil, transparencybg = nil, transparency_cursor = {}, drawings = {}}}
        --
        local colorpicker_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(30+4),colorpicker.axis), section.section_frame}, {
            Size = utility:Size(0, 30, 0, 15),
            Position = utility:Position(1, -(30+4), 0, colorpicker.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
            Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
            Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker__transparency
        if transp then
            colorpicker__transparency = utility:Create("Image", {Vector2.new(1,1), colorpicker_inline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                Position = utility:Position(0, 1, 0 , 1, colorpicker_inline),
                Visible = page.open
            }, section.visibleContent)
        end
        --
        local colorpicker_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_inline}, {
            Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
            Position = utility:Position(0, 1, 0, 1, colorpicker_inline),
            Color = def,
            Transparency = transp and (1 - transp) or 1,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker__gradient = utility:Create("Image", {Vector2.new(0,0), colorpicker_frame}, {
            Size = utility:Size(1, 0, 1, 0, colorpicker_frame),
            Position = utility:Position(0, 0, 0 , 0, colorpicker_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,colorpicker.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2)), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, colorpicker.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2), section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        if transp then
            utility:LoadImage(colorpicker__transparency, "cptransp", "https://i.imgur.com/IIPee2A.png")
        end
        utility:LoadImage(colorpicker__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function colorpicker:Set(color, transp_val)
            if typeof(color) == "table" then
                colorpicker.current = color
                colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
            elseif typeof(color) == "color3" then
                local h, s, v = color:ToHSV()
                colorpicker.current = {h, s, v, (transp_val or 0)}
                colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4]) 
            end
        end
        --
        function colorpicker:Refresh()
            local mouseLocation = utility:MouseLocation()
            if colorpicker.open and colorpicker.holder.picker and colorpicker.holding.picker then
                colorpicker.current[2] = math.clamp(mouseLocation.X - colorpicker.holder.picker.Position.X, 0, colorpicker.holder.picker.Size.X) / colorpicker.holder.picker.Size.X
                --
                colorpicker.current[3] = 1-(math.clamp(mouseLocation.Y - colorpicker.holder.picker.Position.Y, 0, colorpicker.holder.picker.Size.Y) / colorpicker.holder.picker.Size.Y)
                --
                colorpicker.holder.picker_cursor.Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker.holder.picker)
                --
                utility:UpdateOffset(colorpicker.holder.picker_cursor, {Vector2.new((colorpicker.holder.picker.Size.X*colorpicker.current[2])-3,(colorpicker.holder.picker.Size.Y*(1-colorpicker.current[3]))-3), colorpicker.holder.picker})
                --
                if colorpicker.holder.transparencybg then
                    colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                end
            elseif colorpicker.open and colorpicker.holder.huepicker and colorpicker.holding.huepicker then
                colorpicker.current[1] = (math.clamp(mouseLocation.Y - colorpicker.holder.huepicker.Position.Y, 0, colorpicker.holder.huepicker.Size.Y) / colorpicker.holder.huepicker.Size.Y)
                --
                colorpicker.holder.huepicker_cursor[1].Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker.holder.huepicker)
                colorpicker.holder.huepicker_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[1])
                colorpicker.holder.huepicker_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[2])
                colorpicker.holder.huepicker_cursor[3].Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                --
                utility:UpdateOffset(colorpicker.holder.huepicker_cursor[1], {Vector2.new(-3,(colorpicker.holder.huepicker.Size.Y*colorpicker.current[1])-3), colorpicker.holder.huepicker})
                --
                colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                --
                if colorpicker.holder.transparency_cursor and colorpicker.holder.transparency_cursor[3] then
                    colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                end
                --
                if colorpicker.holder.transparencybg then
                    colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                end
            elseif colorpicker.open and colorpicker.holder.transparency and colorpicker.holding.transparency then
                colorpicker.current[4] = 1 - (math.clamp(mouseLocation.X - colorpicker.holder.transparency.Position.X, 0, colorpicker.holder.transparency.Size.X) / colorpicker.holder.transparency.Size.X)
                --
                colorpicker.holder.transparency_cursor[1].Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker.holder.transparency)
                colorpicker.holder.transparency_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[1])
                colorpicker.holder.transparency_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[2])
                colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                colorpicker_frame.Transparency = (1 - colorpicker.current[4])
                --
                utility:UpdateTransparency(colorpicker_frame, (1 - colorpicker.current[4]))
                utility:UpdateOffset(colorpicker.holder.transparency_cursor[1], {Vector2.new((colorpicker.holder.transparency.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker.holder.transparency})
                --
                colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
            end
            --
            colorpicker:Set(colorpicker.current)
        end
        --
        function colorpicker:Get()
            return Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and colorpicker_outline.Visible then
                if colorpicker.open and colorpicker.holder.inline and utility:MouseOverDrawing({colorpicker.holder.inline.Position.X, colorpicker.holder.inline.Position.Y, colorpicker.holder.inline.Position.X + colorpicker.holder.inline.Size.X, colorpicker.holder.inline.Position.Y + colorpicker.holder.inline.Size.Y}) then
                    if colorpicker.holder.picker and utility:MouseOverDrawing({colorpicker.holder.picker.Position.X - 2, colorpicker.holder.picker.Position.Y - 2, colorpicker.holder.picker.Position.X - 2 + colorpicker.holder.picker.Size.X + 4, colorpicker.holder.picker.Position.Y - 2 + colorpicker.holder.picker.Size.Y + 4}) then
                        colorpicker.holding.picker = true
                        colorpicker:Refresh()
                    elseif colorpicker.holder.huepicker and utility:MouseOverDrawing({colorpicker.holder.huepicker.Position.X - 2, colorpicker.holder.huepicker.Position.Y - 2, colorpicker.holder.huepicker.Position.X - 2 + colorpicker.holder.huepicker.Size.X + 4, colorpicker.holder.huepicker.Position.Y - 2 + colorpicker.holder.huepicker.Size.Y + 4}) then
                        colorpicker.holding.huepicker = true
                        colorpicker:Refresh()
                    elseif colorpicker.holder.transparency and utility:MouseOverDrawing({colorpicker.holder.transparency.Position.X - 2, colorpicker.holder.transparency.Position.Y - 2, colorpicker.holder.transparency.Position.X - 2 + colorpicker.holder.transparency.Size.X + 4, colorpicker.holder.transparency.Position.Y - 2 + colorpicker.holder.transparency.Size.Y + 4}) then
                        colorpicker.holding.transparency = true
                        colorpicker:Refresh()
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + colorpicker.axis, section.section_frame.Position.X + section.section_frame.Size.X - (colorpicker.secondColorpicker and (30+4) or 0), section.section_frame.Position.Y + colorpicker.axis + 15}) and not window:IsOverContent() then
                    if not colorpicker.open then
                        window:CloseContent()
                        colorpicker.open = not colorpicker.open
                        --
                        local colorpicker_open_outline = utility:Create("Frame", {Vector2.new(4,colorpicker.axis + 19), section.section_frame}, {
                            Size = utility:Size(1, -8, 0, transp and 219 or 200, section.section_frame),
                            Position = utility:Position(0, 4, 0, colorpicker.axis + 19, section.section_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings);colorpicker.holder.inline = colorpicker_open_outline
                        --
                        local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                            Color = theme.darkcontrast
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                            Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                            Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                            Color = theme.accent
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,2), colorpicker_open_frame}, {
                            Text = cpinfo,
                            Size = theme.textsize,
                            Font = theme.font,
                            Color = theme.textcolor,
                            OutlineColor = theme.textborder,
                            Position = utility:Position(0, 4, 0, 2, colorpicker_open_frame),
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                            Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                            Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_picker_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_inline),
                            Color = Color3.fromHSV(colorpicker.current[1],1,1)
                        }, colorpicker.holder.drawings);colorpicker.holder.background = colorpicker_open_picker_bg
                        --
                        local colorpicker_open_picker_image = utility:Create("Image", {Vector2.new(0,0), colorpicker_open_picker_bg}, {
                            Size = utility:Size(1, 0, 1, 0, colorpicker_open_picker_bg),
                            Position = utility:Position(0, 0, 0 , 0, colorpicker_open_picker_bg),
                        }, colorpicker.holder.drawings);colorpicker.holder.picker = colorpicker_open_picker_image
                        --
                        local colorpicker_open_picker_cursor = utility:Create("Image", {Vector2.new((colorpicker_open_picker_image.Size.X*colorpicker.current[2])-3,(colorpicker_open_picker_image.Size.Y*(1-colorpicker.current[3]))-3), colorpicker_open_picker_image}, {
                            Size = utility:Size(0, 6, 0, 6, colorpicker_open_picker_image),
                            Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker_open_picker_image),
                        }, colorpicker.holder.drawings);colorpicker.holder.picker_cursor = colorpicker_open_picker_cursor
                        --
                        local colorpicker_open_huepicker_outline = utility:Create("Frame", {Vector2.new(colorpicker_open_frame.Size.X-19,17), colorpicker_open_frame}, {
                            Size = utility:Size(0, 15, 1, transp and -40 or -21, colorpicker_open_frame),
                            Position = utility:Position(1, -19, 0, 17, colorpicker_open_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        local colorpicker_open_huepicker_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_huepicker_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_inline),
                            Position = utility:Position(0, 1, 0 , 1, colorpicker_open_huepicker_inline),
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker = colorpicker_open_huepicker_image
                        --
                        local colorpicker_open_huepicker_cursor_outline = utility:Create("Frame", {Vector2.new(-3,(colorpicker_open_huepicker_image.Size.Y*colorpicker.current[1])-3), colorpicker_open_huepicker_image}, {
                            Size = utility:Size(1, 6, 0, 6, colorpicker_open_huepicker_image),
                            Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker_open_huepicker_image),
                            Color = theme.outline
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[1] = colorpicker_open_huepicker_cursor_outline
                        --
                        local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                            Color = theme.textcolor
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                        --
                        local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                            Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                        --
                        if transp then
                            local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.X-19), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_transparency_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                            }, colorpicker.holder.drawings);colorpicker.holder.transparencybg = colorpicker_open_transparency_bg
                            --
                            local colorpicker_open_transparency_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                Position = utility:Position(0, 1, 0 , 1, colorpicker_open_transparency_inline),
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency = colorpicker_open_transparency_image
                            --
                            local colorpicker_open_transparency_cursor_outline = utility:Create("Frame", {Vector2.new((colorpicker_open_transparency_image.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker_open_transparency_image}, {
                                Size = utility:Size(0, 6, 1, 6, colorpicker_open_transparency_image),
                                Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker_open_transparency_image),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[1] = colorpicker_open_transparency_cursor_outline
                            --
                            local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                            --
                            local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                            --
                            utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
                            --utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/VcMAYjL.png")
                        end
                        --
                        utility:LoadImage(colorpicker_open_picker_image, "valsat", "https://i.imgur.com/wpDRqVH.png")
                        utility:LoadImage(colorpicker_open_picker_cursor, "valsat_cursor", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                        utility:LoadImage(colorpicker_open_huepicker_image, "hue", "https://i.imgur.com/iEOsHFv.png")
                        --
                        window.currentContent.frame = colorpicker_open_inline
                        window.currentContent.colorpicker = colorpicker
                    else
                        colorpicker.open = not colorpicker.open
                        --
                        for i,v in pairs(colorpicker.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        colorpicker.holder.drawings = {}
                        colorpicker.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.colorpicker = nil
                    end
                else
                    if colorpicker.open then
                        colorpicker.open = not colorpicker.open
                        --
                        for i,v in pairs(colorpicker.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        colorpicker.holder.drawings = {}
                        colorpicker.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.colorpicker = nil
                    end
                end
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and colorpicker.open then
                colorpicker.open = not colorpicker.open
                --
                for i,v in pairs(colorpicker.holder.drawings) do
                    utility:Remove(v)
                end
                --
                colorpicker.holder.drawings = {}
                colorpicker.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.colorpicker = nil
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                if colorpicker.holding.picker then
                    colorpicker.holding.picker = not colorpicker.holding.picker
                end
                if colorpicker.holding.huepicker then
                    colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                end
                if colorpicker.holding.transparency then
                    colorpicker.holding.transparency = not colorpicker.holding.transparency
                end
            end
        end
        --
        library.changed[#library.changed + 1] = function()
            if colorpicker.open and colorpicker.holding.picker or colorpicker.holding.huepicker or colorpicker.holding.transparency then
                if window.isVisible then
                    colorpicker:Refresh()
                else
                    if colorpicker.holding.picker then
                        colorpicker.holding.picker = not colorpicker.holding.picker
                    end
                    if colorpicker.holding.huepicker then
                        colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                    end
                    if colorpicker.holding.transparency then
                        colorpicker.holding.transparency = not colorpicker.holding.transparency
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = colorpicker
        end
        --
        section.currentAxis = section.currentAxis + 15 + 4
        section:Update()
        --
        function colorpicker:Colorpicker(info)
            local info = info or {}
            local cpinfo = info.info or info.Info or name
            local def = info.def or info.Def or info.default or info.Default or Color3.fromRGB(255, 0, 0)
            local transp = info.transparency or info.Transparency or info.transp or info.Transp or info.alpha or info.Alpha or nil
            local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
            local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
            --
            colorpicker.secondColorpicker = true
            --
            local hh, ss, vv = def:ToHSV()
            local colorpicker = {axis = colorpicker.axis, current = {hh, ss, vv , (transp or 0)}, holding = {picker = false, huepicker = false, transparency = false}, holder = {inline = nil, picker = nil, picker_cursor = nil, huepicker = nil, huepicker_cursor = {}, transparency = nil, transparencybg = nil, transparency_cursor = {}, drawings = {}}}
            --
            colorpicker_outline.Position = utility:Position(1, -(60+8), 0, colorpicker.axis, section.section_frame)
            utility:UpdateOffset(colorpicker_outline, {Vector2.new(section.section_frame.Size.X-(60+8),colorpicker.axis), section.section_frame})
            --
            local colorpicker_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(30+4),colorpicker.axis), section.section_frame}, {
                Size = utility:Size(0, 30, 0, 15),
                Position = utility:Position(1, -(30+4), 0, colorpicker.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker__transparency
            if transp then
                colorpicker__transparency = utility:Create("Image", {Vector2.new(1,1), colorpicker_inline}, {
                    Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                    Position = utility:Position(0, 1, 0 , 1, colorpicker_inline),
                    Visible = page.open
                }, section.visibleContent)
            end
            --
            local colorpicker_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_inline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_inline),
                Color = def,
                Transparency = transp and (1 - transp) or 1,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker__gradient = utility:Create("Image", {Vector2.new(0,0), colorpicker_frame}, {
                Size = utility:Size(1, 0, 1, 0, colorpicker_frame),
                Position = utility:Position(0, 0, 0 , 0, colorpicker_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            if transp then
                utility:LoadImage(colorpicker__transparency, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            utility:LoadImage(colorpicker__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
            --
            function colorpicker:Set(color, transp_val)
                if typeof(color) == "table" then
                    colorpicker.current = color
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                elseif typeof(color) == "color3" then
                    local h, s, v = color:ToHSV()
                    colorpicker.current = {h, s, v, (transp_val or 0)}
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4]) 
                end
            end
            --
            function colorpicker:Refresh()
                local mouseLocation = utility:MouseLocation()
                if colorpicker.open and colorpicker.holder.picker and colorpicker.holding.picker then
                    colorpicker.current[2] = math.clamp(mouseLocation.X - colorpicker.holder.picker.Position.X, 0, colorpicker.holder.picker.Size.X) / colorpicker.holder.picker.Size.X
                    --
                    colorpicker.current[3] = 1-(math.clamp(mouseLocation.Y - colorpicker.holder.picker.Position.Y, 0, colorpicker.holder.picker.Size.Y) / colorpicker.holder.picker.Size.Y)
                    --
                    colorpicker.holder.picker_cursor.Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker.holder.picker)
                    --
                    utility:UpdateOffset(colorpicker.holder.picker_cursor, {Vector2.new((colorpicker.holder.picker.Size.X*colorpicker.current[2])-3,(colorpicker.holder.picker.Size.Y*(1-colorpicker.current[3]))-3), colorpicker.holder.picker})
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.huepicker and colorpicker.holding.huepicker then
                    colorpicker.current[1] = (math.clamp(mouseLocation.Y - colorpicker.holder.huepicker.Position.Y, 0, colorpicker.holder.huepicker.Size.Y) / colorpicker.holder.huepicker.Size.Y)
                    --
                    colorpicker.holder.huepicker_cursor[1].Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker.holder.huepicker)
                    colorpicker.holder.huepicker_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[1])
                    colorpicker.holder.huepicker_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[2])
                    colorpicker.holder.huepicker_cursor[3].Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    utility:UpdateOffset(colorpicker.holder.huepicker_cursor[1], {Vector2.new(-3,(colorpicker.holder.huepicker.Size.Y*colorpicker.current[1])-3), colorpicker.holder.huepicker})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    if colorpicker.holder.transparency_cursor and colorpicker.holder.transparency_cursor[3] then
                        colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    end
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.transparency and colorpicker.holding.transparency then
                    colorpicker.current[4] = 1 - (math.clamp(mouseLocation.X - colorpicker.holder.transparency.Position.X, 0, colorpicker.holder.transparency.Size.X) / colorpicker.holder.transparency.Size.X)
                    --
                    colorpicker.holder.transparency_cursor[1].Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker.holder.transparency)
                    colorpicker.holder.transparency_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[1])
                    colorpicker.holder.transparency_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[2])
                    colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    colorpicker_frame.Transparency = (1 - colorpicker.current[4])
                    --
                    utility:UpdateTransparency(colorpicker_frame, (1 - colorpicker.current[4]))
                    utility:UpdateOffset(colorpicker.holder.transparency_cursor[1], {Vector2.new((colorpicker.holder.transparency.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker.holder.transparency})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                end
                --
                colorpicker:Set(colorpicker.current)
            end
            --
            function colorpicker:Get()
                return Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and colorpicker_outline.Visible then
                    if colorpicker.open and colorpicker.holder.inline and utility:MouseOverDrawing({colorpicker.holder.inline.Position.X, colorpicker.holder.inline.Position.Y, colorpicker.holder.inline.Position.X + colorpicker.holder.inline.Size.X, colorpicker.holder.inline.Position.Y + colorpicker.holder.inline.Size.Y}) then
                        if colorpicker.holder.picker and utility:MouseOverDrawing({colorpicker.holder.picker.Position.X - 2, colorpicker.holder.picker.Position.Y - 2, colorpicker.holder.picker.Position.X - 2 + colorpicker.holder.picker.Size.X + 4, colorpicker.holder.picker.Position.Y - 2 + colorpicker.holder.picker.Size.Y + 4}) then
                            colorpicker.holding.picker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.huepicker and utility:MouseOverDrawing({colorpicker.holder.huepicker.Position.X - 2, colorpicker.holder.huepicker.Position.Y - 2, colorpicker.holder.huepicker.Position.X - 2 + colorpicker.holder.huepicker.Size.X + 4, colorpicker.holder.huepicker.Position.Y - 2 + colorpicker.holder.huepicker.Size.Y + 4}) then
                            colorpicker.holding.huepicker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.transparency and utility:MouseOverDrawing({colorpicker.holder.transparency.Position.X - 2, colorpicker.holder.transparency.Position.Y - 2, colorpicker.holder.transparency.Position.X - 2 + colorpicker.holder.transparency.Size.X + 4, colorpicker.holder.transparency.Position.Y - 2 + colorpicker.holder.transparency.Size.Y + 4}) then
                            colorpicker.holding.transparency = true
                            colorpicker:Refresh()
                        end
                    elseif utility:MouseOverDrawing({section.section_frame.Position.X + (section.section_frame.Size.X - (30 + 4 + 2)), section.section_frame.Position.Y + colorpicker.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + colorpicker.axis + 15}) and not window:IsOverContent() then
                        if not colorpicker.open then
                            window:CloseContent()
                            colorpicker.open = not colorpicker.open
                            --
                            local colorpicker_open_outline = utility:Create("Frame", {Vector2.new(4,colorpicker.axis + 19), section.section_frame}, {
                                Size = utility:Size(1, -8, 0, transp and 219 or 200, section.section_frame),
                                Position = utility:Position(0, 4, 0, colorpicker.axis + 19, section.section_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.inline = colorpicker_open_outline
                            --
                            local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                                Color = theme.darkcontrast
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                                Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                                Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                                Color = theme.accent
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,2), colorpicker_open_frame}, {
                                Text = cpinfo,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, 4, 0, 2, colorpicker_open_frame),
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_picker_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_inline),
                                Color = Color3.fromHSV(colorpicker.current[1],1,1)
                            }, colorpicker.holder.drawings);colorpicker.holder.background = colorpicker_open_picker_bg
                            --
                            local colorpicker_open_picker_image = utility:Create("Image", {Vector2.new(0,0), colorpicker_open_picker_bg}, {
                                Size = utility:Size(1, 0, 1, 0, colorpicker_open_picker_bg),
                                Position = utility:Position(0, 0, 0 , 0, colorpicker_open_picker_bg),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker = colorpicker_open_picker_image
                            --
                            local colorpicker_open_picker_cursor = utility:Create("Image", {Vector2.new((colorpicker_open_picker_image.Size.X*colorpicker.current[2])-3,(colorpicker_open_picker_image.Size.Y*(1-colorpicker.current[3]))-3), colorpicker_open_picker_image}, {
                                Size = utility:Size(0, 6, 0, 6, colorpicker_open_picker_image),
                                Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker_open_picker_image),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker_cursor = colorpicker_open_picker_cursor
                            --
                            local colorpicker_open_huepicker_outline = utility:Create("Frame", {Vector2.new(colorpicker_open_frame.Size.X-19,17), colorpicker_open_frame}, {
                                Size = utility:Size(0, 15, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(1, -19, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            local colorpicker_open_huepicker_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_huepicker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_inline),
                                Position = utility:Position(0, 1, 0 , 1, colorpicker_open_huepicker_inline),
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker = colorpicker_open_huepicker_image
                            --
                            local colorpicker_open_huepicker_cursor_outline = utility:Create("Frame", {Vector2.new(-3,(colorpicker_open_huepicker_image.Size.Y*colorpicker.current[1])-3), colorpicker_open_huepicker_image}, {
                                Size = utility:Size(1, 6, 0, 6, colorpicker_open_huepicker_image),
                                Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker_open_huepicker_image),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[1] = colorpicker_open_huepicker_cursor_outline
                            --
                            local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                            --
                            local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                            --
                            if transp then
                                local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.X-19), colorpicker_open_frame}, {
                                    Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                    Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings)
                                --
                                local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                    Color = theme.inline
                                }, colorpicker.holder.drawings)
                                --
                                local colorpicker_open_transparency_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_inline),
                                    Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                                }, colorpicker.holder.drawings);colorpicker.holder.transparencybg = colorpicker_open_transparency_bg
                                --
                                local colorpicker_open_transparency_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0 , 1, colorpicker_open_transparency_inline),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency = colorpicker_open_transparency_image
                                --
                                local colorpicker_open_transparency_cursor_outline = utility:Create("Frame", {Vector2.new((colorpicker_open_transparency_image.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker_open_transparency_image}, {
                                    Size = utility:Size(0, 6, 1, 6, colorpicker_open_transparency_image),
                                    Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker_open_transparency_image),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[1] = colorpicker_open_transparency_cursor_outline
                                --
                                local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                    Color = theme.textcolor
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                                --
                                local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                    Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                                --
                                utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
                                --utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/VcMAYjL.png")
                            end
                            --
                            utility:LoadImage(colorpicker_open_picker_image, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            utility:LoadImage(colorpicker_open_picker_cursor, "valsat_cursor", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                            utility:LoadImage(colorpicker_open_huepicker_image, "hue", "https://i.imgur.com/iEOsHFv.png")
                            --
                            window.currentContent.frame = colorpicker_open_inline
                            window.currentContent.colorpicker = colorpicker
                        else
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    else
                        if colorpicker.open then
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    end
                elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and colorpicker.open then
                    colorpicker.open = not colorpicker.open
                    --
                    for i,v in pairs(colorpicker.holder.drawings) do
                        utility:Remove(v)
                    end
                    --
                    colorpicker.holder.drawings = {}
                    colorpicker.holder.inline = nil
                    --
                    window.currentContent.frame = nil
                    window.currentContent.colorpicker = nil
                end
            end
            --
            library.ended[#library.ended + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if colorpicker.holding.picker then
                        colorpicker.holding.picker = not colorpicker.holding.picker
                    end
                    if colorpicker.holding.huepicker then
                        colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                    end
                    if colorpicker.holding.transparency then
                        colorpicker.holding.transparency = not colorpicker.holding.transparency
                    end
                end
            end
            --
            library.changed[#library.changed + 1] = function()
                if colorpicker.open and colorpicker.holding.picker or colorpicker.holding.huepicker or colorpicker.holding.transparency then
                    if window.isVisible then
                        colorpicker:Refresh()
                    else
                        if colorpicker.holding.picker then
                            colorpicker.holding.picker = not colorpicker.holding.picker
                        end
                        if colorpicker.holding.huepicker then
                            colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                        end
                        if colorpicker.holding.transparency then
                            colorpicker.holding.transparency = not colorpicker.holding.transparency
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = keybind
            end
            --
            return colorpicker
        end
        --
        return colorpicker
    end
    --
    function sections:Listbox(info)
        local info = info or {}
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local list = info.list or info.List or {}
        local callback = info.callback or info.Callback or function() end
        local pointer = info.pointer or info.Pointer or nil
        local multichoice = info.multichoice or info.MultiChoice or false
        --
        local listbox = {axis = section.currentAxis, current = "", startindex = 1, multichoice = multichoice, buttons = {}}
        --
        local listbox_outline = utility:Create("Frame", {Vector2.new(4,listbox.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 148, section.section_frame),
            Position = utility:Position(0, 4, 0, listbox.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_outline] = {
            Color = "outline"
        }
        --
        local listbox_inline = utility:Create("Frame", {Vector2.new(1,1), listbox_outline}, {
            Size = utility:Size(1, -2, 1, -2, listbox_outline),
            Position = utility:Position(0, 1, 0, 1, listbox_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_inline] = {
            Color = "inline"
        }
        --
        local listbox_frame = utility:Create("Frame", {Vector2.new(1,1), listbox_inline}, {
            Size = utility:Size(1, -2, 1, -2, listbox_inline),
            Position = utility:Position(0, 1, 0, 1, listbox_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_frame] = {
            Color = "lightcontrast"
        }
        --
        local listbox_gradient = utility:Create("Image", {Vector2.new(0,0), listbox_frame}, {
            Size = utility:Size(1, 0, 1, 0, listbox_frame),
            Position = utility:Position(0, 0, 0, 0, listbox_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local listbox_scroll_outline = utility:Create("Frame", {Vector2.new(listbox_gradient.Size.X - 4, 0), listbox_gradient}, {
            Size = utility:Size(0, 4, 1, 0, listbox_gradient),
            Position = utility:Position(1, -4, 0, 0, listbox_gradient),
            Color = theme.outline,
            Transparency = 1,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_scroll_outline] = {
            Color = "outline",
        }
        --
        local listbox_scroll_frame = utility:Create("Frame", {Vector2.new(1, 1), listbox_scroll_outline}, {
            Size = utility:Size(0, 2, #list == 0 and 1 or 1 / (#list / 8), -2, listbox_scroll_outline),
            Position = utility:Position(0, 1, 0, 1, listbox_scroll_outline),
            Color = theme.accent,
            Transparency = 1,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_scroll_frame] = {
            Color = "accent"
        }
        --
        utility:LoadImage(listbox_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function listbox:Refresh()
            for i = 1, #self.buttons do
                local button = self.buttons[i]
                button.Color = theme.textcolor
                --
                library.colors[button].Color = "textcolor"
            end
            --
            if multichoice then
                for _, current in ipairs(self.current) do
                    local button = self.buttons[current[2]]
                    if button then
                        button.Color = theme.accent
                        --
                        library.colors[button].Color = "accent"
                    end
                end
            else
                local button = self.buttons[self.current[1][2]]
                if button then
                    button.Color = theme.accent
                    --
                    library.colors[button].Color = "accent"
                end
            end
            --
        end
        --
        function listbox:RefreshScroll(down)
            for i = self.startindex, 1, -1 do
                local button = listbox.buttons[i]
                --
                utility:UpdateTransparency(button, 0)
                utility:UpdateOffset(button, {Vector2.new(listbox_frame.Size.X / 2, 2 + 18 * (#self.buttons - i)), listbox_frame})
                --
                button.Position = utility:Position(0.5, 0, 0, 2 + 18 * (#self.buttons - i), listbox_frame)
                button.Color = theme.textcolor
                button.Transparency = 0
                button.Visible = false
            end
            --
            for i = self.startindex, 7 + self.startindex do
                local button = self.buttons[i]
                --
                local colortype = "textcolor"
                if multichoice then
                    for _, current in ipairs(self.current) do
                        if current[2] == i then
                            colortype = "accent"
                            break
                        end
                    end
                else
                    colortype = i == self.current[1][2] and "accent" or "textcolor"
                end
                --
                utility:UpdateTransparency(button, window.isVisible and page.open and 1 or 0)
                utility:UpdateOffset(button, {Vector2.new(listbox_frame.Size.X / 2, 2 + 18 * (i - self.startindex)), listbox_frame})
                --
                button.Position = utility:Position(0.5, 0, 0, 2 + 18 * (i - self.startindex), listbox_frame)
                button.Color = theme[colortype]
                button.Transparency = window.isVisible and page.open and 1 or 0
                button.Visible = true
                --
                library.colors[button].Color = colortype
            end
            --
            if not down then
                local button = self.buttons[self.startindex + 8]
                --
                utility:UpdateTransparency(button, 0)
                --
                button.Transparency = 0
                button.Visible = false
            end

            self:RefreshScrollBar()
        end
        --
        function listbox:RefreshScrollBar()
            local scale = (self.startindex - 1) / (#self.buttons > 0 and #self.buttons or 1)
            utility:UpdateOffset(listbox_scroll_frame, {Vector2.new(1, 1 + scale * listbox_scroll_outline.Size.Y), listbox_scroll_outline})
            listbox_scroll_frame.Position = utility:Position(0, 1, scale, 1, listbox_scroll_outline)
            listbox_scroll_frame.Size = utility:Size(0, 2, math.clamp(#self.buttons == 0 and 1 or 1 / (#self.buttons / 8), 0, 1), -2, listbox_scroll_outline)
        end
        --
        function listbox:get()
            return self.current
        end
        --
        function listbox:set(value, internal)
            for _, toset in ipairs(value) do
                print(toset[2])
                if not self.buttons[toset[2]] or self.buttons[toset[2]].Text ~= toset[1] then
                    if not self.buttons[1] then
                        return
                    end

                    toset[1] = self.buttons[1]
                    toset[2] = 1
                end
            end
            self.current = value
            self:Refresh()
            if not internal then
                task.spawn(callback, value)
            end
        end
        --
        function listbox:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function listbox:UpdateList(list, dontset, keepscroll)
            local list = list or {}

            for i, button in next, self.buttons do
                self.buttons[i] = nil
                for i2, content in next, section.visibleContent do
                    if content == button then
                        table.remove(section.visibleContent, i2)
                        break
                    end
                end
                --
                utility:Remove(button, false)
                utility:Remove(button, true)
            end
            --
            for i, name in ipairs(list) do
                local button_title = utility:Create("TextLabel", {Vector2.new(listbox_frame.Size.X / 2, 2 + (18 * #listbox.buttons)), listbox_frame}, {
                    Text = name,
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = i == 1 and theme.accent or theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Transparency = #self.buttons + 1 > 8 and 0 or 1,
                    Position = utility:Position(0.5, 0, 0, 2 + (18 * #self.buttons), listbox_frame),
                    Visible = window.isVisible and page.open and #self.buttons + 1 <= 8
                }, section.visibleContent)
                --
                library.colors[button_title] = {
                    OutlineColor = "textborder",
                    Color = i == 1 and "accent" or "textcolor"
                }
                --
                self.buttons[#self.buttons + 1] = button_title
            end
            --

            if keepscroll then
                for index = 1, math.clamp(self.startindex - 1, 1, #self.buttons - 8 <= 0 and 1 or #self.buttons - 8) do
                    self.startindex = index
                    if self.buttons[index + 8] then
                        self:RefreshScroll(true)
                    end
                end
            else
                self.startindex = 1
            end

            self:RefreshScrollBar()

            if not dontset then
                if multichoice then
                    local toset = {}
                    for idx, val in ipairs(list) do
                        if self:get()[idx] then
                            toset[#toset + 1] = self:get()[idx]
                        end
                    end
                    self:set(toset)
                else
                    if list[1] then
                        self:set({{list[1], table.find(list, list[1])}})
                    end
                end
            end
        end
        --
        library.began[#library.began + 1] = function(input)
            -- startIndex: 2
            -- buttons: 10
            -- maxShownButtons: 8
            
            -- we know that there can be 1 new shown if we are at startIndex 2
            -- shownMin: startIndex
            -- showmMax: 7 + startIndex

            -- startIndex: 1
            -- buttons: 4
            -- maxShownButtons: 8
            
            -- now there cannot be more than 4 shown

            local shownMax = #listbox.buttons <= 8 and #listbox.buttons or 7 + listbox.startindex
            for i = listbox.startindex, shownMax do
                local button = listbox.buttons[i]
                --
                utility:UpdateTransparency(button, window.isVisible and page.open and 1 or 0)
                --
                button.Transparency = window.isVisible and page.open and 1 or 0
            end

            if input.UserInputType == Enum.UserInputType.MouseButton1 and listbox_outline.Visible and window.isVisible and utility:MouseOverDrawing({
                section.section_frame.Position.X,
                section.section_frame.Position.Y + listbox.axis,
                section.section_frame.Position.X + section.section_frame.Size.X,
                section.section_frame.Position.Y + listbox.axis + 148
            }) and not window:IsOverContent() then
                local shownMax = #listbox.buttons <= 8 and #listbox.buttons or 7 + listbox.startindex
                for i = listbox.startindex, shownMax do
                    if utility:MouseOverDrawing({
                        section.section_frame.Position.X,
                        section.section_frame.Position.Y + listbox.axis + 2 + (18 * (i - listbox.startindex)),
                        section.section_frame.Position.X + section.section_frame.Size.X,
                        section.section_frame.Position.Y + listbox.axis + 2 + (18 * (i - listbox.startindex)) + 18
                    }) then
                        if multichoice then
                            local newlist = {{listbox.buttons[i].Text, i}}
                            --
                            for idx, val in ipairs(listbox:get()) do
                                if listbox.buttons[i] ~= listbox.buttons[val[2]] then
                                    newlist[#newlist + 1] = val
                                else
                                    table.remove(newlist, 1)
                                end
                            end
                            --
                            listbox:set(newlist)
                        elseif listbox:get()[1][2] ~= i then
                            listbox:set({{listbox.buttons[i].Text, i}})
                        end
                        --
                        return
                    end
                end
            end
        end
        --
        library.changed[#library.changed + 1] = function(input)
            if input.UserInputType == Enum.UserInputType.MouseWheel and listbox_outline.Visible and window.isVisible and utility:MouseOverDrawing({
                section.section_frame.Position.X,
                section.section_frame.Position.Y + listbox.axis,
                section.section_frame.Position.X + section.section_frame.Size.X,
                section.section_frame.Position.Y + listbox.axis + 148
            }) then
                local down = input.Position.Z < 0 and true or false
                if down then
                    local indexesleft = #listbox.buttons - 8 - listbox.startindex
                    if indexesleft >= 0 then
                        listbox.startindex += 1
                        listbox:RefreshScroll(down)
                    end
                else
                    local indexesleft = #listbox.buttons - 8 + listbox.startindex
                    if indexesleft >= #listbox.buttons - 6 then
                        listbox.startindex -= 1
                        listbox:RefreshScroll(down)
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = listbox
        end
        --
        listbox:UpdateList(list)
        --
        section.currentAxis = section.currentAxis + 148 + 4
        section:Update()
        --
        return listbox
    end
    --
    function sections:ConfigBox(info)
        local info = info or {}
        --
        local window = self.window
        local page = self.page
        local section = self
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        --
        local configLoader = {axis = section.currentAxis, current = 1, buttons = {}}
        --
        local configLoader_outline = utility:Create("Frame", {Vector2.new(4,configLoader.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 148, section.section_frame),
            Position = utility:Position(0, 4, 0, configLoader.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[configLoader_outline] = {
            Color = "outline"
        }
        --
        local configLoader_inline = utility:Create("Frame", {Vector2.new(1,1), configLoader_outline}, {
            Size = utility:Size(1, -2, 1, -2, configLoader_outline),
            Position = utility:Position(0, 1, 0, 1, configLoader_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[configLoader_inline] = {
            Color = "inline"
        } -- im being abused, help me please - taskmanager
        --
        local configLoader_frame = utility:Create("Frame", {Vector2.new(1,1), configLoader_inline}, {
            Size = utility:Size(1, -2, 1, -2, configLoader_inline),
            Position = utility:Position(0, 1, 0, 1, configLoader_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[configLoader_frame] = {
            Color = "lightcontrast"
        }
        --
        local configLoader_gradient = utility:Create("Image", {Vector2.new(0,0), configLoader_frame}, {
            Size = utility:Size(1, 0, 1, 0, configLoader_frame),
            Position = utility:Position(0, 0, 0 , 0, configLoader_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        for i=1, 8 do
            local config_title = utility:Create("TextLabel", {Vector2.new(configLoader_frame.Size.X/2,2 + (18 * (i-1))), configLoader_frame}, {
                Text = "Config-Slot: "..tostring(i),
                Size = theme.textsize,
                Font = theme.font,
                Color = i == 1 and theme.accent or theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 2 + (18 * (i-1)), configLoader_frame),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[config_title] = {
                OutlineColor = "textborder",
                Color = i == 1 and "accent" or "textcolor"
            }
            --
            configLoader.buttons[i] = config_title
        end
        --
        utility:LoadImage(configLoader_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function configLoader:Refresh()
            for i,v in pairs(configLoader.buttons) do
                v.Color = i == configLoader.current and theme.accent or theme.textcolor
                --
                library.colors[v] = {
                    Color = i == configLoader.current and "accent" or "textcolor"
                }
            end
        end
        --
        function configLoader:get()
            return configLoader.current
        end
        --
        function configLoader:set(current)
            configLoader.current = current
            configLoader:Refresh()
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and configLoader_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + configLoader.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + configLoader.axis + 148}) and not window:IsOverContent() then
                for i=1, 8 do
                    if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + configLoader.axis + 2 + (18 * (i-1)), section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + configLoader.axis + 2 + (18 * (i-1)) + 18}) then
                        configLoader.current = i
                        configLoader:Refresh()
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = configLoader
        end
        --
        section.currentAxis = section.currentAxis + 148 + 4
        section:Update()
        --
        return configLoader
    end
end
-- // Init
--[[do
    local title_string = "Splix - Private | %A, %B"
    local day = os.date(" %d", os.time())
    local second_string = ", %Y."
    title_string = os.date(title_string, os.time())..day..utility:GetSubPrefix(day)..os.date(second_string, os.time())
    --
    local lib = library:New({name = title_string})
    --
    local test = lib:Page({name = "test"})
    local sucky = lib:Page({name = "sucky"})

    local testMain = test:Section({name = "Main"})

    local list = {}
    for i = 1, 0 do
        list[i] = tostring(i)
    end
    
    local listbox = testMain:Listbox({Pointer = "Config/Selected", List = list})
    testMain:Button({Name = "Delete", Confirmation = true, Callback = function() end})
	testMain:Textbox({Pointer = "Config/Name", PlaceHolder = "Config Name", Text = "", Middle = true, ResetOnFocus = false})

    lib.uibind = Enum.KeyCode.Home
    lib:Initialize()

    print(lib:GetConfig())
end]]
--

function library:UpdateColor(ColorType, ColorValue)
    local ColorType = ColorType:lower()
    --
    theme[ColorType] = ColorValue
    --
    for Index, Value in pairs(library.colors) do
        for Index2, Value2 in pairs(Value) do
            if Value2 == ColorType then
                Index[Index2] = theme[Value2]
            end
        end
    end
end



local m_thread = task do
    setreadonly(m_thread, false)

    function m_thread.spawn_loop(p_time, p_callback)
        m_thread.spawn(function()
            while true do
                p_callback()
                m_thread.wait(p_time)
            end
        end)
    end

    setreadonly(m_thread, true)
end

return library, library.pointers, theme -- utility