local InputService = game:GetService('UserInputService');
local TextService = game:GetService('TextService');
local TweenService = game:GetService('TweenService');
local CoreGui = game:GetService('CoreGui');
local RenderStepped = game:GetService('RunService').RenderStepped;
local LocalPlayer = game:GetService('Players').LocalPlayer;
local Mouse = LocalPlayer:GetMouse();

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);

local ScreenGui = Instance.new('ScreenGui');
ProtectGui(ScreenGui);

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
ScreenGui.Parent = CoreGui;

local Toggles = {};
local Options = {};

getgenv().Toggles = Toggles;
getgenv().Options = Options;

local Library = {
    Registry = {};
    RegistryMap = {};

    HudRegistry = {};

    FontColor = Color3.fromRGB(255, 255, 255);
    MainColor = Color3.fromRGB(28, 28, 28);
    BackgroundColor = Color3.fromRGB(20, 20, 20);
    AccentColor = Color3.fromRGB(0, 85, 255);
    OutlineColor = Color3.fromRGB(50, 50, 50);

    Black = Color3.new(0, 0, 0);

    OpenedFrames = {};
};

task.spawn(function()
    local Tick = tick();
    local Hue = 0;

    while RenderStepped:Wait() do
        if tick() - Tick >= (1 / 60) then
            Hue = Hue + (1 / 400);

            if Hue > 1 then
                Hue = 0;
            end;

            Library.CurrentRainbowHue = Hue;
            Library.CurrentRainbowColor = Color3.fromHSV(Hue, 0.8, 1);

            Tick = tick();
        end;
    end;
end);

function Library:AttemptSave()
    if Library.SaveManager then
        Library.SaveManager:Save();
    end;
end;

function Library:Create(Class, Properties)
    local _Instance = Class;

    if type(Class) == 'string' then
        _Instance = Instance.new(Class);
    end;

    for Property, Value in next, Properties do
        _Instance[Property] = Value;
    end;

    return _Instance;
end;

function Library:CreateLabel(Properties, IsHud)
    local _Instance = Library:Create('TextLabel', {
        BackgroundTransparency = 1;
        Font = Enum.Font.Code;
        TextColor3 = Library.FontColor;
        TextSize = 16;
        TextStrokeTransparency = 0;
    });

    Library:AddToRegistry(_Instance, {
        TextColor3 = 'FontColor';
    }, IsHud);

    return Library:Create(_Instance, Properties);
end;

function Library:MakeDraggable(Instance, Cutoff)
    Instance.Active = true;

    Instance.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            local ObjPos = Vector2.new(
                Mouse.X - Instance.AbsolutePosition.X,
                Mouse.Y - Instance.AbsolutePosition.Y
            );

            if ObjPos.Y > (Cutoff or 40) then
                return;
            end;

            while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                Instance.Position = UDim2.new(
                    0,
                    Mouse.X - ObjPos.X + (Instance.Size.X.Offset * Instance.AnchorPoint.X),
                    0,
                    Mouse.Y - ObjPos.Y + (Instance.Size.Y.Offset * Instance.AnchorPoint.Y)
                );

                RenderStepped:Wait();
            end;
        end;
    end);
end;

function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
    HighlightInstance.MouseEnter:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, Properties do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end);

    HighlightInstance.MouseLeave:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, PropertiesDefault do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end);
end;

function Library:MouseIsOverOpenedFrame()
    for Frame, _ in next, Library.OpenedFrames do
        local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

        if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

            return true;
        end;
    end;
end;

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
    return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
end;

function Library:GetTextBounds(Text, Font, Size)
    return TextService:GetTextSize(Text, Size, Font, Vector2.new(1920, 1080)).X;
end;

function Library:GetDarkerColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S, V / 1.5);
end; Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);

function Library:AddToRegistry(Instance, Properties, IsHud)
    local Idx = #Library.Registry + 1;
    local Data = {
        Instance = Instance;
        Properties = Properties;
        Idx = Idx;
    };

    table.insert(Library.Registry, Data);
    Library.RegistryMap[Instance] = Data;

    if IsHud then
        table.insert(Library.HudRegistry, Data);
    end;
end;

function Library:RemoveFromRegistry(Instance)
    local Data = Library.RegistryMap[Instance];

    if Data then
        for Idx = #Library.Registry, 1, -1 do
            if Library.Registry[Idx] == Data then
                table.remove(Library.Registry, Idx);
            end;
        end;

        for Idx = #Library.HudRegistry, 1, -1 do
            if Library.HudRegistry[Idx] == Data then
                table.remove(Library.HudRegistry, Idx);
            end;
        end;

        Library.RegistryMap[Instance] = nil;
    end;
end;

ScreenGui.DescendantRemoving:Connect(function(Instance)
    if Library.RegistryMap[Instance] then
        Library:RemoveFromRegistry(Instance);
    end;
end);

function Library:UpdateColorsUsingRegistry()
    -- TODO: Could have an 'active' list of objects
    -- where the active list only contains Visible objects.

    -- IMPL: Could setup .Changed events on the AddToRegistry function
    -- that listens for the 'Visible' propert being changed.
    -- Visible: true => Add to active list, and call UpdateColors function
    -- Visible: false => Remove from active list.

    -- The above would be especially efficient for a rainbow menu color or live color-changing.

    for Idx, Object in next, Library.Registry do
        for Property, ColorIdx in next, Object.Properties do
            Object.Instance[Property] = Library[ColorIdx];
        end;
    end;
end;

local BaseAddons = {};

