--[[
    @gs.cc
]]
-- // Variables
local ws, uis, rs, hs, cas, plrs, stats = game:GetService("Workspace"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("HttpService"), game:GetService("ContextActionService"), game:GetService("Players"), game:GetService("Stats")
--
local localplayer = plrs.LocalPlayer
--
local mouse = localplayer:GetMouse()
--
local Remove = table.remove
local Unpack = table.unpack
local Find = table.find
-- UI Variables
local library = {
    drawings = {},
    objects = {},
    hidden = {},
    connections = {},
    pointers = {},
    began = {},
    ended = {},
    changed = {},
    colors = {},
    hovers = {},
    Relations = {},
    folders = {
        main = "Atlanta",
        assets = "Atlanta/Images",
        configs = "Atlanta/Configs"
    },
    shared = {
        initialized = false,
        fps = 0,
        ping = 0
    }
}
--
local utility = {
    Keyboard = {
        Letters = {
            "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
        },
        Modifiers = {
            ["`"] = "~", ["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$", ["5"] = "%", ["6"] = "^", ["7"] = "&", ["8"] = "*", ["9"] = "(",
            ["0"] = ")", ["-"] = "_", ["="] = "+", ["["] = "{", ["]"] = "}", ["\\"] = "|", [";"] = ":", ["'"] = '"', [","] = "<", ["."] = ".",
            ["/"] = "?"
        },
        InputNames = {
            One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9", Zero = "0",
            LeftBracket = "[", RightBracket = "]", Semicolon = ";", BackSlash = "\\", Slash = "/", Minus = "-", Equals = "=", Return = "Enter",
            Backquote = "`", CapsLock = "Caps", LeftShift = "LShift", RightShift = "RShift", LeftControl = "LCtrl", RightControl = "RCtrl",
            LeftAlt = "LAlt", RightAlt = "RAlt", Backspace = "Back", Plus = "+", PageUp = "PgUp", PageDown = "PgDown", Delete = "Del",
            Insert = "Ins", NumLock = "NumL", Comma = ",", Period = "."
        }
    }
}
local pages = {}
local sections = {}
-- Theme Variables
--local themes = {}
local theme = {
    accent = Color3.fromRGB(55, 175, 225),
    lightcontrast = Color3.fromRGB(30, 30, 30),
    darkcontrast = Color3.fromRGB(20, 20, 20),
    outline = Color3.fromRGB(0, 0, 0),
    inline = Color3.fromRGB(50, 50, 50),
    textcolor = Color3.fromRGB(255, 255, 255),
    textdark = Color3.fromRGB(175, 175, 175),
    textborder = Color3.fromRGB(0, 0, 0),
    cursoroutline = Color3.fromRGB(10, 10, 10),
    font = 2,
    textsize = 13
}
-- // utility Functions
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
            frame.ZIndex = 50
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "TextLabel" or instanceType == "textlabel" then
            local text = Drawing.new("Text")
            text.Font = 3
            text.Visible = true
            text.Outline = true
            text.Center = false
            text.Color = Color3.fromRGB(255,255,255)
            text.ZIndex = 50
            text.Transparency = library.shared.initialized and 1 or 0
            instance = text
        elseif instanceType == "Triangle" or instanceType == "triangle" then
            local frame = Drawing.new("Triangle")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.ZIndex = 50
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "Image" or instanceType == "image" then
            local image = Drawing.new("Image")
            image.Size = Vector2.new(12,19)
            image.Position = Vector2.new(0,0)
            image.Visible = true
            image.ZIndex = 50
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
            circle.ZIndex = 50
            circle.Radius = 50
            circle.Transparency = library.shared.initialized and 1 or 0
            instance = circle
        elseif instanceType == "Quad" or instanceType == "quad" then
            local quad = Drawing.new("Quad")
            quad.Visible = false
            quad.Color = Color3.fromRGB(255, 255, 255)
            quad.Thickness = 1.5
            quad.Transparency = 1
            quad.ZIndex = 50
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
            line.ZIndex = 50
            line.Transparency = library.shared.initialized and 1 or 0
            instance = line
        end
        --
        if instance then
            for i, v in pairs(instanceProperties) do
                if i == "Hidden" or i == "hidden" then
                    instanceHidden = true
                else
                    if library.shared.initialized then
                        instance[i] = v
                    else
                        if instanceProperties.Hidden or instanceProperties.hidden then
                            instance[i] = v
                        else
                            if i ~= "Transparency" then
                                instance[i] = v
                            end
                        end
                    end
                end
            end
            --
            if not instanceHidden then
                library.drawings[#library.drawings + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            else
                library.hidden[#library.hidden + 1] = {instance}
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
    function utility:Instance(InstanceType, InstanceProperties)
        local Object = Instance.new(InstanceType)
        --
        for Index, Value in pairs(InstanceProperties) do
            Object[Index] = Value
        end
        --
        library.objects[Object] = true
        --
        return Object
    end
    --
    function utility:RemoveInstance(Object)
        library.objects[Object] = nil
        Object:Remove()
    end
    --
    function utility:UpdateOffset(instance, instanceOffset)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[2] = instanceOffset
            end
        end
    end
    --
    function utility:UpdateTransparency(instance, instanceTransparency)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[3] = instanceTransparency
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
                ind = i
                if hidden then
                    v[1] = nil
                else
                    v[2] = nil
                    v[1] = nil
                end
            end
        end
        --
        Remove(hidden and library.hidden or library.drawings, ind)
        instance:Remove()
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
                instance[i] = ((v - currentIndex[i]) * currentTime / instanceTime) + currentIndex[i]
            end
        end
        --
        connection = utility:Connection(rs.RenderStepped, function(delta)
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
    --
    function utility:InputToString(Input)
        if Input then
            local String = (tostring(Input) .. "."):gsub("%.", ",")
            local Count = 0
            --
            for Value in String:gmatch("(.-),") do
                Count = Count + 1
                --
                if Count == 3 then
                    String = Value:gsub("Keypad", "")
                end
            end
            --
            if String == "Unknown" or Input.Value == 27 then
                return "None"
            elseif utility.Keyboard.InputNames[String] then
                String = utility.Keyboard.InputNames[String]
            end
            --
            return String
        else
            return "None"
        end
    end
end
-- // Library Functions
do
    library.__index = library
	pages.__index = pages
	sections.__index = sections
    --
    function library:Notification(info)
    end
    --
    function library:Loader(info)
		local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "UI Title"
        local size = info.size or info.Size or Vector2.new(375,359)
        local accent = info.accent or info.Accent or info.color or info.Color or theme.accent
        local callback = info.callback or info.Callback or info.callBack or info.CallBack or function() end
        local pageammount = info.pages or info.Pages or 1
        --
        theme.accent = accent
        --
        local window = {pages = {}, loader = true, isVisible = false, pageammount = pageammount, callback = callback, wminfo = "$$$$$ AntarcticaWare $$$$$ || UID : %u || Ping : %s || Fps : %u", currentPage = nil, fading = false, dragging = false, drag = Vector2.new(0,0), currentContent = {frame = nil, dropdown = nil, multibox = nil, colorpicker = nil, keybind = nil, textbox = nil}}
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
        function window:SetName(Name)
            title.Text = Name
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
            elseif window.currentContent.textbox and window.currentContent.textbox.Disconnect then
                window.currentContent.textbox.Disconnect()
                window.currentContent.textbox = nil
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
                    if v[1].__OBJECT_EXISTS then
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
            for i,v in pairs(library.objects) do
                i:Remove()
            end
            --
            for i,v in pairs(library.began) do
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
            library.shared.initialized = false
            library.drawings = {}
            library.objects = {}
            library.hidden = {}
            library.connections = {}
            library.began = {}
            library.ended = {}
            library.changed = {}
            library.pointers = {}
            library.colors = {}
            --
            uis.MouseIconEnabled = true
        end
        --
        function window:Cursor(info)
            window.cursor = {}
            --
            local cursor = utility:Create("Triangle", nil, {
                Color = theme.cursoroutline,
                Thickness = 2.5,
                Filled = false,
                ZIndex = 65,
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
                ZIndex = 65,
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
            uis.MouseIconEnabled = false
            --
            return window.cursor
        end
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
            uis.MouseIconEnabled = not window.isVisible
            --
            window.fading = false
        end
        --
        function window:Initialize()
            if window.pages[1] then window.pages[1]:Show() end
            --
            for i,v in pairs(window.pages) do
                v:Update()
            end
            --
            library.shared.initialized = true
            --
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
            --
            if window.currentContent.textbox then
                if Find(utility.Keyboard.Letters, utility:InputToString(Input.KeyCode)) then
                    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                        window.currentContent.textbox.Fire((utility:InputToString(Input.KeyCode)):upper())
                    else
                        window.currentContent.textbox.Fire((utility:InputToString(Input.KeyCode)):lower())
                    end
                elseif utility:InputToString(Input.KeyCode) == "Space" then
                    window.currentContent.textbox.Fire(" ")
                elseif utility.Keyboard.Modifiers[utility:InputToString(Input.KeyCode)] then
                    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                        if utility.Keyboard.Modifiers[utility:InputToString(Input.KeyCode)] then
                            window.currentContent.textbox.Fire(utility.Keyboard.Modifiers[utility:InputToString(Input.KeyCode)])
                        end
                    else
                        window.currentContent.textbox.Fire(utility:InputToString(Input.KeyCode))
                    end
                elseif utility:InputToString(Input.KeyCode) == "Back" then
                    window.currentContent.textbox.Fire("Backspace")
                    --
                    window.currentContent.textbox.Backspace = {tick(), 0}
                end
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and window.dragging then
                window.dragging = false
                window.drag = Vector2.new(0, 0)
            end
            --
            if window.currentContent.textbox and window.currentContent.textbox.Fire and window.currentContent.textbox.Backspace then
                if utility:InputToString(Input.KeyCode) == "Back" then
                    window.currentContent.textbox.Backspace = nil
                end
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
            elseif Input.KeyCode == Enum.KeyCode.U then
                window:Unload()
            end
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
        utility:Connection(rs.RenderStepped,function()
            if window.currentContent.textbox and window.currentContent.textbox.Fire and window.currentContent.textbox.Backspace then
                local Time = (tick() - window.currentContent.textbox.Backspace[1])
                --
                if Time > 0.4 then
                    window.currentContent.textbox.Backspace[2] = window.currentContent.textbox.Backspace[2] + 1
                    --
                    if (window.currentContent.textbox.Backspace[2] % 5 == 0) then
                        window.currentContent.textbox.Fire("Backspace")
                    end
                end
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
    function library:New(info)
		local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "UI Title"
        local size = info.size or info.Size or Vector2.new(504,604)
        local accent = info.accent or info.Accent or info.color or info.Color or theme.accent
        local callback = info.callback or info.Callback or info.callBack or info.CallBack or function() end
        local style = info.style or info.Style or 1
        local pageammount = info.PageAmmount
        --
        theme.accent = accent
        --
        local window = {pages = {}, loader = style == 2, init = false, pageammount = pageammount, isVisible = false, callback = callback, uibind = Enum.KeyCode.Z, wminfo = "$$$$$ AntarcticaWare $$$$$ || UID : %u || Ping : %s || Fps : %u", currentPage = nil, fading = false, dragging = false, drag = Vector2.new(0,0), currentContent = {frame = nil, dropdown = nil, multibox = nil, colorpicker = nil, keybind = nil, textbox = nil}}
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
        function ColorLerp(Value, MinColor, MaxColor)
            if Value <= 0 then return MaxColor end
            if Value >= 100 then return MinColor end
            --
            return Color3.new(
                MaxColor.R + (MinColor.R - MaxColor.R) * Value,
                MaxColor.G + (MinColor.G - MaxColor.G) * Value,
                MaxColor.B + (MinColor.B - MaxColor.B) * Value
            )
        end
        -- // Esp Preview
        do
            window.VisualPreview = {
                Size = {X = 5, Y = 0},
                Color1 = Color3.fromRGB(0, 255, 0),
                Color2 = Color3.fromRGB(255, 0, 0),
                HealthBarFade = 0,
                Fading = false,
                State = false,
                Visible = true,
                Drawings = {},
                Components = {
                    Box = {
                        Outline = nil,
                        Box = nil,
                        Fill = nil
                    },
                    HealthBar = {
                        Outline = nil,
                        Box = nil,
                        Value = nil
                    },
                    Skeleton = {
                        Head = {},
                        Torso = {},
                        LeftArm = {},
                        RightArm = {},
                        Hips = {},
                        LeftLeg = {},
                        RightLeg = {},
                        HipsTorso = {}
                    },
                    Chams = {
                        Head = {},
                        Torso = {},
                        LeftArm = {},
                        RightArm = {},
                        LeftLeg = {},
                        RightLeg = {}
                    },
                    Title = {
                        Text = nil
                    },
                    Distance = {
                        Text = nil
                    },
                    Tool = {
                        Text = nil
                    },
                    Flags = {
                        Text = nil
                    }
                }
            }
            --
            local esppreview_frame = utility:Create("Frame", {Vector2.new(main_frame.Size.X + 5,0), main_frame}, {
                Size = utility:Size(0, 236, 0, 339),
                Position = utility:Position(1, 5, 0, 0, main_frame),
                Color = theme.outline
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_frame] = {
                Color = "outline"
            }
            --
            local esppreview_inline = utility:Create("Frame", {Vector2.new(1,1), esppreview_frame}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_frame),
                Position = utility:Position(0, 1, 0, 1, esppreview_frame),
                Color = theme.accent
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inline] = {
                Color = "accent"
            }
            --
            local esppreview_inner = utility:Create("Frame", {Vector2.new(1,1), esppreview_inline}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_inline),
                Position = utility:Position(0, 1, 0, 1, esppreview_inline),
                Color = theme.lightcontrast
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner] = {
                Color = "lightcontrast"
            }
            --
            local esppreview_title = utility:Create("TextLabel", {Vector2.new(4,2), esppreview_inner}, {
                Text = "ESP Preview",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(0, 4, 0, 2, esppreview_inner)
            }, window.VisualPreview.Drawings)
            --
            local esppreview_visiblebutton = utility:Create("TextLabel", {Vector2.new(esppreview_inner.Size.X - (5 + 7),2), esppreview_inner}, {
                Text = "O",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(1, -(5 + 7), 0, 2, esppreview_inner)
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local esppreview_inner_inline = utility:Create("Frame", {Vector2.new(4,18), esppreview_inner}, {
                Size = utility:Size(1, -8, 1, -22, esppreview_inner),
                Position = utility:Position(0, 4, 0, 18, esppreview_inner),
                Color = theme.inline
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner_inline] = {
                Color = "inline"
            }
            --
            local esppreview_inner_outline = utility:Create("Frame", {Vector2.new(1,1), esppreview_inner_inline}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_inner_inline),
                Position = utility:Position(0, 1, 0, 1, esppreview_inner_inline),
                Color = theme.outline
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner_outline] = {
                Color = "outline"
            }
            --
            local esppreview_inner_frame = utility:Create("Frame", {Vector2.new(1,1), esppreview_inner_outline}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_inner_outline),
                Position = utility:Position(0, 1, 0, 1, esppreview_inner_outline),
                Color = theme.darkcontrast
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner_frame] = {
                Color = "darkcontrast"
            }
            --
            local esppreview_frame_previewbox = utility:Create("Frame", {Vector2.new(10,10), esppreview_inner_frame}, {
                Size = utility:Size(1, -20, 1, -20, esppreview_inner_frame),
                Position = utility:Position(0, 10, 0, 10, esppreview_inner_frame),
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            })
            --
            local BoxSize = utility:Size(1, -7, 1, -55, esppreview_frame_previewbox)
            local healthbaroutline
            local healthbar
            local healthvalue
            local boxoutline
            --
            function window.VisualPreview:UpdateHealthBar()
                window.VisualPreview.HealthBarFade = window.VisualPreview.HealthBarFade + 0.015
                local Smoothened = (math.acos(math.cos(window.VisualPreview.HealthBarFade * math.pi)) / math.pi)
                local Size = (healthbaroutline.Size.Y - 2) * Smoothened
                local Color = ColorLerp(Smoothened, window.VisualPreview.Color1, window.VisualPreview.Color2)
                --
                healthvalue.Text = "<- " .. math.round(Smoothened * 100)
                healthvalue.Color = Color
                healthbar.Color = Color
                healthbar.Size = utility:Size(1, -2, 0, Size, healthbaroutline)
                healthbar.Position = utility:Position(0, 1, 1, -Size - 1, healthbaroutline)
                utility:UpdateOffset(healthbar, {Vector2.new(1, healthbaroutline.Size.Y - Size - 1), healthbaroutline})
            end
            --
            function window.VisualPreview:UpdateHealthValue(Size)
                local New = Vector2.new(healthbar.Position.X + (5 - Size), math.clamp(healthbar.Position.Y + 5, 0, (healthbar.Position.Y) + (healthbar.Size.Y) - 18))
                --
                healthvalue.Position = New
                utility:UpdateOffset(healthvalue, {Vector2.new(5 - Size, New.Y - healthbar.Position.Y), healthbar})
            end
            --
            function window.VisualPreview:ValidateSize(Side, Size)
                if not (window.VisualPreview.Size[Side] == Size) then
                    window.VisualPreview.Size[Side] = Size
                    --
                    esppreview_frame.Size = utility:Size(0, 231 + window.VisualPreview.Size[Side], 0, 339)
                    esppreview_inline.Size = utility:Size(1, -2, 1, -2, esppreview_frame)
                    esppreview_inner.Size = utility:Size(1, -2, 1, -2, esppreview_inline)
                    esppreview_inner_inline.Size = utility:Size(1, -8, 1, -22, esppreview_inner)
                    esppreview_inner_outline.Size = utility:Size(1, -2, 1, -2, esppreview_inner_inline)
                    esppreview_inner_frame.Size = utility:Size(1, -2, 1, -2, esppreview_inner_outline)
                    esppreview_frame_previewbox.Size = utility:Size(1, -20, 1, -20, esppreview_inner_frame)
                    --
                    esppreview_visiblebutton.Position = utility:Position(1, -(5 + 7), 0, 2, esppreview_inner)
                    esppreview_frame_previewbox.Position = utility:Position(0, 10, 0, 10, esppreview_inner_frame)
                    --
                    utility:UpdateOffset(esppreview_visiblebutton, {Vector2.new(esppreview_inner.Size.X - (5 + 7),2), esppreview_inner})
                    utility:UpdateOffset(esppreview_frame_previewbox, {Vector2.new(10,10), esppreview_inner_frame})
                    utility:UpdateOffset(boxoutline, {Vector2.new(esppreview_frame_previewbox.Size.X - BoxSize.X - 1, 20), esppreview_frame_previewbox})
                    --
                    window:Move(main_frame.Position + Vector2.new(0, 0))
                end
            end
            --
            function window.VisualPreview:SetPreviewState(State)
                window.VisualPreview.Fading = true
                window.VisualPreview.State = State
                --
                task.spawn(function()
                    for Index, Value in pairs(window.VisualPreview.Drawings) do
                        utility:Lerp(Index, {Transparency = window.VisualPreview.State and Value or 0}, 0.2)
                        utility:UpdateTransparency(Index, window.VisualPreview.State and Value or 0)
                    end
                end)
                --
                window.VisualPreview.Fading = false
            end
            --
            function window.VisualPreview:SetComponentProperty(Component, Property, State, Index)
                for Index2, Value in pairs(window.VisualPreview.Components[Component]) do
                    if Index then
                        Value[Index][Property] = State
                        --
                        if Property == "Transparency" then
                            utility:UpdateTransparency(Value[Index], State)
                            if window.VisualPreview.Drawings[Value[Index]] then
                                window.VisualPreview.Drawings[Value[Index]] = State
                            end
                        end
                    else
                        Value[Property] = State
                        --
                        if Property == "Transparency" then
                            utility:UpdateTransparency(Value, State)
                            if window.VisualPreview.Drawings[Value] then
                                window.VisualPreview.Drawings[Value] = State
                            end
                        end
                    end 
                end
            end
            --
            function window.VisualPreview:SetComponentSelfProperty(Component, Self, Property, State, Index)
                if Index then
                    window.VisualPreview.Components[Component][Self][Index][Property] = State
                    --
                    if Property == "Transparency" then
                        utility:UpdateTransparency(window.VisualPreview.Components[Component][Self][Index], State)
                        if window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self][Index]] then
                            window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self][Index]] = State
                        end
                    end
                else
                    window.VisualPreview.Components[Component][Self][Property] = State
                    --
                    if Property == "Transparency" then
                        utility:UpdateTransparency(window.VisualPreview.Components[Component][Self], State)
                        if window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self]] then
                            window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self]] = State
                        end
                    end
                end 
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and esppreview_visiblebutton.Visible and window.isVisible and utility:MouseOverDrawing({esppreview_visiblebutton.Position.X, esppreview_visiblebutton.Position.Y, esppreview_visiblebutton.Position.X + esppreview_visiblebutton.TextBounds.X, esppreview_visiblebutton.Position.Y + esppreview_visiblebutton.TextBounds.Y}) and not window:IsOverContent() then
                    window.VisualPreview.Visible = not window.VisualPreview.Visible
                    esppreview_visiblebutton.Text = window.VisualPreview.Visible and "O" or "0"
                end
            end
            --
            do -- Preview Stuff
                local preview_boxoutline = utility:Create("Frame", {Vector2.new(esppreview_frame_previewbox.Size.X - BoxSize.X - 1, 20), esppreview_frame_previewbox}, {
                    Size = BoxSize,
                    Position = utility:Position(1, -(BoxSize.X - 1), 0, 20, esppreview_frame_previewbox),
                    Color = Color3.fromRGB(0, 0, 0),
                    Filled = false,
                    Thickness = 2.5
                }, window.VisualPreview.Drawings);boxoutline = preview_boxoutline
                --
                local preview_box = utility:Create("Frame", {Vector2.new(0, 0), preview_boxoutline}, {
                    Size = utility:Size(1, 0, 1, 0, preview_boxoutline),
                    Position = utility:Position(0, 0, 0, 0, preview_boxoutline),
                    Color = Color3.fromRGB(255, 255, 255),
                    Filled = false,
                    Thickness = 0.6
                }, window.VisualPreview.Drawings)
                --
                local preview_heatlhbaroutline = utility:Create("Frame", {Vector2.new(-6, -1), preview_boxoutline}, {
                    Size = utility:Size(0, 4, 1, 2, preview_boxoutline),
                    Position = utility:Position(0, -6, 0, -1, preview_boxoutline),
                    Color = Color3.fromRGB(0, 0, 0),
                    Filled = true
                }, window.VisualPreview.Drawings);healthbaroutline = preview_heatlhbaroutline
                --
                local preview_heatlhbar = utility:Create("Frame", {Vector2.new(1, 1), preview_heatlhbaroutline}, {
                    Size = utility:Size(1, -2, 1, -2, preview_heatlhbaroutline),
                    Position = utility:Position(0, 1, 0, 1, preview_heatlhbaroutline),
                    Color = Color3.fromRGB(255, 0, 0),
                    Filled = true
                }, window.VisualPreview.Drawings);healthbar = preview_heatlhbar
                --
                local preview_title = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X / 2, -20), preview_box}, {
                    Text = "Username",
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Position = utility:Position(0.5, 0, 0, -20, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_distance = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X / 2, preview_box.Size.Y + 5), preview_box}, {
                    Text = "25m",
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Position = utility:Position(0.5, 0, 1, 5, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_tool = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X / 2, preview_box.Size.Y + 20), preview_box}, {
                    Text = "Weapon",
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Position = utility:Position(0.5, 0, 1, 20, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_character = utility:Create("Frame", {Vector2.new(46/2, 40/2), preview_box}, {
                    Size = utility:Size(1, -46, 1, -40, preview_box),
                    Position = utility:Position(0, (46/2), 0, (40/2), preview_box),
                    Color = Color3.fromRGB(255, 255, 255),
                    Transparency = 0
                }, window.VisualPreview.Drawings)
                --
                do -- Chams
                    for Index = 1, 2 do
                        local transparency = Index == 1 and 0.75 or 0.5
                        local color = Index == 1 and Color3.fromRGB(93, 62, 152) or Color3.fromRGB(255, 255, 255)
                        --
                        local extrasize = Index == 1 and 4 or 0
                        local extraoffset = Index == 1 and -2 or 0
                        --
                        local preview_character_head = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.35) + (extraoffset), extraoffset), preview_character}, {
                            Size = utility:Size(0.3, extrasize, 0.2, 0, preview_character),
                            Position = utility:Position(0.35, extraoffset, 0, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_torso = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.25) + (extraoffset), (preview_character.Size.Y * 0.2) + (extraoffset)), preview_character}, {
                            Size = utility:Size(0.5, extrasize, 0.4, extrasize, preview_character),
                            Position = utility:Position(0.25, extraoffset, 0.2, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_leftarm = utility:Create("Frame", {Vector2.new(extraoffset, (preview_character.Size.Y * 0.2) + (extraoffset)), preview_character}, {
                            Size = utility:Size(0.25, 0, 0.4, extrasize, preview_character),
                            Position = utility:Position(0, extraoffset, 0.2, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_rightarm = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.75) + (extraoffset + extrasize), (preview_character.Size.Y * 0.2) + (extraoffset)), preview_character}, {
                            Size = utility:Size(0.25, 0, 0.4, extrasize, preview_character),
                            Position = utility:Position(0.75, extraoffset, 0.2, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_leftleg = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.25) + (extraoffset), (preview_character.Size.Y * 0.6) + (extraoffset + extrasize)), preview_character}, {
                            Size = utility:Size(0.25, extrasize / 2, 0.4, 0, preview_character),
                            Position = utility:Position(0.25, extraoffset, 0.6, extraoffset + extrasize, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_rightleg = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.5) + (extraoffset + (extrasize / 2)), (preview_character.Size.Y * 0.6) + (extraoffset + extrasize)), preview_character}, {
                            Size = utility:Size(0.25, extrasize / 2, 0.4, 0, preview_character),
                            Position = utility:Position(0.25, extraoffset, 0.6, extraoffset + extrasize, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        window.VisualPreview.Components.Chams["Head"][Index] = preview_character_head
                        window.VisualPreview.Components.Chams["Torso"][Index] = preview_character_torso
                        window.VisualPreview.Components.Chams["LeftArm"][Index] = preview_character_leftarm
                        window.VisualPreview.Components.Chams["RightArm"][Index] = preview_character_rightarm
                        window.VisualPreview.Components.Chams["LeftLeg"][Index] = preview_character_leftleg
                        window.VisualPreview.Components.Chams["RightLeg"][Index] = preview_character_rightleg
                    end
                end
                --
                do -- Skeleton
                    for Index = 1, 2 do
                        local skeletonsize = Vector2.new(Index == 1 and 3 or 1, Index == 1 and -10 or -12)
                        local skeletonoffset = Vector2.new(Index == 1 and -1 or 0, Index == 1 and 5 or 6)
                        local transparency = 0.5
                        local color = Index == 1 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
                        --
                        local preview_skeleton_head = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["Head"][2].Size.X * 0.5) + skeletonoffset.X, (window.VisualPreview.Components.Chams["Head"][2].Size.Y * 0.5) + skeletonoffset.Y), window.VisualPreview.Components.Chams["Head"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 0.5, 0, window.VisualPreview.Components.Chams["Head"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0.5, skeletonoffset.Y, window.VisualPreview.Components.Chams["Head"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_torso = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["Torso"][2].Size.X * 0) + skeletonoffset.X - (window.VisualPreview.Components.Chams["LeftArm"][2].Size.X / 2) + (Index == 1 and 3 or 1), skeletonoffset.Y), window.VisualPreview.Components.Chams["Torso"][2]}, {
                            Size = utility:Size(1, skeletonsize.X + window.VisualPreview.Components.Chams["LeftArm"][2].Size.X - (Index == 1 and 6 or 2), 0, skeletonsize.X, window.VisualPreview.Components.Chams["Torso"][2]),
                            Position = utility:Position(0, skeletonoffset.X - (window.VisualPreview.Components.Chams["LeftArm"][2].Size.X / 2) + (Index == 1 and 3 or 1), 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["Torso"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_leftarm = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["LeftArm"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["LeftArm"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["LeftArm"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["LeftArm"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_rightarm = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["RightArm"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["RightArm"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["RightArm"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["RightArm"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_hips = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["LeftLeg"][2].Size.X * 1) + skeletonoffset.X - (window.VisualPreview.Components.Chams["LeftLeg"][2].Size.X / 2) + (Index == 1 and 3 or 1), skeletonoffset.Y), window.VisualPreview.Components.Chams["LeftLeg"][2]}, {
                            Size = utility:Size(1, skeletonsize.X - (Index == 1 and 6 or 2), 0, skeletonsize.X, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X + (Index == 1 and 3 or 1), 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_leftleg = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["LeftLeg"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["LeftLeg"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_rightleg = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["RightLeg"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["RightLeg"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["RightLeg"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["RightLeg"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_hipstorso = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["Torso"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y + (Index == 1 and 3 or 1)), window.VisualPreview.Components.Chams["Torso"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, Index == 1 and -3 or -1, window.VisualPreview.Components.Chams["Torso"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y + (Index == 1 and 3 or 1), window.VisualPreview.Components.Chams["Torso"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        window.VisualPreview.Components.Skeleton["Head"][Index] = preview_skeleton_head
                        window.VisualPreview.Components.Skeleton["Torso"][Index] = preview_skeleton_torso
                        window.VisualPreview.Components.Skeleton["LeftArm"][Index] = preview_skeleton_leftarm
                        window.VisualPreview.Components.Skeleton["RightArm"][Index] = preview_skeleton_rightarm
                        window.VisualPreview.Components.Skeleton["Hips"][Index] = preview_skeleton_hips
                        window.VisualPreview.Components.Skeleton["LeftLeg"][Index] = preview_skeleton_leftleg
                        window.VisualPreview.Components.Skeleton["RightLeg"][Index] = preview_skeleton_rightleg
                        window.VisualPreview.Components.Skeleton["HipsTorso"][Index] = preview_skeleton_hipstorso
                    end
                end
                --
                local preview_boxfill = utility:Create("Frame", {Vector2.new(1, 1), preview_boxoutline}, {
                    Size = utility:Size(1, -2, 1, -2, preview_boxoutline),
                    Position = utility:Position(0, 1, 0, 1, preview_boxoutline),
                    Color = Color3.fromRGB(255, 255, 255),
                    Filled = true,
                    Transparency = 0.9
                }, window.VisualPreview.Drawings)
                --
                local preview_flags = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X -56, 5), preview_box}, {
                    Text = "Flags ->", --Display\nMoving\nJumping\nDesynced"
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = Color3.fromRGB(255, 255, 255),
                    OutlineColor = theme.textborder,
                    Center = false,
                    Position = utility:Position(1, -56, 0, 5, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_healthbarvalue = utility:Create("TextLabel", {Vector2.new(0, 5), preview_heatlhbar}, {
                    Text = "<- Number", --Display\nMoving\nJumping\nDesynced"
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = Color3.fromRGB(0, 255, 0),
                    OutlineColor = theme.textborder,
                    Center = false,
                    Position = utility:Position(0, 0, 0, 5, preview_heatlhbar)
                }, window.VisualPreview.Drawings);healthvalue = preview_healthbarvalue
                --
                window.VisualPreview.Components.Title["Text"] = preview_title
                window.VisualPreview.Components.Distance["Text"] = preview_distance
                window.VisualPreview.Components.Tool["Text"] = preview_tool
                window.VisualPreview.Components.Flags["Text"] = preview_flags
                window.VisualPreview.Components.Box["Outline"] = preview_boxoutline
                window.VisualPreview.Components.Box["Box"] = preview_box
                window.VisualPreview.Components.Box["Fill"] = preview_boxfill
                window.VisualPreview.Components.HealthBar["Outline"] = preview_heatlhbaroutline
                window.VisualPreview.Components.HealthBar["Box"] = preview_heatlhbar
                window.VisualPreview.Components.HealthBar["Value"] = preview_healthbarvalue
            end
            --
            do -- New Drawings
                local NewDrawings = {}
                --
                for Index, Value in pairs(library.drawings) do
                    if Value[1] and table.find(window.VisualPreview.Drawings, Value[1]) then
                        NewDrawings[Value[1]] = Value[3]
                    end
                end
                --
                window.VisualPreview.Drawings = NewDrawings
            end
        end
        --
        function window:SetName(Name)
            title.Text = Name
        end
        --
        function window:GetConfig()
            local config = {}
            --
            for i,v in pairs(library.pointers) do
                if typeof(v:Get()) == "table" and v:Get().Transparency then
                    local hue, sat, val = v:Get().Color:ToHSV()
                    config[i] = {Color = {hue, sat, val}, Transparency = v:Get().Transparency}
                else
                    config[i] = v:Get()
                end
            end
            --
            return game:GetService("HttpService"):JSONEncode(config)
        end
        --
        function window:LoadConfig(config)
            local config = hs:JSONDecode(config)
            --
            for i,v in pairs(config) do
                if library.pointers[i] then
                    library.pointers[i]:Set(v)
                end
            end
        end
        --
        function window:Move(vector)
            for i,v in pairs(library.drawings) do
                if v[1].Visible then
                    if v[2][2] then
                        v[1].Position = utility:Position(0, v[2][1].X, 0, v[2][1].Y, v[2][2])
                    else
                        v[1].Position = utility:Position(0, vector.X, 0, vector.Y)
                    end
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
            elseif window.currentContent.textbox and window.currentContent.textbox.Disconnect then
                if window.currentContent.textbox.Item.oldenter ~= window.currentContent.textbox.Item.current then
                    window.currentContent.textbox.Item.oldenter = window.currentContent.textbox.Item.current
                    task.spawn(function()
                        window.currentContent.textbox.Item.callback(window.currentContent.textbox.Item.current, true)
                    end)
                end
                window.currentContent.textbox.Disconnect()
                window.currentContent.textbox = nil
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
                    if v[1].__OBJECT_EXISTS then
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
            for i,v in pairs(library.objects) do
                i:Remove()
            end
            --
            for i,v in pairs(library.began) do
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
            library.drawings = {}
            library.objects = {}
            library.hidden = {}
            library.connections = {}
            library.began = {}
            library.ended = {}
            library.changed = {}
            --
            uis.MouseIconEnabled = true
        end
        --
        function window:Watermark(info)
            window.watermark = {visible = false}
            --
            local info = info or {}
            local watermark_name = info.name or info.Name or info.title or info.Title or window.wminfo
            --
            local text_bounds = utility:GetTextBounds(watermark_name, theme.textsize, theme.font)
            --
            local watermark_outline = utility:Create("Frame", {Vector2.new(100,38/2-10)}, {
                Size = utility:Size(0, text_bounds.X+20, 0, 21),
                Position = utility:Position(0, 100, 0, 38/2-10),
                Hidden = true,
                ZIndex = 60,
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
                ZIndex = 60,
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
                ZIndex = 60,
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
                ZIndex = 60,
                Color = theme.accent,
                Visible = window.watermark.visible
            })
            --
            library.colors[watermark_accent] = {
                Color = "accent"
            }
            --
            local watermark_title = utility:Create("TextLabel", {Vector2.new(2 + 6,4), watermark_outline}, {
                Text = "Failed Loading Watermark.",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Hidden = true,
                ZIndex = 60,
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
            local temp = tick()
            local Tick = tick()
            --
            utility:Connection(rs.RenderStepped, function(FPS)
                library.shared.fps = math.floor(1 / math.abs(temp - tick()))
                temp = tick()
                library.shared.ping = stats.Network:FindFirstChild("ServerStatsItem") and tostring(math.round(stats.Network.ServerStatsItem["Data Ping"]:GetValue())) or "Unknown"
                --
                task.spawn(function()
                    if (tick() - Tick) > 0.15 then
                        watermark_title.Text = window.wminfo:gsub("$PING", library.shared.ping):gsub("$FPS", library.shared.fps)
                        window.watermark:UpdateSize()
                        --
                        Tick = tick()
                    end
                end)
            end)
            --
            return window.watermark
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
                ZIndex = 55,
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
                ZIndex = 55,
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
                ZIndex = 55,
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
                ZIndex = 55,
                Color = theme.accent,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_accent] = {
                Color = "accent"
            }
            --
            local keybindslist_title = utility:Create("TextLabel", {Vector2.new(keybindslist_outline.Size.X/2,4), keybindslist_outline}, {
                Text = "[ Keybinds ]",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                ZIndex = 55,
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
                ZIndex = 55,
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
                ZIndex = 55,
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
                ZIndex = 55,
                Color = theme.accent,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_accent] = {
                Color = "accent"
            }
            --
            local statuslist_title = utility:Create("TextLabel", {Vector2.new(statuslist_outline.Size.X/2,4), statuslist_outline}, {
                Text = "[ Statuses ]",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                        ZIndex = 55,
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
                ZIndex = 65,
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
                ZIndex = 65,
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
            uis.MouseIconEnabled = false
            --
            return window.cursor
        end
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
            uis.MouseIconEnabled = not window.isVisible
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
            window.init = true
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
            --
            if window.currentContent.textbox then
                if Find(utility.Keyboard.Letters, utility:InputToString(Input.KeyCode)) then
                    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                        window.currentContent.textbox.Fire((utility:InputToString(Input.KeyCode)):upper())
                    else
                        window.currentContent.textbox.Fire((utility:InputToString(Input.KeyCode)):lower())
                    end
                elseif utility:InputToString(Input.KeyCode) == "Space" then
                    window.currentContent.textbox.Fire(" ")
                elseif utility.Keyboard.Modifiers[utility:InputToString(Input.KeyCode)] then
                    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                        if utility.Keyboard.Modifiers[utility:InputToString(Input.KeyCode)] then
                            window.currentContent.textbox.Fire(utility.Keyboard.Modifiers[utility:InputToString(Input.KeyCode)])
                        end
                    else
                        window.currentContent.textbox.Fire(utility:InputToString(Input.KeyCode))
                    end
                elseif utility:InputToString(Input.KeyCode) == "Back" then
                    window.currentContent.textbox.Fire("Backspace")
                    --
                    window.currentContent.textbox.Backspace = {tick(), 0}
                end
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and window.dragging then
                window.dragging = false
                window.drag = Vector2.new(0, 0)
            end
            --
            if window.currentContent.textbox and window.currentContent.textbox.Fire and window.currentContent.textbox.Backspace then
                if utility:InputToString(Input.KeyCode) == "Back" then
                    window.currentContent.textbox.Backspace = nil
                end
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
        utility:Connection(rs.RenderStepped,function()
            if window.currentContent.textbox and window.currentContent.textbox.Fire and window.currentContent.textbox.Backspace then
                local Time = (tick() - window.currentContent.textbox.Backspace[1])
                --
                if Time > 0.4 then
                    window.currentContent.textbox.Backspace[2] = window.currentContent.textbox.Backspace[2] + 1
                    --
                    if (window.currentContent.textbox.Backspace[2] % 5 == 0) then
                        window.currentContent.textbox.Fire("Backspace")
                    end
                end
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
            Size = utility:Size(0, window.pageammount and (((window.back_frame.Size.X - 8 - ((window.pageammount - 1) * 2)) / window.pageammount)) or (textbounds.X+20), 0, 21),
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
            Color = theme.textdark,
            Center = true,
            OutlineColor = theme.textborder,
            Position = utility:Position(0.5, 0, 0, 2, page_button_color)
        });page["page_button_title"] = page_button_title
        --
        library.colors[page_button_title] = {
            OutlineColor = "textborder",
            Color = "textdark"
        }
        --
        window.pages[#window.pages + 1] = page
        --
        function page:GetTotalYSize(Side)
            local TotalYSize = 0
            --
            for i,v in pairs(page.sections) do
                if v.side == Side then
                    TotalYSize = TotalYSize + v.section_inline.Size.Y + 5
                end
            end
            --
            return TotalYSize
        end
        --
        function page:Update()
            page.sectionOffset["left"] = 0
            page.sectionOffset["right"] = 0
            --
            for i,v in pairs(page.sections) do
                if v.side then
                    utility:UpdateOffset(v.section_inline, {Vector2.new(v.side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][v.side]), window.tab_frame})
                    v:Update(page.sectionOffset[v.side] + 10)
                    page.sectionOffset[v.side] = page.sectionOffset[v.side] + v.section_inline.Size.Y + 5
                else
                    page.sectionOffset["left"] = page.sectionOffset["left"] + v["playerList_inline"].Size.Y + 5
                    page.sectionOffset["right"] = page.sectionOffset["right"] + v["playerList_inline"].Size.Y + 5
                end
            end
            --
            window:Move(window.main_frame.Position)
        end
        --
        function page:Show()
            if window.currentPage then
                window.currentPage.page_button_color.Size = utility:Size(1, -2, 1, -1, window.currentPage.page_button_inline)
                window.currentPage.page_button_color.Color = theme.darkcontrast
                window.currentPage.page_button_title.Color = theme.textdark
                window.currentPage.open = false
                --
                library.colors[window.currentPage.page_button_color] = {
                    Color = "darkcontrast"
                }
                --
                library.colors[window.currentPage.page_button_title] = {
                    OutlineColor = "textborder",
                    Color = "textdark"
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
            page_button_title.Color = theme.textcolor
            page.open = true
            --
            library.colors[page_button_color] = {
                Color = "lightcontrast"
            }
            --
            library.colors[page_button_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            for i,v in pairs(page.sections) do
                for z,x in pairs(v.visibleContent) do
                    x.Visible = true
                end
            end
            --
            window.callback(name, window.currentPage)
            window:Move(window.main_frame.Position)
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
        local window = self.window
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Section"
        local size = info.size or info.Size
        local fill = info.fill or info.Fill
        local side = window.loader and "left" or (info.side or info.Side or "left")
        side = side:lower()
        local page = self
        local section = {window = window, page = page, visibleContent = {}, currentAxis = 20, side = side}
        --
        local section_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(window.loader and 1 or 0.5, window.loader and -10 or -7, 0, size or 22, window.tab_frame),
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
            Size = utility:Size(1, 0, 0, 2, section_frame),
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
        function section:Update(Padding)
            section_inline.Size = utility:Size(window.loader and 1 or 0.5, window.loader and -10 or -7, 0, fill and (window.tab_frame.Size.Y - (Padding or 0)) or (size or (section.currentAxis+4)), window.tab_frame)
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
        local fill = info.fill or info.Fill
        local callback = info.callback or info.Callback or info.callBack or info.CallBack or function() end
        side = side:lower()
        local window = self.window
        local page = self
        local multiSection = {window = window, page = page, sections = {}, backup = {}, visibleContent = {}, currentSection = nil, side = side}
        --
        local multiSection_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(window.loader and 1 or 0.5, window.loader and -10 or -7, 0, size, window.tab_frame),
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
        function multiSection:Update(Padding)
            multiSection_inline.Size = utility:Size(window.loader and 1 or 0.5, window.loader and -10 or -7, 0, fill and (window.tab_frame.Size.Y - (Padding or 0)) or size, window.tab_frame)
            multiSection_outline.Size = utility:Size(1, -2, 1, -2, multiSection_inline)
            multiSection_frame.Size = utility:Size(1, -2, 1, -2, multiSection_outline)
            --
            for Index, Value in pairs(multiSection.sections) do
                Value:Update(Padding)
            end
        end
        --
        for i,v in pairs(msections) do
            local msection = {window = window, page = page, currentAxis = 24, sections = {}, visibleContent = {}, section_inline = multiSection_inline, section_outline = multiSection_outline, section_frame = multiSection_frame, section_accent = multiSection_accent}
            --
            local textBounds = utility:GetTextBounds(v, theme.textsize, theme.font)
            --
            local msection_frame = utility:Create("Frame", {Vector2.new(((i - 1) * (1 / #msections)) * multiSection_backFrame.Size.X,0), multiSection_backFrame}, {
                Size = utility:Size(1 / #msections, 0, 1, -1, multiSection_backFrame),
                Position = utility:Position((i - 1) * (1 / #msections), 0, 0, 0, multiSection_backFrame),
                Color = i == 1 and theme.darkcontrast or theme.lightcontrast,
                Visible = page.open
            }, multiSection.visibleContent);msection["msection_frame"] = msection_frame
            --
            library.colors[msection_frame] = {
                Color = i == 1 and "darkcontrast" or "lightcontrast"
            }
            --
            local msection_line = utility:Create("Frame", {Vector2.new(msection_frame.Size.X - (i == #msections and 0 or 1),0), msection_frame}, {
                Size = utility:Size(0, 1, 1, 0, msection_frame),
                Position = utility:Position(1, -(i == #msections and 0 or 1), 0, 0, msection_frame),
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
                Size = utility:Size(1, (i == #msections and 0 or -1), 0, 1, msection_frame),
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
                    --
                    callback(v, msection)
                    window:Move(window.main_frame.Position)
                end
            end
            --
            if i == 1 then
                multiSection.currentSection = msection
                callback(v, msection)
            end
            --
            multiSection.sections[#multiSection.sections + 1] = setmetatable(msection, sections)
        end
        --
        for z,x in pairs(multiSection.visibleContent) do
            multiSection.backup[z] = x
        end
        --
        page.sectionOffset[side] = page.sectionOffset[side] + 100 + 5
        page.sections[#page.sections + 1] = multiSection
        --
        return Unpack(multiSection.sections)
    end
    --
    function pages:PlayerList(info)
        local info = info or {}
        --
        local window = self.window
        local page = self
        --
        local playerList = {window = window, page = page, visibleContent = {}, buttons = {}, currentAxis = 20, scrollingindex = 0, scrolling = {false, nil}, items = {}, players = {}}
        --
        local playerList_inline = utility:Create("Frame", {Vector2.new(5,5), window.tab_frame}, {
            Size = utility:Size(1, -10, 0, ((10 * 22) + 4) + 20 + 60 + 12, window.tab_frame),
            Position = utility:Position(0, 5, 0, 5, window.tab_frame),
            Color = theme.inline,
            Visible = page.open
        }, playerList.visibleContent);playerList["playerList_inline"] = playerList_inline
        --
        library.colors[playerList_inline] = {
            Color = "inline"
        }
        --
        local playerList_outline = utility:Create("Frame", {Vector2.new(1,1), playerList_inline}, {
            Size = utility:Size(1, -2, 1, -2, playerList_inline),
            Position = utility:Position(0, 1, 0, 1, playerList_inline),
            Color = theme.outline,
            Visible = page.open
        }, playerList.visibleContent);playerList["playerList_outline"] = playerList_outline
        --
        library.colors[playerList_outline] = {
            Color = "outline"
        }
        --
        local playerList_frame = utility:Create("Frame", {Vector2.new(1,1), playerList_outline}, {
            Size = utility:Size(1, -2, 1, -2, playerList_outline),
            Position = utility:Position(0, 1, 0, 1, playerList_outline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, playerList.visibleContent);playerList["playerList_frame"] = playerList_frame
        --
        library.colors[playerList_frame] = {
            Color = "darkcontrast"
        }
        --
        local playerList_accent = utility:Create("Frame", {Vector2.new(0,0), playerList_frame}, {
            Size = utility:Size(1, 0, 0, 2, playerList_frame),
            Position = utility:Position(0, 0, 0, 0, playerList_frame),
            Color = theme.accent,
            Visible = page.open
        }, playerList.visibleContent);playerList["playerList_accent"] = playerList_accent
        --
        library.colors[playerList_accent] = {
            Color = "accent"
        }
        --
        local playerList_title = utility:Create("TextLabel", {Vector2.new(3,3), playerList_frame}, {
            Text = "Player List - 0 Players",
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, 3, playerList_frame),
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[playerList_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local list_outline = utility:Create("Frame", {Vector2.new(4,20), playerList_frame}, {
            Size = utility:Size(1, -8, 0, ((10 * 22) + 4), playerList_frame),
            Position = utility:Position(0, 4, 0, 20, playerList_frame),
            Color = theme.outline,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[list_outline] = {
            Color = "outline"
        }
        --
        local list_inline = utility:Create("Frame", {Vector2.new(1,1), list_outline}, {
            Size = utility:Size(1, -2, 1, -2, list_outline),
            Position = utility:Position(0, 1, 0, 1, list_outline),
            Color = theme.inline,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[list_inline] = {
            Color = "inline"
        }
        --
        local list_frame = utility:Create("Frame", {Vector2.new(1,1), list_inline}, {
            Size = utility:Size(1, -10, 1, -2, list_inline),
            Position = utility:Position(0, 1, 0, 1, list_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[list_frame] = {
            Color = "lightcontrast"
        }
        --
        local list_scroll = utility:Create("Frame", {Vector2.new(list_inline.Size.X - 9,1), list_inline}, {
            Size = utility:Size(0, 8, 1, -2, list_inline),
            Position = utility:Position(1, -9, 0, 1, list_inline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[list_scroll] = {
            Color = "darkcontrast"
        }
        --
        local list_bar = utility:Create("Frame", {Vector2.new(1,1), list_scroll}, {
            Size = utility:Size(1, -2, 0.5, -2, list_scroll),
            Position = utility:Position(0, 1, 0, 1, list_scroll),
            Color = theme.accent,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[list_bar] = {
            Color = "accent"
        }
        --
        local list_gradient = utility:Create("Image", {Vector2.new(0,0), list_frame}, {
            Size = utility:Size(1, 0, 1, 0, list_frame),
            Position = utility:Position(0, 0, 0 , 0, list_frame),
            Transparency = 0.25,
            Visible = page.open
        }, playerList.visibleContent)
        --
        for Index = 1, 10 do
            local item = {}
            local listitemposition = (Index - 1) * 22
            --
            local listitem_line
            --
            if Index ~= 10 then
                listitem_line = utility:Create("Frame", {Vector2.new(3,listitemposition + 21), list_frame}, {
                    Size = utility:Size(1, -6, 0, 2, list_frame),
                    Position = utility:Position(0, 3, 0, listitemposition + 21, list_frame),
                    Transparency = 0,
                    Color = theme.outline,
                    Visible = page.open
                }, playerList.visibleContent)
                --
                library.colors[listitem_line] = {
                    Color = "outline"
                }
            end
            --
            local listitem_firstline = utility:Create("Frame", {Vector2.new(1/3 * list_frame.Size.X,listitemposition + 3), list_frame}, {
                Size = utility:Size(0, 2, 0, 16, list_frame),
                Position = utility:Position(1/3, 1, 0, listitemposition + 3, list_frame),
                Transparency = 0,
                Color = theme.outline,
                Visible = page.open
            }, playerList.visibleContent)
            --
            library.colors[listitem_firstline] = {
                Color = "outline"
            }
            --
            local listitem_secondline = utility:Create("Frame", {Vector2.new(2/3 * list_frame.Size.X,listitemposition + 3), list_frame}, {
                Size = utility:Size(0, 2, 0, 16, list_frame),
                Position = utility:Position(2/3, 1, 0, listitemposition + 3, list_frame),
                Transparency = 0,
                Color = theme.outline,
                Visible = page.open
            }, playerList.visibleContent)
            --
            library.colors[listitem_secondline] = {
                Color = "outline"
            }
            --
            local listitem_username = utility:Create("TextLabel", {Vector2.new(4, 4 + listitemposition), list_frame}, {
                Text = "",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(0, 4, 0, 4 + listitemposition, list_frame),
                Visible = page.open
            }, playerList.visibleContent)
            --
            library.colors[listitem_username] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local listitem_team = utility:Create("TextLabel", {Vector2.new(6 + (1/3 * list_frame.Size.X), 4 + listitemposition), list_frame}, {
                Text = "",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(1/3, 6, 0, 4 + listitemposition, list_frame),
                Visible = page.open
            }, playerList.visibleContent)
            --
            library.colors[listitem_team] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local listitem_status = utility:Create("TextLabel", {Vector2.new(6 + (2/3 * list_frame.Size.X), 4 + listitemposition), list_frame}, {
                Text = "",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(2/3, 6, 0, 4 + listitemposition, list_frame),
                Visible = page.open
            }, playerList.visibleContent)
            --
            library.colors[listitem_status] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function item:Set(enabled, selected)
                if listitem_line then
                    if window.isVisible then
                        listitem_line.Transparency = enabled and 0.3 or 0
                    end
                    --
                    utility:UpdateTransparency(listitem_line, enabled and 0.3 or 0)
                end
                --
                if window.isVisible then
                    listitem_firstline.Transparency = enabled and 0.3 or 0
                    listitem_secondline.Transparency = enabled and 0.3 or 0
                end
                --
                utility:UpdateTransparency(listitem_firstline, enabled and 0.3 or 0)
                utility:UpdateTransparency(listitem_secondline, enabled and 0.3 or 0)
                --
                if enabled then
                    listitem_username.Text = selected[2]
                    listitem_team.Text = selected[1].Team and tostring(selected[1].Team) or "None"
                    listitem_status.Text = selected[3]
                    --
                    listitem_username.Color = selected[4] and theme.accent or theme.textcolor
                    listitem_status.Color = selected[3] == "Local Player" and Color3.fromRGB(200, 55, 200) or selected[3] == "Priority" and Color3.fromRGB(55, 55, 200) or selected[3] == "Friend" and Color3.fromRGB(55, 200, 55) or selected[3] == "Enemy" and Color3.fromRGB(200, 55, 55) or theme.textcolor
                    --
                    library.colors[listitem_username] = {
                        OutlineColor = "textborder",
                        Color = selected[4] and "accent" or "textcolor"
                    }
                    -- 
                    library.colors[listitem_status] = {
                        OutlineColor = "textborder",
                        Color = selected[3] == "None" and "textcolor" or nil
                    }
                else
                    listitem_username.Text = ""
                    listitem_team.Text = ""
                    listitem_status.Text = ""
                end
            end
            --
            playerList.items[#playerList.items + 1] = item
        end
        --
        local options_iconoutline = utility:Create("Frame", {Vector2.new(0,list_outline.Size.Y + 4), list_outline}, {
            Size = utility:Size(0, 60, 0, 60, list_outline),
            Position = utility:Position(0, 0, 1, 4, list_outline),
            Color = theme.outline,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[options_iconoutline] = {
            Color = "outline"
        }
        --
        local options_iconinline = utility:Create("Frame", {Vector2.new(1,1), options_iconoutline}, {
            Size = utility:Size(1, -2, 1, -2, options_iconoutline),
            Position = utility:Position(0, 1, 0, 1, options_iconoutline),
            Color = theme.inline,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[options_iconinline] = {
            Color = "inline"
        }
        --
        local options_iconframe = utility:Create("Frame", {Vector2.new(1,1), options_iconinline}, {
            Size = utility:Size(1, -2, 1, -2, options_iconinline),
            Position = utility:Position(0, 1, 0, 1, options_iconinline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[options_iconframe] = {
            Color = "lightcontrast"
        }
        --
        local options_avatar = utility:Create("Image", {Vector2.new(0,0), options_iconframe}, {
            Size = utility:Size(1, 0, 1, 0, options_iconframe),
            Position = utility:Position(0, 0, 0 , 0, options_iconframe),
            Transparency = 0.8,
            Visible = page.open
        }, playerList.visibleContent)
        --
        local options_loadingtext = utility:Create("TextLabel", {Vector2.new((options_iconoutline.Size.X / 2) - 1, (options_iconoutline.Size.X / 2) - 10), options_iconframe}, {
            Text = "..?",
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textdark,
            OutlineColor = theme.textborder,
            Position = utility:Position(0.5, -1, 0.5, -10, options_iconframe),
            Center = true,
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[options_loadingtext] = {
            OutlineColor = "textborder",
            Color = "textdark"
        }
        --
        local options_title = utility:Create("TextLabel", {Vector2.new(options_iconoutline.Size.X + 5, 0), options_iconoutline}, {
            Text = "No player selected.", -- ("Display Name : %s\nName : %s\nHealth : %s/%s"):format("gg_bbot", "1envo", "100", "100")
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(1, 5, 0, 0, options_iconoutline),
            Visible = page.open
        }, playerList.visibleContent)
        --
        library.colors[options_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        for Index = 1, 1 do
            local button = {
                open = false,
                current = "None",
                options = {"None", "Friend", "Enemy", "Priority"},
                holder = {buttons = {}, drawings = {}},
                selection = nil
            }
            --
            local button_outline = utility:Create("Frame", {Vector2.new(list_outline.Size.X - 180, list_outline.Size.Y + (Index == 1 and 10 or 36)), list_outline}, {
                Size = utility:Size(0, 180, 0, 22, list_outline),
                Position = utility:Position(1, -180, 1, Index == 1 and 10 or 36, list_outline),
                Color = theme.outline,
                Visible = page.open
            }, playerList.visibleContent)
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
            }, playerList.visibleContent)
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
            }, playerList.visibleContent)
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
            }, playerList.visibleContent)
            --
            local button_title = utility:Create("TextLabel", {Vector2.new(button_frame.Size.X/2,1), button_frame}, {
                Text = Index == 1 and "Prioritise" or "Friendly",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 1, button_frame),
                Visible = page.open
            }, playerList.visibleContent)
            --
            library.colors[button_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local button_image = utility:Create("Image", {Vector2.new(button_frame.Size.X - 15,button_frame.Size.Y/2 - 3), button_frame}, {
                Size = utility:Size(0, 9, 0, 6, button_frame),
                Position = utility:Position(1, -15, 0.5, -3, button_frame),
                Visible = page.open
            }, playerList.visibleContent)
            --
            utility:LoadImage(button_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
            --
            function button:Update(Selection)
                local Visible = Selection ~= nil and (Selection[1] ~= localplayer) or false
                --
                for Index, Value in pairs({button_outline, button_inline, button_frame, button_gradient, button_title, button_image}) do
                    Value.Visible = page.open and Visible or false
                    --
                    if Visible then
                        local fnd = table.find(playerList.visibleContent, Value)
                        --
                        if not fnd then
                            playerList.visibleContent[#playerList.visibleContent + 1] = Value
                        end
                    else
                        local fnd = table.find(playerList.visibleContent, Value)
                        --
                        if fnd then
                            table.remove(playerList.visibleContent, fnd)
                        end
                    end
                end
                --
                if Selection then
                    button_title.Text = Selection[3]
                    button.current = Selection[3]
                    button.selection = Selection
                else
                    button.selection = nil
                end
            end
            --
            function button:UpdateValue()
                if button.open and button.holder.inline then
                    for i,v in pairs(button.holder.buttons) do
                        local value = button.options[i]
                        --
                        v[1].Text = value
                        v[1].Color = value == tostring(button.current) and theme.accent or theme.textcolor
                        v[1].Position = utility:Position(0, value == tostring(button.current) and 8 or 6, 0, 2, v[2])
                        library.colors[v[1]] = {
                            Color = v[1].Text == tostring(button.current) and "accent" or "textcolor"
                        }
                        utility:UpdateOffset(v[1], {Vector2.new(v[1].Text == tostring(button.current) and 8 or 6, 2), v[2]})
                    end
                end
            end
            --
            function button:Close()
                button.open = not button.open
                utility:LoadImage(button_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(button.holder.drawings) do
                    utility:Remove(v)
                end
                --
                button.holder.drawings = {}
                button.holder.buttons = {}
                button.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.button = nil
            end
            --
            function button:Open()
                window:CloseContent()
                button.open = not button.open
                utility:LoadImage(button_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                --
                local button_open_outline = utility:Create("Frame", {Vector2.new(0,21), button_outline}, {
                    Size = utility:Size(1, 0, 0, 3 + (#button.options * 19), button_outline),
                    Position = utility:Position(0, 0, 0, 21, button_outline),
                    Color = theme.outline,
                    Visible = page.open
                }, button.holder.drawings);button.holder.outline = button_open_outline
                --
                library.colors[button_open_outline] = {
                    Color = "outline"
                }
                --
                local button_open_inline = utility:Create("Frame", {Vector2.new(1,1), button_open_outline}, {
                    Size = utility:Size(1, -2, 1, -2, button_open_outline),
                    Position = utility:Position(0, 1, 0, 1, button_open_outline),
                    Color = theme.inline,
                    Visible = page.open
                }, button.holder.drawings);button.holder.inline = button_open_inline
                --
                library.colors[button_open_inline] = {
                    Color = "inline"
                }
                --
                for Index = 1, (#button.options) do
                    local Value = button.options[Index]
                    --
                    if Value then
                        local button_value_frame = utility:Create("Frame", {Vector2.new(1,1 + (19 * (Index-1))), button_open_inline}, {
                            Size = utility:Size(1, -2, 0, 18, button_open_inline),
                            Position = utility:Position(0, 1, 0, 1 + (19 * (Index-1)), button_open_inline),
                            Color = theme.lightcontrast,
                            Visible = page.open
                        }, button.holder.drawings)
                        --
                        library.colors[button_value_frame] = {
                            Color = "lightcontrast"
                        }
                        --
                        local button_value = utility:Create("TextLabel", {Vector2.new(Value == tostring(button.current) and 8 or 6,2), button_value_frame}, {
                            Text = Value,
                            Size = theme.textsize,
                            Font = theme.font,
                            Color = Value == tostring(button.current) and theme.accent or theme.textcolor,
                            OutlineColor = theme.textborder,
                            Position = utility:Position(0, Value == tostring(button.current) and 8 or 6, 0, 2, button_value_frame),
                            Visible = page.open
                        }, button.holder.drawings)
                        --
                        button.holder.buttons[#button.holder.buttons + 1] = {button_value, button_value_frame}
                        --
                        library.colors[button_value] = {
                            OutlineColor = "textborder",
                            Color = Value == tostring(button.current) and "accent" or "textcolor"
                        }
                    end
                end
                --
                window.currentContent.frame = button_open_inline
                window.currentContent.button = button
            end
            --
            utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and (button_outline.Visible or button.open) and window.isVisible then
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and button_outline.Visible then
                        if button.open and button.holder.inline and utility:MouseOverDrawing({button.holder.inline.Position.X, button.holder.inline.Position.Y, button.holder.inline.Position.X + button.holder.inline.Size.X, button.holder.inline.Position.Y + button.holder.inline.Size.Y}) then
                            for i,v in pairs(button.holder.buttons) do
                                local value = button.options[i]
                                --
                                if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and value ~= button.current then
                                    button.current = value
                                    button_title.Text = button.current
        
                                    if button.selection then
                                        button.selection[3] = value
                                        playerList:Refresh(button.selection)
                                    end
        
                                    button:UpdateValue()
                                end
                            end
                        elseif utility:MouseOverDrawing({button_outline.Position.X, button_outline.Position.Y, button_outline.Position.X + button_outline.Size.X, button_outline.Position.Y + button_outline.Size.Y}) and not window:IsOverContent() then
                            task.spawn(function()
                                utility:LoadImage(button_gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                                --
                                task.wait(0.15)
                                --
                                utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png") 
                            end)
                            --
                            if not button.open then
                                button:Open()
                            else
                                button:Close()
                            end
                        else
                            if button.open then
                                button:Close()
                            end
                        end
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and button.open then
                        button:Close()
                    end
                end
            end
            --
            playerList.buttons[#playerList.buttons + 1] = button
        end
        --
        utility:LoadImage(list_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function playerList:GetSelection()
            for Index, Value in pairs(playerList.players) do
                if Value[4] then
                    return Value
                end
            end
        end
        --
        function playerList:UpdateScroll()
            if (#playerList.players - 10) > 0 then
                playerList.scrollingindex = math.clamp(playerList.scrollingindex, 0, (#playerList.players - 10))
                --
                list_bar.Transparency = window.isVisible and 1 or 0
                list_bar.Size = utility:Size(1, -2, (10 / #playerList.players), -2, list_scroll)
                list_bar.Position = utility:Position(0, 1, 0, 1 + ((((list_scroll.Size.Y - 2) - list_bar.Size.Y) / (#playerList.players - 10)) * playerList.scrollingindex), list_scroll)
                utility:UpdateTransparency(list_bar, 1)
                utility:UpdateOffset(list_bar, {Vector2.new(1, 1 + ((((list_scroll.Size.Y - 2) - list_bar.Size.Y) / (#playerList.players - 10)) * playerList.scrollingindex)), list_scroll})
            else
                playerList.scrollingindex = 0
                list_bar.Transparency = 0
                utility:UpdateTransparency(list_bar, 0)
            end
            --
            playerList:Refresh()
        end
        --
        local lastselection
        --
        function playerList:Refresh(Relation)
            for Index, Value in pairs(playerList.items) do
                local Found = playerList.players[Index + playerList.scrollingindex]
                --
                if Found then
                    Value:Set(true, Found)
                else
                    Value:Set(false)
                end
            end
            --
            if Relation then
                library.Relations[Relation[1].UserId] = Relation[3] ~= "None" and Relation[3] or nil
            end
            --
            playerList_title.Text = ("Player List - %s Players"):format(#playerList.items - 1)
            --
            local Selection = playerList:GetSelection()
            --
            playerList.buttons[1]:Update(Selection)
            --
            window:Move(window.main_frame.Position)
            --
            if Selection then
                if lastselection ~= Selection then
                    lastselection = Selection
                    --
                    options_avatar.Data = ""
                    options_loadingtext.Text = "..?"
                    --
                    options_title.Text = ("User ID : %s\nDisplay Name : %s\nName : %s\nHealth : %s/%s"):format(Selection[1].UserId, Selection[1].DisplayName ~= "" and Selection[1].DisplayName or Selection[1].Name, Selection[1].Name, "100", "100")
                    --
                    local imagedata = game:HttpGet(("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=100&height=100&format=png"):format(Selection[1].UserId))
                    --
                    if playerList:GetSelection() == Selection then
                        options_avatar.Data = imagedata
                        options_loadingtext.Text = ""
                    end
                end
            else
                options_title.Text = "No player selected."
                options_avatar.Data = ""
                options_loadingtext.Text = "..?"
                lastselection = nil
            end
        end
        --
        function playerList:Update() end
        --
        utility:Connection(plrs.PlayerAdded, function(Player)
            playerList.players[#playerList.players + 1] = {Player, Player.Name, "None", false}
            --
            playerList:UpdateScroll()
        end)
        --
        utility:Connection(plrs.PlayerRemoving, function(Player)
            for Index, Value in pairs(playerList.players) do
                if Value[1] == Player then
                    Remove(playerList.players, Index)
                end
            end
            --
            playerList:UpdateScroll()
        end)
        --
        for Index, Value in pairs(plrs:GetPlayers()) do
            playerList.players[#playerList.players + 1] = {Value, Value.Name, Value == localplayer and "Local Player" or "None", false}
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and list_outline.Visible and window.isVisible then
                if utility:MouseOverDrawing({list_bar.Position.X, list_bar.Position.Y, list_bar.Position.X + list_bar.Size.X, list_bar.Position.Y + list_bar.Size.Y}) then
                    playerList.scrolling = {true, (utility:MouseLocation().Y - list_bar.Position.Y)}
                elseif utility:MouseOverDrawing({list_frame.Position.X, list_frame.Position.Y, list_frame.Position.X + list_frame.Size.X, list_frame.Position.Y + list_frame.Size.Y}) and not window:IsOverContent() then
                    for Index = 1, 10 do
                        local Found = playerList.players[Index + playerList.scrollingindex]
                        --
                        if Found and utility:MouseOverDrawing({list_frame.Position.X, list_frame.Position.Y + 2 + (22 * (Index - 1)), list_frame.Position.X + list_frame.Size.X, list_frame.Position.Y + 2 + (22 * (Index - 1)) + 22}) then
                            if Found[4] then
                                Found[4] = false
                            else
                                for Index2, Value2 in pairs(playerList.players) do
                                    if Value2 ~= Found then
                                        Value2[4] = false
                                    end
                                end
                                --
                                Found[4] = true
                            end
                            --
                            playerList:UpdateScroll()
                            --
                            break
                        end
                    end
                end
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if playerList.scrolling[1] and Input.UserInputType == Enum.UserInputType.MouseButton1 then
                playerList.scrolling = {false, nil}
            end
        end
        --
        library.changed[#library.changed + 1] = function(Input)
            if playerList.scrolling[1] then
                local MouseLocation = utility:MouseLocation()
                local Position = math.clamp((MouseLocation.Y - list_scroll.Position.Y - playerList.scrolling[2]), 0, ((list_scroll.Size.Y - list_bar.Size.Y)))
                --
                playerList.scrollingindex = math.clamp(math.round((((Position + list_scroll.Position.Y) - list_scroll.Position.Y) / ((list_scroll.Size.Y - list_bar.Size.Y))) * (#playerList.players - 10)), 0, #playerList.players - 10)
                playerList:UpdateScroll()
            end
        end
        --
        utility:Connection(mouse.WheelForward,function()
            if (#playerList.players - 10) > 0 and page.open and list_bar.Visible and utility:MouseOverDrawing({list_frame.Position.X, list_frame.Position.Y, list_frame.Position.X + list_frame.Size.X, list_frame.Position.Y + list_frame.Size.Y}) and not window:IsOverContent() then
                playerList.scrollingindex = math.clamp(playerList.scrollingindex - 1, 0, #playerList.players - 10)
                playerList:UpdateScroll()
            end
        end)
        --
        utility:Connection(mouse.WheelBackward,function()
            if (#playerList.players - 10) > 0 and page.open and list_bar.Visible and utility:MouseOverDrawing({list_frame.Position.X, list_frame.Position.Y, list_frame.Position.X + list_frame.Size.X, list_frame.Position.Y + list_frame.Size.Y}) and not window:IsOverContent() then
                playerList.scrollingindex = math.clamp(playerList.scrollingindex + 1, 0, #playerList.players - 10)
                playerList:UpdateScroll()
            end
        end)
        --
        playerList:UpdateScroll()
        --
        page.sectionOffset["left"] = page.sectionOffset["left"] + playerList_inline.Size.Y + 5
        page.sectionOffset["right"] = page.sectionOffset["right"] + playerList_inline.Size.Y + 5
        page.sections[#page.sections + 1] = playerList
        return playerList
    end
    --
    function sections:Label(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Label"
        local middle = info.middle or info.Middle or info.center or info.Center or false
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
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
            Color = theme.textcolor,
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
        --
        return label
    end
    --
    function sections:Toggle(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Toggle"
        local def = info.def or info.Def or info.default or info.Default or false
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local toggle = {axis = section.currentAxis, current = def, addedAxis = 0, addedKeybind = nil, colorpickers = 0, keybind = nil}
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
        function toggle:Get()
            return toggle.current
        end
        --
        function toggle:Set(bool)
            if typeof(bool) == "boolean" then
                toggle.current = bool
                toggle_frame.Color = toggle.current == true and theme.accent or theme.lightcontrast
                --
                library.colors[toggle_frame] = {
                    Color = toggle.current == true and "accent" or "lightcontrast"
                }
                --
                callback(toggle.current)
                --
                if toggle.keybind then
                    toggle.keybind.active = (bool and (toggle.keybind.mode == "Always" or toggle.keybind.mode == "Off Hold") or false)
                    toggle.keybind:Callback()
                    --
                    if toggle.keybind.mode == "Off Hold" and toggle.current then
                        window.keybindslist:Add(toggle.keybind.keybindname, toggle.keybind.keybind_value.Text)
                    else
                        window.keybindslist:Remove(toggle.keybind.keybindname)
                    end
                end
            end
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
                --
                if toggle.keybind then
                    toggle.keybind.active = (toggle.current and (toggle.keybind.mode == "Always" or toggle.keybind.mode == "Off Hold") or false)
                    toggle.keybind:Callback()
                    if toggle.keybind.mode == "Off Hold" and toggle.current then
                        window.keybindslist:Add(toggle.keybind.keybindname, toggle.keybind.keybind_value.Text)
                    else
                        window.keybindslist:Remove(toggle.keybind.keybindname)
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = toggle
        end
        --
        section.currentAxis = section.currentAxis + 15 + 4
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
            library.colors[colorpicker_outline] = {
                Color = "outline"
            }
            --
            local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[colorpicker_inline] = {
                Color = "inline"
            }
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
                        local h, s, v = Unpack(color.Color)
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
                elseif typeof(color) == "Color3" then
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
                            library.colors[colorpicker_open_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                                Color = theme.darkcontrast
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_frame] = {
                                Color = "darkcontrast"
                            }
                            --
                            local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                                Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                                Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                                Color = theme.accent
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_accent] = {
                                Color = "accent"
                            }
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
                            library.colors[colorpicker_title] = {
                                OutlineColor = "textborder",
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_inline] = {
                                Color = "inline"
                            }
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
                            library.colors[colorpicker_open_huepicker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_huepicker_inline] = {
                                Color = "inline"
                            }
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
                            library.colors[colorpicker_open_huepicker_cursor_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                            --
                            library.colors[colorpicker_open_huepicker_cursor_inline] = {
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                            --
                            if transp then
                                local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.Y-19), colorpicker_open_frame}, {
                                    Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                    Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                    Color = theme.inline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_inline] = {
                                    Color = "inline"
                                }
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
                                library.colors[colorpicker_open_transparency_cursor_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                    Color = theme.textcolor
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                                --
                                library.colors[colorpicker_open_transparency_cursor_inline] = {
                                    Color = "textcolor"
                                }
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
            --
            return colorpicker, toggle
        end
        --
        function toggle:Keybind(info)
            local info = info or {}
            local def = info.def or info.Def or info.default or info.Default or nil
            local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
            local mode = info.mode or info.Mode or "Always"
            local keybindname = info.keybindname or info.keybindName or info.KeybindName or info.Keybindname or nil
            local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
            --
            toggle.addedaxis = toggle.addedAxis + 40 + 4 + 2
            --
            local keybind = {keybindname = keybindname or name, axis = toggle.axis, current = {}, selecting = false, mode = mode, open = false, modemenu = {buttons = {}, drawings = {}}, active = false}
            --
            toggle.keybind = keybind
            --
            local allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","Zero", "Minus", "Equals","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock"}
            local allowedInputTypes = {"MouseButton1","MouseButton2","MouseButton3"}
            local shortenedInputs = {["MouseButton1"] = "MB1", ["MouseButton2"] = "MB2", ["MouseButton3"] = "MB3", ["Insert"] = "Ins", ["Minus"] = "-", ["Equals"] = "=", ["LeftAlt"] = "LAlt", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RAlt", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "Caps"}
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
            }, section.visibleContent);keybind["keybind_value"] = keybind_value
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
                        if Find(allowedKeyCodes, input.Name) or Find(allowedInputTypes, input.Name) then
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
            function keybind:Get()
                return keybind.current
            end
            --
            function keybind:Set(tbl)
                keybind.current = {tbl[1], tbl[2]}
                keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                --
                if tbl[3] then
                    keybind.mode = tbl[3]
                    keybind.active = (keybind.mode == "Always" or keybind.mode == "Off Hold") and (toggle.current) or false
                    --
                    if keybind.mode == "Off Hold" then
                        window.keybindslist:Add(keybindname or name, keybind_value.Text)
                    else
                        window.keybindslist:Remove(keybindname or name)
                    end
                end
                --
                if keybind.current[1] and keybind.current[2] then
                    callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            --
            function keybind:Active()
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
                keybind.active = (keybind.mode == "Always" or keybind.mode == "Off Hold")
                --
                if keybind.mode == "Off Hold" then
                    window.keybindslist:Add(keybindname or name, keybind_value.Text)
                else
                    window.keybindslist:Remove(keybindname or name)
                end
                --
                if keybind.current[1] and keybind.current[2] then
                    callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            --
            function keybind:Callback()
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
                        if keybind.mode == "On Hold" then
                            local old = keybind.active
                            keybind.active = toggle:Get()
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            if keybind.active ~= old then callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active) end
                        elseif keybind.mode == "Off Hold" then
                            local old = keybind.active
                            keybind.active = false
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            if keybind.active ~= old then callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active) end
                        elseif keybind.mode == "Toggle" then
                            local old = keybind.active
                            keybind.active = not keybind.active == true and toggle:Get() or false
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
                        keybind.active = (keybind.mode == "Always" or keybind.mode == "Off Hold") and true or false
                        keybind_frame.Color = theme.lightcontrast
                        --
                        library.colors[keybind_frame] = {
                            Color = "lightcontrast"
                        }
                        --
                        window.keybindslist:Remove(keybindname or name)
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
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
                            Size = utility:Size(0, 68, 0, 64),
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
                        for i,v in pairs({"Always", "Toggle", "On Hold", "Off Hold"}) do
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
                if keybind.mode == "On Hold" or keybind.mode == "Off Hold" then
                    if keybind.current[1] and keybind.current[2] then
                        if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                            if keybind.mode == "On Hold" and keybind.active then
                                keybind.active = false
                                window.keybindslist:Remove(keybindname or name)
                                callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            elseif keybind.mode == "Off Hold" and not keybind.active then
                                keybind.active = toggle:Get()
                                if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                                callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            end
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = keybind
            end
            --
            toggle.addedAxis = 40+4+2
            --
            return keybind
        end
        --
        return toggle
    end
    --
    function sections:Slider(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title
        local def = info.def or info.Def or info.default or info.Default or 10
        local min = info.min or info.Min or info.minimum or info.Minimum or 0
        local max = info.max or info.Max or info.maximum or info.Maximum or 100
        local maxtext = info.maximumtext or info.Maximumtext or info.maximumText or info.MaximumText or max
        local sub = info.suffix or info.Suffix or info.ending or info.Ending or info.prefix or info.Prefix or info.measurement or info.Measurement or ""
        local disable = info.disable or info.Disable or info.disabled or info.disabled or false
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
        local slider = {min = min, max = max, Disabled = false, sub = sub, decimals = decimals, axis = section.currentAxis, current = -99999, holding = false}
        --
        if name then
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
        end
        --
        local slider_outline = utility:Create("Frame", {Vector2.new(4,slider.axis + (name and 15 or 0)), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 14, section.section_frame),
            Position = utility:Position(0, 4, 0, slider.axis + (name and 15 or 0), section.section_frame),
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
            Text = slider.current..slider.sub.."/"..maxtext..slider.sub,
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
        function slider:Set(value)
            local oldval = slider.current
            --
            slider.current = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
            --
            if slider.current ~= oldval then
                local disabledtext = disable and ((slider.current <= disable[2] or slider.current >= disable[3]) and disable[1])
                local percent = 1 - ((slider.max - slider.current) / (slider.max - slider.min))
                slider_value.Text = disabledtext or (slider.current..slider.sub.."/"..maxtext..slider.sub)
                slider_slide.Size = utility:Size(0, percent * slider_frame.Size.X, 1, -2, slider_inline)
                slider.Disabled = disabledtext ~= nil and disabledtext ~= false
                callback(slider.current)
            end
        end
        --
        function slider:Refresh()
            local mouseLocation = utility:MouseLocation()
            local percent = math.clamp(mouseLocation.X - slider_slide.Position.X, 0, slider_frame.Size.X) / slider_frame.Size.X
            local value = math.round((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
            value = math.clamp(value, slider.min, slider.max)
            slider:Set(value)
        end
        --
        function slider:Get()
            return slider.current
        end
        --
        slider:Set(def)
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and slider_outline.Visible and window.isVisible and page.open and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + slider.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + slider.axis + (name and 29 or 14)}) and not window:IsOverContent() then
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
        section.currentAxis = section.currentAxis + (name and 29 or 14) + 4
        --
        return slider
    end
    --
    function sections:Button(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Button"
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local button = {axis = section.currentAxis}
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
        --
        utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and button_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + button.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + button.axis + 20}) and not window:IsOverContent() then
                task.spawn(function()
                    utility:LoadImage(button_gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                    --
                    task.wait(0.15)
                    --
                    utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png") 
                end)
                --
                callback()
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = button
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
        --
        return button
    end
    --
    function sections:TextBox(info)
        local info = info or {}
        local def = info.def or info.Def or info.default or info.Default or ""
        local max = info.max or info.Max or info.maximum or info.Maximum or 200
        local placeholder = info.placeholder or info.Placeholder or info.placeHolder or info.PlaceHolder
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local reactive = info.reactive or info.Reactive;reactive = reactive == nil or reactive
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        local identifier = tostring(math.random(500, 500000)) .. "-" .. tostring(math.random(500, 500000)) .. "-" .. tostring(math.random(500, 500000))
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local textbox = {axis = section.currentAxis, max = max, current = def, oldenter = "", callback = callback}
        --
        local textbox_outline = utility:Create("Frame", {Vector2.new(4,textbox.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, textbox.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_outline] = {
            Color = "outline"
        }
        --
        local textbox_inline = utility:Create("Frame", {Vector2.new(1,1), textbox_outline}, {
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
        local textbox_inneroutline = utility:Create("Frame", {Vector2.new(1,1), textbox_inline}, {
            Size = utility:Size(1, -2, 1, -2, textbox_inline),
            Position = utility:Position(0, 1, 0, 1, textbox_inline),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_inneroutline] = {
            Color = "outline"
        }
        --
        local textbox_frame = utility:Create("Frame", {Vector2.new(1,1), textbox_inneroutline}, {
            Size = utility:Size(1, -2, 1, -2, textbox_inneroutline),
            Position = utility:Position(0, 1, 0, 1, textbox_inneroutline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_frame] = {
            Color = "lightcontrast"
        }
        --
        local textbox_gradient = utility:Create("Image", {Vector2.new(0,0), textbox_frame}, {
            Size = utility:Size(1, 0, 1, 0, textbox_frame),
            Position = utility:Position(0, 0, 0 , 0, textbox_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local textbox_value = utility:Create("TextLabel", {Vector2.new(textbox_frame.Size.X/2,0), textbox_frame}, {
            Text = textbox.current == "" and placeholder or textbox.current,
            Size = theme.textsize,
            Font = theme.font,
            Color = textbox.current == "" and (placeholder and theme.textdark) or theme.textcolor,
            OutlineColor = theme.textborder,
            Center = true,
            Position = utility:Position(0.5, 0, 0, 0, textbox_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_value] = {
            OutlineColor = "textborder",
            Color = textbox.current == "" and (placeholder and "textdark") or "textcolor"
        }
        --
        utility:LoadImage(textbox_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function textbox:Get()
            return textbox.current
        end
        --
        function textbox:Set(state, first)
            textbox.current = state or ""
            --
            local newtext = utility:WrapText(textbox.current == "" and placeholder or textbox.current, textbox_frame.Size.X - 30)
            textbox_value.Text = (textbox.current == "" and placeholder or textbox.current) ~= newtext and (newtext .. "...") or newtext
            textbox_value.Color = textbox.current == "" and (placeholder and theme.textdark) or theme.textcolor
            --
            library.colors[textbox_value] = {
                OutlineColor = "textborder",
                Color = textbox.current == "" and (placeholder and "textdark") or "textcolor"
            }
            --
            if not first then
                callback(textbox.current)
            end
        end
        --
        textbox:Set(textbox.current, true)
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and textbox_outline.Visible and window.isVisible then
                if reactive and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + textbox.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + textbox.axis + 20}) and not window:IsOverContent() then
                    task.spawn(function()
                        utility:LoadImage(textbox_gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                        --
                        task.wait(0.15)
                        --
                        utility:LoadImage(textbox_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png") 
                    end)
                    --
                    if not (window.currentContent.textbox and window.currentContent.textbox.Name == identifier) then
                        window:CloseContent()
                        --
                        textbox_value.Color = theme.accent
                        --
                        library.colors[textbox_value] = {
                            OutlineColor = "textborder",
                            Color = "accent"
                        }
                        --
                        cas:BindActionAtPriority("DisableKeyboard", function() return Enum.ContextActionResult.Sink end, false, 3000, Enum.UserInputType.Keyboard)
                        --
                        window.currentContent.textbox = {
                            Name = identifier,
                            Item = textbox,
                            Fire = function(Text)
                                textbox.current = (Text == "Backspace" and textbox.current:sub(0, #textbox.current - 1) or (textbox.current .. Text)):sub(0, textbox.max)
                                --
                                local newtext = utility:WrapText(textbox.current == "" and placeholder or textbox.current, textbox_frame.Size.X - 30)
                                textbox_value.Text = (textbox.current == "" and placeholder or textbox.current) ~= newtext and (newtext .. "...") or newtext
                                textbox.callback(textbox.current)
                            end,
                            Disconnect = function()
                                cas:UnbindAction('DisableKeyboard')
                                --
                                textbox_value.Color = textbox.current == "" and (placeholder and theme.textdark) or theme.textcolor
                                --
                                library.colors[textbox_value] = {
                                    OutlineColor = "textborder",
                                    Color = textbox.current == "" and (placeholder and "textdark") or "textcolor"
                                }
                            end
                        }
                    else
                        if window.currentContent.textbox.Name == identifier then
                            window:CloseContent()
                        end
                    end
                elseif reactive then
                    if window.currentContent.textbox and window.currentContent.textbox.Name == identifier then
                        window:CloseContent()
                    end
                end
                --
                if uis:IsKeyDown(Enum.KeyCode.LeftControl) and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + textbox.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + textbox.axis + 20}) and not window:IsOverContent() then
                    task.spawn(function()
                        textbox_value.Color = theme.accent
                        --
                        library.colors[textbox_value] = {
                            OutlineColor = "textborder",
                            Color = "accent"
                        }
                        --
                        utility:LoadImage(textbox_gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                        --
                        task.wait(0.15)
                        --
                        textbox_value.Color = textbox.current == "" and (placeholder and theme.textdark) or theme.textcolor
                        --
                        library.colors[textbox_value] = {
                            OutlineColor = "textborder",
                            Color = textbox.current == "" and (placeholder and "textdark") or "textcolor"
                        }
                        --
                        utility:LoadImage(textbox_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
                    end)
                    --
                    setclipboard(textbox.current)
                end
            elseif Input.KeyCode and Input.KeyCode == Enum.KeyCode.Return then
                if window.currentContent.textbox and window.currentContent.textbox.Name == identifier then
                    window:CloseContent()
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = textbox
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
        --
        return textbox
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
                    task.spawn(function()
                        utility:LoadImage(button_gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                        --
                        task.wait(0.15)
                        --
                        utility:LoadImage(button_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png") 
                    end)
                    --
                    buttons[i][2]()
                end
            end
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
    end
    --
    function sections:Dropdown(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title
        local max = info.max or info.Max
        local options = info.options or info.Options or {"1", "2", "3"}
        local def = info.def or info.Def or info.default or info.Default or options[1]
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local dropdown = {open = false, scrollindex = max and 0, scrolling = max and {false, nil}, current = tostring(def), options = options, holder = {buttons = {}, drawings = {}}, axis = section.currentAxis}
        --
        local dropdown_outline = utility:Create("Frame", {Vector2.new(4,name and (dropdown.axis + 15) or dropdown.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, name and (dropdown.axis + 15) or dropdown.axis, section.section_frame),
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
            Visible = page.open
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
        if name then
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
        end
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
        if max then
            local lastupdate = dropdown.scrollindex
            --
            function dropdown:UpdateScroll()
                if dropdown.scrollindex ~= lastupdate then
                    if max and dropdown.bar and dropdown.scroll then
                        lastupdate = dropdown.scrollindex
                        --
                        if (#dropdown.options - max) > 0 then
                            dropdown.bar.Size = utility:Size(1, 0, (max / #dropdown.options), 0, dropdown.scroll)
                            dropdown.bar.Position = utility:Position(0, 0, 0, (((dropdown.scroll.Size.Y - dropdown.bar.Size.Y) / (#dropdown.options - max)) * dropdown.scrollindex), dropdown.scroll)
                            utility:UpdateTransparency(dropdown.bar, 1)
                            utility:UpdateOffset(dropdown.bar, {Vector2.new(1, (((dropdown.scroll.Size.Y - dropdown.bar.Size.Y) / (#dropdown.options - max)) * dropdown.scrollindex)), dropdown.scroll})
                        else
                            dropdown.scrollindex = 0
                            dropdown.bar.Transparency = 0
                            utility:UpdateTransparency(dropdown.bar, 0)
                        end
                        --
                        dropdown:Update()
                    end
                end
            end
        end
        --
        function dropdown:Update()
            if dropdown.open and dropdown.holder.inline then
                for i,v in pairs(dropdown.holder.buttons) do
                    local value = max and dropdown.options[i + dropdown.scrollindex] or dropdown.options[i]
                    --
                    v[1].Text = value
                    v[1].Color = value == tostring(dropdown.current) and theme.accent or theme.textcolor
                    v[1].Position = utility:Position(0, value == tostring(dropdown.current) and 8 or 6, 0, 2, v[2])
                    library.colors[v[1]] = {
                        Color = v[1].Text == tostring(dropdown.current) and "accent" or "textcolor"
                    }
                    utility:UpdateOffset(v[1], {Vector2.new(v[1].Text == tostring(dropdown.current) and 8 or 6, 2), v[2]})
                end
            end
        end
        --
        function dropdown:Set(value)
            if typeof(value) == "string" and Find(dropdown.options, value) then
                dropdown.current = value
                dropdown_value.Text = value
                callback(value)
            end
        end
        --
        function dropdown:Get()
            return dropdown.current
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and dropdown_outline.Visible then
                if dropdown.open and dropdown.holder.inline and utility:MouseOverDrawing({dropdown.holder.inline.Position.X, dropdown.holder.inline.Position.Y, dropdown.holder.inline.Position.X + dropdown.holder.inline.Size.X, dropdown.holder.inline.Position.Y + dropdown.holder.inline.Size.Y}) then
                    if max and dropdown.bar and utility:MouseOverDrawing({dropdown.bar.Position.X - 1, dropdown.bar.Position.Y - 1, dropdown.bar.Position.X - 1 + dropdown.bar.Size.X + 2, dropdown.bar.Position.Y - 1 + dropdown.bar.Size.Y + 2}) then
                        dropdown.scrolling = {true, (utility:MouseLocation().Y - dropdown.bar.Position.Y)}
                    else
                        for i,v in pairs(dropdown.holder.buttons) do
                            local value = max and dropdown.options[(i + dropdown.scrollindex)] or dropdown.options[i]
                            --
                            if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and v[1].Text ~= dropdown.current then
                                dropdown.current = value
                                dropdown_value.Text = dropdown.current
                                callback(value)
                                dropdown:Update()
                            end
                        end
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + dropdown.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + dropdown.axis + (name and (15 + 20) or (20))}) and not window:IsOverContent() then
                    task.spawn(function()
                        utility:LoadImage(dropdown__gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                        --
                        task.wait(0.15)
                        --
                        utility:LoadImage(dropdown__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png") 
                    end)
                    --
                    if not dropdown.open then
                        window:CloseContent()
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        --
                        local dropdown_open_outline = utility:Create("Frame", {Vector2.new(0,19), dropdown_outline}, {
                            Size = utility:Size(1, 0, 0, 3 + ((max and max or #dropdown.options) * 19), dropdown_outline),
                            Position = utility:Position(0, 0, 0, 19, dropdown_outline),
                            Color = theme.outline,
                            Visible = page.open
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
                            Visible = page.open
                        }, dropdown.holder.drawings);dropdown.holder.inline = dropdown_open_inline
                        --
                        library.colors[dropdown_open_inline] = {
                            Color = "inline"
                        }
                        --
                        if max then
                            local dropdown_open_scroll = utility:Create("Frame", {Vector2.new(dropdown_open_inline.Size.X - 5,1), dropdown_open_inline}, {
                                Size = utility:Size(0, 4, 1, -2, dropdown_open_inline),
                                Position = utility:Position(1, -5, 0, 1, dropdown_open_inline),
                                Color = theme.darkcontrast,
                                Visible = page.open
                            }, dropdown.holder.drawings);dropdown.scroll = dropdown_open_scroll
                            --
                            library.colors[dropdown_open_scroll] = {
                                Color = "darkcontrast"
                            }
                            --
                            local dropdown_open_bar = utility:Create("Frame", {Vector2.new(0, (((dropdown_open_scroll.Size.Y - ((max / #dropdown.options) * dropdown_open_scroll.Size.Y)) / (#dropdown.options - max)) * dropdown.scrollindex)), dropdown_open_scroll}, {
                                Size = utility:Size(1, 0, (max / #dropdown.options), 0, dropdown_open_scroll),
                                Position = utility:Position(0, 0, 0, (((dropdown_open_scroll.Size.Y - ((max / #dropdown.options) * dropdown_open_scroll.Size.Y)) / (#dropdown.options - max)) * dropdown.scrollindex), dropdown_open_scroll),
                                Color = theme.accent,
                                Visible = page.open
                            }, dropdown.holder.drawings);dropdown.bar = dropdown_open_bar
                            --
                            library.colors[dropdown_open_bar] = {
                                Color = "accent"
                            }
                        end
                        --
                        for Index = 1, (max and max or #dropdown.options) do
                            local Value = max and dropdown.options[Index + dropdown.scrollindex] or dropdown.options[Index]
                            --
                            if Value then
                                local dropdown_value_frame = utility:Create("Frame", {Vector2.new(1,1 + (19 * (Index-1))), dropdown_open_inline}, {
                                    Size = utility:Size(1, -(max and 7 or 2), 0, 18, dropdown_open_inline),
                                    Position = utility:Position(0, 1, 0, 1 + (19 * (Index-1)), dropdown_open_inline),
                                    Color = theme.lightcontrast,
                                    Visible = page.open
                                }, dropdown.holder.drawings)
                                --
                                library.colors[dropdown_value_frame] = {
                                    Color = "lightcontrast"
                                }
                                --
                                local dropdown_value = utility:Create("TextLabel", {Vector2.new(Value == tostring(dropdown.current) and 8 or 6,2), dropdown_value_frame}, {
                                    Text = Value,
                                    Size = theme.textsize,
                                    Font = theme.font,
                                    Color = Value == tostring(dropdown.current) and theme.accent or theme.textcolor,
                                    OutlineColor = theme.textborder,
                                    Position = utility:Position(0, Value == tostring(dropdown.current) and 8 or 6, 0, 2, dropdown_value_frame),
                                    Visible = page.open
                                }, dropdown.holder.drawings)
                                --
                                dropdown.holder.buttons[#dropdown.holder.buttons + 1] = {dropdown_value, dropdown_value_frame}
                                --
                                library.colors[dropdown_value] = {
                                    OutlineColor = "textborder",
                                    Color = Value == tostring(dropdown.current) and "accent" or "textcolor"
                                }
                            end
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
        if max then
            library.ended[#library.ended + 1] = function(Input)
                if dropdown.scrolling and dropdown.scrolling[1] and Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dropdown.scrolling = {false, nil}
                end
            end
            --
            library.changed[#library.changed + 1] = function(Input)
                if dropdown.scrolling and dropdown.scrolling[1] then
                    local MouseLocation = utility:MouseLocation()
                    local Position = math.clamp((MouseLocation.Y - dropdown.scroll.Position.Y - dropdown.scrolling[2]), 0, ((dropdown.scroll.Size.Y - dropdown.bar.Size.Y)))
                    --
                    dropdown.scrollindex = math.round((((Position + dropdown.scroll.Position.Y) - dropdown.scroll.Position.Y) / ((dropdown.scroll.Size.Y - dropdown.bar.Size.Y))) * (#dropdown.options - max))
                    dropdown:UpdateScroll()
                end
            end
            --
            utility:Connection(mouse.WheelForward,function()
                if page.open and dropdown.open and dropdown.bar and dropdown.bar.Visible and utility:MouseOverDrawing({dropdown.holder.inline.Position.X, dropdown.holder.inline.Position.Y, dropdown.holder.inline.Position.X + dropdown.holder.inline.Size.X, dropdown.holder.inline.Position.Y + dropdown.holder.inline.Size.Y}) then
                    dropdown.scrollindex = math.clamp(dropdown.scrollindex - 1, 0, #dropdown.options - max)
                    dropdown:UpdateScroll()
                end
            end)
            --
            utility:Connection(mouse.WheelBackward,function()
                if page.open and dropdown.open and dropdown.bar and dropdown.bar.Visible and utility:MouseOverDrawing({dropdown.holder.inline.Position.X, dropdown.holder.inline.Position.Y, dropdown.holder.inline.Position.X + dropdown.holder.inline.Size.X, dropdown.holder.inline.Position.Y + dropdown.holder.inline.Size.Y}) then
                    dropdown.scrollindex = math.clamp(dropdown.scrollindex + 1, 0, #dropdown.options - max)
                    dropdown:UpdateScroll()
                end
            end)
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = dropdown
        end
        --
        section.currentAxis = section.currentAxis + (name and 35 or 20) + 4
        --
        return dropdown
    end
    --
    function sections:Multibox(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title
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
        local multibox = {open = false, current = def, options = options, holder = {buttons = {}, drawings = {}}, axis = section.currentAxis}
        --
        local multibox_outline = utility:Create("Frame", {Vector2.new(4, name and (multibox.axis + 15) or multibox.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, name and (multibox.axis + 15) or multibox.axis, section.section_frame),
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
        if name then
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
        end
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
                    v[1].Color = Find(multibox.current, v[1].Text) and theme.accent or theme.textcolor
                    v[1].Position = utility:Position(0, Find(multibox.current, v[1].Text) and 8 or 6, 0, 2, v[2])
                    --
                    library.colors[v[1]] = {
                        Color = Find(multibox.current, v[1].Text) and "accent" or "textcolor"
                    }
                    --
                    utility:UpdateOffset(v[1], {Vector2.new(Find(multibox.current, v[1].Text) and 8 or 6, 2), v[2]})
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
                if Find(tbl, v) then
                    newtbl[#newtbl + 1] = v
                end
            end
            --
            return newtbl
        end
        --
        function multibox:Set(tbl)
            if typeof(tbl) == "table" then
                multibox.current = tbl
                --
                local text = multibox:Serialize(multibox:Resort(multibox.current, multibox.options))
                multibox_value.Text = utility:WrapText(text, multibox_frame.Size.X - 25)
            end
        end
        --
        function multibox:Get()
            return multibox.current
        end
        --
        multibox_value.Text = utility:WrapText(multibox:Serialize(multibox:Resort(multibox.current, multibox.options)), multibox_frame.Size.X - 25)
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and multibox_outline.Visible then
                if multibox.open and multibox.holder.inline and utility:MouseOverDrawing({multibox.holder.inline.Position.X, multibox.holder.inline.Position.Y, multibox.holder.inline.Position.X + multibox.holder.inline.Size.X, multibox.holder.inline.Position.Y + multibox.holder.inline.Size.Y}) then
                    for i,v in pairs(multibox.holder.buttons) do
                        if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and v[1].Text ~= multibox.current then
                            if not Find(multibox.current, v[1].Text) then
                                multibox.current[#multibox.current + 1] = v[1].Text
                                multibox_value.Text = utility:WrapText(multibox:Serialize(multibox:Resort(multibox.current, multibox.options)), multibox_frame.Size.X - 25)
                                multibox:Update()
                            else
                                if #multibox.current > min then
                                    Remove(multibox.current, Find(multibox.current, v[1].Text))
                                    multibox_value.Text = utility:WrapText(multibox:Serialize(multibox:Resort(multibox.current, multibox.options)), multibox_frame.Size.X - 25)
                                    multibox:Update()
                                end
                            end
                        end
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + multibox.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + multibox.axis + (name and 15 or 0) + 20}) and not window:IsOverContent() then
                    task.spawn(function()
                        utility:LoadImage(multibox__gradient, "gradientdown", "https://i.imgur.com/DzrzUt3.png") 
                        --
                        task.wait(0.15)
                        --
                        utility:LoadImage(multibox__gradient, "gradient", "https://i.imgur.com/5hmlrjX.png") 
                    end)
                    --
                    if not multibox.open then
                        window:CloseContent()
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        --
                        local multibox_open_outline = utility:Create("Frame", {Vector2.new(0,19), multibox_outline}, {
                            Size = utility:Size(1, 0, 0, 3 + (#multibox.options * 19), multibox_outline),
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
                        for i,v in pairs(multibox.options) do
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
                            local multibox_value = utility:Create("TextLabel", {Vector2.new(Find(multibox.current, v) and 8 or 6,2), multibox_value_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = Find(multibox.current, v) and theme.accent or theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, Find(multibox.current, v) and 8 or 6, 0, 2, multibox_value_frame),
                                Visible = page.open
                            }, multibox.holder.drawings);multibox.holder.buttons[#multibox.holder.buttons + 1] = {multibox_value, multibox_value_frame}
                            --
                            library.colors[multibox_value] = {
                                OutlineColor = "textborder",
                                Color = Find(multibox.current, v) and "accent" or "textcolor"
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
        section.currentAxis = section.currentAxis + (name and 35 or 20) + 4
        --
        return multibox
    end
    --
    function sections:Keybind(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Keybind"
        local def = info.def or info.Def or info.default or info.Default or nil
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local mode = info.mode or info.Mode or "Always"
        local keybindname = info.keybindname or info.keybindName or info.Keybindname or info.KeybindName or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local keybind = {keybindname = keybindname or name, axis = section.currentAxis, current = {}, selecting = false, mode = mode, open = false, modemenu = {buttons = {}, drawings = {}}, active = false}
        --
        local allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","Zero", "Minus", "Equals","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock"}
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
                    if Find(allowedKeyCodes, input.Name) or Find(allowedInputTypes, input.Name) then
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
        function keybind:Get()
            return keybind.current
        end
        --
        function keybind:Set(tbl)
            keybind.current = {tbl[1], tbl[2]}
            keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
            --
            if tbl[3] then
                keybind.mode = tbl[3]
            end
            --
            keybind.active = (keybind.mode == "Always" or keybind.mode == "Off Hold") and true or false
            --
            if keybind.mode == "Off Hold" then
                window.keybindslist:Add(keybindname or name, keybind_value.Text)
            else
                window.keybindslist:Remove(keybindname or name)
            end
            --
            if keybind.current[1] and keybind.current[2] then
                callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
            end
        end
        --
        function keybind:Active()
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
            keybind.active = (keybind.mode == "Always" or keybind.mode == "Off Hold") and true or false
            --
            if keybind.mode == "Off Hold" then
                window.keybindslist:Add(keybindname or name, keybind_value.Text)
            else
                window.keybindslist:Remove(keybindname or name)
            end
            --
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
                    if keybind.mode == "On Hold" then
                        keybind.active = true
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    elseif keybind.mode == "Off Hold" then
                        keybind.active = false
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    elseif keybind.mode == "Toggle" then
                        keybind.active = not keybind.active
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
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
                    if keybind.mode == "Off Hold" then
                        window.keybindslist:Add(keybindname or name, keybind_value.Text)
                    else
                        window.keybindslist:Remove(keybindname or name)
                    end
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
                        Size = utility:Size(0, 68, 0, 64),
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
                    for i,v in pairs({"Always", "Toggle", "On Hold", "Off Hold"}) do
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
            if keybind.mode == "On Hold" or keybind.mode == "Off Hold" then
                if keybind.current[1] and keybind.current[2] then
                    if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                        if keybind.mode == "On Hold" then
                            if keybind.active then
                                keybind.active = false
                                window.keybindslist:Remove(keybindname or name)
                                callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            end
                        else
                            keybind.active = true
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                        end
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
        library.colors[colorpicker_outline] = {
            Color = "outline"
        }
        --
        local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
            Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
            Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[colorpicker_inline] = {
            Color = "inline"
        }
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
        library.colors[colorpicker_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
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
            elseif typeof(color) == "Color3" then
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
                        library.colors[colorpicker_open_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_inline] = {
                            Color = "inline"
                        }
                        --
                        local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                            Color = theme.darkcontrast
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_frame] = {
                            Color = "darkcontrast"
                        }
                        --
                        local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                            Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                            Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                            Color = theme.accent
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_accent] = {
                            Color = "accent"
                        }
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
                        library.colors[colorpicker_title] = {
                            OutlineColor = "textborder",
                            Color = "textcolor"
                        }
                        --
                        local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                            Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                            Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_picker_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_picker_inline] = {
                            Color = "inline"
                        }
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
                        library.colors[colorpicker_open_huepicker_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_huepicker_inline] = {
                            Color = "inline"
                        }
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
                        library.colors[colorpicker_open_huepicker_cursor_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                            Color = theme.textcolor
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                        --
                        library.colors[colorpicker_open_huepicker_cursor_inline] = {
                            Color = "textcolor"
                        }
                        --
                        local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                            Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                        --
                        if transp then
                            local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.Y-19), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_transparency_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_transparency_inline] = {
                                Color = "inline"
                            }
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
                            library.colors[colorpicker_open_transparency_cursor_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                            --
                            library.colors[colorpicker_open_transparency_cursor_inline] = {
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                            --
                            utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
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
            library.colors[colorpicker_outline] = {
                Color = "outline"
            }
            --
            local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[colorpicker_inline] = {
                Color = "inline"
            }
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
                elseif typeof(color) == "Color3" then
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
                            library.colors[colorpicker_open_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                                Color = theme.darkcontrast
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_frame] = {
                                Color = "darkcontrast"
                            }
                            --
                            local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                                Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                                Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                                Color = theme.accent
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_accent] = {
                                Color = "accent"
                            }
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
                            library.colors[colorpicker_title] = {
                                OutlineColor = "textborder",
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_inline] = {
                                Color = "inline"
                            }
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
                            library.colors[colorpicker_open_huepicker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_huepicker_inline] = {
                                Color = "inline"
                            }
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
                            library.colors[colorpicker_open_huepicker_cursor_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                            --
                            library.colors[colorpicker_open_huepicker_cursor_inline] = {
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                            --
                            if transp then
                                local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.Y-19), colorpicker_open_frame}, {
                                    Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                    Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                    Color = theme.inline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_inline] = {
                                    Color = "inline"
                                }
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
                                library.colors[colorpicker_open_transparency_cursor_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                    Color = theme.textcolor
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                                --
                                library.colors[colorpicker_open_transparency_cursor_inline] = {
                                    Color = "textcolor"
                                }
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
    function sections:List(info)
        local info = info or {}
        local max = info.max or info.Max or info.maximum or info.Maximum or 8
        local current = info.def or info.Default or info.current or info.Current or 1
        local options = info.options or info.Options or {"1", "2", "3"}
        --
        local window = self.window
        local page = self.page
        local section = self
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        --
        local list = {axis = section.currentAxis, options = options, max = max, current = current, scrollingindex = 0, scrolling = {false, nil}, buttons = {}}
        --
        local list_outline = utility:Create("Frame", {Vector2.new(4,list.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, ((list.max * 20) + 4), section.section_frame),
            Position = utility:Position(0, 4, 0, list.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[list_outline] = {
            Color = "outline"
        }
        --
        local list_inline = utility:Create("Frame", {Vector2.new(1,1), list_outline}, {
            Size = utility:Size(1, -2, 1, -2, list_outline),
            Position = utility:Position(0, 1, 0, 1, list_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[list_inline] = {
            Color = "inline"
        }
        --
        local list_frame = utility:Create("Frame", {Vector2.new(1,1), list_inline}, {
            Size = utility:Size(1, -2, 1, -2, list_inline),
            Position = utility:Position(0, 1, 0, 1, list_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[list_frame] = {
            Color = "lightcontrast"
        }
        --
        local list_scroll = utility:Create("Frame", {Vector2.new(list_frame.Size.X - 8,0), list_frame}, {
            Size = utility:Size(0, 8, 1, 0, list_frame),
            Position = utility:Position(1, -8, 0, 0, list_frame),
            Color = theme.darkcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[list_scroll] = {
            Color = "darkcontrast"
        }
        --
        local list_bar = utility:Create("Frame", {Vector2.new(1,1), list_scroll}, {
            Size = utility:Size(1, -2, (list.max / #list.options), -2, list_scroll),
            Position = utility:Position(0, 1, 0, 1, list_scroll),
            Color = theme.accent,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[list_bar] = {
            Color = "accent"
        }
        --
        local list_gradient = utility:Create("Image", {Vector2.new(0,0), list_frame}, {
            Size = utility:Size(1, 0, 1, 0, list_frame),
            Position = utility:Position(0, 0, 0 , 0, list_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        for i=1, list.max do
            local config_title = utility:Create("TextLabel", {Vector2.new(list_frame.Size.X/2,2 + (20 * (i-1))), list_frame}, {
                Text = list.options[i] or "",
                Size = theme.textsize,
                Font = theme.font,
                Color = i == 1 and theme.accent or theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 2 + (20 * (i-1)), list_frame),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[config_title] = {
                OutlineColor = "textborder",
                Color = i == 1 and "accent" or "textcolor"
            }
            --
            list.buttons[i] = config_title
        end
        --
        utility:LoadImage(list_gradient, "gradient", "https://i.imgur.com/5hmlrjX.png")
        --
        function list:UpdateScroll()
            if (#list.options - list.max) > 0 then
                list_bar.Size = utility:Size(1, -2, (list.max / #list.options), -2, list_scroll)
                list_bar.Position = utility:Position(0, 1, 0, 1 + ((((list_scroll.Size.Y - 2) - list_bar.Size.Y) / (#list.options - list.max)) * list.scrollingindex), list_scroll)
                list_bar.Transparency = 1
                utility:UpdateTransparency(list_bar, 1)
                utility:UpdateOffset(list_bar, {Vector2.new(1, 1 + ((((list_scroll.Size.Y - 2) - list_bar.Size.Y) / (#list.options - list.max)) * list.scrollingindex)), list_scroll})
            else
                list.scrollingindex = 0
                list_bar.Transparency = 0
                utility:UpdateTransparency(list_bar, 0)
            end
            --
            list:Refresh()
        end
        --
        function list:Refresh()
            for Index, Value in pairs(list.buttons) do
                Value.Text = list.options[Index + list.scrollingindex] or ""
                Value.Color = (Index + list.scrollingindex) == list.current and theme.accent or theme.textcolor
                --
                library.colors[Value] = {
                    OutlineColor = "textborder",
                    Color = (Index + list.scrollingindex) == list.current and "accent" or "textcolor"
                }
            end
        end
        --
        function list:Get()
            return list.options[list.current + list.scrollingindex]
        end
        --
        function list:Set(current)
            list.current = current
            list:Refresh()
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and list_outline.Visible and window.isVisible then
                if utility:MouseOverDrawing({list_bar.Position.X, list_bar.Position.Y, list_bar.Position.X + list_bar.Size.X, list_bar.Position.Y + list_bar.Size.Y}) then
                    list.scrolling = {true, (utility:MouseLocation().Y - list_bar.Position.Y)}
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + list.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + list.axis + ((list.max * 20) + 4)}) and not window:IsOverContent() then
                    for i=1, list.max do
                        if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + list.axis + 2 + (20 * (i-1)), section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + list.axis + 2 + (20 * (i-1)) + 20}) then
                            list.current = (i + list.scrollingindex)
                            list:Refresh()
                        end
                    end
                end
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if list.scrolling[1] and Input.UserInputType == Enum.UserInputType.MouseButton1 then
                list.scrolling = {false, nil}
            end
        end
        --
        library.changed[#library.changed + 1] = function(Input)
            if list.scrolling[1] then
                local MouseLocation = utility:MouseLocation()
                local Position = math.clamp((MouseLocation.Y - list_scroll.Position.Y - list.scrolling[2]), 0, ((list_scroll.Size.Y - list_bar.Size.Y)))
                --
                list.scrollingindex = math.round((((Position + list_scroll.Position.Y) - list_scroll.Position.Y) / ((list_scroll.Size.Y - list_bar.Size.Y))) * (#list.options - list.max))
                list:UpdateScroll()
            end
        end
        --
        utility:Connection(mouse.WheelForward,function()
            if page.open and list_bar.Visible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + list.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + list.axis + ((list.max * 20) + 4)}) and not window:IsOverContent() then
                list.scrollingindex = math.clamp(list.scrollingindex - 1, 0, #list.options - list.max)
                list:UpdateScroll()
            end
        end)
        --
        utility:Connection(mouse.WheelBackward,function()
            if page.open and list_bar.Visible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + list.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + list.axis + ((list.max * 20) + 4)}) and not window:IsOverContent() then
                list.scrollingindex = math.clamp(list.scrollingindex + 1, 0, #list.options - list.max)
                list:UpdateScroll()
            end
        end)
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = list
        end
        --
        list:UpdateScroll()
        --
        section.currentAxis = section.currentAxis + ((list.max * 20) + 4) + 4
        --
        return list
    end
end
--
return library, utility, library.pointers, theme
