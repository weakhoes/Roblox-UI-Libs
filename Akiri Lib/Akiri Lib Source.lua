-- // Lib \\ --
--[[
    local UI = loadstring(game:HttpGet("https://akiri.best/assets/files/gayasf.ui2?key=5y1lxXSfWKhlQkSqhUuFyB8kPp8hsCau"))()
]]
-- // Library Init \\ --
local Start = tick()
local LoadTime = tick()
local Secure = setmetatable({}, {
    __index = function(Idx, Val)
        return game:GetService(Val)
    end
})
--
local UserInput = Secure.UserInputService
local RunService = Secure.RunService
local CoreGui = Secure.CoreGui
local Players = Secure.Players
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local HttpService = Secure.HttpService
local Mouse = LocalPlayer:GetMouse()
local InputGUI = Instance.new("ScreenGui", CoreGui)

local Stats = Secure.Stats.Network.ServerStatsItem["Data Ping"] 
--
-- Aimware = {6, [[{"Outline":"000005","Accent":"c82828","LightText":"e8e8e8","DarkText":"afafaf","LightContrast":"2b2b2b","CursorOutline":"191919","DarkContrast":"191919","TextBorder":"0a0a0a","Inline":"373737"}]]},
--
local Library = {
    Theme = {
        Accent = {
            Color3.fromHex("#c37be5"), -- Color3.fromHex("#a280d9"), -- Color3.fromRGB(255, 42, 10), Color3.fromHex("#3599d4")
            Color3.fromRGB(180, 156, 255),
            Color3.fromRGB(114, 0, 198),
            Color3.fromRGB(139, 130, 185),
            Color3.fromHex("#a83299")
        },
        Notification = {
            Error = Color3.fromHex("#c82828"),
            Warning = Color3.fromHex("#fc9803")
        },
        Hitbox = Color3.fromRGB(69, 69, 69),
        Friend = Color3.fromRGB(0, 200, 0),
        Outline = Color3.fromHex("#000005"),
        Inline = Color3.fromHex("#3c3c3c"),
        LightContrast = Color3.fromHex("#231946"),
        DarkContrast = Color3.fromHex("#191432"),
        Text = Color3.fromHex("#c8c8ff"),
        TextInactive = Color3.fromHex("#afafaf"),
        Font = Drawing.Fonts.Plex,
        TextSize = 13,
        UseOutline = true
    },
    Icons = {},
    Flags = {},
    Items = {},
    Drawings = {},
    Ignores = {},
    Keybind = {},
    Watermark = {},
    Connections = {},
    Keys = {
        KeyBoard = {["Q"] = "Q", ["W"] = "W", ["E"] = "E", ["R"] = "R", ["T"] = "T", ["Y"] = "Y", ["U"] = "U", ["I"] = "I", ["O"] = "O", ["P"] = "P", ["A"] = "A", ["S"] = "S", ["D"] = "D", ["F"] = "F", ["G"] = "G", ["H"] = "H", ["J"] = "J", ["K"] = "K", ["L"] = "L", ["Z"] = "Z", ["X"] = "X", ["C"] = "C", ["V"] = "V", ["B"] = "B", ["N"] = "N", ["M"] = "M", ["One"] = {"1", "!"}, ["Two"] = {"2", "\""}, ["Three"] = {"3", "£"}, ["Four"] = {"4", "$"}, ["Five"] = {"5", "%"}, ["Six"] = {"6", "^"}, ["Seven"] = {"7", "&"}, ["Eight"] = {"8", "*"}, ["Nine"] = {"9", "("}, ["Zero"] = {"0", ")"}, ["Space"] = " ", ["Slash"] = {"/", "?"}, ["BackSlash"] = {"\\", "|"}, ["Minus"] = {"-", "_"}, ["Equals"] = {"=", "+"}, ["RightBracket"] = {"]", "}"}, ["LeftBracket"] = {"[", "{"}, ["Semicolon"] = {";", ":"}, ["Quote"] = {"'", "@"}, ["Comma"] = {",", "<"}, ["Period"] = {".", ">"}},
        Letters = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"},
        KeyCodes = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen", "Eight", "Nine", "Zero", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift", "RightAlt", "RightControl", "RightShift", "CapsLock"},
        Inputs = {"MouseButton1", "MouseButton2", "MouseButton3"},
        Shortened = {["MouseButton1"] = "M1", ["MouseButton2"] = "M2", ["MouseButton3"] = "M3", ["Insert"] = "INS", ["LeftAlt"] = "LA", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RA", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "CL"}
    },
    Input = {
        Caplock = false,
        LeftShift = false
    },
    Images = {},
    WindowVisible = true,
    Communication = Instance.new("BindableEvent")
}
--
local Utility = {}
--
getgenv().Library = Library
getgenv().Utility = Utility
-----------------------------------------------------------------
do
    Utility.AddInstance = function(NewInstance, Properties)
        local NewInstance = Instance.new(NewInstance)
        --
        for Index, Value in pairs(Properties) do
            NewInstance[Index] = Value
        end
        --
        return NewInstance
    end
    --
    function Utility.CloneTbl(T)
        local Tbl = {}
        for Index, Value in pairs(T) do
            Tbl[Index] = Value
        end
        return Tbl
    end
    --
    Utility.CLCheck = function()
        repeat task.wait() until iswindowactive()
        do
            local InputHandle = Utility.AddInstance("TextBox", {
                Position = UDim2.new(0, 0, 0, 0)
            })
            --
            InputHandle:CaptureFocus() task.wait() keypress(0x4E) task.wait() keyrelease(0x4E) InputHandle:ReleaseFocus()
            Library.Input.Caplock = InputHandle.Text == "N" and true or false
            InputHandle:Destroy()
        end
    end
    --
    Utility.Loop = function(Delay, Call)
        local Callback = typeof(Call) == "function" and Call or function() end
        --
        task.spawn(function()
            while task.wait(Delay) do
                local Success, Error = pcall(function()
                    Callback()
                end)
                --
                if Error then 
                    return 
                end
            end
        end)
    end
    --
    Utility.RemoveDrawing = function(Instance, Location)
        local SpecificDrawing = 0
        --
        Location = Location or Library.Drawings
        --
        for Index, Value in pairs(Location) do 
            if Value[1] == Instance then
                if Value[1] then
                    Value[1]:Remove()
                end
                if Value[2] then
                    Value[2] = nil
                end
                SpecificDrawing = Index
            end
        end
        --
        table.remove(Location, table.find(Location, Location[SpecificDrawing]))
    end
    --
    Utility.AddConnection = function(Type, Callback)
        local Connection = Type:Connect(Callback)
        --
        Library.Connections[#Library.Connections + 1] = Connection
        --
        return Connection
    end
    --
    Utility.Round = function(Num, Float)
        local Bracket = 1 / Float;
        return math.floor(Num * Bracket) / Bracket;
    end
    --
    Utility.AddDrawing = function(Instance, Properties, Location)
        local InstanceType = Instance
        local Instance = Drawing.new(Instance)
        --
        for Index, Value in pairs(Properties) do
            Instance[Index] = Value
            if InstanceType == "Text" then
                if Index == "Font" then
                    Instance.Font = Library.Theme.Font
                end
                if Index == "Size" then
                    Instance.Size = Library.Theme.TextSize
                end
            end
        end
        --
        if Properties.ZIndex ~= nil then
            Instance.ZIndex = Properties.ZIndex + 20
        else
            Instance.ZIndex = 20
        end
        --
        Location = Location or Library.Drawings
        if InstanceType == "Image" then
            Location[#Location + 1] = {Instance, true}
        else
            Location[#Location + 1] = {Instance}
        end
        --
        return Instance
    end
    --
    --Loni
    Utility.OnMouse = function(Instance)
        local Mouse = UserInput:GetMouseLocation()
        if Instance.Visible and (Mouse.X > Instance.Position.X) and (Mouse.X < Instance.Position.X + Instance.Size.X) and (Mouse.Y > Instance.Position.Y) and (Mouse.Y < Instance.Position.Y + Instance.Size.Y) then
            if Library.WindowVisible then
                return true
            end
        end
    end
    --
    Utility.Rounding = function(Num, DecimalPlaces)
        return tonumber(string.format("%." .. (DecimalPlaces or 0) .. "f", Num))
    end
    --
    Utility.AddDrag = function(Sensor, List)
        local DragUtility = {
            MouseStart = Vector2.new(), MouseEnd = Vector2.new(), Dragging = false
        }
        --
        Utility.AddConnection(UserInput.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                if Utility.OnMouse(Sensor) then
                    DragUtility.Dragging = true
                end
            end
        end)
        --
        Utility.AddConnection(UserInput.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                DragUtility.Dragging = false
            end
        end)
        --
        Utility.AddConnection(RunService.RenderStepped, function()
            DragUtility.MouseStart = UserInput:GetMouseLocation()
            --
            for Index, Value in pairs(List) do
                if Index ~= nil and Value ~= nil then
                    if DragUtility.Dragging then
                        Value[1].Position = Vector2.new(
                            Value[1].Position.X + (DragUtility.MouseStart.X - DragUtility.MouseEnd.X), 
                            Value[1].Position.Y + (DragUtility.MouseStart.Y - DragUtility.MouseEnd.Y)
                        )
                    end
                end
            end
            --
            DragUtility.MouseEnd = UserInput:GetMouseLocation()
        end)
    end
    --
    function Utility.HSVToRGB(HSVColor)
        local R, G, B = HSVColor.R * 255, HSVColor.G * 255, HSVColor.B * 255
	    return R, G, B
    end
    --
    Utility.AddCursor = function(Instance)
        local CursorOutline = Utility.AddDrawing("Triangle", {
            Color = Library.Theme.Accent[1],
            Thickness = 1,
            Filled = false,
            ZIndex = 5
        }, Library.Ignores)
        --
        local Cursor = Utility.AddDrawing("Triangle", {
            Color = Library.Theme.Accent[1],
            Thickness = 3,
            Filled = true,
            Transparency = 1,
            ZIndex = 5
        }, Library.Ignores)
        --
        Utility.AddConnection(Library.Communication.Event, function(Type, Color)
            if Type == "Accent" then
                Cursor.Color = Color
                CursorOutline.Color = Color
            end
        end)
        --
        Utility.AddConnection(RunService.RenderStepped, function()
            local Mouse = UserInput:GetMouseLocation()
            --
            if Library.WindowVisible then
                CursorOutline.Visible = true
                CursorOutline.PointA = Vector2.new(Mouse.X, Mouse.Y)
                CursorOutline.PointB = Vector2.new(Mouse.X + 15, Mouse.Y + 5)
                CursorOutline.PointC = Vector2.new(Mouse.X + 5, Mouse.Y + 15)

                Cursor.Visible = true
                Cursor.PointA = Vector2.new(Mouse.X, Mouse.Y)
                Cursor.PointB = Vector2.new(Mouse.X + 15, Mouse.Y + 5)
                Cursor.PointC = Vector2.new(Mouse.X + 5, Mouse.Y + 15)
            else
                CursorOutline.Visible = false
                Cursor.Visible = false
            end
        end)
    end
    --
    Utility.MiddlePos = function(Instance)
        return Vector2.new(
            (Camera.ViewportSize.X / 2) - (Instance.Size.X / 2), 
            (Camera.ViewportSize.Y / 2) - (Instance.Size.Y / 2)
        )
    end
    --
    Utility.SaveConfig = function(Config)
        local CFG = Utility.CloneTbl(Library.Flags)
        for Index, Value in pairs(CFG) do
            if Library.Items[Index].TypeOf == "Colorpicker" then
                local HH, SS, VV = Utility.HSVToRGB(CFG[Index])
                local RR, GG, BB = Color3.fromRGB(HH, SS, VV):ToHSV()
                CFG[Index] = {RR, GG, BB}
            end
        end
        writefile(
            "akiri/Configs/" .. tostring(game.PlaceId) .. "/" .. Config .. ".json", 
            HttpService:JSONEncode(CFG)
        )
    end
    --
    Utility.DeleteConfig = function(Config)
        delfile(
            "akiri/Configs/" .. tostring(game.PlaceId) .. "/" .. Config .. ".json"
        )
    end
    --
    Utility.LoadConfig = function(Config)
        local CFG = HttpService:JSONDecode(readfile("akiri/Configs/" .. tostring(game.PlaceId) .. "/" .. Config .. ".json"))
        --
        for Index, Val in pairs(CFG) do
            if Library.Items[Index].TypeOf == "Keybind" then
                Library.Items[Index]:Set(Val[1], Val[2], Val[3], true)
            elseif Library.Items[Index].TypeOf == "Colorpicker" then
                Library.Items[Index]:SetHue({Value = Val[1]})
                Library.Items[Index]:SetSaturationX({Value = Val[2]})
                Library.Items[Index]:SetSaturationY({Value = Val[3]})
            elseif  Library.Items[Index].TypeOf == "Slider" or Library.Items[Index].TypeOf == "Toggle" then
                Library.Items[Index]:Set(Val)
            end
        end
    end
    --
    Utility.AddFolder = function(GetFolder)
        local Folder = isfolder(GetFolder)
        --
        if Folder then
            return
        else
            makefolder(GetFolder)
            return true
        end
    end
    --
    Utility.AddImage = function(Image, Url, UI)
        local ImageFile = nil
        --
        if isfile(Image) then
            ImageFile = readfile(Image)
        else
            ImageFile = game:HttpGet(Url)
            writefile(Image, ImageFile)
        end
        --
        return ImageFile
    end
end
--
do
    function Library.CreateLoader(Title, WindowSize)
        local Window = {
            Max = 2, Current = 0
        }
        --
        Library.Theme.Logo = Utility.AddImage("akiri/Assets/UI/Logo2.png", "https://i.imgur.com/LbR3IoH.png")
        --
        local WindowOutline = Utility.AddDrawing("Square", {
            Size = WindowSize,
            Thickness = 0,
            Color = Library.Theme.Outline,
            Visible = true,
            Filled = true
        })
        --
        WindowOutline.Position = Utility.MiddlePos(WindowOutline)
        --
        local WindowOutlineBorder = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2),
            Position = Vector2.new(WindowOutline.Position.X + 1, WindowOutline.Position.Y + 1),
            Thickness = 0,
            Color = Library.Theme.Accent[1],
            Visible = true,
            Filled = true
        })
        --
        local WindowFrame = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutlineBorder.Size.X - 2, WindowOutlineBorder.Size.Y - 2),
            Position = Vector2.new(WindowOutlineBorder.Position.X + 1, WindowOutlineBorder.Position.Y + 1),
            Thickness = 0,
            Transparency = 1,
            Color = Library.Theme.DarkContrast,
            Visible = true,
            Filled = true
        })
        --
        local WindowTopline = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutline.Size.X - 2, 2),
            Position = Vector2.new(WindowOutlineBorder.Position.X, WindowOutlineBorder.Position.Y),
            Thickness = 0,
            Color = Library.Theme.Accent[1],
            Visible = false,
            Filled = true
        })
        --
        local WindowImage = Utility.AddDrawing("Image", {
            Size = WindowFrame.Size,
            Position = WindowFrame.Position,
            Transparency = 1, 
            Visible = true,
            Data = Library.Theme.Gradient
        })
        --
        local WindowTitle = Utility.AddDrawing("Text", {
            Font = Library.Theme.Font,
            Size = Library.Theme.TextSize,
            Color = Library.Theme.Text,
            Text = Title,
            Position = Vector2.new(WindowFrame.Position.X + (WindowFrame.Size.X / 2), WindowOutlineBorder.Position.Y + 8),
            Visible = true,
            Center = true,
            Outline = false
        })
        --
        local WindowText = Utility.AddDrawing("Text", {
            Font = Library.Theme.Font,
            Size = Library.Theme.TextSize,
            Color = Library.Theme.Text,
            Visible = true,
            Center = true,
            Outline = false
        })
        --
        local SliderInline = Utility.AddDrawing("Square", {
            Size = Vector2.new(205, 15),
            Color = Library.Theme.Inline,
            Position = Vector2.new(WindowFrame.Position.X + (WindowFrame.Size.X / 2), WindowOutlineBorder.Position.Y + 8),
            Transparency = 0.75,
            Thickness = 0,
            Visible = true,
            Filled = true
        })
        --
        local SliderOutline = Utility.AddDrawing("Square", {
            Size = Vector2.new(SliderInline.Size.X - 2, SliderInline.Size.Y - 2),
            Color = Library.Theme.Outline,
            Transparency = 0.5,
            Thickness = 0,
            Visible = true,
            Filled = true
        })
        --
        local SliderFrame = Utility.AddDrawing("Square", {
            Size = Vector2.new(((SliderInline.Size.X - 2) / (Window.Max / math.clamp(Window.Current, 0, Window.Max))), SliderInline.Size.Y - 2),
            Color = Library.Theme.Accent[1],
            Transparency = 0.75,
            Thickness = 0,
            Visible = true,
            Filled = true
        })
        --
        local SliderFrameShader = Utility.AddDrawing("Image", {
            Size = Vector2.new(SliderInline.Size.X - 2, SliderInline.Size.Y - 2),
            Transparency = 1, 
            Visible = true,
            Data = Library.Theme.Gradient
        })
        --
        local MiddleIcon = Utility.AddDrawing("Image", {
            Size = Vector2.new(175, 175),
            Rounding = 5,
            Transparency = 1, 
            Visible = true,
            Data = Library.Theme.Logo
        })
        --
        MiddleIcon.Position = Vector2.new(WindowOutline.Position.X + (WindowOutline.Size.X / 2) - (MiddleIcon.Size.X / 2), WindowOutline.Position.Y + (WindowOutline.Size.Y / 2) - (MiddleIcon.Size.Y / 2) - 15)
        --
        Window.SetText = function(Val, Txt)
            SliderFrame.Size = Vector2.new(((SliderInline.Size.X - 2) / (Window.Max / math.clamp(Val, 0, Window.Max))), SliderInline.Size.Y - 2)
            WindowText.Text = Txt
        end
        --
        SliderInline.Position = Vector2.new(WindowOutline.Position.X + (WindowOutline.Size.X / 2) - (SliderOutline.Size.X / 2), (WindowOutline.Position.Y + WindowOutline.Size.Y) - 30)
        SliderOutline.Position = Vector2.new(SliderInline.Position.X + 1, SliderInline.Position.Y + 1)
        SliderFrame.Position = Vector2.new(SliderInline.Position.X + 1, SliderInline.Position.Y + 1)
        SliderFrameShader.Position = Vector2.new(SliderInline.Position.X + 1, SliderInline.Position.Y + 1)
        WindowText.Position = Vector2.new(WindowFrame.Position.X + (WindowFrame.Size.X / 2), SliderInline.Position.Y - 16)
        --
        Window.SetText(0, "UI Initialization [ Downloading ]")
        --
        Utility.AddFolder("akiri")
        Utility.AddFolder("akiri/Caches")
        Utility.AddFolder("akiri/Assets")
        Utility.AddFolder("akiri/Assets/UI")
        Utility.AddFolder("akiri/Configs")
        Utility.AddFolder("akiri/Scripts")
        --
        Library.Theme.Gradient = Utility.AddImage("akiri/Assets/UI/Gradient.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/Gradient.png")
        -- Library.Theme.SecondIcon = Utility.AddImage("akiri/Assets/UI/Gradient.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/Gradient.png")
        Library.Theme.Hue = Utility.AddImage("akiri/Assets/UI/Hue.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/HuePicker.png")
        Library.Theme.Saturation = Utility.AddImage("akiri/Assets/UI/Saturation.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/SaturationPicker.png")
        Library.Theme.SaturationCursor = Utility.AddImage("akiri/Assets/UI/HueCursor.png", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
        --
        Library.Theme.Dummy = Utility.AddImage("akiri/Assets/UI/Dummy.png", "https://i.imgur.com/6M6buVv.png")
        Library.Theme.Astolfo = Utility.AddImage("akiri/Assets/UI/Astolfo.png", "https://i.imgur.com/T20cWY9.png")
        Library.Theme.Aiko = Utility.AddImage("akiri/Assets/UI/Aiko.png", "https://i.imgur.com/1gRIdko.png")
        Library.Theme.Rem = Utility.AddImage("akiri/Assets/UI/Rem.png", "https://i.imgur.com/ykbRkhJ.png")
        Library.Theme.Violet = Utility.AddImage("akiri/Assets/UI/Violet.png", "https://i.imgur.com/7B56w4a.png")
        Library.Theme.Asuka = Utility.AddImage("akiri/Assets/UI/Asuka.png", "https://i.imgur.com/3hwztNM.png")
        --
        if not isfolder("akiri/Configs/" .. game.PlaceId) then
            makefolder("akiri/Configs/" .. game.PlaceId)
        end
        --
        Window.SetText(1, "Checking Assets")
        --
        Window.SetText(1, "Checking Input")
        Utility.CLCheck(Window)
        --
        Window.SetText(2, "Finished")
        --
        Utility.RemoveDrawing(WindowOutline)
        Utility.RemoveDrawing(WindowOutlineBorder)
        Utility.RemoveDrawing(WindowTopline)
        Utility.RemoveDrawing(WindowFrame)
        Utility.RemoveDrawing(WindowTitle)
        Utility.RemoveDrawing(WindowText)
        Utility.RemoveDrawing(SliderOutline)
        Utility.RemoveDrawing(SliderInline)
        Utility.RemoveDrawing(SliderFrame)
        Utility.RemoveDrawing(SliderFrameShader)
        Utility.RemoveDrawing(MiddleIcon)
        Utility.RemoveDrawing(WindowImage)
        --
        UserInput.MouseIconEnabled = false
        --
        return Window
    end
end
--
do
    --
    function Library:ChangeVisible(State)
        Library.WindowVisible = State
        UserInput.MouseIconEnabled = not Library.WindowVisible
        for Idx, Val in pairs(Library.Drawings) do
            if Val[2] then
                Val[1].Transparency = Library.WindowVisible and 1 or 0
            else
                if Val[1].Color ~= Library.Theme.Hitbox then
                    Val[1].Transparency = Library.WindowVisible and 1 or 0
                end
            end
        end
    end
    --
    function Library:UpdateTheme(Config)
        if Config.Accent ~= nil then
            Library.Theme.Accent[1] = Config.Accent
            Library.Communication:Fire("Accent", Config.Accent)
        end
        if Config.Outline ~= nil then
            Library.Theme.Outline = Config.Outline
            Library.Communication:Fire("Outline", Config.Outline)
        end
        if Config.Inline ~= nil then
            Library.Theme.Inline = Config.Inline
            Library.Communication:Fire("Inline", Config.Inline)
        end
        if Config.LightContrast ~= nil then
            Library.Theme.LightContrast = Config.LightContrast
            Library.Communication:Fire("LightContrast", Config.LightContrast)
        end
        if Config.DarkContrast ~= nil then
            Library.Theme.DarkContrast = Config.DarkContrast
            Library.Communication:Fire("DarkContrast", Config.DarkContrast)
        end
    end
    --
    function Library.SelfDestruct()
        --
        UserInput.MouseIconEnabled = true
        --
        for Index, Value in pairs(Library.Connections) do
            Value:Disconnect()
        end
        --
        for Index, Value in pairs(Library.Drawings) do
            if Value[1] then    
                Value[1]:Remove()
            end
        end
        --
        for Index, Value in pairs(Library.Watermark) do
            if Value[1] then
                Value[1]:Remove()
            end
        end
        --
        for Index, Value in pairs(Library.Keybind) do
            if Value[1] then
                Value[1]:Remove()
            end
        end
        --
        for Index, Value in pairs(Library.Ignores) do
            if Value[1] then
                Value[1]:Remove()
            end
        end
        --
        Library.Drawings = {}
        Library.Watermark = {}
        Library.Keybind = {}
        Library.Ignores = {}
        --
    end
    --
    function Library.Window(Title, Size)
        local Window = {
            Notification = 0,
            Tabs = {},
            LastTab = nil,
            SelectedTab = nil,
            BindList = ""
        }
        --
        local Blur = Utility.AddDrawing("Image", {
            Position = Vector2.new(0, 0),
            Size = Vector2.new(1920, 1080),
            Transparency = 0,
            Visible = true,
        }, Library.Ignores)
        --
        do
            local WindowOutline = Utility.AddDrawing("Square", {
                Size = Vector2.new(120, 20),
                Thickness = 0,  
                Color = Library.Theme.Outline,
                Visible = true,
                Filled = true
            }, Library.Keybind)
            --
            WindowOutline.Position = Vector2.new(10, (Camera.ViewportSize.Y / 2) - (WindowOutline.Size.Y / 2))
            --
            local WindowOutlineBorder = Utility.AddDrawing("Square", {
                Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2),
                Position = Vector2.new(WindowOutline.Position.X + 1, WindowOutline.Position.Y + 1),
                Thickness = 0,
                Color = Library.Theme.Accent[1],
                Visible = false,
                Filled = true
            }, Library.Keybind)
            --
            local WindowFrame = Utility.AddDrawing("Square", {
                Size = Vector2.new(WindowOutlineBorder.Size.X - 2, WindowOutlineBorder.Size.Y - 2),
                Position = Vector2.new(WindowOutlineBorder.Position.X + 1, WindowOutlineBorder.Position.Y + 1),
                Thickness = 0,
                Transparency = 1,
                Color = Library.Theme.DarkContrast,
                Visible = true,
                Filled = true
            }, Library.Keybind)
            --
            local WindowTopline = Utility.AddDrawing("Square", {
                Size = Vector2.new(WindowOutlineBorder.Size.X, 1),
                Position = Vector2.new(WindowOutlineBorder.Position.X, WindowOutlineBorder.Position.Y),
                Thickness = 0,
                Color = Library.Theme.Accent[1],
                Visible = true,
                Filled = true
            }, Library.Keybind)
            --
            local WindowImage = Utility.AddDrawing("Image", {
                Size = WindowFrame.Size,
                Position = WindowFrame.Position,
                Transparency = 1, 
                Visible = true,
                Data = Library.Theme.Gradient
            }, Library.Keybind)
            --
            local WindowText = Utility.AddDrawing("Text", {
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Text = "Keybinds",
                Position = Vector2.new(WindowOutlineBorder.Position.X + (WindowOutlineBorder.Size.X / 2), WindowOutlineBorder.Position.Y + 2),
                Visible = true,
                Center = true,
                Outline = false
            }, Library.Keybind)
            --
            local CurrentBinds = Utility.AddDrawing("Text", {
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Text = "",
                Position = Vector2.new(WindowOutlineBorder.Position.X + 3, WindowOutlineBorder.Position.Y + 8),
                Visible = true,
                Center = false,
                Outline = false
            }, Library.Keybind)
            --
            Utility.AddConnection(RunService.RenderStepped, function(Type, Color)
                CurrentBinds.Text = Window.BindList

                local CalcuationSize = CurrentBinds.Text ~= "" and Vector2.new(CurrentBinds.TextBounds.X >= 120 and CurrentBinds.TextBounds.X + 6 or 120, 20 + CurrentBinds.TextBounds.Y - 6) or Vector2.new(120, 20)
                WindowOutline.Size = CalcuationSize
                
                WindowOutlineBorder.Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2)
                WindowOutlineBorder.Position = Vector2.new(WindowOutline.Position.X + 1, WindowOutline.Position.Y + 1)

                WindowTopline.Size = Vector2.new(WindowOutlineBorder.Size.X, 1)
                WindowTopline.Position = Vector2.new(WindowOutlineBorder.Position.X, WindowOutlineBorder.Position.Y)

                WindowImage.Size = WindowFrame.Size
                WindowImage.Position = WindowFrame.Position

                WindowText.Position = Vector2.new(WindowOutlineBorder.Position.X + (WindowOutlineBorder.Size.X / 2), WindowOutlineBorder.Position.Y + 2)
            end)
            --
            Utility.AddDrag(WindowOutline, Library.Keybind)
            --
            Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                if Type == "Accent" then
                    WindowOutlineBorder.Color = Color
                    WindowTopline.Color = Color
                elseif Type == "Outline" then
                    WindowOutline.Color = Color
                elseif Type == "DarkContrast" then
                    WindowFrame.Color = Color
                elseif Type == "Text" then
                    WindowText.Color = Color
                end
            end)
        end
        --
        local Anime = Utility.AddDrawing("Image", {
            Transparency = 0.5, 
            Visible = false
        }, Library.Ignores)
        --
        local WindowOutline = Utility.AddDrawing("Square", {
            Size = Size,
            Thickness = 0,
            Color = Library.Theme.Outline,
            Visible = true,
            Filled = true
        })
        --
        WindowOutline.Position = Utility.MiddlePos(WindowOutline)
        --
        local WindowOutlineBorder = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2),
            Position = Vector2.new(WindowOutline.Position.X + 1, WindowOutline.Position.Y + 1),
            Thickness = 0,
            Color = Library.Theme.Accent[1],
            Visible = true,
            Filled = true
        })
        --
        local WindowFrame = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutlineBorder.Size.X - 2, WindowOutlineBorder.Size.Y - 2),
            Position = Vector2.new(WindowOutlineBorder.Position.X + 1, WindowOutlineBorder.Position.Y + 1),
            Thickness = 0,
            Transparency = 1,
            Color = Library.Theme.DarkContrast,
            Visible = true,
            Filled = true
        })
        --
        local WatermarkIcon = Utility.AddDrawing("Image", {
            Size = Vector2.new(70, 70),
            Position = Vector2.new(WindowFrame.Position.X + (WindowFrame.Size.X / 2) - 35, WindowFrame.Position.Y - 4),
            Transparency = 1,
            ZIndex = 3,
            Visible = true,
            Data = Library.Theme.Logo
        })
        --
        Utility.AddCursor(WindowFrame)
        --
        local WindowHeader = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutlineBorder.Size.X - 2, 70),
            Position = Vector2.new(WindowOutlineBorder.Position.X + 1, WindowOutlineBorder.Position.Y + 1),
            Thickness = 0,
            Transparency = 0,
            Color = Library.Theme.Hitbox,
            Visible = true,
            Filled = true
        })
        --
        Utility.AddDrag(WindowHeader, Library.Drawings)
        --
        local WindowTopline = Utility.AddDrawing("Square", {
            Size = Vector2.new(WindowOutlineBorder.Size.X, 1),
            Position = Vector2.new(WindowOutlineBorder.Position.X, WindowOutlineBorder.Position.Y),
            Thickness = 0,
            Color = Library.Theme.Accent[1],
            Visible = false,
            Filled = true
        })
        --
        local WindowImage = Utility.AddDrawing("Image", {
            Size = WindowFrame.Size,
            Position = WindowFrame.Position,
            Transparency = 1, 
            Visible = false,
            Data = Library.Theme.Gradient
        })
        --
        local WindowTitle = Utility.AddDrawing("Text", {
            Font = Library.Theme.Font,
            Size = Library.Theme.TextSize,
            Color = Library.Theme.Text,
            Text = Title,
            Position = Vector2.new(WindowOutlineBorder.Position.X + 8, WindowOutlineBorder.Position.Y + 6),
            Visible = true,
            Center = false,
            Outline = false
        })
        --
        local SecondBorderInline = Utility.AddDrawing("Square", {
            Size = Vector2.new(Size.X - 17, Size.Y - 90),
            Position = Vector2.new(WindowOutlineBorder.Position.X + 8, WindowOutlineBorder.Position.Y + 82),
            Thickness = 0,
            Color = Library.Theme.Inline,
            Visible = true,
            Filled = true
        })
        --
        local SecondBorderOutline = Utility.AddDrawing("Square", {
            Size = Vector2.new(SecondBorderInline.Size.X - 2, SecondBorderInline.Size.Y - 2),
            Position = Vector2.new(SecondBorderInline.Position.X + 1, SecondBorderInline.Position.Y + 1),
            Thickness = 0,
            Color = Library.Theme.LightContrast,
            Visible = true,
            Filled = true
        })
        --
        local TabLine = Utility.AddDrawing("Square", {
            Thickness = 0,
            Color = Library.Theme.Accent[1], --Library.Theme.Outline,
            Visible = true,
            Filled = true,
            ZIndex = 2
        })
        --
        local DisableLine = Utility.AddDrawing("Square", {
            Thickness = 0,
            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
            Visible = true,
            Filled = true,
            ZIndex = 3
        })
        --
        Utility.AddConnection(Library.Communication.Event, function(Type, Color)
            if Type == "Accent" then
                WindowOutlineBorder.Color = Color
                WindowTopline.Color = Color
                TabLine.Color = Color
            elseif Type == "Outline" then
                WindowOutline.Color = Color
            elseif Type == "LightContrast" then
                DisableLine.Color = Color
                SecondBorderOutline.Color = Color
            elseif Type == "DarkContrast" then
                WindowFrame.Color = Color
            elseif Type == "Text" then
                WindowTitle.Color = Color
            elseif Type == "Inline" then
                SecondBorderInline.Color = Color
            end
        end)
        --
        Window["PageCover"] = SecondBorderInline
        --
        function Window.ChangeAnime(Name)
            Anime.Data = (
                Name == "Astolfo" and Library.Theme.Astolfo or
                Name == "Aiko" and Library.Theme.Aiko or
                Name == "Rem" and Library.Theme.Rem or
                Name == "Violet" and Library.Theme.Violet or
                Name == "Asuka" and Library.Theme.Asuka
            )

            Anime.Size = (
                Name == "Astolfo" and Vector2.new(412, 605) or
                Name == "Aiko" and Vector2.new(390, 630) or
                Name == "Rem" and Vector2.new(390, 639) or
                Name == "Violet" and Vector2.new(1029 / 3, 1497 / 3) or
                Name == "Asuka" and Vector2.new(415, 601)
            )

            Anime.Position = Vector2.new(Camera.ViewportSize.X - 400, Camera.ViewportSize.Y - Anime.Size.Y)
        end
        --
        function Window.ToggleAnime(State)
            Anime.Visible = State
        end
        --
        function Window.SendNotification(Type, Title, Duration)
            local Notification, Removed = Window.Notification, false
            --
            local NotificationInline = Utility.AddDrawing("Square", {
                Size = Vector2.new(0, 21),
                Position = Vector2.new(0, (Window.Notification * 25) + 100),
                Thickness = 0,
                Color = Library.Theme.Inline,
                Visible = true,
                Filled = true
            }, Library.Ignores)
            --
            local NotificationOutline = Utility.AddDrawing("Square", {
                Size = Vector2.new(0, NotificationInline.Size.Y - 1),
                Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2),
                Thickness = 0,
                Color = Library.Theme.DarkContrast,
                Visible = true,
                Filled = true
            }, Library.Ignores)
            --
            local NotificationOutlineBorder = Utility.AddDrawing("Square", {
                Size = Vector2.new(NotificationOutline.Size.X - 2, NotificationOutline.Size.Y + 5),
                Position = Vector2.new(NotificationOutline.Position.X + 1, NotificationOutline.Position.Y + 1),
                Thickness = 0,
                Color = Library.Theme.Accent[1],
                Visible = false,
                Filled = true
            }, Library.Ignores)
            --
            local NotificationTopline = Utility.AddDrawing("Square", {
                Size = Vector2.new(NotificationOutline.Size.X, 1),
                Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y),
                Thickness = 0,
                Color = Type == "Warning" and Library.Theme.Notification.Warning or Type == "Error" and Library.Theme.Notification.Error or Library.Theme.DarkContrast,
                Visible = Type == "Warning" or Type == "Error",
                Filled = true
            }, Library.Ignores)
            --
            local NotificationLeftline = Utility.AddDrawing("Square", {
                Size = Vector2.new(1, NotificationOutline.Size.Y),
                Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y),
                Thickness = 0,
                Color = Type == "Normal" and Library.Theme.Accent[1] or Library.Theme.DarkContrast,
                Visible = Type == "Normal",
                Filled = true
            }, Library.Ignores)
            --
            local NotificationImage = Utility.AddDrawing("Image", {
                Size = NotificationOutlineBorder.Size,
                Position = NotificationOutlineBorder.Position,
                Transparency = 1, 
                Visible = true,
                Data = Library.Theme.Gradient
            }, Library.Ignores)
            --
            local NotificationText = Utility.AddDrawing("Text", {
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Text = Title,
                Position = Vector2.new(NotificationOutlineBorder.Position.X + 6, NotificationOutlineBorder.Position.Y + 3),
                Visible = true,
                Center = false,
                Outline = false
            }, Library.Ignores)
            --
            NotificationInline.Size = Vector2.new(NotificationText.TextBounds.X + 15, 21)
            --
            NotificationOutline.Size = Vector2.new(NotificationInline.Size.X - 1, NotificationInline.Size.Y - 1)
            NotificationOutline.Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2)
            --
            NotificationOutlineBorder.Size = Vector2.new(NotificationOutline.Size.X - 2, NotificationOutline.Size.Y - 2)
            NotificationOutlineBorder.Position = Vector2.new(NotificationOutline.Position.X + 1, NotificationOutline.Position.Y + 1)
            --
            NotificationLeftline.Size = Vector2.new(2, NotificationOutline.Size.Y)
            --
            NotificationTopline.Size = Vector2.new(NotificationOutline.Size.X, 1)
            --
            NotificationImage.Size = NotificationOutline.Size
            NotificationImage.Position = NotificationOutline.Position
            --
            task.spawn(function()
                for Index = -100, 0, 2 do
                    pcall(function()
                        NotificationInline.Position = Vector2.new(Index, (Notification * 25) + 100)
                        NotificationOutline.Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2)
                        NotificationOutlineBorder.Position = Vector2.new(NotificationOutline.Position.X + 2, NotificationOutline.Position.Y + 2)
                        NotificationText.Position = Vector2.new(NotificationOutline.Position.X + 6, NotificationOutline.Position.Y + 3)
                        NotificationTopline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                        NotificationImage.Position = NotificationOutline.Position
                        NotificationLeftline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                    end)
                    task.wait()
                end
            end)
            --
            Utility.AddConnection(Library.Communication.Event, function(Type)
                if Type == "UpdateNotification" then
                    Notification -= 1
                    pcall(function()
                        NotificationInline.Size = Vector2.new(Index, (Notification * 25) + 100)
                        NotificationOutline.Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2)
                        NotificationText.Position = Vector2.new(NotificationOutline.Position.X + 6, NotificationOutline.Position.Y + 3)
                        NotificationTopline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                        NotificationImage.Position = NotificationOutline.Position
                        NotificationLeftline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                    end)
                end
            end)
            --
            Window.Notification += 1
            --
            task.spawn(function()
                task.wait(Duration)
                --
                pcall(function()
                    Utility.RemoveDrawing(NotificationInline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationLeftline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationOutline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationOutlineBorder, Library.Ignores)
                    Utility.RemoveDrawing(NotificationText, Library.Ignores)
                    Utility.RemoveDrawing(NotificationTopline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationImage, Library.Ignores)
                end)
                --
                Library.Communication:Fire("UpdateNotification")
                --
                Window.Notification -= 1
            end)
        end
        --
        function Window:RefreshPages()
            for Index, Value in pairs(Window.Tabs) do
                Value:Resize(Index)
            end
        end
        --
        function Window:SwitchTab(Tab)
            for Index, Value in pairs(self.Tabs) do
                Value["TabTitle"].Color = Library.Theme.TextInactive
                Value["TabOutline"].Color = Library.Theme.DarkContrast

                for _, Render in pairs(Value["Render"]) do
                    Render.Visible = false
                end
            end

            Tab["TabOutline"].Color = Library.Theme.LightContrast
            Tab["TabTitle"].Color = Library.Theme.Text

            TabLine.Size = Vector2.new(Tab["TabOutline"].Size.X, 1)
            TabLine.Position = Vector2.new(Tab["TabOutline"].Position.X, Tab["TabOutline"].Position.Y)
            DisableLine.Size = Vector2.new(Tab["TabOutline"].Size.X, 1)
            DisableLine.Position = Vector2.new(Tab["TabOutline"].Position.X, Tab["TabOutline"].Position.Y + Tab["TabOutline"].Size.Y)
            Window.SelectedTab = Tab.CurrentTab

            for _, Render in pairs(Tab["Render"]) do
                Render.Visible = true
            end
        end
        --
        function Window:Tab(Title)
            local Tab = {
                Visible = {},
                SectionAxis = {0, 0},
                Sections = {},
                Dropdowns = {
                    ["Left"] = {}, 
                    ["Right"] = {}
                },
                CurrentTab = #self.Tabs
            }
            --
            local TabInline = Utility.AddDrawing("Square", {
                Position = Vector2.new(SecondBorderInline.Position.X, SecondBorderOutline.Position.Y - 20),
                Size = Vector2.new(0, 20),
                Thickness = 0,
                Color = Library.Theme.Inline,
                Visible = true,
                Filled = true
            })
            --
            local TabOutline = Utility.AddDrawing("Square", {
                Size = Vector2.new(TabInline.Size.X - 2, TabInline.Size.Y - 2),
                Position = Vector2.new(TabInline.Position.X + 1, TabInline.Position.Y + 1),
                Thickness = 0,
                Color = Library.Theme.DarkContrast, --Library.Theme.Outline,
                Visible = true,
                Filled = true
            })
            --
            local TabTitle = Utility.AddDrawing("Text", {
                Text = Title,
                Center = true,
                Outline = false,
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Visible = true,
                ZIndex = 2
            })
            --
            Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                if Type == "DarkContrast" and Window.SelectedTab == Tab then
                    TabOutline.Color = Color
                elseif Type == "LightContrast" and Window.SelectedTab ~= Tab then
                    TabOutline.Color = Color
                elseif Type == "Text" then
                    TabTitle.Color = Color
                elseif Type == "Inline" then
                    TabInline.Color = Color
                end
            end)
            --
            function Tab:Install()
                TabInline.Size = Vector2.new(TabTitle.TextBounds.X + 50, 20)
                TabInline.Position = Vector2.new((Window.LastTab ~= nil and Window.LastTab.Position.X + Window.LastTab.Size.X + 5 or SecondBorderInline.Position.X), SecondBorderOutline.Position.Y - 20)

                TabOutline.Size = Vector2.new(TabInline.Size.X - 2, TabInline.Size.Y - 2)
                TabOutline.Position = Vector2.new(TabInline.Position.X + 1, TabInline.Position.Y + 1)

                if Window.LastTab == nil then
                    TabLine.Size = Vector2.new(TabOutline.Size.X, 1)
                    TabLine.Position = Vector2.new(TabOutline.Position.X + 1, TabOutline.Position.Y)

                    DisableLine.Size = Vector2.new(TabOutline.Size.X, 1)
                    DisableLine.Position = Vector2.new(TabOutline.Position.X, TabOutline.Position.Y + TabOutline.Size.Y)

                    Window.SelectedTab = Tab.CurrentTab
                end

                TabTitle.Position = Vector2.new(TabOutline.Position.X + (TabOutline.Size.X / 2), TabOutline.Position.Y + (TabOutline.Size.Y / 2) - 7)
            end
            --
            function Tab:RemoveDrawing(Instance)
                local SpecificDrawing = 0
                for Index, Value in pairs(Tab["Render"]) do 
                    if Value == Instance then
                        SpecificDrawing = Index
                    end
                end
                table.remove(Tab["Render"], table.find(Tab["Render"], Tab["Render"][SpecificDrawing]))
                --
                local SpecificDrawing2 = 0
                for Index, Value in pairs(Library.Drawings) do 
                    if Value[1] == Instance then
                        if Value[1] then
                            Value[1]:Remove()
                        end
                        if Value[2] then
                            Value[2] = nil
                        end
                        SpecificDrawing2 = Index
                    end
                end
                table.remove(Library.Drawings, table.find(Library.Drawings, Library.Drawings[SpecificDrawing2]))
            end
            --
            function Tab:Section(Title, Side)
                local Section = {
                    ContentAxis = 0,
                    Name = Title
                }
                --
                local AxisX = Side == "Left" and SecondBorderOutline.Position.X + 6 or SecondBorderOutline.Position.X + ((SecondBorderOutline.Size.X / 2) - 10) + 12
                local SectionInline = Utility.AddDrawing("Square", {
                    Position = Vector2.new(AxisX, (Tab.SectionAxis[Side == "Left" and 1 or 2] == 0 and TabOutline.Position.Y + TabOutline.Size.Y + 6 or 6 + Tab.SectionAxis[Side == "Left" and 1 or 2])),
                    Size = Vector2.new((SecondBorderOutline.Size.X / 2) - 8, 24),
                    Thickness = 0,
                    Color = Library.Theme.Inline,
                    Visible = true,
                    Filled = true
                })
                --
                local SectionOutline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(SectionInline.Size.X - 2, SectionInline.Size.Y - 2),
                    Position = Vector2.new(SectionInline.Position.X + 1, SectionInline.Position.Y + 1),
                    Thickness = 0,
                    Color = Library.Theme.DarkContrast, --Library.Theme.Outline,
                    Visible = true,
                    Filled = true
                })
                --
                local SectionTopline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(SectionOutline.Size.X, 1),
                    Position = Vector2.new(SectionOutline.Position.X, SectionOutline.Position.Y),
                    Thickness = 0,
                    Color = Library.Theme.Accent[1],
                    Visible = true,
                    Filled = true
                })
                --
                local SectionTitle = Utility.AddDrawing("Text", {
                    Text = Title,
                    Position = Vector2.new(SectionOutline.Position.X + 4, SectionOutline.Position.Y + 4),
                    Center = false,
                    Outline = false,
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Visible = true,
                    ZIndex = 2
                })
                --
                Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                    if Type == "Accent" then
                        SectionTopline.Color = Color
                    elseif Type == "DarkContrast" then
                        SectionOutline.Color = Color
                    elseif Type == "Text" then
                        SectionTitle.Color = Color
                    elseif Type == "Inline" then
                        SectionInline.Color = Color
                    end
                end)
                --
                function Section:UpdateSizeY(SizeY)
                    SectionInline.Size = Vector2.new(SectionInline.Size.X, SizeY + 10)

                    SectionOutline.Size = Vector2.new(SectionInline.Size.X - 2, SectionInline.Size.Y - 2)
                    SectionOutline.Position = Vector2.new(SectionInline.Position.X + 1, SectionInline.Position.Y + 1)
                end
                --
                Tab.SectionAxis = {
                    Side == "Left" and SectionInline.Position.Y + SectionInline.Size.Y or Tab.SectionAxis[1], 
                    Side == "Right" and SectionInline.Position.Y + SectionInline.Size.Y or Tab.SectionAxis[2]
                }
                --
                Tab["Render"][#Tab["Render"] + 1] = SectionInline
                Tab["Render"][#Tab["Render"] + 1] = SectionOutline
                Tab["Render"][#Tab["Render"] + 1] = SectionTopline
                Tab["Render"][#Tab["Render"] + 1] = SectionTitle
                --
                function Section:Toggle(Options)
                    local Toggle = {
                        TypeOf = "Toggle",
                        Axis = Section.ContentAxis,
                        Toggled = Options.State,
                        Drop = false,
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                    }
                    --
                    Options.Flag = Options.Flag or "AWGWJIjgAWJIGIJAWG"
                    Library.Flags[Options.Flag] = false
                    --
                    Library.Items[Options.Flag] = Toggle
                    --
                    local ToggleInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + 8, SectionInline.Position.Y + 23 + Toggle.Axis),
                        Size = Vector2.new(13, 13),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ToggleOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(ToggleInline.Size.X - 2, ToggleInline.Size.Y - 2),
                        Position = Vector2.new(ToggleInline.Position.X + 1, ToggleInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ToggleHitbox = Utility.AddDrawing("Square", {
                        Size = Vector2.new(SectionOutline.Size.X - 60, ToggleInline.Size.Y - 2),
                        Position = Vector2.new(ToggleInline.Position.X + 1, ToggleInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.Hitbox, --Library.Theme.Outline,
                        Transparency = 0,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ToggleGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(ToggleInline.Size.X - 2, ToggleInline.Size.Y - 2),
                        Position = Vector2.new(ToggleInline.Position.X + 1, ToggleInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 0.5,
                        Visible = true
                    })
                    --
                    local ToggleTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(ToggleInline.Position.X + ToggleInline.Size.X + 8, ToggleInline.Position.Y),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Options.Type ~= nil and Options.Type == "Dangerous" and Color3.fromRGB(255, 255, 0) or Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    function Toggle:Set(State)
                        Toggle.Toggled = State
                        ToggleOutline.Color = Toggle.Toggled and Library.Theme.Accent[1] or Library.Theme.DarkContrast
                        Library.Flags[Options.Flag] = Toggle.Toggled
                        Toggle.Callback(Toggle.Toggled)
                    end
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        for Index, Value in pairs(Tab.Dropdowns[Side]) do
                            if Value then
                                return
                            end
                        end
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 and Utility.OnMouse(ToggleHitbox) then
                            Toggle.Toggled = not Toggle.Toggled
                            Toggle:Set(Toggle.Toggled)
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                        if Input.UserInputType == Enum.UserInputType.MouseMovement then
                            if Utility.OnMouse(ToggleHitbox) then
                                ToggleInline.Color = Library.Theme.Accent[1]
                            else
                                ToggleInline.Color = Library.Theme.Inline
                            end
                        end
                    end)
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                        if Type == "Accent" and Toggle.Toggled then
                            ToggleOutline.Color = Color
                            if Options.Type == "Dangerous" then
                                -- ToggleTitle.Color = Color
                            end
                        elseif Type == "LightContrast" and not Toggle.Toggled then
                            ToggleOutline.Color = Color
                        elseif Type == "Text" then
                            ToggleTitle.Color = Color
                        elseif Type == "Inline" then
                            ToggleInline.Color = Color
                        end
                    end)
                    --
                    Section.ContentAxis = Section.ContentAxis + ToggleOutline.Size.Y + 8
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] + ToggleOutline.Size.Y + 8 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] + ToggleOutline.Size.Y + 8 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + ToggleOutline.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = ToggleInline
                    Tab["Render"][#Tab["Render"] + 1] = ToggleOutline
                    Tab["Render"][#Tab["Render"] + 1] = ToggleTitle
                    Tab["Render"][#Tab["Render"] + 1] = ToggleGradient
                    Tab["Render"][#Tab["Render"] + 1] = ToggleHitbox
                    --
                    function Toggle:Colorpicker(Options)
                        local Colorpicker = {
                            TypeOf = "Colorpicker",
                            Axis = Section.ContentAxis,
                            Color = Options.Color,
                            HexColor = Options.Color:ToHex(),
                            Dropped = false,
                            Offsets = {
                                X = 0,
                                Y = 0
                            },
                            Colors = {
                                HSV = {1, 1, 1}
                            },
                            SaturationDragging = false,
                            HueDragging = false,
                            Decimals = 50,
                            Rainbow = false,
                            Flag = Options.Flag,
                            Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                        }
                        --
                        Colorpicker.Flag = Colorpicker.Flag or "AWIJGHUIWGHuAW"
                        Library.Flags[Colorpicker.Flag] = HexColor
                        --
                        Library.Items[Colorpicker.Flag] = Colorpicker
                        --
                        local H, S, V = Colorpicker.Color:ToHSV()
                        Colorpicker.Colors.HSV[1] = H
                        Colorpicker.Colors.HSV[2] = S
                        Colorpicker.Colors.HSV[3] = V
                        --
                        local ColorpickerInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new((SectionInline.Position.X + SectionInline.Size.X) - 38, ToggleInline.Position.Y + 1),
                            Size = Vector2.new(30, 12),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true
                        })
                        --
                        local ColorpickerOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(ColorpickerInline.Size.X - 2, ColorpickerInline.Size.Y - 2),
                            Position = Vector2.new(ColorpickerInline.Position.X + 1, ColorpickerInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true
                        })
                        --
                        local ColorpickerBase = Utility.AddDrawing("Square", {
                            Size = Vector2.new(ColorpickerInline.Size.X - 2, ColorpickerInline.Size.Y - 2),
                            Position = Vector2.new(ColorpickerInline.Position.X + 1, ColorpickerInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Colorpicker.Color, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true
                        })
                        --
                        local ColorpickerGradient = Utility.AddDrawing("Image", {
                            Size = Vector2.new(ColorpickerInline.Size.X - 2, ColorpickerInline.Size.Y - 2),
                            Position = Vector2.new(ColorpickerInline.Position.X + 1, ColorpickerInline.Position.Y + 1),
                            Data = Library.Theme.Gradient,
                            Transparency = 0.5,
                            Visible = true
                        })
                        --
                        local InternalInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new((ColorpickerInline.Position.X - 225) + ColorpickerInline.Size.X, ToggleInline.Position.Y + 18),
                            Size = Vector2.new(225, 250),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(InternalInline.Size.X - 2, InternalInline.Size.Y - 2),
                            Position = Vector2.new(InternalInline.Position.X + 1, InternalInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalTopline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(InternalOutline.Size.X, 1),
                            Position = Vector2.new(InternalOutline.Position.X, InternalOutline.Position.Y),
                            Thickness = 0,
                            Color = Library.Theme.Accent[1],
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                            if Type == "Accent" then
                                InternalTopline.Color = Color
                            end
                        end)
                        --
                        local InternalTitle = Utility.AddDrawing("Text", {
                            Text = ToggleTitle.Text,
                            Position = Vector2.new(InternalOutline.Position.X + 8, InternalOutline.Position.Y + 6),
                            Center = false,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local InternalBaseInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(InternalOutline.Position.X + 8, InternalOutline.Position.Y + 25),
                            Size = Vector2.new(192, 192),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalBase = Utility.AddDrawing("Square", {
                            Size = Vector2.new(192 - 4, 192 - 4),
                            Position = Vector2.new(InternalBaseInline.Position.X + 2, InternalBaseInline.Position.Y + 2),
                            Thickness = 0,
                            Color = Options.Color, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalSaturation = Utility.AddDrawing("Image", {
                            Size = Vector2.new(196 - 2, 196 - 2),
                            Position = Vector2.new(InternalOutline.Position.X + 8 + 1, InternalOutline.Position.Y + 25 + 1),
                            Data = Library.Theme.Saturation,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local InternalHueInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(InternalOutline.Position.X + InternalBase.Size.X + 14, InternalOutline.Position.Y + 26),
                            Size = Vector2.new(16, 196),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalHue = Utility.AddDrawing("Image", {
                            Size = Vector2.new(InternalHueInline.Size.X - 2, InternalHueInline.Size.Y - 2),
                            Position = Vector2.new(InternalHueInline.Position.X + 1, InternalHueInline.Position.Y + 1),
                            Data = Library.Theme.Hue,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local InternalOutlineHuePicker = Utility.AddDrawing("Square", {
                            Position = Vector2.new(InternalOutline.Position.X + InternalBase.Size.X + 12, InternalOutline.Position.Y + 26),
                            Size = Vector2.new(InternalHueInline.Size.X + 2, 6),
                            Thickness = 2,
                            Color = Library.Theme.Outline,
                            Visible = true,
                            Filled = false,
                            ZIndex = 3
                        })
                        --
                        local InternalHuePicker = Utility.AddDrawing("Square", {
                            Position = Vector2.new(InternalOutlineHuePicker.Position.X + 1, InternalOutlineHuePicker.Position.Y + 1),
                            Size = Vector2.new(InternalOutlineHuePicker.Size.X - 2, InternalOutlineHuePicker.Size.Y - 2),
                            Thickness = 2,
                            Color = Library.Theme.Text,
                            Visible = true,
                            Filled = false,
                            ZIndex = 3
                        })
                        --
                        local Cursor = Utility.AddDrawing("Image", {
                            Size = Vector2.new(6, 6),
                            Data = Library.Theme.SaturationCursor,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 6
                        })
                        --
                        local InternalInlineHex = Utility.AddDrawing("Square", {
                            Size = Vector2.new(80 - 2, 18 - 2),
                            Position = Vector2.new(InternalOutline.Position.X + 8 + 1, InternalOutline.Position.Y + InternalSaturation.Size.Y + 30 + 1),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalOutlineHex = Utility.AddDrawing("Square", {
                            Size = Vector2.new(InternalInlineHex.Size.X - 2, InternalInlineHex.Size.Y - 2),
                            Position = Vector2.new(InternalInlineHex.Position.X + 1, InternalInlineHex.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalHex = Utility.AddDrawing("Text", {
                            Text = ("#%s"):format(tostring(Colorpicker.HexColor)),
                            Position = Vector2.new(InternalOutlineHex.Position.X + (InternalOutlineHex.Size.X / 2), InternalOutlineHex.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local InternalInlineRGB = Utility.AddDrawing("Square", {
                            Size = Vector2.new(130 - 2, 18 - 2),
                            Position = Vector2.new(InternalOutline.Position.X + 90 + 1, InternalOutline.Position.Y + InternalSaturation.Size.Y + 30 + 1),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalOutlineRGB = Utility.AddDrawing("Square", {
                            Size = Vector2.new(InternalInlineRGB.Size.X - 2, InternalInlineRGB.Size.Y - 2),
                            Position = Vector2.new(InternalInlineRGB.Position.X + 1, InternalInlineRGB.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalRGB = Utility.AddDrawing("Text", {
                            Text = ("%s, %s, %s"):format(math.floor(Colorpicker.Color.R * 255), math.floor(Colorpicker.Color.G * 255), math.floor(Colorpicker.Color.B * 255)),
                            Position = Vector2.new(InternalOutlineRGB.Position.X + (InternalOutlineRGB.Size.X / 2), InternalOutlineRGB.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local InternalInlineRainbow = Utility.AddDrawing("Square", {
                            Size = Vector2.new(100 - 2, 18 - 2),
                            Position = Vector2.new((InternalOutline.Position.X + InternalOutline.Size.X) - 100 - 2 + 1, InternalOutline.Position.Y + 4 + 1),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalOutlineRainbow = Utility.AddDrawing("Square", {
                            Size = Vector2.new(InternalInlineRainbow.Size.X - 2, InternalInlineRainbow.Size.Y - 2),
                            Position = Vector2.new(InternalInlineRainbow.Position.X + 1, InternalInlineRainbow.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local InternalRainbow = Utility.AddDrawing("Text", {
                            Text = "Rainbow",
                            Position = Vector2.new(InternalOutlineRainbow.Position.X + (InternalOutlineRainbow.Size.X / 2), InternalOutlineRainbow.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        function Colorpicker:Drop(State)
                            InternalInline.Visible = State
                            InternalOutline.Visible = State
                            InternalTitle.Visible = State
                            InternalBaseInline.Visible = State
                            InternalBase.Visible = State
                            InternalSaturation.Visible = State
                            InternalHueInline.Visible = State
                            InternalHue.Visible = State
                            InternalOutlineHex.Visible = State
                            InternalInlineHex.Visible = State
                            InternalHex.Visible = State
                            InternalInlineRGB.Visible = State
                            InternalOutlineRGB.Visible = State
                            InternalRGB.Visible = State
                            InternalInlineRainbow.Visible = State
                            InternalOutlineRainbow.Visible = State
                            InternalRainbow.Visible = State
                            InternalTopline.Visible = State
                            Cursor.Visible = State
                            InternalOutlineHuePicker.Visible = State
                            InternalHuePicker.Visible = State
                            Tab.Dropdowns[Side][ToggleTitle.Text] = State
                        end
                        --
                        Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                            if Type == "Accent" then
                                
                            elseif Type == "LightContrast" then
                                
                            elseif Type == "Text" then
                                InternalTitle.Color = Color
                            elseif Type == "Inline" then
                                InternalInline.Color = Color
                                InternalBaseInline.Color = Color
                                InternalHueInline.Color = Color
                                InternalInlineHex.Color = Color
                            elseif Type == "Outline" then
                                InternalOutline.Color = Color
                                InternalOutlineHex.Color = Color
                                InternalInline.Color = Color
                            end
                        end)
                        --
                        Colorpicker.Offsets.X = InternalBase.Position.X
                        Colorpicker.Offsets.Y = InternalBase.Position.Y
                        --
                        function Colorpicker:SetHue(Options)
                            local Percent = Options.Percent or Options.Value
        
                            Colorpicker.Colors.HSV[1] = Options.Value

                            local HSVColor = Color3.fromHSV(Colorpicker.Colors.HSV[1], Colorpicker.Colors.HSV[2], Colorpicker.Colors.HSV[3])
                            
                            InternalOutlineHuePicker.Position = Vector2.new(InternalOutline.Position.X + InternalBase.Size.X + 12, InternalHue.Position.Y + (InternalHue.Size.Y * Percent) - 4)
                            InternalHuePicker.Position = Vector2.new(InternalOutlineHuePicker.Position.X + 1, InternalOutlineHuePicker.Position.Y + 1)

                            InternalBase.Color = Color3.fromHSV(Colorpicker.Colors.HSV[1], 1, 1)

                            InternalHex.Text = ("#%s"):format(tostring(HSVColor:ToHex()))
                            
                            local CalculateRGB = Color3.fromRGB(math.floor((HSVColor.R * 255)), math.floor((HSVColor.G * 255)), math.floor((HSVColor.B * 255)))
                            InternalRGB.Text = ("%s, %s, %s"):format(math.floor(CalculateRGB.R * 255), math.floor(CalculateRGB.G * 255), math.floor(CalculateRGB.B * 255))

                            ColorpickerBase.Color = HSVColor

                            if not Options.Visual then
                                Library.Flags[Colorpicker.Flag] = HSVColor
                                Colorpicker.Callback(HSVColor)
                            end
                        end
                        --
                        function Colorpicker:RefreshHue()
                            local PercentHue = math.clamp(((Mouse.Y + 36) - InternalHue.Position.Y) / (InternalHue.Size.Y), 0, 1)
                            local ValueHue = math.floor((0 + (1 - 0) * PercentHue) * Colorpicker.Decimals) / Colorpicker.Decimals
                            ValueHue = math.clamp(ValueHue, 0, 1)
                            self:SetHue({
                                Value = ValueHue, 
                                Percent = PercentHue
                            })
                        end
                        --
                        function Colorpicker:SetSaturationX(Options)
                            local PercentX = Options.Percent or Options.Value

                            local HSVColor = Color3.fromHSV(Colorpicker.Colors.HSV[1], Colorpicker.Colors.HSV[2], Colorpicker.Colors.HSV[3])
                            Colorpicker.Colors.HSV[2] = Options.Value

                            Cursor.Position = Vector2.new(InternalBase.Position.X + (InternalBase.Size.X * PercentX) - 4, Colorpicker.Offsets.Y)
                            Colorpicker.Offsets.X = Cursor.Position.X

                            InternalHex.Text = ("#%s"):format(tostring(HSVColor:ToHex()))

                            local CalculateRGB = Color3.fromRGB(math.floor((HSVColor.R * 255)), math.floor((HSVColor.G * 255)), math.floor((HSVColor.B * 255)))
                            InternalRGB.Text = ("%s, %s, %s"):format(math.floor(CalculateRGB.R * 255), math.floor(CalculateRGB.G * 255), math.floor(CalculateRGB.B * 255))

                            ColorpickerBase.Color = HSVColor

                            if not Options.Visual then
                                Library.Flags[Colorpicker.Flag] = HSVColor
                                Colorpicker.Callback(HSVColor)
                            end
                        end
                        --
                        function Colorpicker:SetSaturationY(Options)
                            local PercentY = Options.Percent or 1 - Options.Value

                            local HSVColor = Color3.fromHSV(Colorpicker.Colors.HSV[1], Colorpicker.Colors.HSV[2], Colorpicker.Colors.HSV[3])
                            Colorpicker.Colors.HSV[3] = Options.Value
        
                            Cursor.Position = Vector2.new(Colorpicker.Offsets.X, InternalBase.Position.Y + (InternalBase.Size.Y * PercentY) - 4)
                            Colorpicker.Offsets.Y = Cursor.Position.Y

                            InternalHex.Text = ("#%s"):format(tostring(HSVColor:ToHex()))

                            local CalculateRGB = Color3.fromRGB(math.floor((HSVColor.R * 255)), math.floor((HSVColor.G * 255)), math.floor((HSVColor.B * 255)))
                            InternalRGB.Text = ("%s, %s, %s"):format(math.floor(CalculateRGB.R * 255), math.floor(CalculateRGB.G * 255), math.floor(CalculateRGB.B * 255))

                            ColorpickerBase.Color = HSVColor

                            if not Options.Visual then
                                Library.Flags[Colorpicker.Flag] = HSVColor
                                Colorpicker.Callback(HSVColor)
                            end
                        end
                        --
                        function Colorpicker:RefreshSaturation()
                            local PercentX = math.clamp((Mouse.X - InternalSaturation.Position.X) / (InternalSaturation.Size.X), 0, 1)
                            local ValueX = math.floor((1 * PercentX) * Colorpicker.Decimals) / Colorpicker.Decimals
                            ValueX = math.clamp(ValueX, 0, 1)
                            self:SetSaturationX({
                                Value = ValueX, 
                                Percent = PercentX
                            })
                            --
                            local PercentY = math.clamp(((Mouse.Y + 36) - InternalSaturation.Position.Y) / (InternalSaturation.Size.Y), 0, 1)
                            local ValueY = 1 - math.floor((1 * PercentY) * Colorpicker.Decimals) / Colorpicker.Decimals
                            ValueY = math.clamp(ValueY, 0, 1)
                            self:SetSaturationY({
                                Value = ValueY, 
                                Percent = PercentY
                            })
                        end
                        --
                        Utility.AddConnection(UserInput.InputEnded, function(Input, Useless)
                            if Useless then
                                return
                            end
                            for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                if Index ~= ToggleTitle.Text and Value then
                                    return
                                end
                            end
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                Colorpicker.HueDragging = false
                                Colorpicker.SaturationDragging = false
                            end
                        end)
        
                        Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                            if Useless then
                                return
                            end
                            if Utility.OnMouse(ColorpickerInline) then
                                ColorpickerInline.Color = Library.Theme.Accent[1]
                            else
                                ColorpickerInline.Color = Library.Theme.Inline
                            end
                            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                                for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                    if Index ~= ToggleTitle.Text and Value then
                                        return
                                    end
                                end
                                if Colorpicker.HueDragging then
                                    Colorpicker:RefreshHue()
                                elseif Colorpicker.SaturationDragging then
                                    Colorpicker:RefreshSaturation()
                                end
                            end
                        end)
                        --
                        Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                            if Useless then
                                return
                            end
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                    if Index ~= ToggleTitle.Text and Value then
                                        return
                                    end
                                end
                                if Utility.OnMouse(ColorpickerInline) then
                                    Colorpicker.Dropped = not Colorpicker.Dropped
                                    Tab.Dropdowns[Side][ToggleTitle.Text] = Colorpicker.Dropped
                                    Colorpicker:Drop(Colorpicker.Dropped)
                                elseif Utility.OnMouse(InternalSaturation) then
                                    Colorpicker:RefreshSaturation()
                                    Colorpicker.SaturationDragging = true
                                elseif Utility.OnMouse(InternalHue) then
                                    Colorpicker:RefreshHue()
                                    Colorpicker.HueDragging = true
                                elseif Utility.OnMouse(InternalInlineRainbow) then
                                    Colorpicker.Rainbow = not Colorpicker.Rainbow
                                    InternalRainbow.Color = Colorpicker.Rainbow and Library.Theme.Accent[1] or Library.Theme.Text
                                    if not Colorpicker.Rainbow then
                                        Colorpicker:SetHue({Value = Colorpicker.Colors.HSV[1]})
                                        Colorpicker:SetSaturationX({Value = Colorpicker.Colors.HSV[2]})
                                        Colorpicker:SetSaturationY({Value = Colorpicker.Colors.HSV[3]})
                                    end
                                else
                                    Colorpicker.Dropped = false
                                    Tab.Dropdowns[Side][ToggleTitle.Text] = Colorpicker.Dropped
                                    Colorpicker:Drop(Colorpicker.Dropped)
                                end
                            end
                        end)
                        --
                        Utility.AddConnection(RunService.RenderStepped, function(Input, Useless)
                            if Colorpicker.Rainbow then
                                -- Colorpicker:SetHue({Value = tick() % 2 / 2, Visual = true})
                                -- Colorpicker:SetSaturationX({Value = 0.5, Visual = true})
                                -- Colorpicker:SetSaturationY({Value = 1, Visual = true})
                                Library.Flags[Colorpicker.Flag] = Color3.fromHSV(tick() % 2 / 2, 0.5, 1)
                                Colorpicker.Callback(Color3.fromHSV(tick() % 2 / 2, 0.5, 1))
                            end
                        end)
                        --
                        Colorpicker:SetHue({Value = Colorpicker.Colors.HSV[1]})
                        Colorpicker:SetSaturationX({Value = Colorpicker.Colors.HSV[2]})
                        Colorpicker:SetSaturationY({Value = Colorpicker.Colors.HSV[3]})
                        --
                        Tab["Render"][#Tab["Render"] + 1] = ColorpickerInline
                        Tab["Render"][#Tab["Render"] + 1] = ColorpickerOutline
                        Tab["Render"][#Tab["Render"] + 1] = ColorpickerBase
                        Tab["Render"][#Tab["Render"] + 1] = ColorpickerGradient
                        --
                        Colorpicker:Drop(false)
                        --
                        return Colorpicker
                    end
                    --
                    function Toggle:Keybind(Options)
                        local Keybind = {
                            TypeOf = "Keybind",
                            Axis = Section.ContentAxis,
                            Title = Options.Title or "LOL",
                            EnumType = Options.Key.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType",
                            Key = Options.Key or Enum.UserInputType.MouseButton2,
                            StateType = Options.StateType or "Hold",
                            State = false,
                            Shorten = "",
                            Binding = false,
                            Dropped = false,
                            Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end,
                            ShowRender = "",
                            AddN = false
                        }
                        --
                        Options.Flag = Options.Flag or "AWGWJIjgAWJIGIJAWG"
                        Library.Flags[Options.Flag] = Keybind.State
                        --
                        Library.Items[Options.Flag] = Keybind.Title
                        --
                        if Keybind.StateType == "Always" then
                            Keybind.Callback(Keybind.State, Keybind.Key)
                            Library.Flags[Options.Flag] = true
                        end
                        --
                        Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                        --
                        Keybind.ShowRender = ("[%s] %s"):format(Keybind.Shorten, Options.Title)
                        --
                        local KeybindInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X - 40 - 6, SectionInline.Position.Y + Keybind.Axis + 2),
                            Size = Vector2.new(40, 14),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true
                        })
                        --
                        local KeybindOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(KeybindInline.Size.X - 2, KeybindInline.Size.Y - 2),
                            Position = Vector2.new(KeybindInline.Position.X + 1, KeybindInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true
                        })
                        --
                        local KeybindGradient = Utility.AddDrawing("Image", {
                            Size = Vector2.new(KeybindInline.Size.X - 2, KeybindInline.Size.Y - 2),
                            Position = Vector2.new(KeybindInline.Position.X + 1, KeybindInline.Position.Y + 1),
                            Data = Library.Theme.Gradient,
                            Transparency = 1,
                            Visible = true
                        })
                        --
                        local KeybindValue = Utility.AddDrawing("Text", {
                            Text = Keybind.Shorten,
                            Position = Vector2.new(KeybindInline.Position.X + (KeybindInline.Size.X / 2), KeybindInline.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 2
                        })
                        --
                        local KeybindHoldInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X + 2 - 6, SectionInline.Position.Y + Keybind.Axis + 2),
                            Size = Vector2.new(60, 16),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindHoldOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(KeybindHoldInline.Size.X - 2, KeybindHoldInline.Size.Y - 2),
                            Position = Vector2.new(KeybindHoldInline.Position.X + 1, KeybindHoldInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindHoldGradient = Utility.AddDrawing("Image", {
                            Size = Vector2.new(KeybindHoldInline.Size.X - 2, KeybindHoldInline.Size.Y - 2),
                            Position = Vector2.new(KeybindHoldInline.Position.X + 1, KeybindHoldInline.Position.Y + 1),
                            Data = Library.Theme.Gradient,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindHoldValue = Utility.AddDrawing("Text", {
                            Text = "Hold",
                            Position = Vector2.new(KeybindHoldInline.Position.X + (KeybindHoldInline.Size.X / 2), KeybindHoldInline.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindToggleInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X + 2 - 6, SectionInline.Position.Y + Keybind.Axis + 18),
                            Size = Vector2.new(60, 16),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true
                        })
                        --
                        local KeybindToggleOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(KeybindToggleInline.Size.X - 2, KeybindToggleInline.Size.Y - 2),
                            Position = Vector2.new(KeybindToggleInline.Position.X + 1, KeybindToggleInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindToggleGradient = Utility.AddDrawing("Image", {
                            Size = Vector2.new(KeybindToggleInline.Size.X - 2, KeybindToggleInline.Size.Y - 2),
                            Position = Vector2.new(KeybindToggleInline.Position.X + 1, KeybindToggleInline.Position.Y + 1),
                            Data = Library.Theme.Gradient,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindToggleValue = Utility.AddDrawing("Text", {
                            Text = "Toggle",
                            Position = Vector2.new(KeybindToggleInline.Position.X + (KeybindToggleInline.Size.X / 2), KeybindToggleInline.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindAlwaysInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X + 2 - 6, SectionInline.Position.Y + Keybind.Axis + 34),
                            Size = Vector2.new(60, 16),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindAlwaysOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(KeybindAlwaysInline.Size.X - 2, KeybindAlwaysInline.Size.Y - 2),
                            Position = Vector2.new(KeybindAlwaysInline.Position.X + 1, KeybindAlwaysInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindAlwaysGradient = Utility.AddDrawing("Image", {
                            Size = Vector2.new(KeybindAlwaysInline.Size.X - 2, KeybindAlwaysInline.Size.Y - 2),
                            Position = Vector2.new(KeybindAlwaysInline.Position.X + 1, KeybindAlwaysInline.Position.Y + 1),
                            Data = Library.Theme.Gradient,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local KeybindAlwaysValue = Utility.AddDrawing("Text", {
                            Text = "Always",
                            Position = Vector2.new(KeybindAlwaysInline.Position.X + (KeybindAlwaysInline.Size.X / 2), KeybindAlwaysInline.Position.Y),
                            Center = true,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        function Keybind:Drop(State)
                            KeybindHoldInline.Visible = State
                            KeybindHoldOutline.Visible = State
                            KeybindHoldGradient.Visible = State
                            KeybindHoldValue.Visible = State
    
                            KeybindToggleInline.Visible = State
                            KeybindToggleOutline.Visible = State
                            KeybindToggleGradient.Visible = State
                            KeybindToggleValue.Visible = State
    
                            KeybindAlwaysInline.Visible = State
                            KeybindAlwaysOutline.Visible = State
                            KeybindAlwaysGradient.Visible = State
                            KeybindAlwaysValue.Visible = State
                        end
                        --
                        function Keybind:SetStateType(State)
                            if State == "Hold" then
                                Keybind.StateType = "Hold"
    
                                KeybindAlwaysValue.Color = Library.Theme.Text
                                KeybindToggleValue.Color = Library.Theme.Text
                                KeybindHoldValue.Color = Library.Theme.Accent[1]
                            elseif State == "Toggle" then
                                Keybind.StateType = "Toggle"
    
                                KeybindAlwaysValue.Color = Library.Theme.Text
                                KeybindToggleValue.Color = Library.Theme.Accent[1]
                                KeybindHoldValue.Color = Library.Theme.Text
                            else
                                Keybind.StateType = "Always"
    
                                KeybindAlwaysValue.Color = Library.Theme.Accent[1]
                                KeybindToggleValue.Color = Library.Theme.Text
                                KeybindHoldValue.Color = Library.Theme.Text
                            end
                        end
                        --
                        Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if Keybind.Binding then
                                    Keybind.Binding = false
                                    Keybind.Key = Enum.UserInputType.MouseButton1
                                    Keybind.EnumType = "UserInputType"
                                    local Old = Keybind.Shorten
                                    Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                                    Window.BindList = string.gsub(Window.BindList, "\n%[" .. Old .. "%] " .. Options.Title, ("\n[%s] %s"):format(Keybind.Shorten, Options.Title))
                                    KeybindValue.Text = Keybind.Binding and "[...]" or Keybind.Shorten
                                end
                                if Utility.OnMouse(KeybindHoldInline) then
                                    Keybind:SetStateType("Hold")
                                end
                                if Utility.OnMouse(KeybindToggleInline) then
                                    Keybind:SetStateType("Toggle")
                                end
                                if Utility.OnMouse(KeybindAlwaysInline) then
                                    Keybind:SetStateType("Always")
                                end
                                if Utility.OnMouse(KeybindInline) then
                                    for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                        if Value then
                                            return
                                        end
                                    end
                                    if Keybind.Binding then
                                        Keybind.Binding = false
                                        KeybindValue.Text = Keybind.Shorten
                                        Keybind.ShowRender = ("[%s] %s"):format(Keybind.Shorten, Options.Title)
                                    else
                                        Keybind.Binding = true
                                        KeybindValue.Text = Keybind.Binding and "[...]" or Keybind.Shorten
                                    end
                                else
                                    if Utility.OnMouse(KeybindHoldInline) or Utility.OnMouse(KeybindToggleInline) or Utility.OnMouse(KeybindAlwaysInline) then
                                        return
                                    end
                                    Keybind.Dropped = false
                                    Keybind:Drop(Keybind.Dropped)
                                    Tab.Dropdowns["Left"][ToggleTitle.Text] = Keybind.Dropped
                                    Tab.Dropdowns["Right"][ToggleTitle.Text] = Keybind.Dropped
                                end
                            elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                                if Keybind.Binding then
                                    Keybind.Binding = false
                                    Keybind.Key = Input.KeyCode
                                    Keybind.EnumType = "KeyCode"
                                    local Old = Keybind.Shorten
                                    Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                                    KeybindValue.Text = Keybind.Shorten
                                    Window.BindList = string.gsub(Window.BindList, "\n%[" .. Old .. "%] " .. Options.Title, ("\n[%s] %s"):format(Keybind.Shorten, Options.Title))
                                    Keybind.ShowRender = ("[%s] %s"):format(Keybind.Shorten, Options.Title)
                                end
                            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                                if Keybind.Binding then
                                    Keybind.Binding = false
                                    Keybind.Key = Enum.UserInputType.MouseButton2
                                    Keybind.EnumType = "UserInputType"
                                    local Old = Keybind.Shorten
                                    Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                                    KeybindValue.Text = Keybind.Shorten
                                    Window.BindList = string.gsub(Window.BindList, "\n%[" .. Old .. "%] " .. Options.Title, ("\n[%s] %s"):format(Keybind.Shorten, Options.Title))
                                    Keybind.ShowRender = ("[%s] %s"):format(Keybind.Shorten, Options.Title)
                                end
                                if Utility.OnMouse(KeybindInline) then
                                    Keybind.Dropped = not Keybind.Dropped
                                    Keybind:Drop(Keybind.Dropped)
                                    Tab.Dropdowns["Left"][ToggleTitle.Text] = Keybind.Dropped
                                    Tab.Dropdowns["Right"][ToggleTitle.Text] = Keybind.Dropped
                                end
                            end
                        end)
                        --
                        Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                            if (Keybind.EnumType == "KeyCode" and Input.KeyCode == Keybind.Key) or (Keybind.EnumType == "UserInputType" and Input.UserInputType == Keybind.Key) then
                                if Keybind.StateType ~= "Always" then
                                    if Keybind.StateType == "Toggle" then
                                        Keybind.State = not Keybind.State
                                    elseif Keybind.StateType == "Hold" then
                                        Keybind.State = true
                                    end
                                    if Keybind.State then
                                        if not string.find(Window.BindList, "\n%[" .. Keybind.Shorten .. "%] " .. Options.Title) then
                                            Window.BindList = Window.BindList .. "\n" .. Keybind.ShowRender
                                        end
                                    else
                                        Keybind:RemoveFromKeyBindGui()
                                    end
                                    Keybind.Callback(Keybind.State, Keybind.Key)
                                    Library.Flags[Options.Flag] = Keybind.State
                                end
                            end
                        end)
                        --
                        Utility.AddConnection(RunService.Stepped, function(Input, Useless)
                            if Keybind.StateType == "Always" then
                                Keybind.State = true
                                Keybind.Callback(Keybind.State, Keybind.Key)
                                Library.Flags[Options.Flag] = Keybind.State
                                if not string.find(Window.BindList, "\n%[" .. Keybind.Shorten .. "%] " .. Options.Title) then
                                    Window.BindList = Window.BindList .. "\n" .. Keybind.ShowRender
                                end
                            end
                        end)
                        --
                        Keybind:SetStateType(Keybind.StateType)
                        --
                        function Keybind:RemoveFromKeyBindGui()
                            Window.BindList = string.gsub(Window.BindList, "\n%[" .. Keybind.Shorten .. "%] " .. Options.Title, "")
                        end
                        --
                        Utility.AddConnection(UserInput.InputEnded, function(Input, Useless)
                            if (Keybind.EnumType == "KeyCode" and Input.KeyCode == Keybind.Key) or (Keybind.EnumType == "UserInputType" and Input.UserInputType == Keybind.Key) then
                                if Keybind.StateType ~= "Always" then
                                    if Keybind.StateType == "Hold" then
                                        Keybind.State = false
                                        Keybind:RemoveFromKeyBindGui()
                                        Keybind.Callback(Keybind.State, Keybind.Key)
                                        Library.Flags[Options.Flag] = Keybind.State
                                    end
                                end
                            end
                        end)
                        --
                        Keybind:Drop(false)
                        --
                        Tab["Render"][#Tab["Render"] + 1] = KeybindTitle
                        Tab["Render"][#Tab["Render"] + 1] = KeybindGradient
                        Tab["Render"][#Tab["Render"] + 1] = KeybindInline
                        Tab["Render"][#Tab["Render"] + 1] = KeybindOutline
                        Tab["Render"][#Tab["Render"] + 1] = KeybindValue
                        --
                        return Keybind
                    end
                    --
                    return Toggle
                end
                --
                function Section:Slider(Options)
                    local Slider = {
                        TypeOf = "Slider",
                        Default = Options.Default or 100,
                        Decimals = Options.Decimals or 1,
                        Axis = Section.ContentAxis,
                        Max = Options.Max or 200,
                        Min = Options.Min or 0,
                        Dragging = false,
                        Symbol = Options.Symbol or "",
                        Current = Options.Default,
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                    }
                    --
                    Options.Flag = Options.Flag or "AWGWJIjgAWJIGIJAWG"
                    Library.Flags[Options.Flag] = Slider.Default
                    --
                    Library.Items[Options.Flag] = Slider
                    --
                    if Slider.Min > Slider.Max then 
                        Slider.Min = Slider.Max - 1 
                    end
                    if Slider.Default < Slider.Min then 
                        Slider.Default = Slider.Min 
                    end
                    if Slider.Default > Slider.Max then 
                        Slider.Default = Slider.Max 
                    end
                    --
                    local SliderInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + 8, SectionInline.Position.Y + 23 + Slider.Axis + 15),
                        Size = Vector2.new(SectionOutline.Size.X - 12, 13),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local SliderOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(SliderInline.Size.X - 2, SliderInline.Size.Y - 2),
                        Position = Vector2.new(SliderInline.Position.X + 1, SliderInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local SliderBar = Utility.AddDrawing("Square", {
                        Size = Vector2.new(SliderOutline.Size.X / 2, SliderOutline.Size.Y),
                        Position = Vector2.new(SliderOutline.Position.X, SliderOutline.Position.Y),
                        Thickness = 0,
                        Transparency = 0.75,
                        Color = Library.Theme.Accent[1], --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local SliderGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(SliderInline.Size.X - 2, SliderInline.Size.Y - 2),
                        Position = Vector2.new(SliderInline.Position.X + 1, SliderInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 0.5,
                        Visible = false
                    })
                    --
                    local SliderTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(SliderInline.Position.X, SliderInline.Position.Y - 17),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local SliderValue = Utility.AddDrawing("Text", {
                        Position = Vector2.new(SliderInline.Position.X + (SliderInline.Size.X / 2), SliderInline.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    SliderValue.Outline = true
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                        if Type == "Accent" then
                            SliderBar.Color = Color
                        elseif Type == "LightContrast" then
                            SliderOutline.Color = Color
                        elseif Type == "Text" then
                            SliderTitle.Color = Color
                            SliderValue.Color = Color
                        elseif Type == "Inline" then
                            SliderInline.Color = Color
                        end
                    end)
                    --
                    function Slider:SetText(Text)
                        SliderText.Text = Text
                    end
    
                    function Slider:Set(GetValue, ConvertToMin)
                        if GetValue > Slider.Max then return end
                        if GetValue < Slider.Min then return end
                        
                        local Bracket = 1 / Slider.Decimals
                        local DecimalsCon = math.clamp(math.round(GetValue * Bracket) / Bracket, Slider.Min, Slider.Max)
                        local Percent = 1 - ((Slider.Max - DecimalsCon) / (Slider.Max - Slider.Min))
                        SliderBar.Size = Vector2.new(SliderOutline.Size.X * Percent, SliderOutline.Size.Y)
                        SliderValue.Text = ("%s%s/%s%s"):format(DecimalsCon, Slider.Symbol, Slider.Max, Slider.Symbol)
                        Library.Flags[Options.Flag] = GetValue
                        Slider.Callback(GetValue)
                    end
    
                    function Slider:SetMax(NewMax)
                        if NewMax < Slider.Current then Slider.Current = NewMax end
                        if Slider.Current < Slider.Min then return end
    
                        Slider.Max = NewMax
                        local DecimalsCon = math.clamp(math.round(Slider.Current * Slider.Decimals) / Slider.Decimals, Slider.Min, Slider.Max)
                        local Percent = 1 - ((Slider.Max - DecimalsCon) / (Slider.Max - Slider.Min))
                        SliderBar.Size = Vector2.new(SliderOutline.Size.X * Percent, SliderOutline.Size.Y)
                        SliderValue.Text = ("%s%s/%s%s"):format(DecimalsCon, Slider.Symbol, Slider.Max, Slider.Symbol)
                        Library.Flags[Options.Flag] = Slider.Current
                        Slider.Callback(Slider.Current)
                    end
    
                    function Slider:SetMin(NewMin)
                        Slider.Min = NewMin
                        if Slider.Current > Slider.Max then return end
                        if Slider.Current < Slider.Min then return end
    
                        local DecimalsCon = math.clamp(math.round(Slider.Current * Slider.Decimals) / Slider.Decimals, Slider.Min, Slider.Max)
                        local Percent = 1 - ((Slider.Max - DecimalsCon) / (Slider.Max - Slider.Min))
                        SliderBar.Size = Vector2.new(SliderOutline.Size.X * Percent, SliderOutline.Size.Y)
                        SliderValue.Text = ("%s%s/%s%s"):format(DecimalsCon, Slider.Symbol, Slider.Max, Slider.Symbol)
                        Library.Flags[Options.Flag] = Slider.Current
                        Slider.Callback(Slider.Current)
                    end
    
                    function Slider:Refresh()
                        local Percent = math.clamp((Mouse.X - SliderOutline.Position.X) / (SliderOutline.Size.X), 0, 1)
                        local Bracket = 1 / Slider.Decimals
                        local Value = math.floor((Slider.Min + (Slider.Max - Slider.Min) * Percent) * Bracket) / Bracket
                        Value = math.clamp(Value, Slider.Min, Slider.Max)
                        Slider:Set(Value)
                    end
    
                    Slider:Set(Slider.Default)
                
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        for Index, Value in pairs(Tab.Dropdowns[Side]) do
                            if Value then
                                return
                            end
                        end
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 and Utility.OnMouse(SliderOutline) then
                            Slider:Refresh()
                            Slider.Dragging = true
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputEnded, function(Input, Useless)
                        
                        for Index, Value in pairs(Tab.Dropdowns[Side]) do
                            if Value then
                                return
                            end
                        end
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Slider.Dragging = false
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                        if Utility.OnMouse(SliderInline) then
                            SliderInline.Color = Library.Theme.Accent[1]
                        else
                            SliderInline.Color = Library.Theme.Inline
                        end
                        
                        for Index, Value in pairs(Tab.Dropdowns[Side]) do
                            if Value then
                                return
                            end
                        end
                        if Input.UserInputType == Enum.UserInputType.MouseMovement and Slider.Dragging then
                            Slider:Refresh()
                        end
                    end)
                    --
                    Section.ContentAxis = Section.ContentAxis + SliderOutline.Size.Y + 24
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] + SliderOutline.Size.Y + 24 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] + SliderOutline.Size.Y + 24 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + SliderOutline.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = SliderInline
                    Tab["Render"][#Tab["Render"] + 1] = SliderOutline
                    Tab["Render"][#Tab["Render"] + 1] = SliderTitle
                    Tab["Render"][#Tab["Render"] + 1] = SliderGradient
                    Tab["Render"][#Tab["Render"] + 1] = SliderBar
                    Tab["Render"][#Tab["Render"] + 1] = SliderValue
                    --
                    return Slider
                end
                --
                function Section:Button(Options)
                    local Button = {
                        Title = Options.Title or "LMAO",
                        Axis = Section.ContentAxis,
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                    }
                    --
                    local ButtonInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + 8, SectionInline.Position.Y + 24 + Button.Axis),
                        Size = Vector2.new(SectionOutline.Size.X - 12, 18),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ButtonOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(ButtonInline.Size.X - 2, ButtonInline.Size.Y - 2),
                        Position = Vector2.new(ButtonInline.Position.X + 1, ButtonInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ButtonGradient = Utility.AddDrawing("Image", {
                        Size = ButtonOutline.Size,
                        Position = ButtonOutline.Position,
                        Data = Library.Theme.Gradient,
                        Transparency = 0.5,
                        Visible = true
                    })
                    --
                    local ButtonTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(ButtonInline.Position.X + (ButtonInline.Size.X / 2), ButtonInline.Position.Y + 2),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                        if Type == "LightContrast" then
                            ButtonOutline.Color = Color
                        elseif Type == "Text" then
                            ButtonTitle.Color = Color
                        elseif Type == "Inline" then
                            ButtonInline.Color = Color
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                        if Utility.OnMouse(ButtonInline) then
                            ButtonInline.Color = Library.Theme.Accent[1]
                        else
                            ButtonInline.Color = Library.Theme.Inline
                        end
                    end)
                    --
                    function Button:EmitEffect()
                        ButtonOutline.Color = Library.Theme.LightContrast
                        delay(0.1, function()
                            pcall(function()
                                ButtonOutline.Color = Library.Theme.DarkContrast
                            end)
                        end)
                    end
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 and Utility.OnMouse(ButtonOutline) then
                            for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                if Value then
                                    return
                                end
                            end
                            Button:EmitEffect()
                            Button.Callback()
                        end
                    end)
                    --
                    Section.ContentAxis = Section.ContentAxis + ButtonOutline.Size.Y + 6
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] + ButtonOutline.Size.Y + 6 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] + ButtonOutline.Size.Y + 6 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + ButtonOutline.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = ButtonInline
                    Tab["Render"][#Tab["Render"] + 1] = ButtonGradient
                    Tab["Render"][#Tab["Render"] + 1] = ButtonOutline
                    Tab["Render"][#Tab["Render"] + 1] = ButtonTitle
                    --
                    return Button
                end
                --
                function Section:TextBox(Options)
                    local TextBox = {
                        TypeOf = "TextBox",
                        Title = Options.Title or "LMAO",
                        Axis = Section.ContentAxis,
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end,
                        Current = Options.Current or "",
                        Inputting = false,
                        Deleting = false
                    }
                    --
                    Options.Flag = Options.Flag or "AWGWJIjgAWJIGIJAWG"
                    Library.Flags[Options.Flag] = TextBox.Current
                    --
                    Library.Items[Options.Flag] = TextBox
                    --
                    local TextBoxInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + 8, SectionInline.Position.Y + 34 + TextBox.Axis),
                        Size = Vector2.new(SectionOutline.Size.X - 12, 18),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local TextBoxOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(TextBoxInline.Size.X - 2, TextBoxInline.Size.Y - 2),
                        Position = Vector2.new(TextBoxInline.Position.X + 1, TextBoxInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local TextBoxTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(TextBoxInline.Position.X + 2, TextBoxInline.Position.Y - 16),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local TextBoxValue = Utility.AddDrawing("Text", {
                        Text = Options.Current,
                        Position = Vector2.new(TextBoxInline.Position.X + (TextBoxInline.Size.X / 2), TextBoxInline.Position.Y + 2),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    function TextBox:Set()

                    end
                    --
                    local InputHandler = Instance.new("TextBox", ScreenGui)
                    InputHandler.Position = UDim2.new(-100, 0, -100, 0)
                    InputHandler.Name = ("akiri-INPUT-%s"):format(HttpService:GenerateGUID(false))
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, GameProcessed)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if Utility.OnMouse(TextBoxOutline) then
                                for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                    if Index ~= Text then
                                        if Value then
                                            return
                                        end
                                    end
                                end
                                TextBox.Inputting = not TextBox.Inputting
                                if TextBox.Inputting then
                                    InputHandler:CaptureFocus()
                                    TextBoxInline.Color = Library.Theme.Accent[1]
                                else
                                    InputHandler:ReleaseFocus()
                                    TextBoxInline.Color = Library.Theme.Inline
                                end
                            else
                                if TextBox.Inputting ~= false then
                                    TextBox.Callback(TextBoxValue.Text)
                                    Library.Flags[Options.Flag] = TextBoxValue.Text
                                    TextBoxInline.Color = Library.Theme.Inline
                                    TextBox.Inputting = false
                                    InputHandler:ReleaseFocus()
                                end
                            end
                        elseif Input.KeyCode and TextBox.Inputting then
                            if Input.UserInputType == Enum.UserInputType.Keyboard then
                                if Input.KeyCode == Enum.KeyCode.Backspace then
                                    TextBox.Deleting = true
                                    local Subbed = string.len(TextBox.Current) == 1 and "" or string.sub(TextBox.Current, 1, TextBox.Current:len() - 1)
                                    TextBox.Current = Subbed
                                    TextBoxValue.Text = TextBox.Current
                                elseif Input.KeyCode == Enum.KeyCode.Return then
                                    TextBox.Callback(TextBoxValue.Text)
                                    Library.Flags[Options.Flag] = TextBoxValue.Text
                                    TextBox.Inputting = false
                                    InputHandler:ReleaseFocus()
                                    TextBoxInline.Color = Library.Theme.Inline
                                else
                                    if Library.Keys.KeyBoard[Input.KeyCode.Name] then
                                        local Check = type(Library.Keys.KeyBoard[Input.KeyCode.Name]) == "table" and (Theme.LeftShift and Library.Keys.KeyBoard[Input.KeyCode.Name][2] or Library.Keys.KeyBoard[Input.KeyCode.Name][1]) or ((Library.Input.Caplock or Library.Input.LeftShift) and Library.Keys.KeyBoard[Input.KeyCode.Name] or string.lower(Library.Keys.KeyBoard[Input.KeyCode.Name]))
                                        TextBox.Current = TextBox.Current .. Check
                                        TextBoxValue.Text = TextBox.Current
                                    end
                                end
                            end
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputEnded, function(Input, GameProcessed)
                        if Input.KeyCode == Enum.KeyCode.Backspace then
                            TextBox.Deleting = false
                        end
                    end)
                    --
                    task.spawn(function()
                        while task.wait(0.25) do
                            if TextBox.Deleting then
                                local Subbed = string.len(TextBox.Current) == 1 and "" or string.sub(TextBox.Current, 1, TextBox.Current:len() - 1)
                                TextBox.Current = Subbed
                                TextBoxValue.Text = TextBox.Current
                            end
                        end
                    end) 
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                        if Type == "LightContrast" then
                            pcall(function()
                                ButtonOutline.Color = Color
                            end)
                        elseif Type == "Text" then
                            ButtonTitle.Color = Color
                        elseif Type == "Inline" then
                            pcall(function()
                                ButtonInline.Color = Color
                            end)
                        end
                    end)
                    --
                    Section.ContentAxis = Section.ContentAxis + TextBoxOutline.Size.Y + 16
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] + TextBoxOutline.Size.Y + 16 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] + TextBoxOutline.Size.Y + 16 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + TextBoxOutline.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = TextBoxInline
                    Tab["Render"][#Tab["Render"] + 1] = TextBoxValue
                    Tab["Render"][#Tab["Render"] + 1] = TextBoxOutline
                    Tab["Render"][#Tab["Render"] + 1] = TextBoxTitle
                    --
                    return Button
                end
                --
                function Section:Colorpicker(Options)
                    local Colorpicker = {
                        TypeOf = "Colorpicker",
                        Axis = Section.ContentAxis,
                        Color = Options.Color,
                        HexColor = Options.Color:ToHex(),
                        Dropped = false,
                        Offsets = {
                            X = 0,
                            Y = 0
                        },
                        Colors = {
                            HSV = {1, 1, 1}
                        },
                        SaturationDragging = false,
                        HueDragging = false,
                        Decimals = 50,
                        Rainbow = false,
                        Flag = Options.Flag,
                        Title = Options.Title or "Color Picker",
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                    }
                    --
                    Library.Items[Options.Flag] = Colorpicker
                    --
                    local H, S, V = Colorpicker.Color:ToHSV()
                    Colorpicker.Colors.HSV[1] = H
                    Colorpicker.Colors.HSV[2] = S
                    Colorpicker.Colors.HSV[3] = V
                    --
                    Library.Flags[Options.Flag] = Colorpicker.HexColor
                    --
                    local ColorpickerTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(SectionInline.Position.X + 8, SectionInline.Position.Y + 23 + Colorpicker.Axis),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local ColorpickerInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new((SectionInline.Position.X + SectionInline.Size.X) - 38, SectionInline.Position.Y + 23 + Colorpicker.Axis),
                        Size = Vector2.new(30, 12),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ColorpickerOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(ColorpickerInline.Size.X - 2, ColorpickerInline.Size.Y - 2),
                        Position = Vector2.new(ColorpickerInline.Position.X + 1, ColorpickerInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ColorpickerBase = Utility.AddDrawing("Square", {
                        Size = Vector2.new(ColorpickerInline.Size.X - 2, ColorpickerInline.Size.Y - 2),
                        Position = Vector2.new(ColorpickerInline.Position.X + 1, ColorpickerInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Colorpicker.Color, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local ColorpickerGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(ColorpickerInline.Size.X - 2, ColorpickerInline.Size.Y - 2),
                        Position = Vector2.new(ColorpickerInline.Position.X + 1, ColorpickerInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 0.5,
                        Visible = true
                    })
                    --
                    local InternalInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new((ColorpickerInline.Position.X - 225) + ColorpickerInline.Size.X, ColorpickerInline.Position.Y + 18),
                        Size = Vector2.new(225, 250),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(InternalInline.Size.X - 2, InternalInline.Size.Y - 2),
                        Position = Vector2.new(InternalInline.Position.X + 1, InternalInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalTopline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(InternalOutline.Size.X, 1),
                        Position = Vector2.new(InternalOutline.Position.X, InternalOutline.Position.Y),
                        Thickness = 0,
                        Color = Library.Theme.Accent[1],
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                        if Type == "Accent" then
                            InternalTopline.Color = Color
                        end
                    end)
                    --
                    local InternalTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(InternalOutline.Position.X + 8, InternalOutline.Position.Y + 6),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 3
                    })
                    --
                    local InternalBaseInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(InternalOutline.Position.X + 8, InternalOutline.Position.Y + 25),
                        Size = Vector2.new(192, 192),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalBase = Utility.AddDrawing("Square", {
                        Size = Vector2.new(192 - 4, 192 - 4),
                        Position = Vector2.new(InternalBaseInline.Position.X + 2, InternalBaseInline.Position.Y + 2),
                        Thickness = 0,
                        Color = Options.Color, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalSaturation = Utility.AddDrawing("Image", {
                        Size = Vector2.new(196 - 2, 196 - 2),
                        Position = Vector2.new(InternalOutline.Position.X + 8 + 1, InternalOutline.Position.Y + 25 + 1),
                        Data = Library.Theme.Saturation,
                        Transparency = 1,
                        Visible = true,
                        ZIndex = 3
                    })
                    --
                    local InternalHueInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(InternalOutline.Position.X + InternalBase.Size.X + 14, InternalOutline.Position.Y + 26),
                        Size = Vector2.new(16, 196),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalHue = Utility.AddDrawing("Image", {
                        Size = Vector2.new(InternalHueInline.Size.X - 2, InternalHueInline.Size.Y - 2),
                        Position = Vector2.new(InternalHueInline.Position.X + 1, InternalHueInline.Position.Y + 1),
                        Data = Library.Theme.Hue,
                        Transparency = 1,
                        Visible = true,
                        ZIndex = 3
                    })
                    --
                    local InternalOutlineHuePicker = Utility.AddDrawing("Square", {
                        Position = Vector2.new(InternalOutline.Position.X + InternalBase.Size.X + 12, InternalOutline.Position.Y + 26),
                        Size = Vector2.new(InternalHueInline.Size.X + 2, 6),
                        Thickness = 2,
                        Color = Library.Theme.Outline,
                        Visible = true,
                        Filled = false,
                        ZIndex = 3
                    })
                    --
                    local InternalHuePicker = Utility.AddDrawing("Square", {
                        Position = Vector2.new(InternalOutlineHuePicker.Position.X + 1, InternalOutlineHuePicker.Position.Y + 1),
                        Size = Vector2.new(InternalOutlineHuePicker.Size.X - 2, InternalOutlineHuePicker.Size.Y - 2),
                        Thickness = 2,
                        Color = Library.Theme.Text,
                        Visible = true,
                        Filled = false,
                        ZIndex = 3
                    })
                    --
                    
                    --
                    local Cursor = Utility.AddDrawing("Image", {
                        Size = Vector2.new(6, 6),
                        Data = Library.Theme.SaturationCursor,
                        Transparency = 1,
                        Visible = true,
                        ZIndex = 6
                    })
                    --
                    local InternalInlineHex = Utility.AddDrawing("Square", {
                        Size = Vector2.new(80 - 2, 18 - 2),
                        Position = Vector2.new(InternalOutline.Position.X + 8 + 1, InternalOutline.Position.Y + InternalSaturation.Size.Y + 30 + 1),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalOutlineHex = Utility.AddDrawing("Square", {
                        Size = Vector2.new(InternalInlineHex.Size.X - 2, InternalInlineHex.Size.Y - 2),
                        Position = Vector2.new(InternalInlineHex.Position.X + 1, InternalInlineHex.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalHex = Utility.AddDrawing("Text", {
                        Text = ("#%s"):format(tostring(Colorpicker.HexColor)),
                        Position = Vector2.new(InternalOutlineHex.Position.X + (InternalOutlineHex.Size.X / 2), InternalOutlineHex.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 3
                    })
                    --
                    local InternalInlineRGB = Utility.AddDrawing("Square", {
                        Size = Vector2.new(130 - 2, 18 - 2),
                        Position = Vector2.new(InternalOutline.Position.X + 90 + 1, InternalOutline.Position.Y + InternalSaturation.Size.Y + 30 + 1),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalOutlineRGB = Utility.AddDrawing("Square", {
                        Size = Vector2.new(InternalInlineRGB.Size.X - 2, InternalInlineRGB.Size.Y - 2),
                        Position = Vector2.new(InternalInlineRGB.Position.X + 1, InternalInlineRGB.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalRGB = Utility.AddDrawing("Text", {
                        Text = ("%s, %s, %s"):format(math.floor(Colorpicker.Color.R * 255), math.floor(Colorpicker.Color.G * 255), math.floor(Colorpicker.Color.B * 255)),
                        Position = Vector2.new(InternalOutlineRGB.Position.X + (InternalOutlineRGB.Size.X / 2), InternalOutlineRGB.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 3
                    })
                    --
                    
                    --
                    local InternalInlineRainbow = Utility.AddDrawing("Square", {
                        Size = Vector2.new(100 - 2, 18 - 2),
                        Position = Vector2.new((InternalOutline.Position.X + InternalOutline.Size.X) - 100 - 2 + 1, InternalOutline.Position.Y + 4 + 1),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalOutlineRainbow = Utility.AddDrawing("Square", {
                        Size = Vector2.new(InternalInlineRainbow.Size.X - 2, InternalInlineRainbow.Size.Y - 2),
                        Position = Vector2.new(InternalInlineRainbow.Position.X + 1, InternalInlineRainbow.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true,
                        ZIndex = 3
                    })
                    --
                    local InternalRainbow = Utility.AddDrawing("Text", {
                        Text = "Rainbow",
                        Position = Vector2.new(InternalOutlineRainbow.Position.X + (InternalOutlineRainbow.Size.X / 2), InternalOutlineRainbow.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 3
                    })
                    --
                    function Colorpicker:Drop(State)
                        InternalInline.Visible = State
                        InternalOutline.Visible = State
                        InternalTitle.Visible = State
                        InternalBaseInline.Visible = State
                        InternalBase.Visible = State
                        InternalSaturation.Visible = State
                        InternalHueInline.Visible = State
                        InternalHue.Visible = State
                        InternalOutlineHex.Visible = State
                        InternalInlineHex.Visible = State
                        InternalHex.Visible = State
                        InternalInlineRGB.Visible = State
                        InternalOutlineRGB.Visible = State
                        InternalRGB.Visible = State
                        InternalInlineRainbow.Visible = State
                        InternalOutlineRainbow.Visible = State
                        InternalRainbow.Visible = State
                        InternalTopline.Visible = State
                        Cursor.Visible = State
                        InternalOutlineHuePicker.Visible = State
                        InternalHuePicker.Visible = State
                        Tab.Dropdowns[Side][ColorpickerTitle.Text] = State
                    end
                    --
                    Colorpicker.Offsets.X = InternalBase.Position.X
                    Colorpicker.Offsets.Y = InternalBase.Position.Y
                    --
                    function Colorpicker:SetHue(Options)
                        local Percent = Options.Percent or Options.Value
    
                        Colorpicker.Colors.HSV[1] = Options.Value

                        local HSVColor = Color3.fromHSV(Colorpicker.Colors.HSV[1], Colorpicker.Colors.HSV[2], Colorpicker.Colors.HSV[3])
                        
                        InternalOutlineHuePicker.Position = Vector2.new(InternalOutline.Position.X + InternalBase.Size.X + 12, InternalHue.Position.Y + (InternalHue.Size.Y * Percent) - 4)
                        InternalHuePicker.Position = Vector2.new(InternalOutlineHuePicker.Position.X + 1, InternalOutlineHuePicker.Position.Y + 1)

                        InternalBase.Color = Color3.fromHSV(Colorpicker.Colors.HSV[1], 1, 1)

                        InternalHex.Text = ("#%s"):format(tostring(HSVColor:ToHex()))
                        
                        local CalculateRGB = Color3.fromRGB(math.floor((HSVColor.R * 255)), math.floor((HSVColor.G * 255)), math.floor((HSVColor.B * 255)))
                        InternalRGB.Text = ("%s, %s, %s"):format(math.floor(CalculateRGB.R * 255), math.floor(CalculateRGB.G * 255), math.floor(CalculateRGB.B * 255))

                        ColorpickerBase.Color = HSVColor

                        if not Options.Visual then
                            Library.Flags[Colorpicker.Flag] = HSVColor
                            Colorpicker.Callback(HSVColor)
                        end
                    end
                    --
                    function Colorpicker:RefreshHue()
                        local PercentHue = math.clamp(((Mouse.Y + 36) - InternalHue.Position.Y) / (InternalHue.Size.Y), 0, 1)
                        local ValueHue = math.floor((0 + (1 - 0) * PercentHue) * Colorpicker.Decimals) / Colorpicker.Decimals
                        ValueHue = math.clamp(ValueHue, 0, 1)
                        self:SetHue({
                            Value = ValueHue, 
                            Percent = PercentHue
                        })
                    end
                    --
                    function Colorpicker:SetSaturationX(Options)
                        local PercentX = Options.Percent or Options.Value

                        local HSVColor = Color3.fromHSV(Colorpicker.Colors.HSV[1], Colorpicker.Colors.HSV[2], Colorpicker.Colors.HSV[3])
                        Colorpicker.Colors.HSV[2] = Options.Value

                        Cursor.Position = Vector2.new(InternalBase.Position.X + (InternalBase.Size.X * PercentX) - 4, Colorpicker.Offsets.Y)
                        Colorpicker.Offsets.X = Cursor.Position.X

                        InternalHex.Text = ("#%s"):format(tostring(HSVColor:ToHex()))

                        local CalculateRGB = Color3.fromRGB(math.floor((HSVColor.R * 255)), math.floor((HSVColor.G * 255)), math.floor((HSVColor.B * 255)))
                        InternalRGB.Text = ("%s, %s, %s"):format(math.floor(CalculateRGB.R * 255), math.floor(CalculateRGB.G * 255), math.floor(CalculateRGB.B * 255))

                        ColorpickerBase.Color = HSVColor

                        if not Options.Visual then
                            Library.Flags[Colorpicker.Flag] = HSVColor
                            Colorpicker.Callback(HSVColor)
                        end
                    end
                    --
                    function Colorpicker:SetSaturationY(Options)
                        local PercentY = Options.Percent or 1 - Options.Value

                        local HSVColor = Color3.fromHSV(Colorpicker.Colors.HSV[1], Colorpicker.Colors.HSV[2], Colorpicker.Colors.HSV[3])
                        Colorpicker.Colors.HSV[3] = Options.Value
    
                        Cursor.Position = Vector2.new(Colorpicker.Offsets.X, InternalBase.Position.Y + (InternalBase.Size.Y * PercentY) - 4)
                        Colorpicker.Offsets.Y = Cursor.Position.Y

                        InternalHex.Text = ("#%s"):format(tostring(HSVColor:ToHex()))

                        local CalculateRGB = Color3.fromRGB(math.floor((HSVColor.R * 255)), math.floor((HSVColor.G * 255)), math.floor((HSVColor.B * 255)))
                        InternalRGB.Text = ("%s, %s, %s"):format(math.floor(CalculateRGB.R * 255), math.floor(CalculateRGB.G * 255), math.floor(CalculateRGB.B * 255))

                        ColorpickerBase.Color = HSVColor

                        if not Options.Visual then
                            Library.Flags[Colorpicker.Flag] = HSVColor
                            Colorpicker.Callback(HSVColor)
                        end
                    end
                    --
                    function Colorpicker:RefreshSaturation()
                        local PercentX = math.clamp((Mouse.X - InternalSaturation.Position.X) / (InternalSaturation.Size.X), 0, 1)
                        local ValueX = math.floor((1 * PercentX) * Colorpicker.Decimals) / Colorpicker.Decimals
                        ValueX = math.clamp(ValueX, 0, 1)
                        self:SetSaturationX({
                            Value = ValueX, 
                            Percent = PercentX
                        })
                        --
                        local PercentY = math.clamp(((Mouse.Y + 36) - InternalSaturation.Position.Y) / (InternalSaturation.Size.Y), 0, 1)
                        local ValueY = 1 - math.floor((1 * PercentY) * Colorpicker.Decimals) / Colorpicker.Decimals
                        ValueY = math.clamp(ValueY, 0, 1)
                        self:SetSaturationY({
                            Value = ValueY, 
                            Percent = PercentY
                        })
                    end
                    --
                    Utility.AddConnection(UserInput.InputEnded, function(Input, Useless)
                        
                        for Index, Value in pairs(Tab.Dropdowns[Side]) do
                            if Index ~= ColorpickerTitle.Text and Value then
                                return
                            end
                        end
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Colorpicker.HueDragging = false
                            Colorpicker.SaturationDragging = false
                        end
                    end)
    
                    Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                        if Utility.OnMouse(ColorpickerInline) then
                            ColorpickerInline.Color = Library.Theme.Accent[1]
                        else
                            ColorpickerInline.Color = Library.Theme.Inline
                        end
                        
                        if Input.UserInputType == Enum.UserInputType.MouseMovement then
                            for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                if Index ~= ColorpickerTitle.Text and Value then
                                    return
                                end
                            end
                            if Colorpicker.HueDragging then
                                Colorpicker:RefreshHue()
                            elseif Colorpicker.SaturationDragging then
                                Colorpicker:RefreshSaturation()
                            end
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                if Index ~= ColorpickerTitle.Text and Value then
                                    return
                                end
                            end
                            if Utility.OnMouse(ColorpickerInline) then
                                Colorpicker.Dropped = not Colorpicker.Dropped
                                Tab.Dropdowns[Side][ColorpickerTitle.Text] = Colorpicker.Dropped
                                Colorpicker:Drop(Colorpicker.Dropped)
                            elseif Utility.OnMouse(InternalSaturation) then
                                Colorpicker:RefreshSaturation()
                                Colorpicker.SaturationDragging = true
                            elseif Utility.OnMouse(InternalHue) then
                                Colorpicker:RefreshHue()
                                Colorpicker.HueDragging = true
                            elseif Utility.OnMouse(InternalInlineRainbow) then
                                Colorpicker.Rainbow = not Colorpicker.Rainbow
                                InternalRainbow.Color = Colorpicker.Rainbow and Library.Theme.Accent[1] or Library.Theme.Text
                                if not Colorpicker.Rainbow then
                                    Colorpicker:SetHue({Value = Colorpicker.Colors.HSV[1]})
                                    Colorpicker:SetSaturationX({Value = Colorpicker.Colors.HSV[2]})
                                    Colorpicker:SetSaturationY({Value = Colorpicker.Colors.HSV[3]})
                                end
                            else
                                Colorpicker.Dropped = false
                                Tab.Dropdowns[Side][ColorpickerTitle.Text] = Colorpicker.Dropped
                                Colorpicker:Drop(Colorpicker.Dropped)
                            end
                        end
                    end)
                    --
                    Utility.AddConnection(RunService.RenderStepped, function(Input, Useless)
                        if Colorpicker.Rainbow then
                            -- Colorpicker:SetHue({Value = tick() % 2 / 2, Visual = true})
                            -- Colorpicker:SetSaturationX({Value = 0.5, Visual = true})
                            -- Colorpicker:SetSaturationY({Value = 1, Visual = true})
                            Library.Flags[Colorpicker.Flag] = Color3.fromHSV(tick() % 2 / 2, 0.5, 1)
                            Colorpicker.Callback(Color3.fromHSV(tick() % 2 / 2, 0.5, 1))
                        end
                    end)
                    --
                    Colorpicker:SetHue({Value = Colorpicker.Colors.HSV[1]})
                    Colorpicker:SetSaturationX({Value = Colorpicker.Colors.HSV[2]})
                    Colorpicker:SetSaturationY({Value = Colorpicker.Colors.HSV[3]})
                    --
                    Section.ContentAxis = Section.ContentAxis + ColorpickerBase.Size.Y + 10
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] +  ColorpickerBase.Size.Y + 10 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] +  ColorpickerBase.Size.Y + 10 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + ColorpickerBase.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = ColorpickerTitle
                    Tab["Render"][#Tab["Render"] + 1] = ColorpickerInline
                    Tab["Render"][#Tab["Render"] + 1] = ColorpickerOutline
                    Tab["Render"][#Tab["Render"] + 1] = ColorpickerBase
                    Tab["Render"][#Tab["Render"] + 1] = ColorpickerGradient
                    --
                    Colorpicker:Drop(false)
                    --
                    return Colorpicker
                end
                --
                function Section:Dropdown(Options)
                    local Dropdown = {
                        TypeOf = "Dropdown",
                        Axis = Section.ContentAxis,
                        List = List or {""},
                        ListRender = {
                            Texts = {},
                            Objects = {}
                        }, 
                        Show = true,
                        Selected = Options.Default or Options.List[1],
                        BaseSize = 16,
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                    }
                    --
                    Options.Flag = Options.Flag or "AWGWJIjgAWJIGIJAWG"
                    Library.Flags[Options.Flag] = Dropdown.Selected
                    --
                    Library.Items[Options.Flag] = Dropdown
                    --
                    local DropdownInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + 8, SectionInline.Position.Y + 23 + Dropdown.Axis + 16),
                        Size = Vector2.new(SectionOutline.Size.X - 12, Dropdown.BaseSize),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local DropdownOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(DropdownInline.Size.X - 2, DropdownInline.Size.Y - 2),
                        Position = Vector2.new(DropdownInline.Position.X + 1, DropdownInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local DropdownGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(DropdownInline.Size.X - 2, DropdownInline.Size.Y - 2),
                        Position = Vector2.new(DropdownInline.Position.X + 1, DropdownInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 1,
                        Visible = true
                    })
                    --
                    local DropdownTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(DropdownInline.Position.X + 2, DropdownInline.Position.Y - 16),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local DropdownValue = Utility.AddDrawing("Text", {
                        Text = Options.Default,
                        Position = Vector2.new(DropdownOutline.Position.X + 4, DropdownOutline.Position.Y),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local DropdownSymbol = Utility.AddDrawing("Text", {
                        Text = "+",
                        Position = Vector2.new(DropdownOutline.Position.X + DropdownOutline.Size.X - 12, DropdownOutline.Position.Y),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local DropdownDetect = Utility.AddDrawing("Square", {
                        Thickness = 0,
                        Transparency = 0,
                        Color = Library.Theme.Hitbox, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    function Dropdown:Set(Selected)
                        for Index, Value in pairs(Dropdown.ListRender.Texts) do
                            Value.Color = Library.Theme.Text
                        end
                        Dropdown.ListRender.Texts[Selected].Color = Library.Theme.Accent[1]
                        Dropdown.Selected = Selected
                        DropdownValue.Text = Selected
                        Dropdown.Callback(Dropdown.Selected)
                        Library.Flags[Options.Flag] = Dropdown.Selected
                    end
                    --
                    function Dropdown:ShowList(State)
                        for Index, Value in pairs(Dropdown.ListRender.Objects) do
                            Value.Visible = State
                        end
                        --
                        for Index, Value in pairs(Dropdown.ListRender.Texts) do
                            Value.Visible = State
                        end
                        --
                        Tab.Dropdowns[Side][DropdownTitle.Text] = State
                    end
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                        if Type == "Accent" then
                            Dropdown.ListRender.Texts[Dropdown.Selected].Color = Color
                        elseif Type == "LightContrast" then
                            DropdownOutline.Color = Color
                        elseif Type == "Text" then
                            DropdownTitle.Color = Color
                            DropdownSymbol.Color = Color
                            DropdownValue.Color = Color
                        elseif Type == "Inline" then
                            DropdownInline.Color = Color
                        end
                    end)
                    --
                    for Index, Value in pairs(Options.List) do
                        local SelectionInline = Utility.AddDrawing("Square", {
                            Position = Vector2.new(DropdownInline.Position.X, (DropdownInline.Position.Y + (Index * (18)))),
                            Size = Vector2.new(SectionOutline.Size.X - 12, 18),
                            Thickness = 0,
                            Color = Library.Theme.Inline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local SelectionOutline = Utility.AddDrawing("Square", {
                            Size = Vector2.new(SelectionInline.Size.X - 2, SelectionInline.Size.Y - 2),
                            Position = Vector2.new(SelectionInline.Position.X + 1, SelectionInline.Position.Y + 1),
                            Thickness = 0,
                            Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                            Visible = true,
                            Filled = true,
                            ZIndex = 3
                        })
                        --
                        local SelectionGradient = Utility.AddDrawing("Image", {
                            Size = Vector2.new(SelectionInline.Size.X - 2, SelectionInline.Size.Y - 2),
                            Position = Vector2.new(SelectionInline.Position.X + 1, SelectionInline.Position.Y + 1),
                            Data = Library.Theme.Gradient,
                            Transparency = 1,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        local SelectionTitle = Utility.AddDrawing("Text", {
                            Text = Value,
                            Position = Vector2.new(SelectionInline.Position.X + 6, SelectionInline.Position.Y + 3),
                            Center = false,
                            Outline = false,
                            Font = Library.Theme.Font,
                            Size = Library.Theme.TextSize,
                            Color = Library.Theme.Text,
                            Visible = true,
                            ZIndex = 3
                        })
                        --
                        Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                            if Type == "LightContrast" then
                                SelectionOutline.Color = Color
                            elseif Type == "Text" then
                                SelectionTitle.Color = Color
                            elseif Type == "Inline" then
                                SelectionInline.Color = Color
                            end
                        end)
                        --
                        Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                                if Utility.OnMouse(SelectionInline) then
                                    SelectionInline.Color = Library.Theme.Accent[1]
                                else
                                    SelectionInline.Color = Library.Theme.Inline
                                end
                            end
                        end)
                        --
                        Dropdown.ListRender.Objects[#Dropdown.ListRender.Objects + 1] = SelectionInline
                        Dropdown.ListRender.Objects[#Dropdown.ListRender.Objects + 1] = SelectionOutline
                        Dropdown.ListRender.Objects[#Dropdown.ListRender.Objects + 1] = SelectionGradient
                        Dropdown.ListRender.Texts[Value] = SelectionTitle
                        --
                        Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                            if Useless then
                                return
                            end
                            for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                if Index ~= DropdownTitle.Text and Value then
                                    return
                                end
                            end
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 and Utility.OnMouse(SelectionInline) then
                                Dropdown:Set(Value)
                            end
                        end)
                        --
                    end
                    --
                    DropdownDetect.Position = Vector2.new(DropdownInline.Position.X, DropdownInline.Position.Y + DropdownInline.Size.Y)
                    DropdownDetect.Size = Vector2.new(SectionOutline.Size.X - 12, (#Options.List * Dropdown.BaseSize) + Dropdown.BaseSize)
                    --
                    Dropdown:Set(Dropdown.Selected)
                    Dropdown:ShowList(false)
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if Utility.OnMouse(DropdownInline) then
                                for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                    if Index ~= DropdownTitle.Text and Value then
                                        return
                                    end
                                end
                                Dropdown.Show = not Dropdown.Show
                                Tab.Dropdowns[Side][DropdownTitle.Text] = Dropdown.Show
                                DropdownSymbol.Text = Dropdown.Show and "-" or "+"
                                Dropdown:ShowList(Dropdown.Show)
                            elseif not Utility.OnMouse(DropdownDetect) then
                                Dropdown.Show = false
                                Tab.Dropdowns[Side][DropdownTitle.Text] = Dropdown.Show
                                DropdownSymbol.Text = "+"
                                Dropdown:ShowList(false)
                            end
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputChanged, function(Input, Useless)
                        if Input.UserInputType == Enum.UserInputType.MouseMovement then
                            if Utility.OnMouse(DropdownInline) then
                                DropdownInline.Color = Library.Theme.Accent[1]
                            else
                                DropdownInline.Color = Library.Theme.Inline
                            end
                        end
                    end)
                    --
                    Section.ContentAxis = Section.ContentAxis + DropdownOutline.Size.Y + 20
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] + DropdownOutline.Size.Y + 20 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] + DropdownOutline.Size.Y + 20 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + DropdownOutline.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = DropdownInline
                    Tab["Render"][#Tab["Render"] + 1] = DropdownOutline
                    Tab["Render"][#Tab["Render"] + 1] = DropdownTitle
                    Tab["Render"][#Tab["Render"] + 1] = DropdownGradient
                    Tab["Render"][#Tab["Render"] + 1] = DropdownSymbol
                    Tab["Render"][#Tab["Render"] + 1] = DropdownValue
                    --
                    return Dropdown
                end
                --
                function Section:Label(Title)
                    local Label = {
                        TypeOf = "Label",
                        Axis = Section.ContentAxis
                    }
                    --
                    local LabelTitle = Utility.AddDrawing("Text", {
                        Text = Title,
                        Position = Vector2.new(SectionInline.Position.X + 6, SectionInline.Position.Y + 23 + Label.Axis),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    function Label:Set(Txt)
                        LabelTitle.Text = Txt
                    end
                    --
                    Section.ContentAxis = Section.ContentAxis + LabelTitle.Size + 8
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] +  LabelTitle.Size + 8 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] +  LabelTitle.Size + 8 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + LabelTitle.Size)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = LabelTitle
                    --
                    return Label
                end
                --
                function Section:Keybind(Options)
                    local Keybind = {
                        TypeOf = "Keybind",
                        Axis = Section.ContentAxis,
                        Title = Options.Title and Options.Title or "LOL",
                        EnumType = Options.Key.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType",
                        Key = Options.Key or Enum.UserInputType.MouseButton2,
                        StateType = Options.StateType or "Hold",
                        State = false,
                        Shorten = "",
                        Binding = false,
                        Dropped = false,
                        Callback = typeof(Options.Callback) == "function" and Options.Callback or function() end
                    }
                    --
                    if Keybind.StateType == "Always" then
                        Keybind.Callback(Keybind.State, Keybind.Key)
                    end
                    --
                    Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                    --
                    local KeybindTitle = Utility.AddDrawing("Text", {
                        Text = Options.Title,
                        Position = Vector2.new(SectionInline.Position.X + 6, SectionInline.Position.Y + 26 + Keybind.Axis),
                        Center = false,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local KeybindInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X - 40 - 6, SectionInline.Position.Y + 23 + Keybind.Axis + 2),
                        Size = Vector2.new(40, 14),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(KeybindInline.Size.X - 2, KeybindInline.Size.Y - 2),
                        Position = Vector2.new(KeybindInline.Position.X + 1, KeybindInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(KeybindInline.Size.X - 2, KeybindInline.Size.Y - 2),
                        Position = Vector2.new(KeybindInline.Position.X + 1, KeybindInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 1,
                        Visible = true
                    })
                    --
                    local KeybindValue = Utility.AddDrawing("Text", {
                        Text = Keybind.Shorten,
                        Position = Vector2.new(KeybindInline.Position.X + (KeybindInline.Size.X / 2), KeybindInline.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local KeybindHoldInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X + 2 - 6, SectionInline.Position.Y + 23 + Keybind.Axis + 2),
                        Size = Vector2.new(60, 16),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindHoldOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(KeybindHoldInline.Size.X - 2, KeybindHoldInline.Size.Y - 2),
                        Position = Vector2.new(KeybindHoldInline.Position.X + 1, KeybindHoldInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindHoldGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(KeybindHoldInline.Size.X - 2, KeybindHoldInline.Size.Y - 2),
                        Position = Vector2.new(KeybindHoldInline.Position.X + 1, KeybindHoldInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 1,
                        Visible = true
                    })
                    --
                    local KeybindHoldValue = Utility.AddDrawing("Text", {
                        Text = "Hold",
                        Position = Vector2.new(KeybindHoldInline.Position.X + (KeybindHoldInline.Size.X / 2), KeybindHoldInline.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local KeybindToggleInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X + 2 - 6, SectionInline.Position.Y + 23 + Keybind.Axis + 2 + 18),
                        Size = Vector2.new(60, 16),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindToggleOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(KeybindToggleInline.Size.X - 2, KeybindToggleInline.Size.Y - 2),
                        Position = Vector2.new(KeybindToggleInline.Position.X + 1, KeybindToggleInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindToggleGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(KeybindToggleInline.Size.X - 2, KeybindToggleInline.Size.Y - 2),
                        Position = Vector2.new(KeybindToggleInline.Position.X + 1, KeybindToggleInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 1,
                        Visible = true
                    })
                    --
                    local KeybindToggleValue = Utility.AddDrawing("Text", {
                        Text = "Toggle",
                        Position = Vector2.new(KeybindToggleInline.Position.X + (KeybindToggleInline.Size.X / 2), KeybindToggleInline.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    local KeybindAlwaysInline = Utility.AddDrawing("Square", {
                        Position = Vector2.new(SectionInline.Position.X + SectionInline.Size.X + 2 - 6, SectionInline.Position.Y + 23 + Keybind.Axis + 2 + 34),
                        Size = Vector2.new(60, 16),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindAlwaysOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(KeybindAlwaysInline.Size.X - 2, KeybindAlwaysInline.Size.Y - 2),
                        Position = Vector2.new(KeybindAlwaysInline.Position.X + 1, KeybindAlwaysInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.LightContrast, --Library.Theme.Outline,
                        Visible = true,
                        Filled = true
                    })
                    --
                    local KeybindAlwaysGradient = Utility.AddDrawing("Image", {
                        Size = Vector2.new(KeybindAlwaysInline.Size.X - 2, KeybindAlwaysInline.Size.Y - 2),
                        Position = Vector2.new(KeybindAlwaysInline.Position.X + 1, KeybindAlwaysInline.Position.Y + 1),
                        Data = Library.Theme.Gradient,
                        Transparency = 1,
                        Visible = true
                    })
                    --
                    local KeybindAlwaysValue = Utility.AddDrawing("Text", {
                        Text = "Always",
                        Position = Vector2.new(KeybindAlwaysInline.Position.X + (KeybindAlwaysInline.Size.X / 2), KeybindAlwaysInline.Position.Y),
                        Center = true,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Color = Library.Theme.Text,
                        Visible = true,
                        ZIndex = 2
                    })
                    --
                    function Keybind:Drop(State)
                        KeybindHoldInline.Visible = State
                        KeybindHoldOutline.Visible = State
                        KeybindHoldGradient.Visible = State
                        KeybindHoldValue.Visible = State

                        KeybindToggleInline.Visible = State
                        KeybindToggleOutline.Visible = State
                        KeybindToggleGradient.Visible = State
                        KeybindToggleValue.Visible = State

                        KeybindAlwaysInline.Visible = State
                        KeybindAlwaysOutline.Visible = State
                        KeybindAlwaysGradient.Visible = State
                        KeybindAlwaysValue.Visible = State
                    end
                    --
                    function Keybind:SetStateType(State)
                        if State == "Hold" then
                            Keybind.StateType = "Hold"

                            KeybindAlwaysValue.Color = Library.Theme.Text
                            KeybindToggleValue.Color = Library.Theme.Text
                            KeybindHoldValue.Color = Library.Theme.Accent[1]
                        elseif State == "Toggle" then
                            Keybind.StateType = "Toggle"

                            KeybindAlwaysValue.Color = Library.Theme.Text
                            KeybindToggleValue.Color = Library.Theme.Accent[1]
                            KeybindHoldValue.Color = Library.Theme.Text
                        else
                            Keybind.StateType = "Always"

                            KeybindAlwaysValue.Color = Library.Theme.Accent[1]
                            KeybindToggleValue.Color = Library.Theme.Text
                            KeybindHoldValue.Color = Library.Theme.Text

                            Keybind.State = true
                            Keybind.Callback(Keybind.State, Keybind.Key)
                        end
                    end
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if Keybind.Binding then
                                Keybind.Binding = false
                                Keybind.Key = Enum.UserInputType.MouseButton1
                                Keybind.EnumType = "UserInputType"
                                Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                                KeybindValue.Text = Keybind.Binding and "[...]" or Keybind.Shorten
                            end
                            if Utility.OnMouse(KeybindInline) then
                                for Index, Value in pairs(Tab.Dropdowns[Side]) do
                                    if Index ~= KeybindTitle.Text and Value then
                                        return
                                    end
                                end
                                if Keybind.Binding then
                                    Keybind.Binding = false
                                    KeybindValue.Text = Keybind.Shorten
                                else
                                    Keybind.Binding = true
                                    KeybindValue.Text = Keybind.Binding and "[...]" or Keybind.Shorten
                                end
                            end
                            if Utility.OnMouse(KeybindHoldInline) then
                                Keybind:SetStateType("Hold")
                            end
                            if Utility.OnMouse(KeybindToggleInline) then
                                Keybind:SetStateType("Toggle")
                            end
                            if Utility.OnMouse(KeybindAlwaysInline) then
                                Keybind:SetStateType("Always")
                            end
                        elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                            if Keybind.Binding then
                                Keybind.Binding = false
                                Keybind.Key = Input.KeyCode
                                Keybind.EnumType = "KeyCode"
                                Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                                KeybindValue.Text = Keybind.Binding and "[...]" or Keybind.Shorten
                            end
                        elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            if Keybind.Binding then
                                Keybind.Binding = false
                                Keybind.Key = Enum.UserInputType.MouseButton2
                                Keybind.EnumType = "UserInputType"
                                Keybind.Shorten = Library.Keys.Shortened[Keybind.Key.Name] or Keybind.Key.Name
                                KeybindValue.Text = Keybind.Binding and "[...]" or Keybind.Shorten
                            end
                            if Utility.OnMouse(KeybindInline) then
                                Keybind.Dropped = not Keybind.Dropped
                                Keybind:Drop(Keybind.Dropped)
                            end
                        end
                    end)
                    --
                    Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                        
                        if (Keybind.EnumType == "KeyCode" and Input.KeyCode == Keybind.Key) or (Keybind.EnumType == "UserInputType" and Input.UserInputType == Keybind.Key) then
                            if Keybind.StateType == "Toggle" then
                                Keybind.State = not Keybind.State
                            elseif Keybind.StateType == "Hold" then
                                Keybind.State = true
                            end
                            Keybind.Callback(Keybind.State, Keybind.Key)
                        end
                    end)
                    --
                    Keybind:SetStateType(Keybind.StateType)
                    --
                    Utility.AddConnection(UserInput.InputEnded, function(Input, Useless)
                        
                        if (Keybind.EnumType == "KeyCode" and Input.KeyCode == Keybind.Key) or (Keybind.EnumType == "UserInputType" and Input.UserInputType == Keybind.Key) then
                            if Keybind.StateType == "Hold" then
                                Keybind.State = false
                                Keybind.Callback(Keybind.State, Keybind.Key)
                            end
                        end
                    end)
                    --
                    Keybind:Drop(false)
                    --
                    Section.ContentAxis = Section.ContentAxis + KeybindInline.Size.Y + 8
                    Tab.SectionAxis = {
                        Side == "Left" and Tab.SectionAxis[1] +  KeybindInline.Size.Y + 8 or Tab.SectionAxis[1], 
                        Side == "Right" and Tab.SectionAxis[2] +  KeybindInline.Size.Y + 8 or Tab.SectionAxis[2]
                    }
                    --
                    self:UpdateSizeY(Section.ContentAxis + KeybindInline.Size.Y)
                    --
                    Tab["Render"][#Tab["Render"] + 1] = KeybindTitle
                    Tab["Render"][#Tab["Render"] + 1] = KeybindInline
                    Tab["Render"][#Tab["Render"] + 1] = KeybindOutline
                    Tab["Render"][#Tab["Render"] + 1] = KeybindValue
                    Tab["Render"][#Tab["Render"] + 1] = KeybindGradient
                    --
                    return Keybind
                end
                --
                return Section
            end
            --
            Utility.AddConnection(UserInput.InputBegan, function(Input, Useless)
                if Useless then
                    return
                end
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and Utility.OnMouse(TabInline) then
                    task.spawn(function()
                        --[[
                            local Speed = 4
                            local Distance = (TabLine.Position.X - TabOutline.Position.X < 0) and 1 + (Tab.CurrentTab + (#self.Tabs - self.SelectedTab)) * Speed or 1 + ((#self.Tabs - Tab.CurrentTab) + self.SelectedTab) * Speed
                            local Calculation = (TabLine.Position.X - TabOutline.Position.X < 0) and Distance or -Distance
                            for Index = TabLine.Position.X, TabOutline.Position.X, Calculation do
                                TabLine.Position = Vector2.new(Index, TabLine.Position.Y)
                                task.wait()
                            end
                            TabLine.Size = Vector2.new(TabOutline.Size.X, 1)
                            TabLine.Position = Vector2.new(TabOutline.Position.X, TabLine.Position.Y)
                        ]]
                        
                        self:SwitchTab(Tab)
                    end)
                end
            end)
            --
            function Tab:AddPlayerlist()
                local PlayerList = {
                    PlayersInList = 0
                }
                --
                local PlayerListTabInline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(SecondBorderOutline.Size.X - 16, 40),
                    Position = Vector2.new(SecondBorderOutline.Position.X + 8, SecondBorderOutline.Position.Y + 6),
                    Thickness = 0,
                    Color = Library.Theme.Inline,
                    Visible = true,
                    Filled = true
                })
                --
                local PlayerListTabOutline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(PlayerListTabInline.Size.X - 2, PlayerListTabInline.Size.Y - 2),
                    Position = Vector2.new(PlayerListTabInline.Position.X + 1, PlayerListTabInline.Position.Y + 1),
                    Thickness = 0,
                    Color = Library.Theme.Outline,
                    Visible = true,
                    Filled = true
                })
                --
                local PlayerListPage = Utility.AddDrawing("Square", {
                    Size = Vector2.new(PlayerListTabOutline.Size.X - 4, PlayerListTabOutline.Size.Y - 4),
                    Position = Vector2.new(PlayerListTabOutline.Position.X + 2, PlayerListTabOutline.Position.Y + 2),
                    Thickness = 0,
                    Color = Library.Theme.DarkContrast,
                    Visible = true,
                    Filled = true
                })
                --
                local PlayerListTopline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(PlayerListTabOutline.Size.X, 1),
                    Position = Vector2.new(PlayerListTabOutline.Position.X, PlayerListTabOutline.Position.Y),
                    Thickness = 0,
                    Color = Library.Theme.Accent[1],
                    Visible = true,
                    Filled = true
                })
                --
                local PlayerListTitle = Utility.AddDrawing("Text", {
                    Text = "Player List",
                    Outline = false,
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Position = Vector2.new(PlayerListTabInline.Position.X + 4, PlayerListTabInline.Position.Y + 4),
                    Color = Library.Theme.Text,
                    Visible = true
                })
                --
                local PlayerListName = Utility.AddDrawing("Text", {
                    Text = "Name",
                    Outline = false,
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Position = Vector2.new(PlayerListTabInline.Position.X + 6, PlayerListTabInline.Position.Y + 20),
                    Color = Library.Theme.Text,
                    Visible = true
                })
                --
                local PlayerListTeam = Utility.AddDrawing("Text", {
                    Text = "Team",
                    Outline = false,
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Position = Vector2.new(PlayerListTabInline.Position.X + 182, PlayerListTabInline.Position.Y + 20),
                    Color = Library.Theme.Text,
                    Visible = true
                })
                --
                local PlayerListStatus = Utility.AddDrawing("Text", {
                    Text = "Status",
                    Outline = false,
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Position = Vector2.new(PlayerListTabInline.Position.X + 334, PlayerListTabInline.Position.Y + 20),
                    Color = Library.Theme.Text,
                    Visible = true
                })
                --
                function PlayerList:RefreshList(Int)
                    PlayerListTabInline.Size = Vector2.new(SecondBorderOutline.Size.X - 16, (22 * Int) + 37)
                    --
                    PlayerListTabOutline.Size = Vector2.new(PlayerListTabInline.Size.X - 2, PlayerListTabInline.Size.Y - 2)
                    PlayerListTabOutline.Position = Vector2.new(PlayerListTabInline.Position.X + 1, PlayerListTabInline.Position.Y + 1)
                    --
                    PlayerListPage.Size = Vector2.new(PlayerListTabOutline.Size.X - 4, PlayerListTabOutline.Size.Y - 4)
                    PlayerListPage.Position = Vector2.new(PlayerListTabOutline.Position.X + 2, PlayerListTabOutline.Position.Y + 2)
                end
                --
                function PlayerList:AddPlayer(Player)
                    PlayerList.PlayersInList += 1
                    local CurrentList, Removed = PlayerList.PlayersInList, false
                    --
                    local PlayerTabInline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(PlayerListTabInline.Size.X - 2, 22),
                        Position = Vector2.new(PlayerListTabInline.Position.X + 1, (PlayerListTabInline.Position.Y + 15) + (PlayerList.PlayersInList * 22)),
                        Thickness = 0,
                        Color = Library.Theme.Inline,
                        Visible = Window.SelectedTab == "Settings",
                        Filled = true
                    })
                    --
                    local PlayerTabOutline = Utility.AddDrawing("Square", {
                        Size = Vector2.new(PlayerTabInline.Size.X - 2, PlayerTabInline.Size.Y - 2),
                        Position = Vector2.new(PlayerTabInline.Position.X + 1, PlayerTabInline.Position.Y + 1),
                        Thickness = 0,
                        Color = Library.Theme.Outline,
                        Visible = Window.SelectedTab == "Settings",
                        Filled = true
                    })
                    --
                    local PlayerName = Utility.AddDrawing("Text", {
                        Text = Player.Name,
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Position = Vector2.new(PlayerTabInline.Position.X + 4, PlayerTabInline.Position.Y + 4),
                        Color = Library.Theme.Text,
                        Visible = Window.SelectedTab == "Settings"
                    })
                    --
                    local PlayerTeam = Utility.AddDrawing("Text", {
                        Text = Player.Team ~= nil and Player.Team.Name or "Neutral",
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Position = Vector2.new(PlayerTabInline.Position.X + 180, PlayerTabInline.Position.Y + 4),
                        Color = Player.Team ~= nil and Player.TeamColor.Color or Library.Theme.TextInactive,
                        Visible = Window.SelectedTab == "Settings"
                    })
                    --
                    local PlayerStatus = Utility.AddDrawing("Text", {
                        Text = Player == LocalPlayer and "Client" or "None",
                        Outline = false,
                        Font = Library.Theme.Font,
                        Size = Library.Theme.TextSize,
                        Position = Vector2.new(PlayerTabInline.Position.X + 330, PlayerTabInline.Position.Y + 4),
                        Color = Player == LocalPlayer and Library.Theme.Accent[1] or Library.Theme.Text,
                        Visible = Window.SelectedTab == "Settings"
                    })
                    --
                    Tab["Render"][#Tab["Render"] + 1] = PlayerTabInline
                    Tab["Render"][#Tab["Render"] + 1] = PlayerTabOutline
                    Tab["Render"][#Tab["Render"] + 1] = PlayerName
                    Tab["Render"][#Tab["Render"] + 1] = PlayerTeam
                    Tab["Render"][#Tab["Render"] + 1] = PlayerStatus
                    --
                    self:RefreshList(CurrentList)
                    --
                    Utility.AddConnection(Library.Communication.Event, function(Type, User)
                        if Type == "RemovePlayer" then
                            if User == Player.Name then
                                Tab:RemoveDrawing(PlayerTabInline)
                                Tab:RemoveDrawing(PlayerTabOutline)
                                Tab:RemoveDrawing(PlayerName)
                                Tab:RemoveDrawing(PlayerTeam)
                                Tab:RemoveDrawing(PlayerStatus)
                                --
                                --[[
                                    Utility.RemoveDrawing(PlayerTabInline)
                                    Utility.RemoveDrawing(PlayerTabOutline)
                                    Utility.RemoveDrawing(PlayerName)
                                    Utility.RemoveDrawing(PlayerTeam)
                                    Utility.RemoveDrawing(PlayerStatus)
                                ]]
                            end
                            CurrentList -= 1
                            self:RefreshList(CurrentList)
                        end
                    end)
                end
                --
                function PlayerList:RemovePlayer(Player)
                    PlayerList[Player.Name] = {}
                    --
                    Library.Communication:Fire("RemovePlayer", Player.Name)
                    --
                    PlayerList.PlayersInList -= 1
                    self:RefreshList(PlayerList.PlayersInList)
                end
                --
                Tab["Render"][#Tab["Render"] + 1] = PlayerListTabInline
                Tab["Render"][#Tab["Render"] + 1] = PlayerListTabOutline
                Tab["Render"][#Tab["Render"] + 1] = PlayerListTopline
                Tab["Render"][#Tab["Render"] + 1] = PlayerListName
                Tab["Render"][#Tab["Render"] + 1] = PlayerListTeam
                Tab["Render"][#Tab["Render"] + 1] = PlayerListStatus
                Tab["Render"][#Tab["Render"] + 1] = PlayerListPage
                Tab["Render"][#Tab["Render"] + 1] = PlayerListTitle
                --
                return PlayerList
            end
            --
            function Tab:AddESPPreview()
                local ESPPreviewLib = {}
            
                local GetEndedPosition = Vector2.new(WindowOutline.Position.X + WindowOutline.Size.X, WindowOutline.Position.Y)
            
                local ESPPreviewOutline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(250, 335),
                    Thickness = 0,  
                    Color = Library.Theme.Outline,
                    Visible = false
                    ,
                    Filled = true
                })
                --
                ESPPreviewOutline.Position = Vector2.new(GetEndedPosition.X + 6, GetEndedPosition.Y)
                --
                local ESPPreviewBorder = Utility.AddDrawing("Square", {
                    Size = Vector2.new(ESPPreviewOutline.Size.X - 2, ESPPreviewOutline.Size.Y - 2),
                    Position = Vector2.new(ESPPreviewOutline.Position.X + 1, ESPPreviewOutline.Position.Y + 1),
                    Thickness = 0,
                    Color = Library.Theme.Accent[1],
                    Visible = false,
                    Filled = true
                })
                --
                local ESPPreviewFrame = Utility.AddDrawing("Square", {
                    Size = Vector2.new(ESPPreviewBorder.Size.X - 2, ESPPreviewBorder.Size.Y - 2),
                    Position = Vector2.new(ESPPreviewBorder.Position.X + 1, ESPPreviewBorder.Position.Y + 1),
                    Thickness = 0,
                    Transparency = 1,
                    Color = Library.Theme.DarkContrast,
                    Visible = false,
                    Filled = true
                })
                --
                local ESPPreviewTitle = Utility.AddDrawing("Text", {
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Text = "ESP Preview",
                    Position = Vector2.new(ESPPreviewBorder.Position.X + 8, ESPPreviewBorder.Position.Y + 6),
                    Visible = false,
                    Center = false,
                    Outline = false
                })
                --
                local ESPPreviewOutline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(230, 300),
                    Position = Vector2.new(ESPPreviewBorder.Position.X + 10, ESPPreviewBorder.Position.Y + 25),
                    Thickness = 0,
                    Transparency = 1,
                    Color = Library.Theme.Outline,
                    Visible = false,
                    Filled = true
                })
                --
                local ESPPreviewInnerBoxBorder = Utility.AddDrawing("Square", {
                    Size = Vector2.new(ESPPreviewOutline.Size.X - 2, ESPPreviewOutline.Size.Y - 2),
                    Position = Vector2.new(ESPPreviewOutline.Position.X + 1, ESPPreviewOutline.Position.Y + 1),
                    Thickness = 0,
                    Color = Library.Theme.Inline,
                    Visible = false,
                    Filled = true
                })
                --
                local ESPPreviewInnerBox = Utility.AddDrawing("Square", {
                    Size = Vector2.new(ESPPreviewInnerBoxBorder.Size.X - 2, ESPPreviewInnerBoxBorder.Size.Y - 2),
                    Position = Vector2.new(ESPPreviewInnerBoxBorder.Position.X + 1, ESPPreviewInnerBoxBorder.Position.Y + 1),
                    Thickness = 0,
                    Transparency = 1,
                    Color = Library.Theme.LightContrast,
                    Visible = false,
                    Filled = true
                })
                --
                local Dummy = Utility.AddDrawing("Image", {
                    Transparency = 0.75, 
                    Visible = false,
                    Size = Vector2.new(ESPPreviewInnerBox.Size.X - 20, ESPPreviewInnerBox.Size.Y - 50),
                    Position = Vector2.new(ESPPreviewInnerBox.Position.X + 10, ESPPreviewInnerBox.Position.Y + 10),
                    Data = Library.Theme.Dummy
                })
                --
                local ESPBoxOutline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(200, 236),
                    Position = Vector2.new(Dummy.Position.X + 5, Dummy.Position.Y + 14),
                    Thickness = 3,
                    Transparency = 1,
                    Color = Library.Theme.Outline,
                    Visible = false,
                    Filled = false
                })
                --
                local ESPBox = Utility.AddDrawing("Square", {
                    Size = Vector2.new(200, 236),
                    Position = Vector2.new(Dummy.Position.X + 5, Dummy.Position.Y + 14),
                    Thickness = 1,
                    Transparency = 1,
                    Color = Library.Theme.Accent[1],
                    Visible = false,
                    Filled = false
                })
                --
                local ESPHealthBarOutline = Utility.AddDrawing("Square", {
                    Size = Vector2.new(2, 236),
                    Position = Vector2.new(ESPBox.Position.X - 6, ESPBox.Position.Y),
                    Thickness = 1,
                    Transparency = 1,
                    Color = Color3.fromRGB(0, 0, 0),
                    Visible = false,
                    Filled = true
                })
                --
                local ESPHealthBar = Utility.AddDrawing("Square", {
                    Size = Vector2.new(2, 236),
                    Position = Vector2.new(ESPBox.Position.X - 6, ESPBox.Position.Y),
                    Thickness = 1,
                    Transparency = 1,
                    Color = Color3.fromRGB(0, 255, 0),
                    Visible = false,
                    Filled = true
                })
                --
                local ESPName = Utility.AddDrawing("Text", {
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Text = "Username",
                    Position = Vector2.new(ESPBox.Position.X + (ESPBox.Size.X / 2), ESPBox.Position.Y - 15),
                    Visible = false,
                    Center = true,
                    Outline = true
                })
                --
                local ESPDistance = Utility.AddDrawing("Text", {
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Text = "25m",
                    Position = Vector2.new(ESPBox.Position.X + (ESPBox.Size.X / 2), ESPBox.Position.Y + ESPBox.Size.Y + 2),
                    Visible = false,
                    Center = true,
                    Outline = true
                })
                --
                local ESPWeapon = Utility.AddDrawing("Text", {
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Text = "Weapon",
                    Position = Vector2.new(ESPBox.Position.X + (ESPBox.Size.X / 2), ESPBox.Position.Y + ESPBox.Size.Y + 2 + 14),
                    Visible = false,
                    Center = true,
                    Outline = true
                })
            
                function ESPPreviewLib:UpdateName(State, Color)
                    ESPName.Visible = State; ESPName.Color = Color
                end
            
                function ESPPreviewLib:UpdateBoundingBox(State, Color)
                    ESPBoxOutline.Visible = State; ESPBox.Visible = State; ESPBox.Color = Color
                end
            
                function ESPPreviewLib:UpdateDistance(State, Color)
                    ESPDistance.Visible = State; ESPDistance.Color = Color
                end

                function ESPPreviewLib:UpdateWeapon(State, Color)
                    ESPWeapon.Visible = State; ESPWeapon.Color = Color
                end
            
                function ESPPreviewLib:UpdateHealthBar(State, Color, Configuration)
                    ESPHealthBarOutline.Visible = State;
                    ESPHealthBar.Visible = State; ESPHealthBar.Color = Color
                    ESPHealthBar.Size = Vector2.new(3, (Configuration.Health / Configuration.MaxHealth) * 236)
                    ESPHealthBar.Position = Vector2.new(ESPBox.Position.X - 6, ESPBox.Position.Y + (236 - ((Configuration.Health / Configuration.MaxHealth) * 236)))
                end
            
                return ESPPreviewLib
            end
            --
            Tab["TabInline"] = TabInline
            Tab["TabOutline"] = TabOutline
            Tab["TabTitle"] = TabTitle
            --
            Tab:Install()
            --
            Window.LastTab = TabInline
            self.Tabs[#self.Tabs + 1] = Tab
            -- self:RefreshPages()
            Tab["Render"] = {}
            return Tab
        end
        --
        function Window:AddSettingsTab(Additional)
            Additional = typeof(Additional) == "function" and Additional or function() end

            local LocalTheme = {
                Accent = Library.Theme.Accent[1],
                Outline = Color3.fromHex("#000005"),
                Inline = Color3.fromHex("#323232"),
                LightContrast = Color3.fromHex("#202020"),
                DarkContrast = Color3.fromHex("#191919"),
                Text = Color3.fromHex("#e8e8e8"),
                TextInactive = Color3.fromHex("#aaaaaa")
            }

            local Settings = Window:Tab("Settings")

            local Theme = Settings:Section("Theme", "Left")
            
            Theme:Colorpicker({Title = "Accent", Color = LocalTheme.Accent, Flag = "UIAccent", Callback = function(Color)
                print(Color)
                Library:UpdateTheme({
                    Accent = Color
                })
                LocalTheme.Accent = Color
            end})
            
            Theme:Colorpicker({Title = "Outline", Color = LocalTheme.Outline, Flag = "UIOutline", Callback = function(Color)
                Library:UpdateTheme({
                    Outline = Color
                })
                LocalTheme.Outline = Color
            end})
            
            Theme:Colorpicker({Title = "Inline", Color = LocalTheme.Inline, Flag = "UIInline", Callback = function(Color)
                Library:UpdateTheme({
                    Inline = Color
                })
                LocalTheme.Inline = Color
            end})
            
            Theme:Colorpicker({Title = "Inline Contrast", Color = LocalTheme.LightContrast, Flag = "UILightContrast", Callback = function(Color)
                Library:UpdateTheme({
                    LightContrast = Color
                })
                LocalTheme.LightContrast = Color
            end})
            
            Theme:Colorpicker({Title = "Dark Contrast", Color = LocalTheme.DarkContrast, Flag = "UIDarkContrast", Callback = function(Color)
                Library:UpdateTheme({
                    DarkContrast = Color
                })
                LocalTheme.DarkContrast = Color
            end})
            
            Theme:Colorpicker({Title = "Text", Color = LocalTheme.Text, Flag = "UIText", Callback = function(Color)
                Library:UpdateTheme({
                    Text = Color
                })
                LocalTheme.Text = Color
            end})
            
            Theme:Colorpicker({Title = "Text Inactive", Color = LocalTheme.TextInactive, Flag = "UITextInactive", Callback = function(Color)
                Library:UpdateTheme({
                    TextInactive = Color
                })
                LocalTheme.TextInactive = Color
            end})
            
            Theme:Dropdown({
                Title = "Theme",
                List = {"Default", "Neverlose", "Fatality", "Aimware", "Onetap", "Vape", "Gamesense", "OldAbyss"},
                Default = "Default",
                Callback = function(Choosen)
                    if Choosen == "Default" then
                        Library:UpdateTheme({
                            Accent = Color3.fromHex("#322850"),
                            Outline = Color3.fromHex("#000005"),
                            Inline = Color3.fromHex("#3c3c3c"),
                            LightContrast = Color3.fromHex("#231946"),
                            DarkContrast = Color3.fromHex("#191432"),
                            Text = Color3.fromHex("#c8c8ff"),
                            TextInactive = Color3.fromHex("#afafaf")
                        })
                    elseif Choosen == "Neverlose" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#000005"),
                            Inline = Color3.fromHex("#0a1e28"),
                            Accent = Color3.fromHex("#00b4f0"),
                            Text = Color3.fromHex("#ffffff"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#000f1e"),
                            DarkContrast = Color3.fromHex("#050514"),
                        })
                    elseif Choosen == "Octohook" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#000000"),
                            Inline = Color3.fromHex("#3c3c3c"),
                            Accent = Color3.fromHex("#8f4b67"),
                            Text = Color3.fromHex("#ffffff"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#171717"),
                            DarkContrast = Color3.fromHex("#121112"),
                        })
                    elseif Choosen == "Fatality" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#322850"),
                            Inline = Color3.fromHex("#3c3c3c"),
                            Accent = Color3.fromHex("#f00f50"),
                            Text = Color3.fromHex("#c8c8ff"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#231946"),
                            DarkContrast = Color3.fromHex("#191432"),
                        })
                    elseif Choosen == "Aimware" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#000005"),
                            Inline = Color3.fromHex("#373737"),
                            Accent = Color3.fromHex("#c82828"),
                            Text = Color3.fromHex("#e8e8e8"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#2b2b2b"),
                            DarkContrast = Color3.fromHex("#191919"),
                        })
                    elseif Choosen == "Onetap" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#000000"),
                            Inline = Color3.fromHex("#4e5158"),
                            Accent = Color3.fromHex("#dda85d"),
                            Text = Color3.fromHex("#d6d9e0"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#2c3037"),
                            DarkContrast = Color3.fromHex("#1f2125"),
                        })
                    elseif Choosen == "Vape" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#0a0a0a"),
                            Inline = Color3.fromHex("#363636"),
                            Accent = Color3.fromHex("#26866a"),
                            Text = Color3.fromHex("#d6d9e0"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#1f1f1f"),
                            DarkContrast = Color3.fromHex("#1a1a1a"),
                        })
                    elseif Choosen == "Gamesense" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#000000"),
                            Inline = Color3.fromHex("#4e5158"),
                            Accent = Color3.fromHex("#a7d94d"),
                            Text = Color3.fromHex("#ffffff"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#171717"),
                            DarkContrast = Color3.fromHex("#0c0c0c"),
                        })
                    elseif Choosen == "OldAbyss" then
                        Library:UpdateTheme({
                            Outline = Color3.fromHex("#0a0a0a"),
                            Inline = Color3.fromHex("#322850"),
                            Accent = Color3.fromHex("#8c87b4"),
                            Text = Color3.fromHex("#ffffff"),
                            TextInactive = Color3.fromHex("#afafaf"),
                            LightContrast = Color3.fromHex("#1e1e1e"),
                            DarkContrast = Color3.fromHex("#141414"),
                        })
                    end
                end
            })
            
            local ClickGUI = Settings:Section("Click GUI", "Right")
            
            ClickGUI:Toggle({
                Title = "Enable Anime",
                Callback = function(State)
                    Window.ToggleAnime(State)
                end
            })
            
            ClickGUI:Dropdown({
                Title = "Anime",
                List = {"Astolfo", "Violet", "Rem", "Aiko", "Asuka"},
                Default = "Astolfo",
                Callback = function(Name)
                    Window.ChangeAnime(Name)
                end
            })

            ClickGUI:Button({
                Title = "Self Destruct",
                Callback = function()
                    Library.SelfDestruct()
                    Additional()
                end
            })

            return Settings
        end
        --
        function Window.Watermark(Title)
            local Watermark = {
                Title = Title,
                FPS = 60,
                Visible = true
            }
            --
            local WindowOutline = Utility.AddDrawing("Square", {
                Size = Vector2.new(475, 24),
                Position = Vector2.new(150, 8),
                Thickness = 0,
                Color = Library.Theme.Outline,
                Visible = true,
                Filled = true
            }, Library.Watermark)
            --
            local WatermarkIcon = Utility.AddDrawing("Image", {
                Size = Vector2.new(18, 20),
                Position = Vector2.new(WindowOutline.Position.X + 2, WindowOutline.Position.Y + 2),
                Transparency = 1,
                ZIndex = 3,
                Visible = true,
                Data = Library.Theme.Logo
            }, Library.Watermark)
            --
            local WindowOutlineBorder = Utility.AddDrawing("Square", {
                Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2),
                Position = Vector2.new(WindowOutline.Position.X + 1, WindowOutline.Position.Y + 1),
                Thickness = 0,
                Color = Library.Theme.Accent[1],
                Visible = false,
                Filled = true
            }, Library.Watermark)
            --
            local WindowFrame = Utility.AddDrawing("Square", {
                Size = Vector2.new(WindowOutlineBorder.Size.X - 2, WindowOutlineBorder.Size.Y - 2),
                Position = Vector2.new(WindowOutlineBorder.Position.X + 1, WindowOutlineBorder.Position.Y + 1),
                Thickness = 0,
                Transparency = 1,
                Color = Library.Theme.DarkContrast,
                Visible = true,
                Filled = true
            }, Library.Watermark)
            --
            local WindowTopline = Utility.AddDrawing("Square", {
                Size = Vector2.new(WindowOutlineBorder.Size.X, 1),
                Position = Vector2.new(WindowOutlineBorder.Position.X, WindowOutlineBorder.Position.Y),
                Thickness = 0,
                Color = Library.Theme.Accent[1],
                Visible = true,
                Filled = true
            }, Library.Watermark)
            --
            Utility.AddConnection(Library.Communication.Event, function(Type, Color)
                if Type == "Accent" then
                    WindowOutlineBorder.Color = Color
                    WindowTopline.Color = Color
                end
            end)
            --
            local WindowImage = Utility.AddDrawing("Image", {
                Size = WindowFrame.Size,
                Position = WindowFrame.Position,
                Transparency = 1, 
                Visible = true,
                Data = Library.Theme.Gradient
            }, Library.Watermark)
            --
            local WindowTitle = Utility.AddDrawing("Text", {
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Text = Watermark.Title .. " | " .. ("%s, %s, %s"):format(os.date("%B"), os.date("%d"), os.date("%Y")),
                Position = Vector2.new(WindowFrame.Position.X + (WindowFrame.Size.X / 2), WindowOutlineBorder.Position.Y + 4),
                Visible = true,
                Center = false,
                Outline = false
            }, Library.Watermark)
            --
            WindowOutline.Size = Vector2.new(WindowTitle.TextBounds.X + 19, 20)
            WindowTopline.Size = Vector2.new(WindowOutline.Size.X - 2, 2)
            WindowFrame.Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2)
            --
            --[[
                Utility.Loop(1, function()
                    WindowTitle.Text = ("%s | Ping: %s ms | FPS: %s fps"):format(Watermark.Title, tostring(math.floor(Stats:GetValue())), Watermark.FPS)
                    Watermark.FPS = 0
                end)
            ]]
            Utility.AddDrag(WindowOutline, Library.Watermark)
            --
            Utility.AddConnection(RunService.RenderStepped, function()
                Watermark.FPS += 1
                if Watermark.Visible then
                    local Hours, Minutes, Secs = os.date("*t")["hour"], os.date("*t")["min"], os.date("*t")["sec"]
                    local Format = Hours > 12 and Hours - 12 or Hours
                    local AMORPM = Hours > 12 and "PM" or "AM"
                    local FixZero = string.len(tostring(Secs)) == 1 and "0" .. Secs or Secs
                    WindowTitle.Text =  ("%s | %s:%s:%s %s | %s, %s, %s, %s"):format(Watermark.Title, Format, Minutes, FixZero, AMORPM, os.date("%A"), os.date("%B"), os.date("%d"), os.date("%Y"))

                    WindowOutline.Visible = true
                    WindowImage.Visible = true
                    --
                    WindowOutline.Size = Vector2.new(WindowTitle.TextBounds.X + 28, 22)
                    WindowOutlineBorder.Size = WindowOutline.Size
                    WindowTopline.Size = Vector2.new(WindowOutline.Size.X - 2, 1)
                    WindowFrame.Size = Vector2.new(WindowOutline.Size.X - 2, WindowOutline.Size.Y - 2)
                    WindowImage.Size = WindowFrame.Size
                    WindowTitle.Position = Vector2.new(WindowTopline.Position.X + 22, WindowTopline.Position.Y + 4)
                    --
                    WindowFrame.Visible = true
                    WindowTitle.Visible = true
                    WatermarkIcon.Visible = true
                    WindowTopline.Visible = true
                else
                    WatermarkIcon.Visible = false
                    WindowOutline.Visible = false
                    WindowFrame.Visible = false
                    WindowTitle.Visible = false
                    WindowTopline.Visible = false
                end
            end)
            --
            return Watermark
        end

        return Window
    end
end