do
    local Funcs = {};

    function Funcs:AddColorPicker(Idx, Info)
        local ToggleLabel = self.TextLabel;
        local Container = self.Container;

        local ColorPicker = {
            Value = Info.Default;
            Type = 'ColorPicker';
        };

        function ColorPicker:SetHSVFromRGB(Color)
            local H, S, V = Color3.toHSV(Color);

            ColorPicker.Hue = H;
            ColorPicker.Sat = S;
            ColorPicker.Vib = V;
        end;

        ColorPicker:SetHSVFromRGB(ColorPicker.Value);

        local DisplayFrame = Library:Create('Frame', {
            BackgroundColor3 = ColorPicker.Value;
            BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(0, 28, 0, 14);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        local RelativeOffset = 0;

        for _, Element in next, Container:GetChildren() do
            if not Element:IsA('UIListLayout') then
                RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
            end;
        end;

        local PickerFrameOuter = Library:Create('Frame', {
            Name = 'Color';
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 20 + RelativeOffset + 1);
            Size = UDim2.new(1, -4, 0, 234);
            Visible = false;
            ZIndex = 15;
            Parent = Container.Parent;
        });

        local PickerFrameInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 16;
            Parent = PickerFrameOuter;
        });

        Library:AddToRegistry(PickerFrameInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local Highlight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 2);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        Library:AddToRegistry(Highlight, {
            BackgroundColor3 = 'AccentColor';
        });

        local SatVibMapOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 6);
            Size = UDim2.new(0, 200, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = SatVibMapOuter;
        });

        Library:AddToRegistry(SatVibMapInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local SatVibMap = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Image = 'rbxassetid://4155801252';
            Parent = SatVibMapInner;
        });

        local HueSelectorOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 211, 0, 7);
            Size = UDim2.new(0, 15, 0, 198);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local HueSelectorInner = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = HueSelectorOuter;
        });

        local HueTextSize = Library:GetTextBounds('Hex color', Enum.Font.Code, 16) + 3
        local RgbTextSize = Library:GetTextBounds('255, 255, 255', Enum.Font.Code, 16) + 3

        local HueBoxOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(4, 209),
            Size = UDim2.new(0.5, -6, 0, 20),
            ZIndex = 18,
            Parent = PickerFrameInner;
        });

        local HueBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18,
            Parent = HueBoxOuter;
        });

        Library:AddToRegistry(HueBoxInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = HueBoxInner;
        });

        local HueBox = Library:Create('TextBox', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            Font = Enum.Font.Code;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = 'Hex color',
            Text = '#FFFFFF',
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 20,
            Parent = HueBoxInner;
        });

        local RgbBoxBase = Library:Create(HueBoxOuter:Clone(), {
            Position = UDim2.new(0.5, 2, 0, 209),
            Size = UDim2.new(0.5, -6, 0, 20),
            Parent = PickerFrameInner
        })  

        Library:AddToRegistry(RgbBoxBase.Frame, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local RgbBox = Library:Create(RgbBoxBase.Frame:FindFirstChild('TextBox'), {
            Text = '255, 255, 255',
            PlaceholderText = 'RGB color',
        })

        local SequenceTable = {};

        for Hue = 0, 1, 0.1 do
            table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
        end;

        local HueSelectorGradient = Library:Create('UIGradient', {
            Color = ColorSequence.new(SequenceTable);
            Rotation = 90;
            Parent = HueSelectorInner;
        });

        HueBox.FocusLost:Connect(function(enter)
            if enter then
                local success, result = pcall(Color3.fromHex, HueBox.Text)
                if success and typeof(result) == 'Color3' then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(result)
                end
            end

            ColorPicker:Display()
        end)

        RgbBox.FocusLost:Connect(function(enter)
            if enter then
                local r, g, b = RgbBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')
                if r and g and b then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(Color3.fromRGB(r, g, b))
                end
            end

            ColorPicker:Display()
        end)

        function ColorPicker:Display()
            ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
            SatVibMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1);

            Library:Create(DisplayFrame, {
                BackgroundColor3 = ColorPicker.Value;
                BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            });

            HueBox.Text = '#' .. ColorPicker.Value:ToHex()
            RgbBox.Text = table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', ')

            if ColorPicker.Changed then
                ColorPicker.Changed();
            end;
        end;

        function ColorPicker:OnChanged(Func)
            ColorPicker.Changed = Func;
            Func();
        end;

        function ColorPicker:Show()
            for Frame, Val in next, Library.OpenedFrames do
                if Frame.Name == 'Color' then
                    Frame.Visible = false;
                    Library.OpenedFrames[Frame] = nil;
                end;
            end;

            PickerFrameOuter.Visible = true;
            Library.OpenedFrames[PickerFrameOuter] = true;
        end;

        function ColorPicker:Hide()
            PickerFrameOuter.Visible = false;
            Library.OpenedFrames[PickerFrameOuter] = nil;
        end;

        function ColorPicker:SetValue(HSV)
            local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3]);

            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        function ColorPicker:SetValueRGB(Color)
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        SatVibMap.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinX = SatVibMap.AbsolutePosition.X;
                    local MaxX = MinX + SatVibMap.AbsoluteSize.X;
                    local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                    local MinY = SatVibMap.AbsolutePosition.Y;
                    local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
                    ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        HueSelectorInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinY = HueSelectorInner.AbsolutePosition.Y;
                    local MaxY = MinY + HueSelectorInner.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        DisplayFrame.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                if PickerFrameOuter.Visible then
                    ColorPicker:Hide();
                else
                    ColorPicker:Show();
                end;
            end;
        end);

        InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ColorPicker:Hide();
                end;
            end;
        end);

        ColorPicker:Display();

        Options[Idx] = ColorPicker;

        return self;
    end;

    function Funcs:AddKeyPicker(Idx, Info)
        local ToggleLabel = self.TextLabel;
        local Container = self.Container;

        local KeyPicker = {
            Value = Info.Default;
            Toggled = false;
            Mode = Info.Mode or 'Toggle'; -- Always, Toggle, Hold
            Type = 'KeyPicker';
        };

        local RelativeOffset = 0;

        for _, Element in next, Container:GetChildren() do
            if not Element:IsA('UIListLayout') then
                RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
            end;
        end;

        local PickOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 28, 0, 15);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        local PickInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 7;
            Parent = PickOuter;
        });

        Library:AddToRegistry(PickInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 13;
            Text = Info.Default;
            TextWrapped = true;
            ZIndex = 8;
            Parent = PickInner;
        });

        local ModeSelectOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(1, 0, 0, RelativeOffset + 1);
            Size = UDim2.new(0, 60, 0, 45 + 2);
            Visible = false;
            ZIndex = 14;
            Parent = Container.Parent;
        });

        local ModeSelectInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 15;
            Parent = ModeSelectOuter;
        });

        Library:AddToRegistry(ModeSelectInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ModeSelectInner;
        });

        local ContainerLabel = Library:CreateLabel({
            TextXAlignment = Enum.TextXAlignment.Left;
            Size = UDim2.new(1, 0, 0, 18);
            TextSize = 13;
            Visible = false;
            ZIndex = 110;
            Parent = Library.KeybindContainer;
        },  true);

        local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold' };
        local ModeButtons = {};

        for Idx, Mode in next, Modes do
            local ModeButton = {};

            local Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 15);
                TextSize = 13;
                Text = Mode;
                ZIndex = 16;
                Parent = ModeSelectInner;
            });

            function ModeButton:Select()
                for _, Button in next, ModeButtons do
                    Button:Deselect();
                end;

                KeyPicker.Mode = Mode;

                Label.TextColor3 = Library.AccentColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';

                ModeSelectOuter.Visible = false;
            end;

            function ModeButton:Deselect()
                KeyPicker.Mode = nil;

                Label.TextColor3 = Library.FontColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
            end;

            Label.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    ModeButton:Select();
                    Library:AttemptSave();
                end;
            end);

            if Mode == KeyPicker.Mode then
                ModeButton:Select();
            end;

            ModeButtons[Mode] = ModeButton;
        end;

        function KeyPicker:Update()
            if Info.NoUI then
                return;
            end;

            local State = KeyPicker:GetState();

            ContainerLabel.Text = string.format('[%s] %s (%s)', KeyPicker.Value, Info.Text, KeyPicker.Mode);
            ContainerLabel.Visible = true;
            ContainerLabel.TextColor3 = State and Library.AccentColor or Library.FontColor;

            Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';

            local YSize = 0;

            for _, Label in next, Library.KeybindContainer:GetChildren() do
                if not Label:IsA('UIListLayout') then
                    if Label.Visible then
                        YSize = YSize + 18;
                    end;
                end;
            end;

            Library.KeybindFrame.Size = UDim2.new(0, 210, 0, 20 + YSize);
        end;

        function KeyPicker:GetState()
            if KeyPicker.Mode == 'Always' then
                return true;
            elseif KeyPicker.Mode == 'Hold' then
                local Key = KeyPicker.Value;

                if Key == 'MB1' or Key == 'MB2' then
                    return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
                else
                    return InputService:IsKeyDown(Enum.KeyCode[KeyPicker.Value]);
                end;
            else
                return KeyPicker.Toggled;
            end;
        end;

        function KeyPicker:SetValue(Data)
            local Key, Mode = Data[1], Data[2];
            DisplayLabel.Text = Key;
            KeyPicker.Value = Key;
            ModeButtons[Mode]:Select();
            KeyPicker:Update();
        end;

        function KeyPicker:OnClick(Callback)
            KeyPicker.Clicked = Callback
        end

        function KeyPicker:DoClick()
            if KeyPicker.Clicked then
                KeyPicker.Clicked()
            end
        end

        local Picking = false;

        PickOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                Picking = true;

                DisplayLabel.Text = '';

                local Break;
                local Text = '';

                task.spawn(function()
                    while (not Break) do
                        if Text == '...' then
                            Text = '';
                        end;

                        Text = Text .. '.';
                        DisplayLabel.Text = Text;

                        wait(0.4);
                    end;
                end);

                wait(0.2);

                local Event;
                Event = InputService.InputBegan:Connect(function(Input)
                    local Key;

                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = Input.KeyCode.Name;
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Key = 'MB1';
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Key = 'MB2';
                    end;

                    Break = true;
                    Picking = false;

                    DisplayLabel.Text = Key;
                    KeyPicker.Value = Key;

                    Library:AttemptSave();

                    Event:Disconnect();
                end);
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ModeSelectOuter.Visible = true;
            end;
        end);

        InputService.InputBegan:Connect(function(Input)
            if (not Picking) then
                if KeyPicker.Mode == 'Toggle' then
                    local Key = KeyPicker.Value;

                    if Key == 'MB1' or Key == 'MB2' then
                        if Key == 'MB1' and Input.UserInputType == Enum.UserInputType.MouseButton1
                        or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            KeyPicker.Toggled = not KeyPicker.Toggled
                            KeyPicker:DoClick()
                        end;
                    elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                        if Input.KeyCode.Name == Key then
                            KeyPicker.Toggled = not KeyPicker.Toggled;
                            KeyPicker:DoClick()
                        end;
                    end;
                end;

                KeyPicker:Update();
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ModeSelectOuter.Visible = false;
                end;
            end;
        end);

        InputService.InputEnded:Connect(function(Input)
            if (not Picking) then
                KeyPicker:Update();
            end;
        end);

        KeyPicker:Update();

        Options[Idx] = KeyPicker;

        return self;
    end;

    BaseAddons.__index = Funcs;
    BaseAddons.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

local BaseGroupbox = {};

do
    local Funcs = {};

    function Funcs:AddBlank(Size)
        local Groupbox = self;
        local Container = Groupbox.Container;

        Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, Size);
            ZIndex = 1;
            Parent = Container;
        });
    end;

    function Funcs:AddLabel(Text)
        local Label = {};

        local Groupbox = self;
        local Container = Groupbox.Container;

        local TextLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            TextSize = 14;
            Text = Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = TextLabel;
        });

        Label.TextLabel = TextLabel;
        Label.Container = Container;
        setmetatable(Label, BaseAddons);

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Label;
    end;

    function Funcs:AddButton(Text, Func)
        local Button = {};

        local Groupbox = self;
        local Container = Groupbox.Container;

        local ButtonOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(ButtonOuter, {
            BorderColor3 = 'Black';
        });

        local ButtonInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = ButtonOuter;
        });

        Library:AddToRegistry(ButtonInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = ButtonInner;
        });

        local ButtonLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 14;
            Text = Text;
            ZIndex = 6;
            Parent = ButtonInner;
        });

        Library:OnHighlight(ButtonOuter, ButtonOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        ButtonOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                Func();
            end;
        end);

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Button;
    end;

    function Funcs:AddInput(Idx, Info)
        local Textbox = {
            Value = Info.Default or '';
            Type = 'Input';
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local InputLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 15);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        Groupbox:AddBlank(1);

        local TextBoxOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        local TextBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = TextBoxOuter;
        });

        Library:AddToRegistry(TextBoxInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = TextBoxInner;
        });

        local Box = Library:Create('TextBox', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            Font = Enum.Font.Code;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = Info.Placeholder or '';
            Text = Info.Default or '';
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 7;
            Parent = TextBoxInner;
        });

        function Textbox:SetValue(Text)
            if Info.MaxLength and #Text > Info.MaxLength then
                Text = Text:sub(1, Info.MaxLength);
            end;

            if Textbox.Changed then
                Textbox.Changed();
            end;

            Textbox.Value = Text;
            Box.Text = Text;
        end;

        Box:GetPropertyChangedSignal('Text'):Connect(function()
            Textbox:SetValue(Box.Text);
            Library:AttemptSave();
        end);

        Library:AddToRegistry(Box, {
            TextColor3 = 'FontColor';
        });

        function Textbox:OnChanged(Func)
            Textbox.Changed = Func;
            Func();
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        Options[Idx] = Textbox;

        return Textbox;
    end;

    function Funcs:AddToggle(Idx, Info)
        local Toggle = {
            Value = Info.Default or false;
            Type = 'Toggle';
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local ToggleOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 13, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(ToggleOuter, {
            BorderColor3 = 'Black';
        });

        local ToggleInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = ToggleOuter;
        });

        Library:AddToRegistry(ToggleInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local ToggleLabel = Library:CreateLabel({
            Size = UDim2.new(0, 216, 1, 0);
            Position = UDim2.new(1, 6, 0, 0);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 6;
            Parent = ToggleInner;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ToggleLabel;
        });

        local ToggleRegion = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(0, 170, 1, 0);
            ZIndex = 8;
            Parent = ToggleOuter;
        });

        Library:OnHighlight(ToggleRegion, ToggleOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        function Toggle:UpdateColors()
            Toggle:Display();
        end;

        function Toggle:Display()
            ToggleInner.BackgroundColor3 = Toggle.Value and Library.AccentColor or Library.MainColor;
            ToggleInner.BorderColor3 = Toggle.Value and Library.AccentColorDark or Library.OutlineColor;

            Library.RegistryMap[ToggleInner].Properties.BackgroundColor3 = Toggle.Value and 'AccentColor' or 'MainColor';
            Library.RegistryMap[ToggleInner].Properties.BorderColor3 = Toggle.Value and 'AccentColorDark' or 'OutlineColor';
        end;

        function Toggle:OnChanged(Func)
            Toggle.Changed = Func;
            Func();
        end;

        function Toggle:SetValue(Bool)
            Toggle.Value = Bool;
            Toggle:Display();

            if Toggle.Changed then
                Toggle.Changed();
            end;
        end;

        ToggleRegion.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                Toggle.Value = not Toggle.Value;
                Toggle:Display();

                if Toggle.Changed then
                    Toggle.Changed();
                end;

                Library:AttemptSave();
            end;
        end);

        Toggle:Display();
        Groupbox:AddBlank(Info.BlankSize or 5 + 2);
        Groupbox:Resize();

        Toggle.TextLabel = ToggleLabel;
        Toggle.Container = Container;
        setmetatable(Toggle, BaseAddons);

        Toggles[Idx] = Toggle;

        return Toggle;
    end;

    function Funcs:AddSlider(Idx, Info)
        assert(Info.Default and Info.Text and Info.Min and Info.Max and Info.Rounding, 'Bad Slider Data');

        local Slider = {
            Value = Info.Default;
            Min = Info.Min;
            Max = Info.Max;
            Rounding = Info.Rounding;
            MaxSize = 232;
            Type = 'Slider';
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        if not Info.Compact then
            Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = 5;
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end

        local SliderOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(SliderOuter, {
            BorderColor3 = 'Black';
        });

        local SliderInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = SliderOuter;
        });

        Library:AddToRegistry(SliderInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Fill = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderColor3 = Library.AccentColorDark;
            Size = UDim2.new(0, 0, 1, 0);
            ZIndex = 7;
            Parent = SliderInner;
        });

        Library:AddToRegistry(Fill, {
            BackgroundColor3 = 'AccentColor';
            BorderColor3 = 'AccentColorDark';
        });

        local HideBorderRight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = UDim2.new(1, 0, 0, 0);
            Size = UDim2.new(0, 1, 1, 0);
            ZIndex = 8;
            Parent = Fill;
        });

        Library:AddToRegistry(HideBorderRight, {
            BackgroundColor3 = 'AccentColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 14;
            Text = 'Infinite';
            ZIndex = 9;
            Parent = SliderInner;
        });

        Library:OnHighlight(SliderOuter, SliderOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        function Slider:UpdateColors()
            Fill.BackgroundColor3 = Library.AccentColor;
            Fill.BorderColor3 = Library.AccentColorDark;
        end;

        function Slider:Display()
            local Suffix = Info.Suffix or '';
            DisplayLabel.Text = string.format('%s/%s', Slider.Value .. Suffix, Slider.Max .. Suffix);

            local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, Slider.MaxSize));
            Fill.Size = UDim2.new(0, X, 1, 0);

            HideBorderRight.Visible = not (X == Slider.MaxSize or X == 0);
        end;

        function Slider:OnChanged(Func)
            Slider.Changed = Func;
            Func();
        end;

        local function Round(Value)
            if Slider.Rounding == 0 then
                return math.floor(Value);
            end;

            local Str = Value .. '';
            local Dot = Str:find('%.');

            return Dot and tonumber(Str:sub(1, Dot + Slider.Rounding)) or Value;
        end;

        function Slider:GetValueFromXOffset(X)
            return Round(Library:MapValue(X, 0, Slider.MaxSize, Slider.Min, Slider.Max));
        end;

        function Slider:SetValue(Str)
            local Num = tonumber(Str);

            if (not Num) then
                return;
            end;

            Num = math.clamp(Num, Slider.Min, Slider.Max);

            Slider.Value = Num;
            Slider:Display();

            if Slider.Changed then
                Slider.Changed();
            end;
        end;

        SliderInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                local mPos = Mouse.X;
                local gPos = Fill.Size.X.Offset;
                local Diff = mPos - (Fill.AbsolutePosition.X + gPos);

                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local nMPos = Mouse.X;
                    local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize);

                    local nValue = Slider:GetValueFromXOffset(nX);
                    local OldValue = Slider.Value;
                    Slider.Value = nValue;

                    Slider:Display();

                    if nValue ~= OldValue and Slider.Changed then
                        Slider.Changed();
                    end;

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        Slider:Display();
        Groupbox:AddBlank(Info.BlankSize or 6);
        Groupbox:Resize();

        Options[Idx] = Slider;

        return Slider;
    end;

    function Funcs:AddDropdown(Idx, Info)
        assert(Info.Text and Info.Values, 'Bad Dropdown Data');

        local Dropdown = {
            Values = Info.Values;
            Value = Info.Multi and {};
            Multi = Info.Multi;
            Type = 'Dropdown';
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local RelativeOffset = 0;

        local DropdownLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 10);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextYAlignment = Enum.TextYAlignment.Bottom;
            ZIndex = 5;
            Parent = Container;
        });

        Groupbox:AddBlank(3);

        for _, Element in next, Container:GetChildren() do
            if not Element:IsA('UIListLayout') then
                RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
            end;
        end;

        local DropdownOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(DropdownOuter, {
            BorderColor3 = 'Black';
        });

        local DropdownInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = DropdownOuter;
        });

        Library:AddToRegistry(DropdownInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = DropdownInner;
        });

        local DropdownArrow = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0, 0.5);
            BackgroundTransparency = 1;
            Position = UDim2.new(1, -16, 0.5, 0);
            Size = UDim2.new(0, 12, 0, 12);
            Image = 'http://www.roblox.com/asset/?id=6282522798';
            ZIndex = 7;
            Parent = DropdownInner;
        });

        local ItemList = Library:CreateLabel({
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            TextSize = 14;
            Text = '--';
            TextXAlignment = Enum.TextXAlignment.Left;
            TextWrapped = true;
            ZIndex = 7;
            Parent = DropdownInner;
        });

        Library:OnHighlight(DropdownOuter, DropdownOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        local MAX_DROPDOWN_ITEMS = 8;

        local ListOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 20 + RelativeOffset + 1 + 20);
            Size = UDim2.new(1, -8, 0, MAX_DROPDOWN_ITEMS * 20 + 2);
            ZIndex = 20;
            Visible = false;
            Parent = Container.Parent;
        });

        local ListInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListOuter;
        });

        Library:AddToRegistry(ListInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Scrolling = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            CanvasSize = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListInner;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 0);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Scrolling;
        });

        function Dropdown:Display()
            local Values = Dropdown.Values;
            local Str = '';

            if Info.Multi then
                for Idx, Value in next, Values do
                    if Dropdown.Value[Value] then
                        Str = Str .. Value .. ', ';
                    end;
                end;

                Str = Str:sub(1, #Str - 2);
            else
                Str = Dropdown.Value or '';
            end;

            ItemList.Text = (Str == '' and '--' or Str);
        end;

        function Dropdown:GetActiveValues()
            if Info.Multi then
                local T = {};

                for Value, Bool in next, Dropdown.Value do
                    table.insert(T, Value);
                end;

                return T;
            else
                return Dropdown.Value and 1 or 0;
            end;
        end;

        function Dropdown:SetValues()
            local Values = Dropdown.Values;
            local Buttons = {};

            for _, Element in next, Scrolling:GetChildren() do
                if not Element:IsA('UIListLayout') then
                    -- Library:RemoveFromRegistry(Element);
                    Element:Destroy();
                end;
            end;

            local Count = 0;

            for Idx, Value in next, Values do
                local Table = {};

                Count = Count + 1;

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Middle;
                    Size = UDim2.new(1, -1, 0, 20);
                    ZIndex = 23;
                    Parent = Scrolling;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'OutlineColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Size = UDim2.new(1, -6, 1, 0);
                    Position = UDim2.new(0, 6, 0, 0);
                    TextSize = 14;
                    Text = Value;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 25;
                    Parent = Button;
                });

                Library:OnHighlight(Button, Button,
                    { BorderColor3 = 'AccentColor', ZIndex = 24 },
                    { BorderColor3 = 'OutlineColor', ZIndex = 23 }
                );

                local Selected;

                if Info.Multi then
                    Selected = Dropdown.Value[Value];
                else
                    Selected = Dropdown.Value == Value;
                end;

                function Table:UpdateButton()
                    if Info.Multi then
                        Selected = Dropdown.Value[Value];
                    else
                        Selected = Dropdown.Value == Value;
                    end;

                    ButtonLabel.TextColor3 = Selected and Library.AccentColor or Library.FontColor;
                    Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
                end;

                ButtonLabel.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Try = not Selected;

                        if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                        else
                            if Info.Multi then
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value[Value] = true;
                                else
                                    Dropdown.Value[Value] = nil;
                                end;
                            else
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value = Value;
                                else
                                    Dropdown.Value = nil;
                                end;

                                for _, OtherButton in next, Buttons do
                                    OtherButton:UpdateButton();
                                end;
                            end;

                            Table:UpdateButton();
                            Dropdown:Display();

                            if Dropdown.Changed then
                                Dropdown.Changed();
                            end;

                            Library:AttemptSave();
                        end;
                    end;
                end);

                Table:UpdateButton();
                Dropdown:Display();

                Buttons[Button] = Table;
            end;

            local Y = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
            ListOuter.Size = UDim2.new(1, -8, 0, Y);
            Scrolling.CanvasSize = UDim2.new(0, 0, 0, Count * 20);

            -- ListOuter.Size = UDim2.new(1, -8, 0, (#Values * 20) + 2);
        end;

        function Dropdown:OpenDropdown()
            ListOuter.Visible = true;
            Library.OpenedFrames[ListOuter] = true;
            DropdownArrow.Rotation = 180;
        end;

        function Dropdown:CloseDropdown()
            ListOuter.Visible = false;
            Library.OpenedFrames[ListOuter] = nil;
            DropdownArrow.Rotation = 0;
        end;

        function Dropdown:OnChanged(Func)
            Dropdown.Changed = Func;
            Func();
        end;

        function Dropdown:SetValue(Val)
            if Dropdown.Multi then
                local nTable = {};

                for Value, Bool in next, Val do
                    if table.find(Dropdown.Values, Value) then
                        nTable[Value] = true
                    end;
                end;

                Dropdown.Value = nTable;
            else
                if (not Val) then
                    Dropdown.Value = nil;
                elseif table.find(Dropdown.Values, Val) then
                    Dropdown.Value = Val;
                end;
            end;

            Dropdown:SetValues();
            Dropdown:Display();
        end;

        DropdownOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                if ListOuter.Visible then
                    Dropdown:CloseDropdown();
                else
                    Dropdown:OpenDropdown();
                end;
            end;
        end);

        InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    Dropdown:CloseDropdown();
                end;
            end;
        end);

        Dropdown:SetValues();
        Dropdown:Display();

        if type(Info.Default) == 'string' then
            Info.Default = table.find(Dropdown.Values, Info.Default)
        end

        if Info.Default then
            if Info.Multi then
                Dropdown.Value[Dropdown.Values[Info.Default]] = true;
            else
                Dropdown.Value = Dropdown.Values[Info.Default];
            end;

            Dropdown:SetValues();
            Dropdown:Display();
        end;

        Groupbox:AddBlank(Info.BlankSize or 5);
        Groupbox:Resize();

        Options[Idx] = Dropdown;

        return Dropdown;
    end;

    BaseGroupbox.__index = Funcs;
    BaseGroupbox.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

-- < Create other UI elements >
do
    Library.NotificationArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 0, 0, 40);
        Size = UDim2.new(0, 300, 0, 200);
        ZIndex = 100;
        Parent = ScreenGui;
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = Library.NotificationArea;
    });



    local WatermarkOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, -25);
        Size = UDim2.new(0, 213, 0, 20);
        ZIndex = 200;
        Visible = false;
        Parent = ScreenGui;
    });

    local WatermarkInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 201;
        Parent = WatermarkOuter;
    });

    Library:AddToRegistry(WatermarkInner, {
        BorderColor3 = 'AccentColor';
    });

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 202;
        Parent = WatermarkInner;
    });

    Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 52, 52))
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    local WatermarkLabel = Library:CreateLabel({
        Position = UDim2.new(0, 4, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        TextSize = 14;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 203;
        Parent = InnerFrame;
    });

    Library.Watermark = WatermarkOuter;
    Library.WatermarkText = WatermarkLabel;
    Library:MakeDraggable(Library.Watermark);



    local KeybindOuter = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0, 0.5);
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 10, 0.5, 0);
        Size = UDim2.new(0, 210, 0, 20);
        Visible = false;
        ZIndex = 100;
        Parent = ScreenGui;
    });

    local KeybindInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = KeybindOuter;
    });

    Library:AddToRegistry(KeybindInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local ColorFrame = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 0, 2);
        ZIndex = 102;
        Parent = KeybindInner;
    });

    Library:AddToRegistry(ColorFrame, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    local KeybindLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 20);
        Text = 'Keybinds';
        ZIndex = 104;
        Parent = KeybindInner;
    });

    local KeybindContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, -20);
        Position = UDim2.new(0, 0, 0, 20);
        ZIndex = 1;
        Parent = KeybindInner;
    });

    Library:Create('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = KeybindContainer;
    });

    Library.KeybindFrame = KeybindOuter;
    Library.KeybindContainer = KeybindContainer;
    Library:MakeDraggable(KeybindOuter);
end;

function Library:SetWatermarkVisibility(Bool)
    Library.Watermark.Visible = Bool;
end;

function Library:SetWatermark(Text)
    local Size = Library:GetTextBounds(Text, Enum.Font.Code, 14);
    Library.Watermark.Size = UDim2.new(0, Size + 8 + 2, 0, 20);
    Library:SetWatermarkVisibility(true)

    Library.WatermarkText.Text = Text;
end;

function Library:Notify(Text, Time)
    local MaxSize = Library:GetTextBounds(Text, Enum.Font.Code, 14);

    local NotifyOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, 10);
        Size = UDim2.new(0, 0, 0, 20);
        ClipsDescendants = true;
        ZIndex = 100;
        Parent = Library.NotificationArea;
    });

    local NotifyInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(NotifyInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 102;
        Parent = NotifyInner;
    });

    Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 52, 52))
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    local NotifyLabel = Library:CreateLabel({
        Position = UDim2.new(0, 4, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        Text = Text;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextSize = 14;
        ZIndex = 103;
        Parent = InnerFrame;
    });

    local LeftColor = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, -1, 0, -1);
        Size = UDim2.new(0, 3, 1, 2);
        ZIndex = 104;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(LeftColor, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    NotifyOuter:TweenSize(UDim2.new(0, MaxSize + 8 + 4, 0, 20), 'Out', 'Quad', 0.4, true);

    task.spawn(function()
        wait(5 or Time);

        NotifyOuter:TweenSize(UDim2.new(0, 0, 0, 20), 'Out', 'Quad', 0.4, true);

        wait(0.4);

        NotifyOuter:Destroy();
    end);
end;

function Library:CreateWindow(WindowTitle)
    local Window = {
        Tabs = {};
    };

    local Outer = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 175, 0, 50);
        Size = UDim2.new(0, 550, 0, 600);
        Visible = false;
        ZIndex = 1;
        Parent = ScreenGui;
    });

    Library:MakeDraggable(Outer, 25);

    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 1;
        Parent = Outer;
    });

    Library:AddToRegistry(Inner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'AccentColor';
    });

    local WindowLabel = Library:CreateLabel({
        Position = UDim2.new(0, 7, 0, 0);
        Size = UDim2.new(0, 0, 0, 25);
        Text = WindowTitle or '';
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 1;
        Parent = Inner;
    });

    local MainSectionOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 25);
        Size = UDim2.new(1, -16, 1, -33);
        ZIndex = 1;
        Parent = Inner;
    });

    Library:AddToRegistry(MainSectionOuter, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local MainSectionInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Color3.new(0, 0, 0);
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 1;
        Parent = MainSectionOuter;
    });

    Library:AddToRegistry(MainSectionInner, {
        BackgroundColor3 = 'BackgroundColor';
    });

    local TabArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 8, 0, 8);
        Size = UDim2.new(1, -16, 0, 21);
        ZIndex = 1;
        Parent = MainSectionInner;
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 0);
        FillDirection = Enum.FillDirection.Horizontal;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = TabArea;
    });

    local TabContainer = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 30);
        Size = UDim2.new(1, -16, 1, -38);
        ZIndex = 2;
        Parent = MainSectionInner;
    });

    Library:AddToRegistry(TabContainer, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    function Window:SetWindowTitle(Title)
        WindowLabel.Text = Title;
    end;

    function Window:AddTab(Name)
        local Tab = {
            Groupboxes = {};
            Tabboxes = {};
        };

        local TabButtonWidth = Library:GetTextBounds(Name, Enum.Font.Code, 16);

        local TabButton = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            Size = UDim2.new(0, TabButtonWidth + 8 + 4, 1, 0);
            ZIndex = 1;
            Parent = TabArea;
        });

        Library:AddToRegistry(TabButton, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local TabButtonLabel = Library:CreateLabel({
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, -1);
            Text = Name;
            ZIndex = 1;
            Parent = TabButton;
        });

        local Blocker = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 0, 1, 0);
            Size = UDim2.new(1, 0, 0, 1);
            BackgroundTransparency = 1;
            ZIndex = 3;
            Parent = TabButton;
        });

        Library:AddToRegistry(Blocker, {
            BackgroundColor3 = 'MainColor';
        });

        local TabFrame = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            Visible = false;
            ZIndex = 2;
            Parent = TabContainer;
        });

        local LeftSide = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 8, 0, 8);
            Size = UDim2.new(0.5, -12, 0, 507);
            ZIndex = 2;
            Parent = TabFrame;
        });

        local RightSide = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0.5, 4, 0, 8);
            Size = UDim2.new(0.5, -12, 0, 507);
            ZIndex = 2;
            Parent = TabFrame;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = LeftSide;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = RightSide;
        });

        function Tab:ShowTab()
            for _, Tab in next, Window.Tabs do
                Tab:HideTab();
            end;

            Blocker.BackgroundTransparency = 0;
            TabButton.BackgroundColor3 = Library.MainColor;
            TabFrame.Visible = true;
        end;

        function Tab:HideTab()
            Blocker.BackgroundTransparency = 1;
            TabButton.BackgroundColor3 = Library.BackgroundColor;
            TabFrame.Visible = false;
        end;

        function Tab:AddGroupbox(Info)
            local Groupbox = {};

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                Size = UDim2.new(1, 0, 0, 507);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 4;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local GroupboxLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 18);
                Position = UDim2.new(0, 4, 0, 2);
                TextSize = 14;
                Text = Info.Name;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 5;
                Parent = BoxInner;
            });

            local Container = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 4, 0, 20);
                Size = UDim2.new(1, -4, 1, -20);
                ZIndex = 1;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = Container;
            });

            function Groupbox:Resize()
                local Size = 0;

                for _, Element in next, Groupbox.Container:GetChildren() do
                    if not Element:IsA('UIListLayout') then
                        Size = Size + Element.Size.Y.Offset;
                    end;
                end;

                BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2);
            end;

            Groupbox.Container = Container;
            setmetatable(Groupbox, BaseGroupbox);

            Groupbox:AddBlank(3);
            Groupbox:Resize();

            Tab.Groupboxes[Info.Name] = Groupbox;

            return Groupbox;
        end;

        function Tab:AddLeftGroupbox(Name)
            return Tab:AddGroupbox({ Side = 1; Name = Name; });
        end;

        function Tab:AddRightGroupbox(Name)
            return Tab:AddGroupbox({ Side = 2; Name = Name; });
        end;

        function Tab:AddTabbox(Info)
            local Tabbox = {
                Tabs = {};
            };

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                Size = UDim2.new(1, 0, 0, 0);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 4;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 10;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local TabboxButtons = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 1);
                Size = UDim2.new(1, 0, 0, 18);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TabboxButtons;
            });

            function Tabbox:AddTab(Name)
                local Tab = {};

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Color3.new(0, 0, 0);
                    Size = UDim2.new(0.5, 0, 1, 0);
                    ZIndex = 6;
                    Parent = TabboxButtons;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Size = UDim2.new(1, 0, 1, 0);
                    TextSize = 14;
                    Text = Name;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    ZIndex = 7;
                    Parent = Button;
                });

                local Block = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 1);
                    Visible = false;
                    ZIndex = 9;
                    Parent = Button;
                });

                Library:AddToRegistry(Block, {
                    BackgroundColor3 = 'BackgroundColor';
                });

                local Container = Library:Create('Frame', {
                    Position = UDim2.new(0, 4, 0, 20);
                    Size = UDim2.new(1, -4, 1, -20);
                    ZIndex = 1;
                    Visible = false;
                    Parent = BoxInner;
                });

                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = Container;
                });

                function Tab:Show()
                    for _, Tab in next, Tabbox.Tabs do
                        Tab:Hide();
                    end;

                    Container.Visible = true;
                    Block.Visible = true;

                    Button.BackgroundColor3 = Library.BackgroundColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'BackgroundColor';
                end;

                function Tab:Hide()
                    Container.Visible = false;
                    Block.Visible = false;

                    Button.BackgroundColor3 = Library.MainColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'MainColor';
                end;

                function Tab:Resize()
                    local TabCount = 0;

                    for _, Tab in next, Tabbox.Tabs do
                        TabCount = TabCount +  1;
                    end;

                    for _, Button in next, TabboxButtons:GetChildren() do
                        if not Button:IsA('UIListLayout') then
                            Button.Size = UDim2.new(1 / TabCount, 0, 1, 0);
                        end;
                    end;

                    local Size = 0;

                    for _, Element in next, Tab.Container:GetChildren() do
                        if not Element:IsA('UIListLayout') then
                            Size = Size + Element.Size.Y.Offset;
                        end;
                    end;

                    if BoxOuter.Size.Y.Offset < 20 + Size + 2 then
                        BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2);
                    end;
                end;

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                        Tab:Show();
                    end;
                end);

                Tab.Container = Container;
                Tabbox.Tabs[Name] = Tab;

                setmetatable(Tab, BaseGroupbox);

                Tab:AddBlank(3);
                Tab:Resize();

                if #TabboxButtons:GetChildren() == 2 then
                    Tab:Show();
                end;

                return Tab;
            end;

            Tab.Tabboxes[Info.Name or ''] = Tabbox;

            return Tabbox;
        end;

        function Tab:AddLeftTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 1; });
        end;

        function Tab:AddRightTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 2; });
        end;

        TabButton.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Tab:ShowTab();
            end;
        end);

        -- This was the first tab added, so we show it by default.
        if #TabContainer:GetChildren() == 1 then
            Tab:ShowTab();
        end;

        Window.Tabs[Name] = Tab;
        return Tab;
    end;

    local ModalElement = Library:Create('TextButton', {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 0, 0, 0);
        Visible = true;
        Text = '';
        Modal = false;
        Parent = ScreenGui;
    });

    InputService.InputBegan:Connect(function(Input, Processed)
        if Input.KeyCode == Enum.KeyCode.RightControl or (Input.KeyCode == Enum.KeyCode.RightShift and (not Processed)) then
            Outer.Visible = not Outer.Visible;
            ModalElement.Modal = Outer.Visible;

            local oIcon = Mouse.Icon;
            local State = InputService.MouseIconEnabled;

            local Cursor = Drawing.new('Triangle');
            Cursor.Thickness = 1;
            Cursor.Filled = true;

            while Outer.Visible do
                local mPos = workspace.CurrentCamera:WorldToViewportPoint(Mouse.Hit.p);

                Cursor.Color = Library.AccentColor;
                Cursor.PointA = Vector2.new(mPos.X, mPos.Y);
                Cursor.PointB = Vector2.new(mPos.X, mPos.Y) + Vector2.new(6, 14);
                Cursor.PointC = Vector2.new(mPos.X, mPos.Y) + Vector2.new(-6, 14);

                Cursor.Visible = not InputService.MouseIconEnabled;

                RenderStepped:Wait();
            end;

            Cursor:Remove();
        end;
    end);

    Window.Holder = Outer;

    return Window;
end;

return Library;