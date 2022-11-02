--[[

â–‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•—â–‘â–‘â–‘â–‘â–‘â–‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–‘â–‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—
â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•—â•šâ•â•â–ˆâ–ˆâ•”â•â•â•â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–‘â–‘â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•â•â•â•â•
â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•‘â–‘â–‘â–‘â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–‘â–‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•‘â•šâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–‘
â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–‘â–‘â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•‘â–‘â•šâ•â•â•â–ˆâ–ˆâ•—
â–ˆâ–ˆâ•‘â–‘â–‘â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–ˆâ–ˆâ•‘â–‘â–‘â–‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•‘â–‘â–‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•
â•šâ•â•â–‘â–‘â•šâ•â•â–‘â–‘â–‘â•šâ•â•â–‘â–‘â–‘â•šâ•â•â•â•â•â•â•â•šâ•â•â–‘â–‘â•šâ•â•â•šâ•â•â•â•â•â•â–‘

Made by RoadToGlory#9879
Join: https://discord.gg/xu5dDS3Pb9

]]

local VERSION = "1.1"

-- LURAPH (if i left it enabled)
if not LPH_OBFUSCATED then
    local function r(...)
        return ...
    end
    LPH_JIT_MAX = r
    LPH_NO_VIRTUALIZE = r
    LPH_JIT = r
end

-- SERVICES
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local Run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Core = game:GetService("CoreGui")
local MP = game:GetService("MarketplaceService")

-- VARIABLES
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- CLASSES
local Library = {}
local Page = {}
local Section = {}
local Element = {}

Library.__index = Library
Page.__index = Page
Section.__index = Section
Element.__index = Element

-- CONSTANTS
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- ICONS
Library.Icons = {
    ["Warning"] = 11110093949;
    ["Info"] = 11109991278;
    ["Error"] = 11109992284
}

local old_warn = warn
local warn = function(...)
    old_warn("[ATLAS]",...)
end

-- UTILITY
local utility = {}

do
    function utility.BlankFunction()
    end

    function utility:Lerp(start,goal,alpha)
        return start+(goal-start)*alpha
    end

    function utility:Warn(...)
        warn("ARTEMIS:", ...)
    end

    function utility:Wait()
        return Run.RenderStepped:Wait()
    end

    function utility:Disconnect(connection)
        pcall(function()
            connection:Disconnect()
        end)
    end

    function utility:HandleGradientButton(element,callback)
        element.Active = true
        local button = element
        local gradient = element:FindFirstChildOfClass("UIGradient")

        button.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 then
                gradient.Rotation = 90
            end
        end)

        button.MouseLeave:Connect(function()
            gradient.Rotation = -90
        end)

        local con = UIS.InputEnded:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 then
                if gradient.Rotation == 90 then
                    coroutine.wrap(callback)()
                end
                gradient.Rotation = -90
            end
        end)

        return con -- for proper destroying and to prevent memory leaks
    end

    function utility:FormatNumber(number,decimalPlaces)
        if not typeof(number)=="number" then
            error("Arg 1 must be a number")
        end
        decimalPlaces = math.clamp(decimalPlaces,0,math.huge)
        local exp = 10^decimalPlaces
        number = math.round(number*exp)/exp
        local formatted = number
        LPH_JIT_MAX(function()
            while true do
                local k
                formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
                if (k==0) then
                    break
                end
            end
        end)()
        return formatted
    end

    function utility:IsPadding(element)
        return element:IsA("Frame") and string.lower(element.Name):find("padding")
    end

    function utility:DoClickEffect(element)
        local function makeEffect()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["__buttonEffect"] = Instance.new("Frame");
                ["_ImageLabel"] = Instance.new("ImageLabel");
            }

            --Properties

            Converted["__buttonEffect"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["__buttonEffect"].BackgroundTransparency = 1
            Converted["__buttonEffect"].ClipsDescendants = true
            Converted["__buttonEffect"].Size = UDim2.new(1, 0, 1, 0)
            Converted["__buttonEffect"].ZIndex = 0
            Converted["__buttonEffect"].Name = "_buttonEffect"

            Converted["_ImageLabel"].Image = "http://www.roblox.com/asset/?id=10261338527"
            Converted["_ImageLabel"].ImageRectSize = Vector2.new(200, 200)
            Converted["_ImageLabel"].ImageTransparency = 0.8999999761581421
            Converted["_ImageLabel"].ScaleType = Enum.ScaleType.Crop
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0, 0, 0, 0)
            Converted["_ImageLabel"].Size = UDim2.new(0, 0, 1, 0)
            Converted["_ImageLabel"].Parent = Converted["__buttonEffect"]

            return Converted["__buttonEffect"]
        end

        local effect = makeEffect()
        effect.Parent = element

        local corner = element:FindFirstChildOfClass("UICorner")
        if corner then
            corner:Clone().Parent = effect
        end

        local tweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0)

        local realAbsPosition = Vector2.new(element.AbsolutePosition.X-(element.AbsoluteSize.X*element.AnchorPoint.X),element.AbsolutePosition.Y-(element.AbsoluteSize.Y*element.AnchorPoint.Y))
        local relative = Vector2.new(mouse.X,mouse.Y)-realAbsPosition

        effect.ImageLabel.Position = UDim2.new(0,relative.X,0.5,0)
        effect.ImageLabel.ImageRectOffset = Vector2.new(0,-relative.Y)

        local tween = TS:Create(effect.ImageLabel,tweenInfo,{
            ["Size"] = UDim2.new(0,375,1,0);
            ["ImageTransparency"] = 1;
        })

        tween:Play()

        tween.Completed:Connect(function()
            effect:Destroy()
        end)

        return tween
    end

    function utility:GetColor(percentage, ColorKeyPoints)
        if (percentage < 0) or (percentage>1) then
            utility:Warn('getColor got out of bounds percentage (less than 0 or greater than 1')
        end
        
        local closestToLeft = ColorKeyPoints[1]
        local closestToRight = ColorKeyPoints[#ColorKeyPoints]
        local LocalPercentage = .5
        local color = closestToLeft.Value
        
        -- This loop can probably be improved by doing something like a Binary search instead
        -- This should work fine though
        for i=1,#ColorKeyPoints-1 do
            if (ColorKeyPoints[i].Time <= percentage) and (ColorKeyPoints[i+1].Time >= percentage) then
                closestToLeft = ColorKeyPoints[i]
                closestToRight = ColorKeyPoints[i+1]
                LocalPercentage = (percentage-closestToLeft.Time)/(closestToRight.Time-closestToLeft.Time)
                color = closestToLeft.Value:lerp(closestToRight.Value,LocalPercentage)
                return color
            end
        end
        utility:Warn('Color not found!')
        return color
    end

    function utility:CreateButtonObject(obj)
        -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
        local Converted = {
            ["_Button"] = Instance.new("TextButton");
        }

        --Properties

        Converted["_Button"].Font = Enum.Font.SourceSans
        Converted["_Button"].Text = ""
        Converted["_Button"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Converted["_Button"].TextSize = 14
        Converted["_Button"].AnchorPoint = Vector2.new(0.5, 0.5)
        Converted["_Button"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Converted["_Button"].BackgroundTransparency = 1
        Converted["_Button"].Position = UDim2.new(0.5, 0, 0.5, 0)
        Converted["_Button"].Size = UDim2.new(1, 0, 1, 0)
        Converted["_Button"].Name = "Button"
        Converted["_Button"].Parent = obj -- modified

        return Converted["_Button"]
    end

    function utility:CreateHint()
        -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
        local Converted = {
            ["_Hint"] = Instance.new("StringValue");
        }

        --Properties

        Converted["_Hint"].Value = "Hint"
        Converted["_Hint"].Name = "Hint"

        return Converted["_Hint"]
    end

    function utility:GetPlayerThumbnail(UserId)
        return "rbxthumb://type=AvatarHeadShot&id="..UserId.."&w=420&h=420"
    end

    function utility:GetGameThumbnail(placeId) -- use in studio
        local thumbnailId = MP:GetProductInfo(placeId).IconImageAssetId
        return "rbxassetid://"..thumbnailId
    end

    function utility:SetModal(obj)
        local m = Instance.new("TextButton")
        m.Text = ""
        m.BackgroundTransparency = 1
        m.Modal = true
        m.TextTransparency = 1
        m.Size = UDim2.fromOffset(1,1)
        m.ZIndex = -25
        m.Visible = true
        m.Active = true
        m.AutoButtonColor = false
        m.Name = "__modal"
        m.Parent = obj
        return obj
    end

    function utility:Tween(object,properties,duration,...)
        assert(object and properties and duration,"Missing arguments for utility::Tween")
        local tween = TS:Create(object,TweenInfo.new(duration,...),properties)
        tween:Play()
        return tween
    end

    function utility:GetTextContrast(color)
        local r,g,b = color.R*255,color.G*255,color.B*255
        return (((r * 0.299) + (g * 0.587) + (b * 0.114)) > 150) and Color3.new(0,0,0) or Color3.new(1,1,1)
    end

    function utility:InitDragging(frame,button)
        button = button or frame

        assert(button and frame,"Need a frame in order to start dragging")

        -- dragging
        local _dragging = false
        local _dragging_offset

        local inputBegan = button.MouseButton1Down:Connect(function()
            _dragging = true
            _dragging_offset = Vector2.new(mouse.X,mouse.Y)-frame.AbsolutePosition
        end)

        local inputEnded = mouse.Button1Up:Connect(function()
            _dragging = false
            _dragging_offset = nil
        end)

        local updateEvent
        LPH_JIT_MAX(function()
            updateEvent = Run.RenderStepped:Connect(function()
                if frame.Visible == false or not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    _dragging = false
                    _dragging_offset = nil
                end
                if _dragging and _dragging_offset then
                    frame.Position = UDim2.fromOffset(mouse.X-_dragging_offset.X+(frame.AbsoluteSize.X*frame.AnchorPoint.X),mouse.Y-_dragging_offset.Y+36+(frame.AbsoluteSize.Y*frame.AnchorPoint.Y))
                end
            end)
        end)()

        return {inputBegan,inputEnded,updateEvent}
    end

    function utility:HandleButton(button,callback)
        
    end

    function utility:Requirement(arg,errorResponse)
        if not arg then
            error(errorResponse)
        end
    end
end

-- LIBRARY
do
    function Library.new(info)
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing config folder argument")
        if info.Color==nil then
            info.Color = Color3.fromRGB(164, 53, 90)
        end
        if info.Credit==nil then
            info.Credit = "Made with love <3"
        end
        info.FullName = info.FullName or info.Name

        local function makeLoader()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_Loader"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_GameThumbnail"] = Instance.new("ImageLabel");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_UIGradient"] = Instance.new("UIGradient");
                ["_Main"] = Instance.new("Frame");
                ["_No"] = Instance.new("Frame");
                ["_UICorner2"] = Instance.new("UICorner");
                ["_UIStroke"] = Instance.new("UIStroke");
                ["_UIGradient1"] = Instance.new("UIGradient");
                ["_TextLabel"] = Instance.new("TextLabel");
                ["_Yes"] = Instance.new("Frame");
                ["_UICorner3"] = Instance.new("UICorner");
                ["_UIStroke1"] = Instance.new("UIStroke");
                ["_TextLabel1"] = Instance.new("TextLabel");
                ["_UIGradient2"] = Instance.new("UIGradient");
                ["_GameName"] = Instance.new("TextLabel");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Message"] = Instance.new("TextLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("TextLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Shadow"] = Instance.new("Frame");
                ["_ImageLabel1"] = Instance.new("ImageLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Key"] = Instance.new("Frame");
                ["_Input"] = Instance.new("Frame");
                ["_UICorner4"] = Instance.new("UICorner");
                ["_UIStroke2"] = Instance.new("UIStroke");
                ["_TextBox"] = Instance.new("TextBox");
                ["_ImageLabel2"] = Instance.new("ImageLabel");
                ["_Message1"] = Instance.new("TextLabel");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme6"] = Instance.new("StringValue");
                ["_Category6"] = Instance.new("StringValue");
                ["_Ignore6"] = Instance.new("BoolValue");
                ["_Directions"] = Instance.new("TextLabel");
                ["_Theme7"] = Instance.new("StringValue");
                ["_Category7"] = Instance.new("StringValue");
                ["_Ignore7"] = Instance.new("BoolValue");
                ["_Interact"] = Instance.new("Frame");
                ["_Button"] = Instance.new("Frame");
                ["_UICorner5"] = Instance.new("UICorner");
                ["_UIStroke3"] = Instance.new("UIStroke");
                ["_UIGradient3"] = Instance.new("UIGradient");
                ["_TextLabel2"] = Instance.new("TextLabel");
                ["_UISizeConstraint"] = Instance.new("UISizeConstraint");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_0_padding"] = Instance.new("Frame");
                ["_padding"] = Instance.new("Frame");
                ["_ImageLabel3"] = Instance.new("ImageLabel");
                ["_Profile"] = Instance.new("Frame");
                ["_Title2"] = Instance.new("TextLabel");
                ["_Theme8"] = Instance.new("StringValue");
                ["_Category8"] = Instance.new("StringValue");
                ["_Ignore8"] = Instance.new("BoolValue");
                ["_Player"] = Instance.new("Frame");
                ["_Gradient"] = Instance.new("Frame");
                ["_UICorner6"] = Instance.new("UICorner");
                ["_UIGradient4"] = Instance.new("UIGradient");
                ["_UIStroke4"] = Instance.new("UIStroke");
                ["_UICorner7"] = Instance.new("UICorner");
                ["_Thumbnail"] = Instance.new("ImageLabel");
                ["_UICorner8"] = Instance.new("UICorner");
                ["_PlayerName"] = Instance.new("Frame");
                ["_TextLabel3"] = Instance.new("TextLabel");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_ImageLabel4"] = Instance.new("ImageLabel");
                ["_Rank"] = Instance.new("Frame");
                ["_TextLabel4"] = Instance.new("TextLabel");
                ["_UIListLayout2"] = Instance.new("UIListLayout");
                ["_Close"] = Instance.new("ImageLabel");
                ["_Theme9"] = Instance.new("StringValue");
                ["_Category9"] = Instance.new("StringValue");
                ["_Ignore9"] = Instance.new("BoolValue");
            }

            --Properties

            Converted["_Loader"].AnchorPoint = Vector2.new(1, 1)
            Converted["_Loader"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Loader"].Position = UDim2.new(1, -20, 1, -20)
            Converted["_Loader"].Size = UDim2.new(0, 280, 0, 127)
            Converted["_Loader"].Name = "Loader"
            Converted["_Loader"].Parent = game:GetService("CoreGui")

            Converted["_UICorner"].CornerRadius = UDim.new(0, 6)
            Converted["_UICorner"].Parent = Converted["_Loader"]

            Converted["_Theme"].Value = "BackgroundColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Loader"]

            Converted["_Category"].Value = "Notification"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_GameThumbnail"].Image = "https://www.roblox.com/asset-thumbnail/image?assetId=5670218884&width=768&height=432&format=png"
            Converted["_GameThumbnail"].ImageTransparency = 0.8
            Converted["_GameThumbnail"].ScaleType = Enum.ScaleType.Crop
            Converted["_GameThumbnail"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_GameThumbnail"].BackgroundTransparency = 1
            Converted["_GameThumbnail"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_GameThumbnail"].Name = "GameThumbnail"
            Converted["_GameThumbnail"].Parent = Converted["_Loader"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 6)
            Converted["_UICorner1"].Parent = Converted["_GameThumbnail"]

            Converted["_UIGradient"].Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 0.543749988079071)
            }
            Converted["_UIGradient"].Parent = Converted["_GameThumbnail"]

            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].ClipsDescendants = true
            Converted["_Main"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Loader"]

            Converted["_No"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_No"].Position = UDim2.new(0, 154, 0, 92)
            Converted["_No"].Size = UDim2.new(0, 85, 0, 24)
            Converted["_No"].Name = "No"
            Converted["_No"].Parent = Converted["_Main"]

            Converted["_UICorner2"].CornerRadius = UDim.new(0, 5)
            Converted["_UICorner2"].Parent = Converted["_No"]

            Converted["_UIStroke"].Color = Color3.fromRGB(255, 43.00000123679638, 43.00000123679638)
            Converted["_UIStroke"].Parent = Converted["_No"]

            Converted["_UIGradient1"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73.00000324845314, 73.00000324845314)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(144.00000661611557, 47.0000009983778, 47.0000009983778))
            }
            Converted["_UIGradient1"].Rotation = -90
            Converted["_UIGradient1"].Parent = Converted["_No"]

            Converted["_TextLabel"].Font = Enum.Font.GothamMedium
            Converted["_TextLabel"].Text = "Don't Load"
            Converted["_TextLabel"].TextColor3 = Color3.fromRGB(225.00001698732376, 225.00001698732376, 225.00001698732376)
            Converted["_TextLabel"].TextSize = 14
            Converted["_TextLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextLabel"].BackgroundTransparency = 1
            Converted["_TextLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_TextLabel"].Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
            Converted["_TextLabel"].Parent = Converted["_No"]

            Converted["_Yes"].AnchorPoint = Vector2.new(1, 0)
            Converted["_Yes"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Yes"].Position = UDim2.new(0, 125, 0, 92)
            Converted["_Yes"].Size = UDim2.new(0, 85, 0, 24)
            Converted["_Yes"].Name = "Yes"
            Converted["_Yes"].Parent = Converted["_Main"]

            Converted["_UICorner3"].CornerRadius = UDim.new(0, 5)
            Converted["_UICorner3"].Parent = Converted["_Yes"]

            Converted["_UIStroke1"].Color = Color3.fromRGB(12.000000234693289, 129.00000751018524, 255)
            Converted["_UIStroke1"].Parent = Converted["_Yes"]

            Converted["_TextLabel1"].Font = Enum.Font.GothamMedium
            Converted["_TextLabel1"].Text = "Load"
            Converted["_TextLabel1"].TextColor3 = Color3.fromRGB(225.00001698732376, 225.00001698732376, 225.00001698732376)
            Converted["_TextLabel1"].TextSize = 14
            Converted["_TextLabel1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_TextLabel1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextLabel1"].BackgroundTransparency = 1
            Converted["_TextLabel1"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_TextLabel1"].Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
            Converted["_TextLabel1"].Parent = Converted["_Yes"]

            Converted["_UIGradient2"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(12.000000234693289, 129.00000751018524, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(21.000000648200512, 72.00000330805779, 116.00000068545341))
            }
            Converted["_UIGradient2"].Rotation = -90
            Converted["_UIGradient2"].Parent = Converted["_Yes"]

            Converted["_GameName"].Font = Enum.Font.Gotham
            Converted["_GameName"].Text = "[âš”] item asylum"
            Converted["_GameName"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_GameName"].TextSize = 13
            Converted["_GameName"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_GameName"].TextWrapped = true
            Converted["_GameName"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_GameName"].TextYAlignment = Enum.TextYAlignment.Top
            Converted["_GameName"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_GameName"].BackgroundTransparency = 1
            Converted["_GameName"].Position = UDim2.new(0, 12, 0, 44)
            Converted["_GameName"].Size = UDim2.new(0, 257, 0, 13)
            Converted["_GameName"].Name = "GameName"
            Converted["_GameName"].Parent = Converted["_Main"]

            Converted["_Theme1"].Value = "TextColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_GameName"]

            Converted["_Category1"].Value = "Symbols"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Message"].Font = Enum.Font.GothamMedium
            Converted["_Message"].Text = "Script: AWP Script Hub"
            Converted["_Message"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Message"].TextSize = 13
            Converted["_Message"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Message"].TextWrapped = true
            Converted["_Message"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Message"].TextYAlignment = Enum.TextYAlignment.Top
            Converted["_Message"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Message"].BackgroundTransparency = 1
            Converted["_Message"].Position = UDim2.new(0, 12, 0, 68)
            Converted["_Message"].Size = UDim2.new(0, 257, 0, 13)
            Converted["_Message"].Name = "Message"
            Converted["_Message"].Parent = Converted["_Main"]

            Converted["_Theme2"].Value = "TextColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Message"]

            Converted["_Category2"].Value = "Symbols"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Title"].Font = Enum.Font.GothamBold
            Converted["_Title"].Text = "Game Detected"
            Converted["_Title"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title"].TextSize = 18
            Converted["_Title"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title"].TextWrapped = true
            Converted["_Title"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0, 44, 0, 8)
            Converted["_Title"].Size = UDim2.new(0, 224, 0, 31)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Main"]

            Converted["_Theme3"].Value = "TextColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Title"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_ImageLabel"].Image = "rbxassetid://11117108054"
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0, 12, 0, 23)
            Converted["_ImageLabel"].Size = UDim2.new(0, 24, 0, 24)
            Converted["_ImageLabel"].Parent = Converted["_Main"]

            Converted["_Shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Shadow"].BackgroundTransparency = 1
            Converted["_Shadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Shadow"].Size = UDim2.new(1, 55, 1, 55)
            Converted["_Shadow"].ZIndex = 0
            Converted["_Shadow"].Name = "Shadow"
            Converted["_Shadow"].Parent = Converted["_Loader"]

            Converted["_ImageLabel1"].Image = "rbxassetid://10955010523"
            Converted["_ImageLabel1"].ImageColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ImageLabel1"].ImageTransparency = 0.550000011920929
            Converted["_ImageLabel1"].ScaleType = Enum.ScaleType.Slice
            Converted["_ImageLabel1"].SliceCenter = Rect.new(60, 60, 360, 360)
            Converted["_ImageLabel1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel1"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ImageLabel1"].BackgroundTransparency = 1
            Converted["_ImageLabel1"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel1"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ImageLabel1"].ZIndex = 0
            Converted["_ImageLabel1"].Parent = Converted["_Shadow"]

            Converted["_Theme4"].Value = "ImageColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_ImageLabel1"]

            Converted["_Category4"].Value = "Shadow"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Key"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Key"].BackgroundTransparency = 1
            Converted["_Key"].ClipsDescendants = true
            Converted["_Key"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Key"].Visible = false
            Converted["_Key"].Name = "Key"
            Converted["_Key"].Parent = Converted["_Loader"]

            Converted["_Input"].AnchorPoint = Vector2.new(1, 0)
            Converted["_Input"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Input"].Position = UDim2.new(0, 269, 0, 94)
            Converted["_Input"].Size = UDim2.new(0, 257, 0, 24)
            Converted["_Input"].Name = "Input"
            Converted["_Input"].Parent = Converted["_Key"]

            Converted["_UICorner4"].CornerRadius = UDim.new(0, 5)
            Converted["_UICorner4"].Parent = Converted["_Input"]

            Converted["_UIStroke2"].Color = Color3.fromRGB(49.000004678964615, 49.000004678964615, 49.000004678964615)
            Converted["_UIStroke2"].Parent = Converted["_Input"]

            Converted["_TextBox"].Font = Enum.Font.Gotham
            Converted["_TextBox"].Text = ""
            Converted["_TextBox"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_TextBox"].TextSize = 14
            Converted["_TextBox"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_TextBox"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_TextBox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextBox"].BackgroundTransparency = 1
            Converted["_TextBox"].Position = UDim2.new(0.0311284047, 0, 0, 0)
            Converted["_TextBox"].Size = UDim2.new(0.968871593, -24, 1, 0)
            Converted["_TextBox"].Parent = Converted["_Input"]

            Converted["_ImageLabel2"].Image = "rbxassetid://11116814746"
            Converted["_ImageLabel2"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel2"].BackgroundTransparency = 1
            Converted["_ImageLabel2"].Position = UDim2.new(1, -12, 0.5, 0)
            Converted["_ImageLabel2"].Size = UDim2.new(0, 21, 0, 21)
            Converted["_ImageLabel2"].Parent = Converted["_Input"]

            Converted["_Message1"].Font = Enum.Font.Gotham
            Converted["_Message1"].Text = "The key is in the discord server. Copy the  invite by pressing the button above."
            Converted["_Message1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Message1"].TextScaled = true
            Converted["_Message1"].TextSize = 1
            Converted["_Message1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Message1"].TextWrapped = true
            Converted["_Message1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Message1"].TextYAlignment = Enum.TextYAlignment.Top
            Converted["_Message1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Message1"].BackgroundTransparency = 1
            Converted["_Message1"].Position = UDim2.new(0, 12, 0, 40)
            Converted["_Message1"].Size = UDim2.new(0, 257, 0, 35)
            Converted["_Message1"].Name = "Message"
            Converted["_Message1"].Parent = Converted["_Key"]

            Converted["_Theme5"].Value = "TextColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_Message1"]

            Converted["_Category5"].Value = "Symbols"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Title1"].Font = Enum.Font.GothamBold
            Converted["_Title1"].Text = "Key System"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 18
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Position = UDim2.new(0, 12, 0, 8)
            Converted["_Title1"].Size = UDim2.new(0, 102, 0, 31)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Key"]

            Converted["_Theme6"].Value = "TextColor3"
            Converted["_Theme6"].Name = "Theme"
            Converted["_Theme6"].Parent = Converted["_Title1"]

            Converted["_Category6"].Value = "Symbols"
            Converted["_Category6"].Name = "Category"
            Converted["_Category6"].Parent = Converted["_Theme6"]

            Converted["_Ignore6"].Name = "Ignore"
            Converted["_Ignore6"].Parent = Converted["_Theme6"]

            Converted["_Directions"].Font = Enum.Font.GothamMedium
            Converted["_Directions"].Text = "Enter key below"
            Converted["_Directions"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Directions"].TextSize = 13
            Converted["_Directions"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Directions"].TextWrapped = true
            Converted["_Directions"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Directions"].TextYAlignment = Enum.TextYAlignment.Top
            Converted["_Directions"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Directions"].BackgroundTransparency = 1
            Converted["_Directions"].Position = UDim2.new(0, 12, 0, 75)
            Converted["_Directions"].Size = UDim2.new(0, 257, 0, 15)
            Converted["_Directions"].Name = "Directions"
            Converted["_Directions"].Parent = Converted["_Key"]

            Converted["_Theme7"].Value = "TextColor3"
            Converted["_Theme7"].Name = "Theme"
            Converted["_Theme7"].Parent = Converted["_Directions"]

            Converted["_Category7"].Value = "Symbols"
            Converted["_Category7"].Name = "Category"
            Converted["_Category7"].Parent = Converted["_Theme7"]

            Converted["_Ignore7"].Name = "Ignore"
            Converted["_Ignore7"].Parent = Converted["_Theme7"]

            Converted["_Interact"].AnchorPoint = Vector2.new(1, 0)
            Converted["_Interact"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Interact"].BackgroundTransparency = 1
            Converted["_Interact"].Position = UDim2.new(0, 268, 0, 12)
            Converted["_Interact"].Size = UDim2.new(0, 147, 0, 21)
            Converted["_Interact"].Name = "Interact"
            Converted["_Interact"].Parent = Converted["_Key"]

            Converted["_Button"].AnchorPoint = Vector2.new(1, 0)
            Converted["_Button"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Button"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Button"].ClipsDescendants = true
            Converted["_Button"].Position = UDim2.new(1, 0, 0, 0)
            Converted["_Button"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Button"].Name = "Button"
            Converted["_Button"].Parent = Converted["_Interact"]

            Converted["_UICorner5"].CornerRadius = UDim.new(0, 5)
            Converted["_UICorner5"].Parent = Converted["_Button"]

            Converted["_UIStroke3"].Color = Color3.fromRGB(12.000000234693289, 129.00000751018524, 255)
            Converted["_UIStroke3"].Parent = Converted["_Button"]

            Converted["_UIGradient3"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(12.000000234693289, 129.00000751018524, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(21.000000648200512, 72.00000330805779, 116.00000068545341))
            }
            Converted["_UIGradient3"].Rotation = -90
            Converted["_UIGradient3"].Parent = Converted["_Button"]

            Converted["_TextLabel2"].Font = Enum.Font.Gotham
            Converted["_TextLabel2"].Text = "Copied"
            Converted["_TextLabel2"].TextColor3 = Color3.fromRGB(225.00001698732376, 225.00001698732376, 225.00001698732376)
            Converted["_TextLabel2"].TextSize = 13
            Converted["_TextLabel2"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_TextLabel2"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_TextLabel2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextLabel2"].BackgroundTransparency = 1
            Converted["_TextLabel2"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_TextLabel2"].Size = UDim2.new(0, 1, 0.5, 0)
            Converted["_TextLabel2"].Parent = Converted["_Button"]

            Converted["_UISizeConstraint"].MaxSize = Vector2.new(147, math.huge)
            Converted["_UISizeConstraint"].Parent = Converted["_TextLabel2"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 4)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_Button"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_Button"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_Button"]

            Converted["_ImageLabel3"].Image = "http://www.roblox.com/asset/?id=10954923256"
            Converted["_ImageLabel3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel3"].BackgroundTransparency = 1
            Converted["_ImageLabel3"].Size = UDim2.new(0, 18, 0, 18)
            Converted["_ImageLabel3"].Parent = Converted["_Button"]

            Converted["_Profile"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Profile"].BackgroundTransparency = 1
            Converted["_Profile"].ClipsDescendants = true
            Converted["_Profile"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Profile"].Visible = false
            Converted["_Profile"].Name = "Profile"
            Converted["_Profile"].Parent = Converted["_Loader"]

            Converted["_Title2"].Font = Enum.Font.GothamBold
            Converted["_Title2"].Text = "Welcome back."
            Converted["_Title2"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title2"].TextSize = 18
            Converted["_Title2"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title2"].TextWrapped = true
            Converted["_Title2"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title2"].BackgroundTransparency = 1
            Converted["_Title2"].Position = UDim2.new(0, 12, 0, 8)
            Converted["_Title2"].Size = UDim2.new(0, 224, 0, 31)
            Converted["_Title2"].Name = "Title"
            Converted["_Title2"].Parent = Converted["_Profile"]

            Converted["_Theme8"].Value = "TextColor3"
            Converted["_Theme8"].Name = "Theme"
            Converted["_Theme8"].Parent = Converted["_Title2"]

            Converted["_Category8"].Value = "Symbols"
            Converted["_Category8"].Name = "Category"
            Converted["_Category8"].Parent = Converted["_Theme8"]

            Converted["_Ignore8"].Name = "Ignore"
            Converted["_Ignore8"].Parent = Converted["_Theme8"]

            Converted["_Player"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Player"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Player"].BorderSizePixel = 0
            Converted["_Player"].Position = UDim2.new(0, 140, 0, 77)
            Converted["_Player"].Size = UDim2.new(0, 245, 0, 71)
            Converted["_Player"].Name = "Player"
            Converted["_Player"].Parent = Converted["_Profile"]

            Converted["_Gradient"].BackgroundColor3 = Color3.fromRGB(0, 170.0000050663948, 255)
            Converted["_Gradient"].BorderSizePixel = 0
            Converted["_Gradient"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Gradient"].ZIndex = 0
            Converted["_Gradient"].Name = "Gradient"
            Converted["_Gradient"].Parent = Converted["_Player"]

            Converted["_UICorner6"].CornerRadius = UDim.new(0, 7)
            Converted["_UICorner6"].Parent = Converted["_Gradient"]

            Converted["_UIGradient4"].Offset = Vector2.new(-0.5, 0)
            Converted["_UIGradient4"].Rotation = 35
            Converted["_UIGradient4"].Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.22499996423721313),
                NumberSequenceKeypoint.new(1, 1)
            }
            Converted["_UIGradient4"].Parent = Converted["_Gradient"]

            Converted["_UIStroke4"].Color = Color3.fromRGB(48.00000473856926, 48.00000473856926, 48.00000473856926)
            Converted["_UIStroke4"].Parent = Converted["_Gradient"]

            Converted["_UICorner7"].CornerRadius = UDim.new(0, 7)
            Converted["_UICorner7"].Parent = Converted["_Player"]

            Converted["_Thumbnail"].Image = "rbxthumb://type=AvatarHeadShot&id=2755663001&w=420&h=420"
            Converted["_Thumbnail"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Thumbnail"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Thumbnail"].BackgroundTransparency = 0.75
            Converted["_Thumbnail"].Position = UDim2.new(0, 7, 0.5, 0)
            Converted["_Thumbnail"].Size = UDim2.new(0, 57, 0, 57)
            Converted["_Thumbnail"].Name = "Thumbnail"
            Converted["_Thumbnail"].Parent = Converted["_Player"]

            Converted["_UICorner8"].CornerRadius = UDim.new(1, 0)
            Converted["_UICorner8"].Parent = Converted["_Thumbnail"]

            Converted["_PlayerName"].AnchorPoint = Vector2.new(0, 1)
            Converted["_PlayerName"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_PlayerName"].BackgroundTransparency = 1
            Converted["_PlayerName"].Position = UDim2.new(0.298000008, 0, 0.550000012, 3)
            Converted["_PlayerName"].Size = UDim2.new(0, 159, 0, 30)
            Converted["_PlayerName"].Name = "PlayerName"
            Converted["_PlayerName"].Parent = Converted["_Player"]

            Converted["_TextLabel3"].Font = Enum.Font.GothamBold
            Converted["_TextLabel3"].Text = "TrojanHorse57"
            Converted["_TextLabel3"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_TextLabel3"].TextSize = 16
            Converted["_TextLabel3"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_TextLabel3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextLabel3"].BackgroundTransparency = 1
            Converted["_TextLabel3"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_TextLabel3"].Parent = Converted["_PlayerName"]

            Converted["_UIListLayout1"].Padding = UDim.new(0, 4)
            Converted["_UIListLayout1"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Center
            Converted["_UIListLayout1"].Parent = Converted["_PlayerName"]

            Converted["_ImageLabel4"].Image = "http://www.roblox.com/asset/?id=11117540300"
            Converted["_ImageLabel4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel4"].BackgroundTransparency = 1
            Converted["_ImageLabel4"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_ImageLabel4"].Parent = Converted["_PlayerName"]

            Converted["_Rank"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Rank"].BackgroundTransparency = 1
            Converted["_Rank"].Position = UDim2.new(0.298000008, 0, 0.524999976, 3)
            Converted["_Rank"].Size = UDim2.new(0, 159, 0, 30)
            Converted["_Rank"].Name = "Rank"
            Converted["_Rank"].Parent = Converted["_Player"]

            Converted["_TextLabel4"].Font = Enum.Font.GothamMedium
            Converted["_TextLabel4"].Text = "Developer"
            Converted["_TextLabel4"].TextColor3 = Color3.fromRGB(164.00000542402267, 164.00000542402267, 164.00000542402267)
            Converted["_TextLabel4"].TextSize = 13
            Converted["_TextLabel4"].TextYAlignment = Enum.TextYAlignment.Top
            Converted["_TextLabel4"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_TextLabel4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextLabel4"].BackgroundTransparency = 1
            Converted["_TextLabel4"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_TextLabel4"].Parent = Converted["_Rank"]

            Converted["_UIListLayout2"].Padding = UDim.new(0, 4)
            Converted["_UIListLayout2"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout2"].VerticalAlignment = Enum.VerticalAlignment.Center
            Converted["_UIListLayout2"].Parent = Converted["_Rank"]

            Converted["_Close"].Image = "http://www.roblox.com/asset/?id=10259890025"
            Converted["_Close"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Close"].AnchorPoint = Vector2.new(1, 0)
            Converted["_Close"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Close"].BackgroundTransparency = 1
            Converted["_Close"].Position = UDim2.new(0, 273, 0, 7)
            Converted["_Close"].Size = UDim2.new(0, 23, 0, 23)
            Converted["_Close"].Name = "Close"
            Converted["_Close"].Parent = Converted["_Profile"]

            Converted["_Theme9"].Value = "ImageColor3"
            Converted["_Theme9"].Name = "Theme"
            Converted["_Theme9"].Parent = Converted["_Close"]

            Converted["_Category9"].Value = "Symbols"
            Converted["_Category9"].Name = "Category"
            Converted["_Category9"].Parent = Converted["_Theme9"]

            Converted["_Ignore9"].Name = "Ignore"
            Converted["_Ignore9"].Parent = Converted["_Theme9"]

            return Converted["_Loader"]
        end

        if info.CheckKey then
            info.UseLoader = true
        end

        info.Rank = info.Rank or "User"
        info.RankColor = info.RankColor or Color3.new(0,1,0)

        if info.CheckKey and not info.Discord then
            warn("You must include a discord argument when using check key argument!")
            wait(9e9)
            error()
        end

        local function makeLibrary()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_Atlas"] = Instance.new("ScreenGui");
                ["_UI_Library"] = Instance.new("Folder");
                ["_Name"] = Instance.new("StringValue");
                ["_Creator"] = Instance.new("StringValue");
                ["_Discord"] = Instance.new("StringValue");
                ["_Main"] = Instance.new("Frame");
                ["_Contents"] = Instance.new("Frame");
                ["_Appearance"] = Instance.new("Frame");
                ["_Fade"] = Instance.new("Frame");
                ["_UIGradient"] = Instance.new("UIGradient");
                ["_Top"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Line"] = Instance.new("Frame");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Top_fill"] = Instance.new("Frame");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Top1"] = Instance.new("Frame");
                ["_Close"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Menu"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint1"] = Instance.new("UIAspectRatioConstraint");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("TextLabel");
                ["_UISizeConstraint"] = Instance.new("UISizeConstraint");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Info"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint2"] = Instance.new("UIAspectRatioConstraint");
                ["_Credits"] = Instance.new("Frame");
                ["_Main1"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Frame"] = Instance.new("Frame");
                ["_B"] = Instance.new("TextLabel");
                ["_A"] = Instance.new("TextLabel");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_padding"] = Instance.new("Frame");
                ["_0_padding"] = Instance.new("Frame");
                ["_Arrow"] = Instance.new("ImageLabel");
                ["_Theme6"] = Instance.new("StringValue");
                ["_Category6"] = Instance.new("StringValue");
                ["_Ignore6"] = Instance.new("BoolValue");
                ["_Search"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint3"] = Instance.new("UIAspectRatioConstraint");
                ["_Theme7"] = Instance.new("StringValue");
                ["_Category7"] = Instance.new("StringValue");
                ["_Ignore7"] = Instance.new("BoolValue");
                ["_SearchBar"] = Instance.new("Frame");
                ["_UICorner2"] = Instance.new("UICorner");
                ["_Icon"] = Instance.new("ImageLabel");
                ["_Theme8"] = Instance.new("StringValue");
                ["_Category8"] = Instance.new("StringValue");
                ["_Ignore8"] = Instance.new("BoolValue");
                ["_TextBox"] = Instance.new("TextBox");
                ["_Theme9"] = Instance.new("StringValue");
                ["_Category9"] = Instance.new("StringValue");
                ["_Ignore9"] = Instance.new("BoolValue");
                ["_Theme10"] = Instance.new("StringValue");
                ["_Category10"] = Instance.new("StringValue");
                ["_Ignore10"] = Instance.new("BoolValue");
                ["_Theme11"] = Instance.new("StringValue");
                ["_Category11"] = Instance.new("StringValue");
                ["_Ignore11"] = Instance.new("BoolValue");
                ["_Drag"] = Instance.new("TextButton");
                ["_Theme12"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint4"] = Instance.new("UIAspectRatioConstraint");
                ["_Theme13"] = Instance.new("StringValue");
                ["_Category12"] = Instance.new("StringValue");
                ["_Ignore12"] = Instance.new("BoolValue");
                ["_Background"] = Instance.new("Frame");
                ["_UICorner3"] = Instance.new("UICorner");
                ["_Theme14"] = Instance.new("StringValue");
                ["_Category13"] = Instance.new("StringValue");
                ["_Ignore13"] = Instance.new("BoolValue");
                ["_Pages"] = Instance.new("Frame");
                ["_UICorner4"] = Instance.new("UICorner");
                ["_Close1"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint5"] = Instance.new("UIAspectRatioConstraint");
                ["_Theme15"] = Instance.new("StringValue");
                ["_Category14"] = Instance.new("StringValue");
                ["_Ignore14"] = Instance.new("BoolValue");
                ["_Line1"] = Instance.new("Frame");
                ["_Theme16"] = Instance.new("StringValue");
                ["_Category15"] = Instance.new("StringValue");
                ["_Ignore15"] = Instance.new("BoolValue");
                ["_ScrollingFrame"] = Instance.new("ScrollingFrame");
                ["_UIListLayout2"] = Instance.new("UIListLayout");
                ["_Theme17"] = Instance.new("StringValue");
                ["_Category16"] = Instance.new("StringValue");
                ["_Ignore16"] = Instance.new("BoolValue");
                ["_Contents1"] = Instance.new("Frame");
                ["_Page"] = Instance.new("Frame");
                ["_ScrollingFrame1"] = Instance.new("ScrollingFrame");
                ["_UIListLayout3"] = Instance.new("UIListLayout");
                ["_padding1"] = Instance.new("Frame");
                ["_0_padding1"] = Instance.new("Frame");
                ["_Theme18"] = Instance.new("StringValue");
                ["_Category17"] = Instance.new("StringValue");
                ["_Ignore17"] = Instance.new("BoolValue");
                ["_Shadow"] = Instance.new("Frame");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Theme19"] = Instance.new("StringValue");
                ["_Category18"] = Instance.new("StringValue");
                ["_Ignore18"] = Instance.new("BoolValue");
                ["_Resize"] = Instance.new("Frame");
                ["_Frame1"] = Instance.new("Frame");
                ["_Frame2"] = Instance.new("Frame");
                ["_ResizeArea"] = Instance.new("TextButton");
                ["_Modal"] = Instance.new("TextButton");
                ["_Notifications"] = Instance.new("Frame");
                ["_UIListLayout4"] = Instance.new("UIListLayout");
                ["_Hint"] = Instance.new("Frame");
                ["_Arrow1"] = Instance.new("ImageLabel");
                ["_Theme20"] = Instance.new("StringValue");
                ["_Category19"] = Instance.new("StringValue");
                ["_Ignore19"] = Instance.new("BoolValue");
                ["_Main2"] = Instance.new("Frame");
                ["_Main3"] = Instance.new("Frame");
                ["_UICorner5"] = Instance.new("UICorner");
                ["_UIListLayout5"] = Instance.new("UIListLayout");
                ["_Frame3"] = Instance.new("Frame");
                ["_UIListLayout6"] = Instance.new("UIListLayout");
                ["_0_padding2"] = Instance.new("Frame");
                ["_1_main"] = Instance.new("Frame");
                ["_Text"] = Instance.new("TextLabel");
                ["_0_padding3"] = Instance.new("Frame");
                ["_padding2"] = Instance.new("Frame");
                ["_UIListLayout7"] = Instance.new("UIListLayout");
                ["_2_padding"] = Instance.new("Frame");
                ["_padding3"] = Instance.new("Frame");
                ["_0_padding4"] = Instance.new("Frame");
                ["_UIStroke"] = Instance.new("UIStroke");
                ["_Theme21"] = Instance.new("StringValue");
                ["_Category20"] = Instance.new("StringValue");
                ["_Ignore20"] = Instance.new("BoolValue");
                ["_Theme22"] = Instance.new("StringValue");
                ["_Category21"] = Instance.new("StringValue");
                ["_Ignore21"] = Instance.new("BoolValue");
            }

            --Properties

            Converted["_Atlas"].DisplayOrder = 99
            Converted["_Atlas"].IgnoreGuiInset = true
            Converted["_Atlas"].ResetOnSpawn = false
            Converted["_Atlas"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            Converted["_Atlas"].Name = "Atlas"
            Converted["_Atlas"].Parent = game:GetService("CoreGui")

            Converted["_UI_Library"].Name = "UI_Library"
            Converted["_UI_Library"].Parent = Converted["_Atlas"]

            Converted["_Name"].Value = "Atlas UI Library"
            Converted["_Name"].Name = "Name"
            Converted["_Name"].Parent = Converted["_UI_Library"]

            Converted["_Creator"].Value = "RoadToGlory#9879"
            Converted["_Creator"].Name = "Creator"
            Converted["_Creator"].Parent = Converted["_UI_Library"]

            Converted["_Discord"].Value = "https://discord.gg/xu5dDS3Pb9"
            Converted["_Discord"].Name = "Discord"
            Converted["_Discord"].Parent = Converted["_UI_Library"]

            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Position = UDim2.new(0.5, -320, 0.5, -219)
            Converted["_Main"].Size = UDim2.new(0, 640, 0, 438)
            Converted["_Main"].ZIndex = 100
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Atlas"]

            Converted["_Contents"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Contents"].BackgroundTransparency = 1
            Converted["_Contents"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Contents"].ZIndex = 10
            Converted["_Contents"].Name = "Contents"
            Converted["_Contents"].Parent = Converted["_Main"]

            Converted["_Appearance"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Appearance"].BackgroundTransparency = 1
            Converted["_Appearance"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Appearance"].ZIndex = 10
            Converted["_Appearance"].Name = "Appearance"
            Converted["_Appearance"].Parent = Converted["_Contents"]

            Converted["_Fade"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_Fade"].BorderSizePixel = 0
            Converted["_Fade"].Position = UDim2.new(0, 0, 0, 32)
            Converted["_Fade"].Size = UDim2.new(1, 0, 0, 9)
            Converted["_Fade"].ZIndex = 28
            Converted["_Fade"].Name = "Fade"
            Converted["_Fade"].Parent = Converted["_Appearance"]

            Converted["_UIGradient"].Rotation = 90
            Converted["_UIGradient"].Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.48750001192092896),
                NumberSequenceKeypoint.new(1, 1)
            }
            Converted["_UIGradient"].Parent = Converted["_Fade"]

            Converted["_Top"].BackgroundColor3 = Color3.fromRGB(30.00000011175871, 30.00000011175871, 30.00000011175871)
            Converted["_Top"].Size = UDim2.new(1, 0, 0, 32)
            Converted["_Top"].ZIndex = 30
            Converted["_Top"].Name = "Top"
            Converted["_Top"].Parent = Converted["_Appearance"]

            Converted["_UICorner"].CornerRadius = UDim.new(0, 7)
            Converted["_UICorner"].Parent = Converted["_Top"]

            Converted["_Theme"].Value = "BackgroundColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Top"]

            Converted["_Category"].Value = "LightContrast"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Line"].BackgroundColor3 = Color3.fromRGB(164.00000542402267, 53.00000064074993, 90.00000223517418)
            Converted["_Line"].BorderSizePixel = 0
            Converted["_Line"].Position = UDim2.new(0, 0, 0, 32)
            Converted["_Line"].Size = UDim2.new(1, 0, 0, 2)
            Converted["_Line"].ZIndex = 29
            Converted["_Line"].Name = "Line"
            Converted["_Line"].Parent = Converted["_Appearance"]

            Converted["_Theme1"].Value = "BackgroundColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Line"]

            Converted["_Category1"].Value = "Main"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Top_fill"].AnchorPoint = Vector2.new(0, 1)
            Converted["_Top_fill"].BackgroundColor3 = Color3.fromRGB(30.00000011175871, 30.00000011175871, 30.00000011175871)
            Converted["_Top_fill"].BorderSizePixel = 0
            Converted["_Top_fill"].Position = UDim2.new(0, 0, 0, 32)
            Converted["_Top_fill"].Size = UDim2.new(1, 0, 0, 4)
            Converted["_Top_fill"].ZIndex = 27
            Converted["_Top_fill"].Name = "Top_fill"
            Converted["_Top_fill"].Parent = Converted["_Appearance"]

            Converted["_Theme2"].Value = "BackgroundColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Top_fill"]

            Converted["_Category2"].Value = "LightContrast"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Top1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Top1"].BackgroundTransparency = 1
            Converted["_Top1"].Size = UDim2.new(1, 0, 0, 32)
            Converted["_Top1"].ZIndex = 10
            Converted["_Top1"].Name = "Top"
            Converted["_Top1"].Parent = Converted["_Contents"]

            Converted["_Close"].Image = "http://www.roblox.com/asset/?id=10259890025"
            Converted["_Close"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Close"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Close"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Close"].BackgroundTransparency = 1
            Converted["_Close"].Position = UDim2.new(1, -5, 0.5, 0)
            Converted["_Close"].Size = UDim2.new(0, 22, 0, 22)
            Converted["_Close"].Name = "Close"
            Converted["_Close"].Parent = Converted["_Top1"]

            Converted["_UIAspectRatioConstraint"].AspectType = Enum.AspectType.ScaleWithParentSize
            Converted["_UIAspectRatioConstraint"].DominantAxis = Enum.DominantAxis.Height
            Converted["_UIAspectRatioConstraint"].Parent = Converted["_Close"]

            Converted["_Theme3"].Value = "ImageColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Close"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Menu"].Image = "http://www.roblox.com/asset/?id=10953432322"
            Converted["_Menu"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Menu"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Menu"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Menu"].BackgroundTransparency = 1
            Converted["_Menu"].Position = UDim2.new(0, 9, 0.5, 0)
            Converted["_Menu"].Size = UDim2.new(0, 22, 0, 22)
            Converted["_Menu"].Name = "Menu"
            Converted["_Menu"].Parent = Converted["_Top1"]

            Converted["_UIAspectRatioConstraint1"].AspectType = Enum.AspectType.ScaleWithParentSize
            Converted["_UIAspectRatioConstraint1"].DominantAxis = Enum.DominantAxis.Height
            Converted["_UIAspectRatioConstraint1"].Parent = Converted["_Menu"]

            Converted["_Theme4"].Value = "ImageColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Menu"]

            Converted["_Category4"].Value = "Symbols"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Title"].Font = Enum.Font.GothamBlack
            Converted["_Title"].Text = "Atlas"
            Converted["_Title"].TextColor3 = Color3.fromRGB(164.00000542402267, 53.00000064074993, 90.00000223517418)
            Converted["_Title"].TextSize = 16
            Converted["_Title"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(1, -150, 0.5, 0)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Top1"]

            Converted["_UISizeConstraint"].Parent = Converted["_Title"]

            Converted["_Theme5"].Value = "TextColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_Title"]

            Converted["_Category5"].Value = "Main"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Info"].Image = "http://www.roblox.com/asset/?id=10954638982"
            Converted["_Info"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Info"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Info"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Info"].BackgroundTransparency = 1
            Converted["_Info"].Position = UDim2.new(0, 60, 0.5, 0)
            Converted["_Info"].Size = UDim2.new(0, 22, 0, 20)
            Converted["_Info"].Name = "Info"
            Converted["_Info"].Parent = Converted["_Top1"]

            Converted["_UIAspectRatioConstraint2"].AspectType = Enum.AspectType.ScaleWithParentSize
            Converted["_UIAspectRatioConstraint2"].DominantAxis = Enum.DominantAxis.Height
            Converted["_UIAspectRatioConstraint2"].Parent = Converted["_Info"]

            Converted["_Credits"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Credits"].BackgroundTransparency = 1
            Converted["_Credits"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Credits"].Visible = false
            Converted["_Credits"].Name = "Credits"
            Converted["_Credits"].Parent = Converted["_Info"]

            Converted["_Main1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Main1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main1"].BackgroundColor3 = Color3.fromRGB(31.000000052154064, 31.000000052154064, 31.000000052154064)
            Converted["_Main1"].Position = UDim2.new(0.5, 0, -2.25, 0)
            Converted["_Main1"].Size = UDim2.new(0, 1, 2.5, 0)
            Converted["_Main1"].ZIndex = 70
            Converted["_Main1"].Name = "Main"
            Converted["_Main1"].Parent = Converted["_Credits"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 6)
            Converted["_UICorner1"].Parent = Converted["_Main1"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 7)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_Main1"]

            Converted["_Frame"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame"].BackgroundTransparency = 1
            Converted["_Frame"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Frame"].Parent = Converted["_Main1"]

            Converted["_B"].Font = Enum.Font.Gotham
            Converted["_B"].Text = "Atlas UI Lib: RoadToGlory#9879"
            Converted["_B"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_B"].TextSize = 12
            Converted["_B"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_B"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_B"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_B"].BackgroundTransparency = 1
            Converted["_B"].Position = UDim2.new(0.5, 0, 0.699999988, 0)
            Converted["_B"].Size = UDim2.new(0, 1, 0.300000012, 0)
            Converted["_B"].Name = "B"
            Converted["_B"].Parent = Converted["_Frame"]

            Converted["_A"].Font = Enum.Font.Gotham
            Converted["_A"].Text = "AWP: RoadToGlory#9879"
            Converted["_A"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_A"].TextSize = 12
            Converted["_A"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_A"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_A"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_A"].BackgroundTransparency = 1
            Converted["_A"].Position = UDim2.new(0.5, 0, 0.300000012, 0)
            Converted["_A"].Size = UDim2.new(0, 1, 0.300000012, 0)
            Converted["_A"].Name = "A"
            Converted["_A"].Parent = Converted["_Frame"]

            Converted["_UIListLayout1"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Center
            Converted["_UIListLayout1"].Parent = Converted["_Frame"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_Main1"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_Main1"]

            Converted["_Arrow"].Image = "http://www.roblox.com/asset/?id=10955007577"
            Converted["_Arrow"].ImageColor3 = Color3.fromRGB(31.000000052154064, 31.000000052154064, 31.000000052154064)
            Converted["_Arrow"].AnchorPoint = Vector2.new(0.5, 0)
            Converted["_Arrow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Arrow"].BackgroundTransparency = 1
            Converted["_Arrow"].Position = UDim2.new(0.5, 0, -1, 0)
            Converted["_Arrow"].Rotation = 180
            Converted["_Arrow"].Size = UDim2.new(0, 10, 0, 10)
            Converted["_Arrow"].Name = "Arrow"
            Converted["_Arrow"].Parent = Converted["_Credits"]

            Converted["_Theme6"].Value = "ImageColor3"
            Converted["_Theme6"].Name = "Theme"
            Converted["_Theme6"].Parent = Converted["_Info"]

            Converted["_Category6"].Value = "Symbols"
            Converted["_Category6"].Name = "Category"
            Converted["_Category6"].Parent = Converted["_Theme6"]

            Converted["_Ignore6"].Name = "Ignore"
            Converted["_Ignore6"].Parent = Converted["_Theme6"]

            Converted["_Search"].Image = "http://www.roblox.com/asset/?id=10954646243"
            Converted["_Search"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Search"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Search"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Search"].BackgroundTransparency = 1
            Converted["_Search"].Position = UDim2.new(1, -32, 0.5, 0)
            Converted["_Search"].Size = UDim2.new(0, 22, 0, 21)
            Converted["_Search"].Name = "Search"
            Converted["_Search"].Parent = Converted["_Top1"]

            Converted["_UIAspectRatioConstraint3"].AspectType = Enum.AspectType.ScaleWithParentSize
            Converted["_UIAspectRatioConstraint3"].DominantAxis = Enum.DominantAxis.Height
            Converted["_UIAspectRatioConstraint3"].Parent = Converted["_Search"]

            Converted["_Theme7"].Value = "ImageColor3"
            Converted["_Theme7"].Name = "Theme"
            Converted["_Theme7"].Parent = Converted["_Search"]

            Converted["_Category7"].Value = "Symbols"
            Converted["_Category7"].Name = "Category"
            Converted["_Category7"].Parent = Converted["_Theme7"]

            Converted["_Ignore7"].Name = "Ignore"
            Converted["_Ignore7"].Parent = Converted["_Theme7"]

            Converted["_SearchBar"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_SearchBar"].BackgroundColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_SearchBar"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_SearchBar"].Size = UDim2.new(0.328999996, 0, 0, 21)
            Converted["_SearchBar"].Visible = false
            Converted["_SearchBar"].Name = "SearchBar"
            Converted["_SearchBar"].Parent = Converted["_Top1"]

            Converted["_UICorner2"].Parent = Converted["_SearchBar"]

            Converted["_Icon"].Image = "http://www.roblox.com/asset/?id=10954646243"
            Converted["_Icon"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Icon"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Icon"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Icon"].BackgroundTransparency = 1
            Converted["_Icon"].Position = UDim2.new(0, 3, 0.5, 0)
            Converted["_Icon"].Size = UDim2.new(0, 17, 0, 17)
            Converted["_Icon"].Name = "Icon"
            Converted["_Icon"].Parent = Converted["_SearchBar"]

            Converted["_Theme8"].Value = "ImageColor3"
            Converted["_Theme8"].Name = "Theme"
            Converted["_Theme8"].Parent = Converted["_Icon"]

            Converted["_Category8"].Value = "Symbols"
            Converted["_Category8"].Name = "Category"
            Converted["_Category8"].Parent = Converted["_Theme8"]

            Converted["_Ignore8"].Name = "Ignore"
            Converted["_Ignore8"].Parent = Converted["_Theme8"]

            Converted["_TextBox"].Font = Enum.Font.Gotham
            Converted["_TextBox"].PlaceholderColor3 = Color3.fromRGB(165.00000536441803, 165.00000536441803, 165.00000536441803)
            Converted["_TextBox"].PlaceholderText = "search"
            Converted["_TextBox"].Text = ""
            Converted["_TextBox"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_TextBox"].TextSize = 13
            Converted["_TextBox"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_TextBox"].AnchorPoint = Vector2.new(0.5, 0)
            Converted["_TextBox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextBox"].BackgroundTransparency = 1
            Converted["_TextBox"].Position = UDim2.new(0.5, 0, 0, 0)
            Converted["_TextBox"].Size = UDim2.new(1, -34, 1, 0)
            Converted["_TextBox"].Parent = Converted["_SearchBar"]

            Converted["_Theme9"].Value = "PlaceholderColor3"
            Converted["_Theme9"].Name = "Theme"
            Converted["_Theme9"].Parent = Converted["_TextBox"]

            Converted["_Category9"].Value = "GreyContrast"
            Converted["_Category9"].Name = "Category"
            Converted["_Category9"].Parent = Converted["_Theme9"]

            Converted["_Ignore9"].Name = "Ignore"
            Converted["_Ignore9"].Parent = Converted["_Theme9"]

            Converted["_Theme10"].Value = "TextColor3"
            Converted["_Theme10"].Name = "Theme"
            Converted["_Theme10"].Parent = Converted["_TextBox"]

            Converted["_Category10"].Value = "Symbols"
            Converted["_Category10"].Name = "Category"
            Converted["_Category10"].Parent = Converted["_Theme10"]

            Converted["_Ignore10"].Name = "Ignore"
            Converted["_Ignore10"].Parent = Converted["_Theme10"]

            Converted["_Theme11"].Value = "BackgroundColor3"
            Converted["_Theme11"].Name = "Theme"
            Converted["_Theme11"].Parent = Converted["_SearchBar"]

            Converted["_Category11"].Value = "Background"
            Converted["_Category11"].Name = "Category"
            Converted["_Category11"].Parent = Converted["_Theme11"]

            Converted["_Ignore11"].Name = "Ignore"
            Converted["_Ignore11"].Parent = Converted["_Theme11"]

            Converted["_Drag"].Font = Enum.Font.SourceSans
            Converted["_Drag"].Text = ""
            Converted["_Drag"].TextColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_Drag"].TextSize = 14
            Converted["_Drag"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Drag"].BackgroundTransparency = 1
            Converted["_Drag"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Drag"].ZIndex = 0
            Converted["_Drag"].Name = "Drag"
            Converted["_Drag"].Parent = Converted["_Top1"]

            Converted["_Theme12"].Image = "http://www.roblox.com/asset/?id=10983705188"
            Converted["_Theme12"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Theme12"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Theme12"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Theme12"].BackgroundTransparency = 1
            Converted["_Theme12"].Position = UDim2.new(1, -59, 0.5, 0)
            Converted["_Theme12"].Size = UDim2.new(0, 22, 0, 21)
            Converted["_Theme12"].Visible = false
            Converted["_Theme12"].Name = "Theme"
            Converted["_Theme12"].Parent = Converted["_Top1"]

            Converted["_UIAspectRatioConstraint4"].AspectType = Enum.AspectType.ScaleWithParentSize
            Converted["_UIAspectRatioConstraint4"].DominantAxis = Enum.DominantAxis.Height
            Converted["_UIAspectRatioConstraint4"].Parent = Converted["_Theme12"]

            Converted["_Theme13"].Value = "ImageColor3"
            Converted["_Theme13"].Name = "Theme"
            Converted["_Theme13"].Parent = Converted["_Theme12"]

            Converted["_Category12"].Value = "Symbols"
            Converted["_Category12"].Name = "Category"
            Converted["_Category12"].Parent = Converted["_Theme13"]

            Converted["_Ignore12"].Name = "Ignore"
            Converted["_Ignore12"].Parent = Converted["_Theme13"]

            Converted["_Background"].BackgroundColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_Background"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Background"].Name = "Background"
            Converted["_Background"].Parent = Converted["_Contents"]

            Converted["_UICorner3"].CornerRadius = UDim.new(0, 7)
            Converted["_UICorner3"].Parent = Converted["_Background"]

            Converted["_Theme14"].Value = "BackgroundColor3"
            Converted["_Theme14"].Name = "Theme"
            Converted["_Theme14"].Parent = Converted["_Background"]

            Converted["_Category13"].Value = "Background"
            Converted["_Category13"].Name = "Category"
            Converted["_Category13"].Parent = Converted["_Theme14"]

            Converted["_Ignore13"].Name = "Ignore"
            Converted["_Ignore13"].Parent = Converted["_Theme14"]

            Converted["_Pages"].BackgroundColor3 = Color3.fromRGB(37.00000159442425, 37.00000159442425, 37.00000159442425)
            Converted["_Pages"].Size = UDim2.new(0, 0, 1, 0)
            Converted["_Pages"].Visible = true
            Converted["_Pages"].ZIndex = 80
            Converted["_Pages"].Name = "Pages"
            Converted["_Pages"].Parent = Converted["_Contents"]

            Converted["_UICorner4"].CornerRadius = UDim.new(0, 7)
            Converted["_UICorner4"].Parent = Converted["_Pages"]

            Converted["_Close1"].Image = "http://www.roblox.com/asset/?id=10259890025"
            Converted["_Close1"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Close1"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Close1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Close1"].BackgroundTransparency = 1
            Converted["_Close1"].Position = UDim2.new(0, 5, 0, 16)
            Converted["_Close1"].Size = UDim2.new(0, 22, 0, 22)
            Converted["_Close1"].Name = "Close"
            Converted["_Close1"].Parent = Converted["_Pages"]

            Converted["_UIAspectRatioConstraint5"].AspectType = Enum.AspectType.ScaleWithParentSize
            Converted["_UIAspectRatioConstraint5"].DominantAxis = Enum.DominantAxis.Height
            Converted["_UIAspectRatioConstraint5"].Parent = Converted["_Close1"]

            Converted["_Theme15"].Value = "ImageColor3"
            Converted["_Theme15"].Name = "Theme"
            Converted["_Theme15"].Parent = Converted["_Close1"]

            Converted["_Category14"].Value = "Symbols"
            Converted["_Category14"].Name = "Category"
            Converted["_Category14"].Parent = Converted["_Theme15"]

            Converted["_Ignore14"].Name = "Ignore"
            Converted["_Ignore14"].Parent = Converted["_Theme15"]

            Converted["_Line1"].BackgroundColor3 = Color3.fromRGB(65.0000037252903, 65.0000037252903, 65.0000037252903)
            Converted["_Line1"].BorderSizePixel = 0
            Converted["_Line1"].Position = UDim2.new(0, 0, 0, 32)
            Converted["_Line1"].Size = UDim2.new(1, 0, 0, 1)
            Converted["_Line1"].ZIndex = 29
            Converted["_Line1"].Name = "Line"
            Converted["_Line1"].Parent = Converted["_Pages"]

            Converted["_Theme16"].Value = "BackgroundColor3"
            Converted["_Theme16"].Name = "Theme"
            Converted["_Theme16"].Parent = Converted["_Line1"]

            Converted["_Category15"].Value = "SidebarSeperator"
            Converted["_Category15"].Name = "Category"
            Converted["_Category15"].Parent = Converted["_Theme16"]

            Converted["_Ignore15"].Name = "Ignore"
            Converted["_Ignore15"].Parent = Converted["_Theme16"]

            Converted["_ScrollingFrame"].AutomaticCanvasSize = Enum.AutomaticSize.Y
            Converted["_ScrollingFrame"].CanvasSize = UDim2.new(0, 0, 1, 0)
            Converted["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ScrollingFrame"].ScrollBarThickness = 0
            Converted["_ScrollingFrame"].Active = true
            Converted["_ScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ScrollingFrame"].BackgroundTransparency = 1
            Converted["_ScrollingFrame"].Position = UDim2.new(0, 9, 0, 39)
            Converted["_ScrollingFrame"].Size = UDim2.new(0.88554424, 0, 0.985523105, -40)
            Converted["_ScrollingFrame"].Parent = Converted["_Pages"]

            Converted["_UIListLayout2"].Parent = Converted["_ScrollingFrame"]

            Converted["_Theme17"].Value = "BackgroundColor3"
            Converted["_Theme17"].Name = "Theme"
            Converted["_Theme17"].Parent = Converted["_Pages"]

            Converted["_Category16"].Value = "Sidebar"
            Converted["_Category16"].Name = "Category"
            Converted["_Category16"].Parent = Converted["_Theme17"]

            Converted["_Ignore16"].Name = "Ignore"
            Converted["_Ignore16"].Parent = Converted["_Theme17"]

            Converted["_Contents1"].AnchorPoint = Vector2.new(1, 1)
            Converted["_Contents1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Contents1"].BackgroundTransparency = 1
            Converted["_Contents1"].Position = UDim2.new(1, 0, 1, 0)
            Converted["_Contents1"].Size = UDim2.new(1, 0, 1, -32)
            Converted["_Contents1"].ZIndex = 50
            Converted["_Contents1"].Name = "Contents"
            Converted["_Contents1"].Parent = Converted["_Contents"]

            Converted["_Page"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Page"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Page"].BackgroundTransparency = 1
            Converted["_Page"].Position = UDim2.new(1, -3, 0.5, 0)
            Converted["_Page"].Size = UDim2.new(1, -9, 1, -12)
            Converted["_Page"].Name = "Page"
            Converted["_Page"].Parent = Converted["_Contents1"]

            Converted["_ScrollingFrame1"].AutomaticCanvasSize = Enum.AutomaticSize.Y
            Converted["_ScrollingFrame1"].CanvasSize = UDim2.new(0, 0, 1, 0)
            Converted["_ScrollingFrame1"].ScrollBarImageColor3 = Color3.fromRGB(151.00000619888306, 151.00000619888306, 151.00000619888306)
            Converted["_ScrollingFrame1"].ScrollBarImageTransparency = 0.20000000298023224
            Converted["_ScrollingFrame1"].ScrollBarThickness = 5
            Converted["_ScrollingFrame1"].Active = true
            Converted["_ScrollingFrame1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ScrollingFrame1"].BackgroundTransparency = 1
            Converted["_ScrollingFrame1"].BorderSizePixel = 0
            Converted["_ScrollingFrame1"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ScrollingFrame1"].Parent = Converted["_Page"]

            Converted["_UIListLayout3"].Padding = UDim.new(0, 8)
            Converted["_UIListLayout3"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout3"].Parent = Converted["_ScrollingFrame1"]

            Converted["_padding1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding1"].BackgroundTransparency = 1
            Converted["_padding1"].Size = UDim2.new(1, 0, 0, 0)
            Converted["_padding1"].Name = "padding"
            Converted["_padding1"].Parent = Converted["_ScrollingFrame1"]

            Converted["_0_padding1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding1"].BackgroundTransparency = 1
            Converted["_0_padding1"].Size = UDim2.new(1, 0, 0, 0)
            Converted["_0_padding1"].Name = "0_padding"
            Converted["_0_padding1"].Parent = Converted["_ScrollingFrame1"]

            Converted["_Theme18"].Value = "ScrollBarImageColor3"
            Converted["_Theme18"].Name = "Theme"
            Converted["_Theme18"].Parent = Converted["_ScrollingFrame1"]

            Converted["_Category17"].Value = "Scrollbar"
            Converted["_Category17"].Name = "Category"
            Converted["_Category17"].Parent = Converted["_Theme18"]

            Converted["_Ignore17"].Name = "Ignore"
            Converted["_Ignore17"].Parent = Converted["_Theme18"]

            Converted["_Shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Shadow"].BackgroundTransparency = 1
            Converted["_Shadow"].Position = UDim2.new(0.5, 0, 0.506053269, 0)
            Converted["_Shadow"].Size = UDim2.new(1, 55, 1.01210654, 55)
            Converted["_Shadow"].ZIndex = 0
            Converted["_Shadow"].Name = "Shadow"
            Converted["_Shadow"].Parent = Converted["_Main"]

            Converted["_ImageLabel"].Image = "rbxassetid://10955010523"
            Converted["_ImageLabel"].ImageColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ImageLabel"].ImageTransparency = 0.5
            Converted["_ImageLabel"].ScaleType = Enum.ScaleType.Slice
            Converted["_ImageLabel"].SliceCenter = Rect.new(60, 60, 360, 360)
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ImageLabel"].ZIndex = 0
            Converted["_ImageLabel"].Parent = Converted["_Shadow"]

            Converted["_Theme19"].Value = "ImageColor3"
            Converted["_Theme19"].Name = "Theme"
            Converted["_Theme19"].Parent = Converted["_ImageLabel"]

            Converted["_Category18"].Value = "Shadow"
            Converted["_Category18"].Name = "Category"
            Converted["_Category18"].Parent = Converted["_Theme19"]

            Converted["_Ignore18"].Name = "Ignore"
            Converted["_Ignore18"].Parent = Converted["_Theme19"]

            Converted["_Resize"].AnchorPoint = Vector2.new(1, 1)
            Converted["_Resize"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Resize"].BackgroundTransparency = 1
            Converted["_Resize"].Position = UDim2.new(1, -4, 1, -4)
            Converted["_Resize"].Size = UDim2.new(0, 10, 0, 10)
            Converted["_Resize"].Visible = false
            Converted["_Resize"].ZIndex = 20
            Converted["_Resize"].Name = "Resize"
            Converted["_Resize"].Parent = Converted["_Main"]

            Converted["_Frame1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Frame1"].BackgroundColor3 = Color3.fromRGB(143.00000667572021, 143.00000667572021, 143.00000667572021)
            Converted["_Frame1"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Frame1"].Rotation = -45
            Converted["_Frame1"].Size = UDim2.new(1, 0, 0.100000001, 0)
            Converted["_Frame1"].Parent = Converted["_Resize"]

            Converted["_Frame2"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Frame2"].BackgroundColor3 = Color3.fromRGB(143.00000667572021, 143.00000667572021, 143.00000667572021)
            Converted["_Frame2"].Position = UDim2.new(0.800000012, 0, 0.800000012, 0)
            Converted["_Frame2"].Rotation = -45
            Converted["_Frame2"].Size = UDim2.new(0.400000006, 0, 0.100000001, 0)
            Converted["_Frame2"].Parent = Converted["_Resize"]

            Converted["_ResizeArea"].Font = Enum.Font.SourceSans
            Converted["_ResizeArea"].Text = ""
            Converted["_ResizeArea"].TextColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ResizeArea"].TextSize = 14
            Converted["_ResizeArea"].AnchorPoint = Vector2.new(1, 1)
            Converted["_ResizeArea"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ResizeArea"].BackgroundTransparency = 1
            Converted["_ResizeArea"].Position = UDim2.new(1, 2, 1, 2)
            Converted["_ResizeArea"].Size = UDim2.new(0, 18, 0, 18)
            Converted["_ResizeArea"].Name = "ResizeArea"
            Converted["_ResizeArea"].Parent = Converted["_Main"]

            Converted["_Modal"].Font = Enum.Font.SourceSans
            Converted["_Modal"].Text = ""
            Converted["_Modal"].TextColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_Modal"].TextSize = 14
            Converted["_Modal"].TextTransparency = 1
            Converted["_Modal"].Modal = true
            Converted["_Modal"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Modal"].BackgroundTransparency = 1
            Converted["_Modal"].Name = "Modal"
            Converted["_Modal"].Parent = Converted["_Main"]

            Converted["_Notifications"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Notifications"].BackgroundTransparency = 1
            Converted["_Notifications"].Position = UDim2.new(0, 40, 0, 0)
            Converted["_Notifications"].Size = UDim2.new(0, 260, 1, -20)
            Converted["_Notifications"].ZIndex = 200
            Converted["_Notifications"].Name = "Notifications"
            Converted["_Notifications"].Parent = Converted["_Atlas"]

            Converted["_UIListLayout4"].Padding = UDim.new(0, 10)
            Converted["_UIListLayout4"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout4"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout4"].Parent = Converted["_Notifications"]

            Converted["_Hint"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Hint"].BackgroundTransparency = 1
            Converted["_Hint"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Hint"].Size = UDim2.new(0, 10, 0, 10)
            Converted["_Hint"].Visible = false
            Converted["_Hint"].ZIndex = 300
            Converted["_Hint"].Name = "Hint"
            Converted["_Hint"].Parent = Converted["_Atlas"]

            Converted["_Arrow1"].Image = "http://www.roblox.com/asset/?id=10955007577"
            Converted["_Arrow1"].ImageColor3 = Color3.fromRGB(21.000000648200512, 21.000000648200512, 21.000000648200512)
            Converted["_Arrow1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Arrow1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Arrow1"].BackgroundTransparency = 1
            Converted["_Arrow1"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Arrow1"].Rotation = 180
            Converted["_Arrow1"].Size = UDim2.new(0, 10, 0, 10)
            Converted["_Arrow1"].Name = "Arrow"
            Converted["_Arrow1"].Parent = Converted["_Hint"]

            Converted["_Theme20"].Value = "ImageColor3"
            Converted["_Theme20"].Name = "Theme"
            Converted["_Theme20"].Parent = Converted["_Arrow1"]

            Converted["_Category19"].Value = "Hint"
            Converted["_Category19"].Name = "Category"
            Converted["_Category19"].Parent = Converted["_Theme20"]

            Converted["_Ignore19"].Name = "Ignore"
            Converted["_Ignore19"].Parent = Converted["_Theme20"]

            Converted["_Main2"].AnchorPoint = Vector2.new(0.5, 1)
            Converted["_Main2"].BackgroundColor3 = Color3.fromRGB(21.000000648200512, 21.000000648200512, 21.000000648200512)
            Converted["_Main2"].BackgroundTransparency = 1
            Converted["_Main2"].Position = UDim2.new(0.5, 0, 0, 0)
            Converted["_Main2"].Size = UDim2.new(0, 10, 0, 10)
            Converted["_Main2"].ZIndex = 70
            Converted["_Main2"].Name = "Main"
            Converted["_Main2"].Parent = Converted["_Hint"]

            Converted["_Main3"].AnchorPoint = Vector2.new(0.5, 1)
            Converted["_Main3"].AutomaticSize = Enum.AutomaticSize.XY
            Converted["_Main3"].BackgroundColor3 = Color3.fromRGB(21.000000648200512, 21.000000648200512, 21.000000648200512)
            Converted["_Main3"].Position = UDim2.new(0.5, 0, 1, 0)
            Converted["_Main3"].Size = UDim2.new(0, 1, 0, 1)
            Converted["_Main3"].ZIndex = 70
            Converted["_Main3"].Name = "Main"
            Converted["_Main3"].Parent = Converted["_Main2"]

            Converted["_UICorner5"].CornerRadius = UDim.new(0, 6)
            Converted["_UICorner5"].Parent = Converted["_Main3"]

            Converted["_UIListLayout5"].Padding = UDim.new(0, 7)
            Converted["_UIListLayout5"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout5"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout5"].Parent = Converted["_Main3"]

            Converted["_Frame3"].AutomaticSize = Enum.AutomaticSize.XY
            Converted["_Frame3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame3"].BackgroundTransparency = 1
            Converted["_Frame3"].Size = UDim2.new(0, 1, 0, 1)
            Converted["_Frame3"].Parent = Converted["_Main3"]

            Converted["_UIListLayout6"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout6"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout6"].Parent = Converted["_Frame3"]

            Converted["_0_padding2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding2"].BackgroundTransparency = 1
            Converted["_0_padding2"].Name = "0_padding"
            Converted["_0_padding2"].Parent = Converted["_Frame3"]

            Converted["_1_main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_1_main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_1_main"].BackgroundTransparency = 1
            Converted["_1_main"].Size = UDim2.new(0, 1, 0, 1)
            Converted["_1_main"].Name = "1_main"
            Converted["_1_main"].Parent = Converted["_Frame3"]

            Converted["_Text"].Font = Enum.Font.Gotham
            Converted["_Text"].RichText = true
            Converted["_Text"].Text = "This feature is currently not functional."
            Converted["_Text"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Text"].TextSize = 14
            Converted["_Text"].AutomaticSize = Enum.AutomaticSize.XY
            Converted["_Text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Text"].BackgroundTransparency = 1
            Converted["_Text"].Size = UDim2.new(0, 1, 0, 1)
            Converted["_Text"].SizeConstraint = Enum.SizeConstraint.RelativeYY
            Converted["_Text"].Name = "Text"
            Converted["_Text"].Parent = Converted["_1_main"]

            Converted["_0_padding3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding3"].BackgroundTransparency = 1
            Converted["_0_padding3"].Name = "0_padding"
            Converted["_0_padding3"].Parent = Converted["_1_main"]

            Converted["_padding2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding2"].BackgroundTransparency = 1
            Converted["_padding2"].Name = "padding"
            Converted["_padding2"].Parent = Converted["_1_main"]

            Converted["_UIListLayout7"].Padding = UDim.new(0, 5)
            Converted["_UIListLayout7"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout7"].Parent = Converted["_1_main"]

            Converted["_2_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_2_padding"].BackgroundTransparency = 1
            Converted["_2_padding"].Name = "2_padding"
            Converted["_2_padding"].Parent = Converted["_Frame3"]

            Converted["_padding3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding3"].BackgroundTransparency = 1
            Converted["_padding3"].Name = "padding"
            Converted["_padding3"].Parent = Converted["_Main3"]

            Converted["_0_padding4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding4"].BackgroundTransparency = 1
            Converted["_0_padding4"].Name = "0_padding"
            Converted["_0_padding4"].Parent = Converted["_Main3"]

            Converted["_UIStroke"].Color = Color3.fromRGB(165.00000536441803, 165.00000536441803, 165.00000536441803)
            Converted["_UIStroke"].Parent = Converted["_Main3"]

            Converted["_Theme21"].Value = "Color"
            Converted["_Theme21"].Name = "Theme"
            Converted["_Theme21"].Parent = Converted["_UIStroke"]

            Converted["_Category20"].Value = "GreyContrast"
            Converted["_Category20"].Name = "Category"
            Converted["_Category20"].Parent = Converted["_Theme21"]

            Converted["_Ignore20"].Name = "Ignore"
            Converted["_Ignore20"].Parent = Converted["_Theme21"]

            Converted["_Theme22"].Value = "BackgroundColor3"
            Converted["_Theme22"].Name = "Theme"
            Converted["_Theme22"].Parent = Converted["_Main2"]

            Converted["_Category21"].Value = "Hint"
            Converted["_Category21"].Name = "Category"
            Converted["_Category21"].Parent = Converted["_Theme22"]

            Converted["_Ignore21"].Name = "Ignore"
            Converted["_Ignore21"].Parent = Converted["_Theme22"]

            return Converted["_Atlas"]
        end

        local lib = makeLibrary()

        local _connections = {}

        pcall(function() -- laziness
            lib.Main.Contents.Contents.Page:Destroy()
        end)

        -- Temporary
        lib.Notifications.Visible = false
        lib.Main.Visible = false
        lib.Hint.Visible = false

        local savedKey = nil
        local flags = {}
        local saveCoroutine

        if info.ConfigFolder then
            -- load data
            local cf = info.ConfigFolder
            local config = cf.."/config.json"
            if not isfolder(cf) then
                makefolder(cf)
            end
            if not isfile(config) then
                writefile(config,"")
            end
            if info.CheckKey then
                local key = cf.."/key.txt"
                if not isfile(key) then
                    writefile(key,"")
                end
                savedKey = readfile(key)
                if savedKey == "" then
                    savedKey = nil
                end
            end
            flags = readfile(config)=="" and {} or game:GetService("HttpService"):JSONDecode(readfile(config))
            for i,v in pairs(flags) do
                if type(v)=="string" then
                    if string.sub(v,1,9)=="?special|" then
                        if string.find(v,"<$enum_type$>") then -- for enums
                            local semiL,_ = string.find(v,";")
                            local enumType = string.sub(v,24,semiL-1)
                            local index = string.sub(v,semiL+15,-1)
                            local finalEnum = Enum[enumType][index]
                            flags[i] = finalEnum
                        elseif string.find(v,"<$colorR$>") then
                            local semiL1,_ = string.find(v,";")
                            local semiL2,_ = string.find(v,";",semiL1+1)

                            local r = string.sub(v,21,semiL1-1)
                            local g = string.sub(v,semiL1+12,semiL2-1)
                            local b = string.sub(v,semiL2+12,-1)

                            flags[i] = Color3.new(tonumber(r),tonumber(g),tonumber(b))
                        end
                    end
                end
            end
            saveCoroutine = coroutine.create(function()
                LPH_JIT_MAX(function()
                    while utility:Wait() do
                        local edited_flags = {}
                        for i,v in pairs(flags) do
                            if typeof(v)=="EnumItem" then
                                v = "?special|<$enum_type$>:"..tostring(v.EnumType)..";<$enum_item$>:"..v.Name
                            elseif typeof(v)=="Color3" then
                                v = "?special|<$colorR$>:"..v.R..";<$colorG$>:"..v.G..";<$colorB$>:"..v.B
                            end
                            edited_flags[i] = v
                        end
                        writefile(config,game:GetService("HttpService"):JSONEncode(edited_flags))
                        task.wait(0.5)
                    end
                end)()
            end)
            coroutine.resume(saveCoroutine)
        end

        if info.UseLoader then
            local loader = makeLoader()
            loader.Parent = lib
            loader.Visible = true
            loader.Position = UDim2.new(1, 300, 1, -20)
            loader.GameThumbnail.Image = "https://www.roblox.com/asset-thumbnail/image?assetId="..game.PlaceId.."&width=768&height=432&format=png"

            local main = loader.Main
            local key = loader.Key
            local profile = loader.Profile

            main.GameName.Text = GameName
            main.Message.Text = "Script: "..info.FullName

            local allGood = false
            local chosen = false

            table.insert(_connections,utility:HandleGradientButton(main.Yes,function()
                if chosen then return else chosen = true end
                local transition = TS:Create(main,TweenInfo.new(0.35,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                    ["Size"] = UDim2.new(0,0,1,0)
                })
                transition:Play()
                transition.Completed:Wait()
                local keyPath = info.ConfigFolder.."/key.txt"
                local nextKey = info.CheckKey and not info.CheckKey(string.gsub(string.gsub(readfile(keyPath), "^%s+", ""), "%s+$", ""))
                local nextObj = nextKey and key or profile
                nextObj.Size = UDim2.fromScale(0,1)
                nextObj.Visible = true
                nextObj.AnchorPoint = Vector2.new(1,0)
                nextObj.Position = UDim2.fromScale(1,0)
                transition = TS:Create(nextObj,TweenInfo.new(0.35,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                    ["Size"] = UDim2.new(1,0,1,0)
                })
                if nextKey then
                    transition:Play()
                    local btn = key.Interact.Button
                    local checkMark = btn.ImageLabel
                    local text = btn.TextLabel
                    checkMark.Visible = false
                    text.Text = "Copy Invite"
                    table.insert(_connections,utility:HandleGradientButton(btn,function()
                        if text.Text == "Copy Invite" then
                            text.Text = "Copied"
                            checkMark.Visible = true
                            setclipboard(info.Discord or "No discord invite")
                            wait(1.5)
                            text.Text = "Copy Invite"
                            checkMark.Visible = false
                        end
                    end))

                    local textBox = key.Input.TextBox
                    local check = utility:CreateButtonObject(key.Input.ImageLabel)

                    local checking = false

                    local function doChecks()
                        if checking then return else checking = true end
                        local formatted = string.gsub(string.gsub(textBox.Text, "^%s+", ""), "%s+$", "")
                        local result = nil
                        pcall(function()
                            result = info.CheckKey(formatted)
                        end)
                        if result then
                            writefile(keyPath,formatted)
                            profile.Size = UDim2.fromScale(0,1)
                            profile.Visible = true
                            profile.AnchorPoint = Vector2.new(1,0)
                            profile.Position = UDim2.fromScale(1,0)
                            transition = TS:Create(profile,TweenInfo.new(0.35,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                                ["Size"] = UDim2.new(1,0,1,0)
                            })
                            local thisTransition = TS:Create(key,TweenInfo.new(0.35,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                                ["Size"] = UDim2.new(0,0,1,0)
                            })
                            thisTransition:Play()
                            thisTransition.Completed:Wait()
                            allGood = transition
                            transition.Completed:Wait()
                            nextObj.AnchorPoint = Vector2.new(0,0)
                            nextObj.Position = UDim2.fromScale(0,0)
                        else
                            checking = false
                        end
                    end

                    check.Activated:Connect(doChecks)
                    textBox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            doChecks()
                        end
                    end)
                else
                    allGood = transition
                end
                transition.Completed:Wait()
                nextObj.AnchorPoint = Vector2.new(0,0)
                nextObj.Position = UDim2.fromScale(0,0)
            end))
            table.insert(_connections,utility:HandleGradientButton(main.No,function()
                if chosen then return else chosen = true end
                local t = TS:Create(loader,TweenInfo.new(0.3,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                    ["Position"] = UDim2.new(1, 300, 1, -20)
                })
                t:Play()
                t.Completed:Wait()
                lib:Destroy()
                for _,v in pairs(_connections) do
                    v:Disconnect()
                end
                wait(9e9)
            end))

            TS:Create(loader,TweenInfo.new(0.3,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                ["Position"] = UDim2.new(1, -20, 1, -20)
            }):Play() -- loader in

            while allGood == false do
                utility:Wait()
            end

            profile.Player.Gradient.BackgroundColor3 = info.RankColor
            profile.Player.Rank.TextLabel.Text = info.Rank

            profile.Player.PlayerName.TextLabel.Text = player.Name

            profile.Player.Thumbnail.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=420&h=420"

            profile.Player.PlayerName.ImageLabel.Visible = info.RankIcon and true
            profile.Player.PlayerName.ImageLabel.Image = info.RankIcon and "http://www.roblox.com/asset/?id="..info.RankIcon or ""

            local closeBtn = utility:CreateButtonObject(profile.Close)

            local closed = false

            local function doClose()
                if closed then return else closed = true end
                local e = TS:Create(loader,TweenInfo.new(0.3,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                    ["Position"] = UDim2.new(1, 300, 1, -20)
                }) -- loader in
                e:Play()
                e.Completed:Connect(function()
                    pcall(function()
                        loader:Destory()
                    end)
                end)
            end

            closeBtn.Activated:Connect(doClose)

            allGood:Play()

            coroutine.resume(coroutine.create(function()
                task.wait(3.5)
                doClose()
            end))
        end

        -- Current page
        local currentPage = Instance.new("IntValue")
        currentPage.Name = "CurrentPage"
        currentPage.Value = 1
        currentPage.Parent = lib.Main

        -- Dragging
        local dragEvents = utility:InitDragging(lib.Main,lib.Main.Contents.Top.Drag)

        -- Section update event
        local sectionUpdateEvent do
            local contents = lib.Main.Contents.Contents
            local categories = lib.Main.Contents.Pages.ScrollingFrame
            LPH_JIT_MAX(function()
                sectionUpdateEvent = Run.RenderStepped:Connect(function()
                    for _,v in pairs(categories:GetChildren()) do
                        if v:IsA("Frame") then
                            local pageNum = v:FindFirstChild("PageNum")
                            if pageNum then
                                local transparency = currentPage.Value==pageNum.Value and 0 or 1
                                v.BackgroundTransparency = transparency
                            end
                        end
                    end
                    for _,v in pairs(contents:GetChildren()) do
                        if v:IsA("Frame") then
                            local pageNum = v:FindFirstChild("PageNum")
                            if pageNum then
                                v.Visible = currentPage.Value==pageNum.Value
                            end
                        end
                    end
                end)
            end)()
        end

        local closePages do -- pages open and close
            local openSize = UDim2.new(0, 150, 1, 0)
            local closeSize = UDim2.new(0, 0, 1, 0)
            
            local open = lib.Main.Contents.Top.Menu
            local close = lib.Main.Contents.Pages.Close

            local openBtn = utility:CreateButtonObject(open)
            local closeBtn = utility:CreateButtonObject(close)

            local state = false

            local pages = lib.Main.Contents.Pages
            local contents = lib.Main.Contents.Contents

            pages.Size = closeSize

            local tweenInfo = TweenInfo.new(0.15,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)
            local existing

            local function startTween(s)
                if existing then
                    existing:Cancel()
                    existing:Destroy()
                end
                existing = TS:Create(pages,tweenInfo,{
                    ["Size"] = s;
                })
                existing:Play()
            end

            local pagesUpdate

            LPH_JIT_MAX(function()
                pagesUpdate = Run.RenderStepped:Connect(function()
                    local o = pages.Size.X.Offset
                    pages.Visible = o~=0
                    contents.Size = UDim2.new(1,-o,1,-32)
                end)
            end)()

            table.insert(_connections,pagesUpdate)

            openBtn.Activated:Connect(function()
                if state == false then
                    state = true
                    startTween(openSize)
                end
            end)

            closeBtn.Activated:Connect(function()
                if state == true then
                    state = false
                    startTween(closeSize)
                end
            end)
            function closePages()
                if state == true then
                    state = false
                    startTween(closeSize)
                end
            end
        end

        do -- other buttons
            local searchBtn = utility:CreateButtonObject(lib.Main.Contents.Top.Search)
            local searchBar = lib.Main.Contents.Top.SearchBar

            searchBtn.Activated:Connect(function()
                searchBar.Visible = not searchBar.Visible
                if not searchBar.Visible then
                    searchBar.TextBox.Text = ""
                end
            end)

            local infoButton = utility:CreateButtonObject(lib.Main.Contents.Top.Info)
            local infoDialogue = lib.Main.Contents.Top.Info.Credits

            infoButton.Activated:Connect(function()
                infoDialogue.Visible = not infoDialogue.Visible
            end)
        end

        do -- resize
            local main = lib.Main
            local resize = main.Resize
            local button = main.ResizeArea

            local isResizing = false
            local offset = nil

            --local tweenInfo = TweenInfo.new(0.1,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)

            local p = resize:GetChildren()
            local p1 = p[1]
            local p2 = p[2]

            local function setColor(c)
                local r = Color3.fromRGB(c, c, c)
                if p1.BackgroundColor3==r then
                    return
                end
                for _,v in pairs(resize:GetChildren()) do
                    p1.BackgroundColor3 = r
                    p2.BackgroundColor3 = r
                end
            end

            button.MouseEnter:Connect(function()
                resize.Visible = true
            end)

            button.MouseLeave:Connect(function()
                resize.Visible = false
            end)

            main:GetPropertyChangedSignal("Visible"):Connect(function()
                if not main.Visible then
                    isResizing = false
                end
            end)

            button.MouseButton1Down:Connect(function()
                isResizing = true
                offset = Vector2.new(mouse.X-(main.AbsolutePosition.X+main.AbsoluteSize.X),mouse.Y-(main.AbsolutePosition.Y+main.AbsoluteSize.Y))
            end)

            LPH_JIT_MAX(function()
                table.insert(_connections,Run.RenderStepped:Connect(function()
                    if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                        isResizing = false
                    end
                    if isResizing then
                        setColor(225)
                        resize.Visible = true
                        local mousePos = Vector2.new(mouse.X-offset.X,mouse.Y-offset.Y)
                        local finalSize = Vector2.new(math.clamp(mousePos.X-main.AbsolutePosition.X,227,math.huge),math.clamp(mousePos.Y-main.AbsolutePosition.Y,225,math.huge))
                        main.Size = UDim2.fromOffset(finalSize.X,finalSize.Y)
                    else
                        setColor(143)
                    end
                end))
            end)()
        end

        LPH_NO_VIRTUALIZE(function()
            local t = lib.Hint.Main.Main.Frame["1_main"].Text
            local hint = lib.Hint
            table.insert(_connections,Run.RenderStepped:Connect(function()
                local currentHint
                local objs = Core:GetGuiObjectsAtPosition(mouse.X,mouse.Y)
                for _,v in pairs(objs) do
                    if v:IsDescendantOf(lib) and v:FindFirstChild("Hint") and v.Hint:IsA("StringValue") then
                        v = v.Hint
                        local e = v
                        local allGood = true
                        while e.Parent~=game do
                            if (e:IsA("GuiObject") and not e.Visible) or (e:IsA("LayerCollector") and not e.Enabled) then
                                allGood = false
                                return
                            end
                            e = e.Parent
                        end
                        if allGood then
                            currentHint = v.Value
                            break
                        end
                    end
                end
                hint.Visible = currentHint and true
                t.Text = currentHint or ""
                hint.Position = UDim2.fromOffset(mouse.X-5,mouse.Y+30)
            end))
        end)()

        -- searching
        do
            local pages = lib.Main.Contents.Contents
            --local elementCache = {}

            local function doSearch(term)
                for _,page in pairs(pages:GetChildren()) do
                    local holder = page.ScrollingFrame

                    for _,v in pairs(holder:GetChildren()) do
                        if v:IsA("Frame") and not utility:IsPadding(v) then
                            for _,element in pairs(v.Contents:GetChildren()) do
                                if element:IsA("Frame") then
                                    if term == "" then
                                        element.Visible = true
                                    else
                                        local existingTitle = element:FindFirstChild("Title")
                                        local title
    
                                        if existingTitle==nil then
                                            title = element.Main.Title.Main.Title
                                        elseif existingTitle:IsA("Frame") then
                                            title = element.Title.Main.Title
                                        elseif existingTitle:IsA("TextLabel") then
                                            title = existingTitle
                                        else
                                            warn("Unrecognized title class name: "..existingTitle.ClassName)
                                        end
    
                                        local t1,t2 = title.Text:lower(),term:lower()
    
                                        if t1:find(t2) or t2:find(t1) then
                                            element.Visible = true
                                        else
                                            element.Visible = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            local searchBar = lib.Main.Contents.Top.SearchBar.TextBox

            local doSearchBtn = utility:CreateButtonObject(lib.Main.Contents.Top.SearchBar.Icon)

            doSearchBtn.Activated:Connect(function()
                searchBar:ReleaseFocus()
            end)

            searchBar:GetPropertyChangedSignal("Text"):Connect(function()
                doSearch(searchBar.Text)
            end)
        end

        lib.Main.Contents.Top.Info.Credits.Main.Frame.A.Text = info.Credit
        lib.Main.Contents.Top.Title.Text = info.Name

        for _,v in pairs(lib:GetDescendants()) do
            if v:IsA("StringValue") and v.Name=="Theme" and v.Category.Value=="Main" then
                v.Parent[v.Value] = info.Color
            end
        end

        lib.Notifications.Visible = true
        lib.Main.Visible = true
        lib.Hint.Visible = false

        local self = setmetatable({
            -- interface
            ["Flags"] = flags or {};
            -- hidden
            ["container"] = lib;
            ["name"] = info.Name;
            ["color"] = info.Color;
            ["toggleBind"] = info.Bind;
            -- used internally
            ["_connections"] = _connections;
            ["_drag_events"] = dragEvents;
            ["_page_num"] = 0;
            ["_section_update"] = sectionUpdateEvent;
            ["_saveCoroutine"] = saveCoroutine;
            ["_usedFlags"] = {};
            ["_closePages"] = closePages;
        }, Library)

        table.insert(self._connections,UIS.InputBegan:Connect(function(input,gpe)
            if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode.Name==self.toggleBind and not gpe then
                self:Toggle()
            end
        end))

        local closeBtn = utility:CreateButtonObject(lib.Main.Contents.Top.Close)

        closeBtn.Activated:Connect(function()
            self:Toggle(false)
        end)

        return self
    end
    function Library:SetToggle(keyCodeName)
        self.toggleBind = keyCodeName
    end
    function Library:Toggle(value)
        if value==nil then
            value = not self.container.Main.Visible
        end
        self.container.Main.Visible = value
        return value
    end
    function Library:CreatePage(name)
        self._page_num = self._page_num+1
        return Page.new(self, {
            ["Color"] = self.Color;
            ["Name"] = name;
        })
    end
    function Library:Notify(info)
        utility:Requirement(info.Title,"Missing title argument")
        utility:Requirement(info.Content,"Missing content argument")

        info.Duration = info.Duration or 3.5

        info.Callback = info.Callback or utility.BlankFunction

        local function makeNotif()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)

            -- Instances:

            local Converted = {
                ["_Notification"] = Instance.new("Frame");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Frame"] = Instance.new("Frame");
                ["_Shadow"] = Instance.new("Frame");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_No"] = Instance.new("ImageLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Yes"] = Instance.new("ImageLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Body"] = Instance.new("TextLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("TextLabel");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_UICorner"] = Instance.new("UICorner");
            }

            -- Properties:

            Converted["_Notification"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Notification"].BackgroundTransparency = 1
            Converted["_Notification"].Size = UDim2.new(1, 0, 0, 75)
            Converted["_Notification"].Name = "Notification"

            Converted["_Theme"].Value = "BackgroundColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Notification"]

            Converted["_Category"].Value = "Notification"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Frame"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Frame"].Parent = Converted["_Notification"]

            Converted["_Shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Shadow"].BackgroundTransparency = 1
            Converted["_Shadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Shadow"].Size = UDim2.new(1, 55, 1, 55)
            Converted["_Shadow"].ZIndex = 0
            Converted["_Shadow"].Name = "Shadow"
            Converted["_Shadow"].Parent = Converted["_Frame"]

            Converted["_ImageLabel"].Image = "rbxassetid://10955010523"
            Converted["_ImageLabel"].ImageColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ImageLabel"].ImageTransparency = 0.6499999761581421
            Converted["_ImageLabel"].ScaleType = Enum.ScaleType.Slice
            Converted["_ImageLabel"].SliceCenter = Rect.new(60, 60, 360, 360)
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ImageLabel"].ZIndex = 0
            Converted["_ImageLabel"].Parent = Converted["_Shadow"]

            Converted["_Theme1"].Value = "ImageColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_ImageLabel"]

            Converted["_Category1"].Value = "Shadow"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_No"].Image = "http://www.roblox.com/asset/?id=10259890025"
            Converted["_No"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_No"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_No"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_No"].BackgroundTransparency = 1
            Converted["_No"].Position = UDim2.new(0.970000029, 0, 0.699999988, 0)
            Converted["_No"].Size = UDim2.new(0, 23, 0, 23)
            Converted["_No"].Name = "No"
            Converted["_No"].Parent = Converted["_Frame"]

            Converted["_Theme2"].Value = "ImageColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_No"]

            Converted["_Category2"].Value = "Symbols"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Yes"].Image = "http://www.roblox.com/asset/?id=10954923256"
            Converted["_Yes"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Yes"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Yes"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Yes"].BackgroundTransparency = 1
            Converted["_Yes"].Position = UDim2.new(0.970000029, 0, 0.300000012, 0)
            Converted["_Yes"].Size = UDim2.new(0, 23, 0, 23)
            Converted["_Yes"].Name = "Yes"
            Converted["_Yes"].Parent = Converted["_Frame"]

            Converted["_Theme3"].Value = "ImageColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Yes"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Body"].Font = Enum.Font.Gotham
            Converted["_Body"].Text = "Body"
            Converted["_Body"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Body"].TextSize = 13
            Converted["_Body"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Body"].TextWrapped = true
            Converted["_Body"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Body"].TextYAlignment = Enum.TextYAlignment.Top
            Converted["_Body"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Body"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Body"].BackgroundTransparency = 1
            Converted["_Body"].Position = UDim2.new(0.0500000007, 0, 0.670000374, 0)
            Converted["_Body"].Size = UDim2.new(0.831538498, 0, 0.449999988, 0)
            Converted["_Body"].Name = "Body"
            Converted["_Body"].Parent = Converted["_Frame"]

            Converted["_Theme4"].Value = "TextColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Body"]

            Converted["_Category4"].Value = "Symbols"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Title"].Font = Enum.Font.GothamBold
            Converted["_Title"].Text = "Notification"
            Converted["_Title"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title"].TextSize = 15
            Converted["_Title"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title"].TextWrapped = true
            Converted["_Title"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0.0500000007, 0, 0.25, 0)
            Converted["_Title"].Size = UDim2.new(0.831538498, 0, 0.219999999, 0)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Frame"]

            Converted["_Theme5"].Value = "TextColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_Title"]

            Converted["_Category5"].Value = "Symbols"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_UICorner"].CornerRadius = UDim.new(0, 6)
            Converted["_UICorner"].Parent = Converted["_Frame"]

            return Converted["_Notification"]
        end
        local notif = makeNotif()
        notif.Name = tostring(os.clock())
        local holder = self.container.Notifications

        local tween = nil

        local start = UDim2.fromScale(-1.5,0)
        local finish = UDim2.fromScale(0,0)

        local function tweenIn()
            pcall(function()
                tween:Cancel()
                tween:Destroy()
            end)

            notif.Frame.Position = start

            tween = TS:Create(notif.Frame,TweenInfo.new(0.45,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{
                ["Position"] = finish;
            })
            tween:Play()
        end

        local leaving = false

        local function tweenOut()
            if leaving then return else leaving = true end
            pcall(function()
                tween:Cancel()
                tween:Destroy()
            end)

            notif.Frame.Position = finish

            tween = TS:Create(notif.Frame,TweenInfo.new(0.45,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{
                ["Position"] = start;
            })
            tween.Completed:Connect(function()
                notif:Destroy()
            end)
            tween:Play()
        end

        notif.Frame.No.Visible = info.ShowNoButton and true

        local yes = utility:CreateButtonObject(notif.Frame.Yes)
        local no = utility:CreateButtonObject(notif.Frame.No)

        yes.Activated:Connect(function()
            tweenOut()
            info.Callback(true)
        end)

        no.Activated:Connect(function()
            tweenOut()
            info.Callback(false)
        end)

        coroutine.resume(coroutine.create(function()
            task.wait(info.Duration)
            if not leaving then
                tweenOut()
            end
        end))

        notif.Frame.Title.Text = info.Title
        notif.Frame.Body.Text = info.Content

        notif.Parent = holder
        tweenIn()
    end
    function Library:Destroy()
        self.container:Destroy()
        for _,v in pairs(self._drag_events) do
            v:Disconnect()
        end
        for _,v in pairs(self._connections) do
            v:Disconnect()
        end
        self._section_update:Disconnect()
        coroutine.close(self._saveCoroutine)
        self = nil
        return nil
    end
end

-- PAGE
do
    function Page.new(_self,info) -- used internally and has no argument checks, use Library::CreatePage instead
        local container = _self.container
        local pageNum = _self._page_num

        local function makeSelector()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_0_page"] = Instance.new("Frame");
                ["_TextLabel"] = Instance.new("TextLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Button"] = Instance.new("TextButton");
            }

            --Properties

            Converted["_0_page"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_0_page"].BackgroundTransparency = 1
            Converted["_0_page"].Size = UDim2.new(1, 0, 0, 30)
            Converted["_0_page"].Name = "page"

            Converted["_TextLabel"].Font = Enum.Font.GothamMedium
            Converted["_TextLabel"].Text = "Example Page"
            Converted["_TextLabel"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_TextLabel"].TextSize = 14
            Converted["_TextLabel"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_TextLabel"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_TextLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextLabel"].BackgroundTransparency = 1
            Converted["_TextLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_TextLabel"].Size = UDim2.new(0.870000005, 0, 1, 0)
            Converted["_TextLabel"].Parent = Converted["_0_page"]

            Converted["_Theme"].Value = "TextColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_TextLabel"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_UICorner"].CornerRadius = UDim.new(0, 6)
            Converted["_UICorner"].Parent = Converted["_0_page"]

            Converted["_Theme1"].Value = "BackgroundColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_0_page"]

            Converted["_Category1"].Value = "PageSelect"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Button"].Font = Enum.Font.SourceSans
            Converted["_Button"].Text = ""
            Converted["_Button"].TextColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_Button"].TextSize = 14
            Converted["_Button"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Button"].BackgroundTransparency = 1
            Converted["_Button"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Button"].ZIndex = 5
            Converted["_Button"].Name = "Button"
            Converted["_Button"].Parent = Converted["_0_page"]

            return Converted["_0_page"]
        end

        local function makeContents()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_Page"] = Instance.new("Frame");
                ["_ScrollingFrame"] = Instance.new("ScrollingFrame");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_padding"] = Instance.new("Frame");
                ["_0_padding"] = Instance.new("Frame");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
            }

            --Properties

            Converted["_Page"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Page"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Page"].BackgroundTransparency = 1
            Converted["_Page"].Position = UDim2.new(1, -3, 0.5, 0)
            Converted["_Page"].Size = UDim2.new(1, -9, 1, -12)
            Converted["_Page"].Name = "Page"

            Converted["_ScrollingFrame"].AutomaticCanvasSize = Enum.AutomaticSize.Y
            Converted["_ScrollingFrame"].CanvasSize = UDim2.new(0, 0, 1, 0)
            Converted["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(151.00000619888306, 151.00000619888306, 151.00000619888306)
            Converted["_ScrollingFrame"].ScrollBarImageTransparency = 0.20000000298023224
            Converted["_ScrollingFrame"].ScrollBarThickness = 5
            Converted["_ScrollingFrame"].Active = true
            Converted["_ScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ScrollingFrame"].BackgroundTransparency = 1
            Converted["_ScrollingFrame"].BorderSizePixel = 0
            Converted["_ScrollingFrame"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ScrollingFrame"].Parent = Converted["_Page"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 8)
            Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_ScrollingFrame"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Size = UDim2.new(1, 0, 0, 0)
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_ScrollingFrame"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Size = UDim2.new(1, 0, 0, 0)
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_ScrollingFrame"]

            Converted["_Theme"].Value = "ScrollBarImageColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_ScrollingFrame"]

            Converted["_Category"].Value = "Scrollbar"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            return Converted["_Page"]
        end

        local selector = makeSelector()
        local contents = makeContents()

        selector.TextLabel.Text = info.Name
        local n = string.rep("_",pageNum)..info.Name
        selector.Name = n
        contents.Name = n

        local v1 = Instance.new("IntValue")
        v1.Name = "PageNum"
        v1.Value = pageNum
        v1.Parent = selector

        local v2 = Instance.new("IntValue")
        v2.Name = "PageNum"
        v2.Value = pageNum
        v2.Parent = selector

        v1.Parent = selector
        v2.Parent = contents

        selector.Button.Activated:Connect(function()
            container.Main.CurrentPage.Value = pageNum
            _self._closePages()
        end)

        selector.Parent = container.Main.Contents.Pages.ScrollingFrame
        contents.Parent = container.Main.Contents.Contents

        return setmetatable({
            ["_self"] = _self;
            ["superior"] = container;
            ["selector"] = selector;
            ["contents"] = contents;
            ["pageName"] = info.Name;
            ["pageNum"] = pageNum;
            ["sectionNum"] = 0;
            ["color"] = info.Color;
        }, Page)
    end

    function Page:CreateSection(name)
        self.sectionNum = self.sectionNum+1
        return Section.new(self,{
            ["Name"] = name;
            ["Page"] = self.contents;
        })
    end

    function Page:Destroy()
        self.selector:Destroy()
        self.contents:Destroy()
        self = nil
        return nil
    end
end

-- SECTION
do
    function Section.new(_self,info) -- used internally and has no argument checks, use Page::CreateSection instead
        local sectionNum = _self.sectionNum
        local color = _self.color

        local function makeSection()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_Section"] = Instance.new("Frame");
                ["_Contents"] = Instance.new("Frame");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Title"] = Instance.new("TextLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
            }

            --Properties

            Converted["_Section"].AutomaticSize = Enum.AutomaticSize.Y
            Converted["_Section"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Section"].BackgroundTransparency = 1
            Converted["_Section"].Size = UDim2.new(1, 0, 0, 10)
            Converted["_Section"].Name = "Section"

            Converted["_Contents"].AutomaticSize = Enum.AutomaticSize.Y
            Converted["_Contents"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Contents"].BackgroundTransparency = 1
            Converted["_Contents"].Position = UDim2.new(0, 13, 0, 20)
            Converted["_Contents"].Size = UDim2.new(0.973999977, -14, 0.875999987, 1)
            Converted["_Contents"].Name = "Contents"
            Converted["_Contents"].Parent = Converted["_Section"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 7)
            Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_Contents"]

            Converted["_Title"].Font = Enum.Font.Gotham
            Converted["_Title"].Text = "Section"
            Converted["_Title"].TextColor3 = Color3.fromRGB(165.00000536441803, 165.00000536441803, 165.00000536441803)
            Converted["_Title"].TextScaled = false
            Converted["_Title"].TextSize = 13
            Converted["_Title"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title"].TextWrapped = true
            Converted["_Title"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0, 13, 0, 0)
            Converted["_Title"].Size = UDim2.new(0.949999988, 0, 0, 13)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Section"]

            Converted["_Theme"].Value = "TextColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Title"]

            Converted["_Category"].Value = "GreyContrast"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            return Converted["_Section"]
        end

        local section = makeSection()

        local pageInner = info.Page.ScrollingFrame

        section.Title.Text = info.Name
        section.Name = string.rep("_",sectionNum)..info.Name

        section.Parent = pageInner

        return setmetatable({
            ["_self"] = _self._self;
            ["holder"] = section;
            ["sectionName"] = info.Name;
            ["elementNum"] = 0;
            ["color"] = color;
        }, Section)
    end
    function Section:CreateToggle(...)
        return Element.CreateToggle(self, ...)
    end
    function Section:CreateSlider(...)
        return Element.CreateSlider(self, ...)
    end
    function Section:CreateSliderToggle(...)
        return Element.CreateSliderToggle(self, ...)
    end
    function Section:CreateParagraph(...)
        local args = {...}
        if #args==1 and type(args[1])=="string" then
            args = {
                {
                    ["Content"] = args[1];
                }
            }
        end
        return Element.CreateParagraph(self, unpack(args))
    end
    function Section:CreateBody(...) -- alias for ::CreateParagraph as ::CreateBody was used in Artemis
        -- do not use, this can be removed at any time without notice, use ::CreateParagraph instead
        return Section:CreateParagraph(...)
    end
    function Section:CreateButton(...)
        return Element.CreateButton(self, ...)
    end
    function Section:CreateTextBox(...)
        return Element.CreateTextBox(self, ...)
    end
    function Section:CreateInteractable(...)
        return Element.CreateInteractable(self, ...)
    end
    function Section:CreateKeybind(...)
        return Element.CreateKeybind(self, ...)
    end
    function Section:CreateKeyBind(...) -- alias for ::CreateParagraph as ::CreateBody was used in Artemis
        -- do not use, this can be removed at any time without notice, use ::CreateParagraph instead
        return Section:CreateKeybind(...)
    end
    function Section:CreateDropdown(...)
        return Element.CreateDropdown(self, ...)
    end
    function Section:CreateColorPicker(...)
        return Element.CreateColorPicker(self, ...)
    end
end

-- ELEMENTS
do
    function Element.CreateToggle(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")
        utility:Requirement(info.Flag,"Missing flag argument")

        if _self._usedFlags[info.Flag] then
            warn("Flag must have unique name!")
            return
        else
            _self._usedFlags[info.Flag] = info.SavingDisabled and "disabled" or true
        end

        if info.Default == nil then
            info.Default = false
        end

        if _self.Flags[info.Flag]==nil then
            _self.Flags[info.Flag] = info.Default
        end

        if info.SavingDisabled then
            _self.Flags[info.Flag] = info.Default
        end

        info.Callback = info.Callback or utility.BlankFunction

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_0_Toggle"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Toggle"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_UIStroke"] = Instance.new("UIStroke");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_0_Toggle"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_0_Toggle"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_0_Toggle"].Name = "0_Toggle"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_0_Toggle"]

            Converted["_Toggle"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Toggle"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Toggle"].Position = UDim2.new(1, -18, 0.5, 0)
            Converted["_Toggle"].Size = UDim2.new(0, 19, 0, 19)
            Converted["_Toggle"].Name = "Toggle"
            Converted["_Toggle"].Parent = Converted["_0_Toggle"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 3)
            Converted["_UICorner1"].Parent = Converted["_Toggle"]

            Converted["_UIStroke"].Color = Color3.fromRGB(84.00000259280205, 84.00000259280205, 84.00000259280205)
            Converted["_UIStroke"].Parent = Converted["_Toggle"]

            Converted["_Theme"].Value = "Color"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_UIStroke"]

            Converted["_Category"].Value = "ToggleOutline"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_ImageLabel"].Image = "http://www.roblox.com/asset/?id=10954923256"
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Parent = Converted["_Toggle"]

            Converted["_Theme1"].Value = "ImageColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_ImageLabel"]

            Converted["_Category1"].Value = "SymbolSelect"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Theme2"].Value = "BackgroundColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Toggle"]

            Converted["_Category2"].Value = "Element"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Theme3"].Value = "BackgroundColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_0_Toggle"]

            Converted["_Category3"].Value = "Element"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0, 9, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(1, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_0_Toggle"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Toggle"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main"]

            Converted["_Theme4"].Value = "TextColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Title1"]

            Converted["_Category4"].Value = "Symbols"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme5"].Value = "ImageColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_Warning"]

            Converted["_Category5"].Value = "Warning"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Element"].Value = "Toggle"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_0_Toggle"]

            return Converted["_0_Toggle"]
        end

        local element = createElement()

        do -- toggling
            local toggle = element.Toggle
            local img = toggle.ImageLabel

            local toggleBtn = utility:CreateButtonObject(toggle)

            local tween1,tween2

            toggleBtn.Activated:Connect(function()
                _self.Flags[info.Flag] = not _self.Flags[info.Flag]
                coroutine.wrap(info.Callback)(_self.Flags[info.Flag])
            end)

            local bigButton = utility:CreateButtonObject(element)
            bigButton.ZIndex = 0
            bigButton.Activated:Connect(function()
                utility:DoClickEffect(element)
                _self.Flags[info.Flag] = not _self.Flags[info.Flag]
                coroutine.wrap(info.Callback)(_self.Flags[info.Flag])
            end)

            local tweenInfo = TweenInfo.new(0.1,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)

            local lastFlag = nil
            local con
            LPH_JIT_MAX(function()
                con = Run.RenderStepped:Connect(function()
                    local currentFlag = _self.Flags[info.Flag]

                    local imageGoalSize = currentFlag and UDim2.fromScale(0.9,0.9) or UDim2.fromScale(0,0)
                    local backgroundGoalColor = currentFlag and _self.color or Color3.fromRGB(28, 28, 28)
    
                    if lastFlag==nil then
                        toggle.BackgroundColor3 = backgroundGoalColor
                        img.Size = imageGoalSize
                    elseif lastFlag~=currentFlag then
                        pcall(function()
                            tween1:Disconnect()
                            tween1:Destroy()
                        end)
                        pcall(function()
                            tween2:Disconnect()
                            tween2:Destroy()
                        end)
                        tween1 = TS:Create(toggle,tweenInfo,{
                            ["BackgroundColor3"] = backgroundGoalColor
                        })
                        tween2 = TS:Create(img,tweenInfo,{
                            ["Size"] = imageGoalSize
                        })
                        tween1:Play()
                        tween2:Play()
                    end
                    lastFlag = currentFlag
                end)
            end)()
            table.insert(_self._connections,con)
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Toggle.ImageLabel.ImageColor3 = utility:GetTextContrast(_self.color)
        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateSlider(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")
        utility:Requirement(info.Flag,"Missing flag argument")
        utility:Requirement(info.Min,"Missing min argument")
        utility:Requirement(info.Max,"Missing max argument")
        utility:Requirement(info.Max>info.Min,"Max must be larger than min")

        if _self._usedFlags[info.Flag] then
            warn("Flag must have unique name!")
            return
        else
            _self._usedFlags[info.Flag] = true
        end

        if info.Default==nil then
            info.Default = info.Min
        end
        if info.AllowOutOfRange==nil then
            info.AllowOutOfRange = false
        end
        if info.Digits==nil then
            info.Digits = 0
        end
        info.Callback = info.Callback or utility.BlankFunction

        if _self.Flags[info.Flag]==nil then
            _self.Flags[info.Flag] = info.Default
        end

        if info.SavingDisabled then
            _self.Flags[info.Flag] = info.Default
        end

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_1_Slider"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Slider"] = Instance.new("ImageLabel");
                ["_Slider1"] = Instance.new("ImageLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Input"] = Instance.new("TextBox");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_1_Slider"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_1_Slider"].BorderColor3 = Color3.fromRGB(27.000000290572643, 42.000001296401024, 53.00000064074993)
            Converted["_1_Slider"].Position = UDim2.new(-1.51867283e-07, 0, 0.46425584, 0)
            Converted["_1_Slider"].Size = UDim2.new(1, 0, 0, 50)
            Converted["_1_Slider"].Name = "1_Slider"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_1_Slider"]

            Converted["_Slider"].Image = "rbxassetid://10261338527"
            Converted["_Slider"].ImageColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_Slider"].ScaleType = Enum.ScaleType.Slice
            Converted["_Slider"].SliceCenter = Rect.new(100, 100, 100, 100)
            Converted["_Slider"].AnchorPoint = Vector2.new(0.5, 1)
            Converted["_Slider"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Slider"].BackgroundTransparency = 1
            Converted["_Slider"].Position = UDim2.new(0.5, 0, 0.774999976, 0)
            Converted["_Slider"].Size = UDim2.new(1, -18, 0, 4)
            Converted["_Slider"].Name = "Slider"
            Converted["_Slider"].Parent = Converted["_1_Slider"]

            Converted["_Slider1"].Image = "rbxassetid://10261338527"
            Converted["_Slider1"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Slider1"].ScaleType = Enum.ScaleType.Slice
            Converted["_Slider1"].SliceCenter = Rect.new(100, 100, 100, 100)
            Converted["_Slider1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Slider1"].BackgroundTransparency = 1
            Converted["_Slider1"].Size = UDim2.new(0.5, 0, 1, 0)
            Converted["_Slider1"].Name = "Slider"
            Converted["_Slider1"].Parent = Converted["_Slider"]

            Converted["_Theme"].Value = "ImageColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Slider1"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Theme1"].Value = "ImageColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Slider"]

            Converted["_Category1"].Value = "Background"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Input"].Font = Enum.Font.GothamMedium
            Converted["_Input"].PlaceholderColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Input"].Text = "0"
            Converted["_Input"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Input"].TextSize = 14
            Converted["_Input"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Input"].TextXAlignment = Enum.TextXAlignment.Right
            Converted["_Input"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Input"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Input"].BackgroundTransparency = 1
            Converted["_Input"].Position = UDim2.new(0.999999881, -9, 0, 17)
            Converted["_Input"].Size = UDim2.new(0.309244812, -45, 0, 14)
            Converted["_Input"].Name = "Input"
            Converted["_Input"].Parent = Converted["_1_Slider"]

            Converted["_Theme2"].Value = "TextColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Input"]

            Converted["_Category2"].Value = "Symbols"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0, 8, 0, 17)
            Converted["_Title"].Size = UDim2.new(0.787999988, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_1_Slider"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Slider"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main"]

            Converted["_Theme3"].Value = "TextColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Title1"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme4"].Value = "ImageColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Warning"]

            Converted["_Category4"].Value = "Warning"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Theme5"].Value = "BackgroundColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_1_Slider"]

            Converted["_Category5"].Value = "Element"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Element"].Value = "Slider"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_1_Slider"]

            return Converted["_1_Slider"]
        end

        local element = createElement()

        do -- sliding
            local slider = element.Slider
            local inner = slider.Slider
            local sliderButton = utility:CreateButtonObject(slider)
            sliderButton.Size = UDim2.fromScale(1,3)
            local input = element.Input

            local dragging = false

            local lastFlag = nil
            local con
            local lastMouseX = mouse.X

            sliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)

            local lerp = 0.45
            local _last_text
            local _focused = false

            LPH_JIT_MAX(function()
                con = Run.RenderStepped:Connect(function(dt)
                    if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                        dragging = false
                    end
                    local finalX = utility:Lerp(lastMouseX,mouse.X,lerp*(dt*60)) -- deltatime in case of slow framerates
                    if dragging then
                        local percent = math.clamp((finalX-slider.AbsolutePosition.X)/slider.AbsoluteSize.X,0,1)
                        _self.Flags[info.Flag] = info.Min+((info.Max-info.Min)*percent)
                    end
                    if not info.AllowOutOfRange then
                        _self.Flags[info.Flag] = math.clamp(_self.Flags[info.Flag],info.Min,info.Max)
                    end
                    _self.Flags[info.Flag] = utility:FormatNumber(_self.Flags[info.Flag],info.Digits)
                    if dragging then
                        coroutine.wrap(info.Callback)(_self.Flags[info.Flag])
                    end
                    local currentFlag = _self.Flags[info.Flag]
                    if lastFlag~=currentFlag then
                        inner.Size = UDim2.fromScale(math.clamp((currentFlag-info.Min)/(info.Max-info.Min),0,1),1)
                        lastFlag = currentFlag
                        input.Text = currentFlag
                    end
                    lastMouseX = finalX
                    if _focused == false then
                        _last_text = input.Text
                    end
                end)
            end)()
            table.insert(_self._connections,con)

            input.Focused:Connect(function()
                _focused = true
            end)
    
            input.FocusLost:Connect(function(enterPressed)
                local newValue
                if enterPressed then
                    local text = input.Text
                    local num = tonumber(text)
                    if num then
                        if not info.AllowOutOfRange then
                            num = math.clamp(num,info.Min,info.Max)
                        end
                        input.Text = utility:FormatNumber(num,info.Digits)
                        newValue = num
                        _self.Flags[info.Flag] = newValue
                    else
                        input.Text = _last_text
                    end
                else
                    input.Text = _last_text
                end
    
                _focused = false
            end)
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateSliderToggle(section,info)
        local _self = section._self
        -- Requirements
        if info.Flag then
            warn("SliderToggle does not have a 'Flag' argument, as it instead has two flags titled 'SliderFlag' and 'ToggleFlag'. Please fix your script.")
        end
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")
        utility:Requirement(info.SliderFlag,"Missing slider flag argument")
        utility:Requirement(info.ToggleFlag,"Missing toggle flag argument")
        utility:Requirement(info.Min,"Missing min argument")
        utility:Requirement(info.Max,"Missing max argument")
        utility:Requirement(info.Max>info.Min,"Max must be larger than min")

        if _self._usedFlags[info.SliderFlag] then
            warn("Slider flag must have unique name!")
            return
        else
            _self._usedFlags[info.SliderFlag] = true
        end

        if _self._usedFlags[info.ToggleFlag] then
            warn("Toggle flag must have unique name!")
            return
        else
            _self._usedFlags[info.ToggleFlag] = true
        end

        info.SliderCallback = info.SliderCallback or utility.BlankFunction
        info.ToggleCallback = info.ToggleCallback or utility.BlankFunction

        if info.SliderDefault==nil then
            info.SliderDefault = info.Min
        end
        if info.ToggleDefault==nil then
            info.ToggleDefault = false
        end
        if info.AllowOutOfRange==nil then
            info.AllowOutOfRange = false
        end
        if info.Digits==nil then
            info.Digits = 0
        end

        if _self.Flags[info.SliderFlag]==nil then
            _self.Flags[info.SliderFlag] = info.SliderDefault
        end
        if _self.Flags[info.ToggleFlag]==nil then
            _self.Flags[info.ToggleFlag] = info.ToggleDefault
        end

        if info.SavingDisabled then
            _self.Flags[info.SliderFlag] = info.SliderDefault
            _self.Flags[info.ToggleFlag] = info.ToggleDefault
        end

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_2_SliderToggle"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Slider"] = Instance.new("ImageLabel");
                ["_Slider1"] = Instance.new("ImageLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Input"] = Instance.new("TextBox");
                ["_Toggle"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_UIStroke"] = Instance.new("UIStroke");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme6"] = Instance.new("StringValue");
                ["_Category6"] = Instance.new("StringValue");
                ["_Ignore6"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme7"] = Instance.new("StringValue");
                ["_Category7"] = Instance.new("StringValue");
                ["_Ignore7"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_2_SliderToggle"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_2_SliderToggle"].BorderColor3 = Color3.fromRGB(27.000000290572643, 42.000001296401024, 53.00000064074993)
            Converted["_2_SliderToggle"].Position = UDim2.new(0, 0, 0.627714336, 0)
            Converted["_2_SliderToggle"].Size = UDim2.new(1, 0, 0, 54)
            Converted["_2_SliderToggle"].Name = "SliderToggle"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_2_SliderToggle"]

            Converted["_Slider"].Image = "rbxassetid://10261338527"
            Converted["_Slider"].ImageColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_Slider"].ScaleType = Enum.ScaleType.Slice
            Converted["_Slider"].SliceCenter = Rect.new(100, 100, 100, 100)
            Converted["_Slider"].AnchorPoint = Vector2.new(0.5, 1)
            Converted["_Slider"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Slider"].BackgroundTransparency = 1
            Converted["_Slider"].Position = UDim2.new(0.479985327, 0, 0.761503458, 0)
            Converted["_Slider"].Size = UDim2.new(0.959725976, -18, 0, 4)
            Converted["_Slider"].Name = "Slider"
            Converted["_Slider"].Parent = Converted["_2_SliderToggle"]

            Converted["_Slider1"].Image = "rbxassetid://10261338527"
            Converted["_Slider1"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Slider1"].ScaleType = Enum.ScaleType.Slice
            Converted["_Slider1"].SliceCenter = Rect.new(100, 100, 100, 100)
            Converted["_Slider1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Slider1"].BackgroundTransparency = 1
            Converted["_Slider1"].Size = UDim2.new(0.5, 0, 1, 0)
            Converted["_Slider1"].Name = "Slider"
            Converted["_Slider1"].Parent = Converted["_Slider"]

            Converted["_Theme"].Value = "ImageColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Slider1"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Theme1"].Value = "ImageColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Slider"]

            Converted["_Category1"].Value = "Background"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Input"].Font = Enum.Font.GothamMedium
            Converted["_Input"].PlaceholderColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Input"].Text = "0"
            Converted["_Input"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Input"].TextSize = 14
            Converted["_Input"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Input"].TextXAlignment = Enum.TextXAlignment.Right
            Converted["_Input"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Input"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Input"].BackgroundTransparency = 1
            Converted["_Input"].Position = UDim2.new(0.999999881, -9, 0, 17)
            Converted["_Input"].Size = UDim2.new(0.350198835, -45, 0, 14)
            Converted["_Input"].Name = "Input"
            Converted["_Input"].Parent = Converted["_2_SliderToggle"]

            Converted["_Toggle"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Toggle"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Toggle"].Position = UDim2.new(1, -14, 0.699999988, 0)
            Converted["_Toggle"].Size = UDim2.new(0, 17, 0, 17)
            Converted["_Toggle"].Name = "Toggle"
            Converted["_Toggle"].Parent = Converted["_2_SliderToggle"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 3)
            Converted["_UICorner1"].Parent = Converted["_Toggle"]

            Converted["_UIStroke"].Color = Color3.fromRGB(84.00000259280205, 84.00000259280205, 84.00000259280205)
            Converted["_UIStroke"].Parent = Converted["_Toggle"]

            Converted["_Theme2"].Value = "Color"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_UIStroke"]

            Converted["_Category2"].Value = "ToggleOutline"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_ImageLabel"].Image = "http://www.roblox.com/asset/?id=10954923256"
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Parent = Converted["_Toggle"]

            Converted["_Theme3"].Value = "ImageColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_ImageLabel"]

            Converted["_Category3"].Value = "SymbolSelect"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Theme4"].Value = "BackgroundColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Toggle"]

            Converted["_Category4"].Value = "Element"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0, 7, 0, 17)
            Converted["_Title"].Size = UDim2.new(0.764999986, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_2_SliderToggle"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Slider Toggle"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main"]

            Converted["_Theme5"].Value = "TextColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_Title1"]

            Converted["_Category5"].Value = "Symbols"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme6"].Value = "ImageColor3"
            Converted["_Theme6"].Name = "Theme"
            Converted["_Theme6"].Parent = Converted["_Warning"]

            Converted["_Category6"].Value = "Warning"
            Converted["_Category6"].Name = "Category"
            Converted["_Category6"].Parent = Converted["_Theme6"]

            Converted["_Ignore6"].Name = "Ignore"
            Converted["_Ignore6"].Parent = Converted["_Theme6"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Theme7"].Value = "BackgroundColor3"
            Converted["_Theme7"].Name = "Theme"
            Converted["_Theme7"].Parent = Converted["_2_SliderToggle"]

            Converted["_Category7"].Value = "Element"
            Converted["_Category7"].Name = "Category"
            Converted["_Category7"].Parent = Converted["_Theme7"]

            Converted["_Ignore7"].Name = "Ignore"
            Converted["_Ignore7"].Parent = Converted["_Theme7"]

            Converted["_Element"].Value = "SliderToggle"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_2_SliderToggle"]

            return Converted["_2_SliderToggle"]
        end

        local element = createElement()

        do -- sliding
            local slider = element.Slider
            local inner = slider.Slider
            local sliderButton = utility:CreateButtonObject(slider)
            sliderButton.Size = UDim2.fromScale(1,3)
            local input = element.Input

            local dragging = false

            local lastFlag = nil
            local con
            local lastMouseX = mouse.X

            sliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)

            local lerp = 0.45
            local _last_text
            local _focused = false

            LPH_JIT_MAX(function()
                con = Run.RenderStepped:Connect(function(dt)
                    if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                        dragging = false
                    end
                    local finalX = utility:Lerp(lastMouseX,mouse.X,lerp*(dt*60)) -- deltatime in case of slow framerates
                    if dragging then
                        local percent = math.clamp((finalX-slider.AbsolutePosition.X)/slider.AbsoluteSize.X,0,1)
                        _self.Flags[info.SliderFlag] = info.Min+((info.Max-info.Min)*percent)
                    end
                    if not info.AllowOutOfRange then
                        _self.Flags[info.SliderFlag] = math.clamp(_self.Flags[info.SliderFlag],info.Min,info.Max)
                    end
                    _self.Flags[info.SliderFlag] = utility:FormatNumber(_self.Flags[info.SliderFlag],info.Digits)
                    if dragging then
                        coroutine.wrap(info.SliderCallback)(_self.Flags[info.SliderFlag])
                    end
                    local currentFlag = _self.Flags[info.SliderFlag]
                    if lastFlag~=currentFlag then
                        inner.Size = UDim2.fromScale(math.clamp((currentFlag-info.Min)/(info.Max-info.Min),0,1),1)
                        lastFlag = currentFlag
                        input.Text = currentFlag
                    end
                    lastMouseX = finalX
                    if _focused == false then
                        _last_text = input.Text
                    end
                end)
            end)()
            table.insert(_self._connections,con)

            input.Focused:Connect(function()
                _focused = true
            end)
    
            input.FocusLost:Connect(function(enterPressed)
                local newValue
                if enterPressed then
                    local text = input.Text
                    local num = tonumber(text)
                    if num then
                        if not info.AllowOutOfRange then
                            num = math.clamp(num,info.Min,info.Max)
                        end
                        input.Text = utility:FormatNumber(num,info.Digits)
                        newValue = num
                        _self.Flags[info.SliderFlag] = newValue
                    else
                        input.Text = _last_text
                    end
                else
                    input.Text = _last_text
                end
    
                _focused = false
            end)
        end

        do -- toggling
            local toggle = element.Toggle
            local img = toggle.ImageLabel

            local toggleBtn = utility:CreateButtonObject(toggle)

            local tween1,tween2

            toggleBtn.Activated:Connect(function()
                _self.Flags[info.ToggleFlag] = not _self.Flags[info.ToggleFlag]
                coroutine.wrap(info.ToggleCallback)(_self.Flags[info.ToggleFlag])
            end)

            local bigButton = utility:CreateButtonObject(element)
            bigButton.ZIndex = 0
            bigButton.Activated:Connect(function()
                utility:DoClickEffect(element)
                _self.Flags[info.ToggleFlag] = not _self.Flags[info.ToggleFlag]
                coroutine.wrap(info.ToggleCallback)(_self.Flags[info.ToggleFlag])
            end)

            local tweenInfo = TweenInfo.new(0.1,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)

            local lastFlag = nil
            local con
            LPH_JIT_MAX(function()
                con = Run.RenderStepped:Connect(function()
                    local currentFlag = _self.Flags[info.ToggleFlag]

                    local imageGoalSize = currentFlag and UDim2.fromScale(0.9,0.9) or UDim2.fromScale(0,0)
                    local backgroundGoalColor = currentFlag and _self.color or Color3.fromRGB(28, 28, 28)
    
                    if lastFlag==nil then
                        toggle.BackgroundColor3 = backgroundGoalColor
                        img.Size = imageGoalSize
                    elseif lastFlag~=currentFlag then
                        pcall(function()
                            tween1:Disconnect()
                            tween1:Destroy()
                        end)
                        pcall(function()
                            tween2:Disconnect()
                            tween2:Destroy()
                        end)
                        tween1 = TS:Create(toggle,tweenInfo,{
                            ["BackgroundColor3"] = backgroundGoalColor
                        })
                        tween2 = TS:Create(img,tweenInfo,{
                            ["Size"] = imageGoalSize
                        })
                        tween1:Play()
                        tween2:Play()
                    end
                    lastFlag = currentFlag
                end)
            end)()
            table.insert(_self._connections,con)
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Toggle.ImageLabel.ImageColor3 = utility:GetTextContrast(_self.color)
        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateParagraph(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Content,"Missing content argument")

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_3_Paragraph"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_0_padding"] = Instance.new("Frame");
                ["_padding"] = Instance.new("Frame");
                ["_Title"] = Instance.new("TextLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_3_Paragraph"].AutomaticSize = Enum.AutomaticSize.Y
            Converted["_3_Paragraph"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_3_Paragraph"].BorderColor3 = Color3.fromRGB(27.000000290572643, 42.000001296401024, 53.00000064074993)
            Converted["_3_Paragraph"].Position = UDim2.new(0, 0, 0.627714336, 0)
            Converted["_3_Paragraph"].Size = UDim2.new(1, 0, 0, 1)
            Converted["_3_Paragraph"].Name = "3_Paragraph"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_3_Paragraph"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Size = UDim2.new(1, 0, 0, 1)
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_3_Paragraph"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Size = UDim2.new(1, 0, 0, 1)
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_3_Paragraph"]

            Converted["_Title"].Font = Enum.Font.GothamMedium
            Converted["_Title"].RichText = true
            Converted["_Title"].Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            Converted["_Title"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title"].TextSize = 14
            Converted["_Title"].TextWrapped = true
            Converted["_Title"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title"].AnchorPoint = Vector2.new(0.5, 0)
            Converted["_Title"].AutomaticSize = Enum.AutomaticSize.Y
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(0.5, 0, 0, 0)
            Converted["_Title"].Size = UDim2.new(1, -18, 0, 1)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_3_Paragraph"]

            Converted["_Theme"].Value = "TextColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Title"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 9)
            Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_3_Paragraph"]

            Converted["_Theme1"].Value = "BackgroundColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_3_Paragraph"]

            Converted["_Category1"].Value = "Element"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Element"].Value = "Paragraph"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_3_Paragraph"]

            return Converted["_3_Paragraph"]
        end

        local element = createElement()

        local p = element.Title
        p.Text = info.Content

        element.Name = string.rep("_",elementNum).."Paragraph"
        element.Parent = section.holder.Contents

        return {
            ["Set"] = function(e)
                p.Text = e
            end;
            ["obj"] = p;
        }
    end
    function Element.CreateButton(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")

        info.Callback = info.Callback or utility.BlankFunction

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_4_Button"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Image"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Shade"] = Instance.new("Frame");
                ["_UICorner2"] = Instance.new("UICorner");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_4_Button"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_4_Button"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_4_Button"].Name = "Button"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_4_Button"]

            Converted["_Image"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Image"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Image"].BackgroundTransparency = 1
            Converted["_Image"].Position = UDim2.new(1, -18, 0.5, 0)
            Converted["_Image"].Size = UDim2.new(0, 24, 0, 24)
            Converted["_Image"].Name = "Image"
            Converted["_Image"].Parent = Converted["_4_Button"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 3)
            Converted["_UICorner1"].Parent = Converted["_Image"]

            Converted["_ImageLabel"].Image = "http://www.roblox.com/asset/?id=10967996591"
            Converted["_ImageLabel"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ImageLabel"].Parent = Converted["_Image"]

            Converted["_Theme"].Value = "ImageColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_ImageLabel"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(1, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_4_Button"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Button"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main"]

            Converted["_Theme1"].Value = "TextColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Title1"]

            Converted["_Category1"].Value = "Symbols"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme2"].Value = "ImageColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Warning"]

            Converted["_Category2"].Value = "Warning"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Theme3"].Value = "BackgroundColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_4_Button"]

            Converted["_Category3"].Value = "Element"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Shade"].BackgroundColor3 = Color3.fromRGB(67.00000360608101, 67.00000360608101, 67.00000360608101)
            Converted["_Shade"].BackgroundTransparency = 1
            Converted["_Shade"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Shade"].Name = "Shade"
            Converted["_Shade"].Parent = Converted["_4_Button"]

            Converted["_UICorner2"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner2"].Parent = Converted["_Shade"]

            Converted["_Theme4"].Value = "BackgroundColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Shade"]

            Converted["_Category4"].Value = "Shade"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Element"].Value = "Button"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_4_Button"]

            return Converted["_4_Button"]
        end

        local element = createElement()

        do -- button
            local btn = utility:CreateButtonObject(element)
            local shade = element.Shade
            shade.ZIndex = -1

            local goal = 0.9

            btn.Activated:Connect(function()
                utility:DoClickEffect(element)
                coroutine.wrap(info.Callback)()
            end)

            local tweenInfo = TweenInfo.new(0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)

            local function isMouseHovering()
                local mx,my = mouse.X,mouse.Y
                local ap,as = element.AbsolutePosition,element.AbsoluteSize
                return mx>ap.X and mx<(ap.X+as.X) and my>ap.Y and my<(ap.Y+as.Y)
            end

            local tween

            local con
            local last = nil
            LPH_JIT_MAX(function()
                con = mouse.Move:Connect(function()
                    local hovering = isMouseHovering()

                    if hovering ~= last then
                        pcall(function()
                            tween:Disconnect()
                            tween:Destroy()
                        end)
                        tween = TS:Create(shade,tweenInfo,{
                            ["BackgroundTransparency"] = hovering and goal or 1
                        })
                        tween:Play()
                    end

                    last = hovering
                end)
            end)()
            table.insert(_self._connections,con)
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateTextBox(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")
        utility:Requirement(info.Flag,"Missing flag argument")

        info.Callback = info.Callback or utility.BlankFunction
        info.TabComplete = info.TabComplete or utility.BlankFunction
        info.PlaceholderText = info.PlaceholderText or "No Text"
        info.DefaultText = info.DefaultText or ""

        if info.ClearTextOnFocus==nil then
            info.ClearTextOnFocus = true
        end

        if _self._usedFlags[info.Flag] then
            warn("Flag must have unique name!")
            return
        else
            _self._usedFlags[info.Flag] = true
        end

        _self.Flags[info.Flag] = _self.Flags[info.Flag] or info.DefaultText

        if info.SavingDisabled then
            _self.Flags[info.Flag] = info.DefaultText
        end

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_5_Textbox"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Input"] = Instance.new("Frame");
                ["_Frame"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_TextBox"] = Instance.new("TextBox");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_0_padding"] = Instance.new("Frame");
                ["_padding"] = Instance.new("Frame");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_5_Textbox"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_5_Textbox"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_5_Textbox"].Name = "5_Textbox"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_5_Textbox"]

            Converted["_Input"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Input"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Input"].BackgroundTransparency = 1
            Converted["_Input"].Position = UDim2.new(1.00000012, -10, 0.5, 0)
            Converted["_Input"].Size = UDim2.new(0.557544649, 1, 0.649999976, 0)
            Converted["_Input"].Name = "Input"
            Converted["_Input"].Parent = Converted["_5_Textbox"]

            Converted["_Frame"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Frame"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_Frame"].Position = UDim2.new(1, 0, 0.5, 0)
            Converted["_Frame"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Frame"].Parent = Converted["_Input"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner1"].Parent = Converted["_Frame"]

            Converted["_TextBox"].Font = Enum.Font.Gotham
            Converted["_TextBox"].PlaceholderColor3 = Color3.fromRGB(165.00000536441803, 165.00000536441803, 165.00000536441803)
            Converted["_TextBox"].PlaceholderText = "No Text"
            Converted["_TextBox"].Text = ""
            Converted["_TextBox"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_TextBox"].TextSize = 14
            Converted["_TextBox"].TextWrapped = true
            Converted["_TextBox"].TextXAlignment = Enum.TextXAlignment.Right
            Converted["_TextBox"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_TextBox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_TextBox"].BackgroundTransparency = 1
            Converted["_TextBox"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_TextBox"].Parent = Converted["_Frame"]

            Converted["_Theme"].Value = "TextColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_TextBox"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Theme1"].Value = "PlaceholderColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_TextBox"]

            Converted["_Category1"].Value = "GreyContrast"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_Frame"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_Frame"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 6)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].Parent = Converted["_Frame"]

            Converted["_Theme2"].Value = "BackgroundColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Frame"]

            Converted["_Category2"].Value = "Background"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(0.442000002, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_5_Textbox"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Textbox Textbox Textbox Textbox Textbox"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main"]

            Converted["_Theme3"].Value = "TextColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Title1"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme4"].Value = "ImageColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Warning"]

            Converted["_Category4"].Value = "Warning"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_UIListLayout1"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout1"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout1"].Parent = Converted["_Title"]

            Converted["_Theme5"].Value = "BackgroundColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_5_Textbox"]

            Converted["_Category5"].Value = "Element"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Element"].Value = "Textbox"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_5_Textbox"]

            return Converted["_5_Textbox"]
        end

        local element = createElement()

        -- textbox
        do
            local textbox = element.Input.Frame.TextBox

            textbox.ClearTextOnFocus = info.ClearTextOnFocus
            textbox.PlaceholderText = info.PlaceholderText
            textbox.Text = _self.Flags[info.Flag]

            textbox.FocusLost:Connect(function(enterPressed)
                local s,r = pcall(function()
                    info.Callback(textbox.Text,enterPressed)
                end)
                if not s then
                    warn("Callback error: "..r)
                end
                _self.Flags[info.Flag] = textbox.Text
            end)

            table.insert(_self._connections,UIS.InputBegan:Connect(function(input)
                if textbox:IsFocused() and input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.Tab then
                    local result
                    local s,r = pcall(function()
                        result = info.TabComplete(textbox.Text)
                    end)
                    if not s then
                        warn("Error in tab completion function: "..r)
                        error()
                    elseif (type(r)~="string" and r~=nil) then
                        warn("TabComplete function must return a string")
                        error()
                    end
                    local final = string.gsub(string.gsub(string.gsub(result or textbox.Text, "^%s+", ""), "%s+$", ""),"\t","")
                    textbox.Text = result or textbox.Text
                    textbox:GetPropertyChangedSignal("Text"):Wait()
                    textbox.Text = textbox.Text:gsub("\t",""):gsub( '^%s+', '' ):gsub( '%s+$', '' )
                end
            end))
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateInteractable(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")

        info.Callback = info.Callback or utility.BlankFunction

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_6_Interactable"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Interactable"] = Instance.new("Frame");
                ["_Frame"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_0_padding"] = Instance.new("Frame");
                ["_padding"] = Instance.new("Frame");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Title"] = Instance.new("TextLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Loading"] = Instance.new("Frame");
                ["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
                ["_Loading1"] = Instance.new("ImageLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Title1"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title2"] = Instance.new("TextLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_6_Interactable"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_6_Interactable"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_6_Interactable"].Name = "6_Interactable"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_6_Interactable"]

            Converted["_Interactable"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Interactable"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Interactable"].BackgroundTransparency = 1
            Converted["_Interactable"].ClipsDescendants = true
            Converted["_Interactable"].Position = UDim2.new(1.00000012, -10, 0.5, 0)
            Converted["_Interactable"].Size = UDim2.new(0.573000014, 0, 0.649999976, 0)
            Converted["_Interactable"].Name = "Interactable"
            Converted["_Interactable"].Parent = Converted["_6_Interactable"]

            Converted["_Frame"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Frame"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(164.00000542402267, 53.00000064074993, 90.00000223517418)
            Converted["_Frame"].Position = UDim2.new(1, 0, 0.5, 0)
            Converted["_Frame"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Frame"].Parent = Converted["_Interactable"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner1"].Parent = Converted["_Frame"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_Frame"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_Frame"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 6)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_Frame"]

            Converted["_Title"].Font = Enum.Font.Gotham
            Converted["_Title"].Text = "Execute"
            Converted["_Title"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title"].TextSize = 14
            Converted["_Title"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Frame"]

            Converted["_Theme"].Value = "TextColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Title"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Theme1"].Value = "BackgroundColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Frame"]

            Converted["_Category1"].Value = "Main"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Loading"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Loading"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Loading"].BackgroundTransparency = 1
            Converted["_Loading"].Size = UDim2.new(0, 17, 0, 17)
            Converted["_Loading"].Visible = false
            Converted["_Loading"].Name = "Loading"
            Converted["_Loading"].Parent = Converted["_Frame"]

            Converted["_UIAspectRatioConstraint"].Parent = Converted["_Loading"]

            Converted["_Loading1"].Image = "http://www.roblox.com/asset/?id=10262657333"
            Converted["_Loading1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Loading1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Loading1"].BackgroundTransparency = 1
            Converted["_Loading1"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Loading1"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Loading1"].Name = "Loading"
            Converted["_Loading1"].Parent = Converted["_Loading"]

            Converted["_Theme2"].Value = "ImageColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Loading1"]

            Converted["_Category2"].Value = "SymbolSelect"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Title1"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title1"].Size = UDim2.new(0.453000009, -45, 0, 14)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_6_Interactable"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title1"]

            Converted["_Title2"].Font = Enum.Font.GothamMedium
            Converted["_Title2"].Text = "Interactable"
            Converted["_Title2"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title2"].TextSize = 14
            Converted["_Title2"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title2"].TextWrapped = true
            Converted["_Title2"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title2"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title2"].BackgroundTransparency = 1
            Converted["_Title2"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title2"].Name = "Title"
            Converted["_Title2"].Parent = Converted["_Main"]

            Converted["_Theme3"].Value = "TextColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Title2"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title1"]

            Converted["_Theme4"].Value = "ImageColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Warning"]

            Converted["_Category4"].Value = "Warning"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_UIListLayout1"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout1"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout1"].Parent = Converted["_Title1"]

            Converted["_Theme5"].Value = "BackgroundColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_6_Interactable"]

            Converted["_Category5"].Value = "Element"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Element"].Value = "Interactable"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_6_Interactable"]

            return Converted["_6_Interactable"]
        end

        local element = createElement()
        local fr = element.Interactable.Frame
        local color = _self.color
        fr.BackgroundColor3 = color
        fr.Active = true
        local contrast = utility:GetTextContrast(color)
        fr.Title.TextColor3 = contrast
        fr.Title.Text = info.ActionText or "Interact"
        fr.Loading.Loading.ImageColor3 = contrast

        LPH_JIT_MAX(function()
            table.insert(_self._connections,Run.RenderStepped:Connect(function()
                fr.Loading.Loading.Rotation = (os.clock()*550)%360
            end))
        end)()

        do -- interactable
            local btn = fr

            btn.MouseEnter:Connect(function()
                local m = 0.8
                fr.BackgroundColor3 = Color3.new(color.R*m,color.G*m,color.B*m)
            end)

            btn.MouseLeave:Connect(function()
                fr.BackgroundColor3 = color
            end)

            btn.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 then
                    local m = 1.2
                    fr.BackgroundColor3 = Color3.new(color.R*m,color.G*m,color.B*m)
                end
            end)

            table.insert(_self._connections,UIS.InputEnded:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 then
                    fr.BackgroundColor3 = color
                end
            end))

            btn.InputEnded:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 and fr.Loading.Visible==false then
                    fr.Loading.Visible = true
                    fr.Title.Visible = false
                    local s,r = pcall(info.Callback)
                    if not s then
                        warn("Interactable Callback Error: "..r)
                    end
                    fr.Loading.Visible = false
                    fr.Title.Visible = true
                end
            end)
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateKeybind(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")
        utility:Requirement(info.Flag,"Missing flag argument")

        info.Callback = info.Callback or utility.BlankFunction
        info.KeyPressed = info.KeyPressed or utility.BlankFunction

        if info.Default and type(info.Default)=="string" then
            info.Default = Enum.KeyCode[info.Default]
        end
        info.Default = info.Default or Enum.KeyCode.Unknown

        if _self._usedFlags[info.Flag] then
            warn("Flag must have unique name!")
            return
        else
            _self._usedFlags[info.Flag] = true
        end

        _self.Flags[info.Flag] = _self.Flags[info.Flag] or info.Default

        if info.SavingDisabled then
            _self.Flags[info.Flag] = info.Default
        end

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_7_Keybind"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Frame"] = Instance.new("Frame");
                ["_Frame1"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_0_padding"] = Instance.new("Frame");
                ["_padding"] = Instance.new("Frame");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Title"] = Instance.new("TextLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Symbol"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Title1"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title2"] = Instance.new("TextLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_7_Keybind"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_7_Keybind"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_7_Keybind"].Name = "7_Keybind"
            Converted["_7_Keybind"].Parent = game:GetService("CoreGui")

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_7_Keybind"]

            Converted["_Frame"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame"].BackgroundTransparency = 1
            Converted["_Frame"].Position = UDim2.new(1.00000012, -10, 0.5, 0)
            Converted["_Frame"].Size = UDim2.new(0.572936594, 1, 0.649999976, 0)
            Converted["_Frame"].Parent = Converted["_7_Keybind"]

            Converted["_Frame1"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Frame1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Frame1"].BackgroundColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_Frame1"].Position = UDim2.new(1, 0, 0.5, 0)
            Converted["_Frame1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Frame1"].Parent = Converted["_Frame"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner1"].Parent = Converted["_Frame1"]

            Converted["_0_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_0_padding"].BackgroundTransparency = 1
            Converted["_0_padding"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_0_padding"].Name = "0_padding"
            Converted["_0_padding"].Parent = Converted["_Frame1"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_Frame1"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 5)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Center
            Converted["_UIListLayout"].Parent = Converted["_Frame1"]

            Converted["_Title"].Font = Enum.Font.Gotham
            Converted["_Title"].Text = "..."
            Converted["_Title"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title"].TextSize = 14
            Converted["_Title"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Frame1"]

            Converted["_Theme"].Value = "TextColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Title"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Symbol"].Image = "http://www.roblox.com/asset/?id=10298464250"
            Converted["_Symbol"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Symbol"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Symbol"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Symbol"].BackgroundTransparency = 1
            Converted["_Symbol"].Size = UDim2.new(0, 17, 0, 17)
            Converted["_Symbol"].Name = "Symbol"
            Converted["_Symbol"].Parent = Converted["_Frame1"]

            Converted["_UIAspectRatioConstraint"].Parent = Converted["_Symbol"]

            Converted["_Theme1"].Value = "ImageColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Symbol"]

            Converted["_Category1"].Value = "Symbols"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Theme2"].Value = "BackgroundColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Frame1"]

            Converted["_Category2"].Value = "Background"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Title1"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title1"].Size = UDim2.new(0.442000002, -45, 0, 14)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_7_Keybind"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title1"]

            Converted["_Title2"].Font = Enum.Font.GothamMedium
            Converted["_Title2"].Text = "Keybind"
            Converted["_Title2"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title2"].TextSize = 14
            Converted["_Title2"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title2"].TextWrapped = true
            Converted["_Title2"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title2"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title2"].BackgroundTransparency = 1
            Converted["_Title2"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title2"].Name = "Title"
            Converted["_Title2"].Parent = Converted["_Main"]

            Converted["_Theme3"].Value = "TextColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Title2"]

            Converted["_Category3"].Value = "Symbols"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title1"]

            Converted["_Theme4"].Value = "ImageColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Warning"]

            Converted["_Category4"].Value = "Warning"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_UIListLayout1"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout1"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout1"].Parent = Converted["_Title1"]

            Converted["_Theme5"].Value = "BackgroundColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_7_Keybind"]

            Converted["_Category5"].Value = "Element"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_Element"].Value = "Keybind"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_7_Keybind"]

            return Converted["_7_Keybind"]
        end

        local element = createElement()
        local fr = element.Frame.Frame
        fr.Active = true
        local key = fr.Title

        do -- keybind
            local listening = false
            local keyLastPressed = nil
            local lastPressed = nil
            table.insert(_self._connections,UIS.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.Keyboard then
                    keyLastPressed = input.KeyCode
                    lastPressed = os.clock()
                    if input.KeyCode == _self.Flags[info.Flag] and input.KeyCode~=Enum.KeyCode.Unknown then
                        info.KeyPressed()
                    end
                end
            end))
            fr.InputEnded:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 and listening==false then
                    listening = true
                    local save = tonumber(lastPressed)
                    repeat utility:Wait() until save~=lastPressed
                    if keyLastPressed==Enum.KeyCode.Backspace then
                        keyLastPressed = Enum.KeyCode.Unknown
                    end
                    _self.Flags[info.Flag] = keyLastPressed
                    listening = false
                    info.Callback(keyLastPressed)
                end
            end)
            LPH_JIT_MAX(function()
                table.insert(_self._connections,Run.RenderStepped:Connect(function()
                    key.Text = listening and "..." or ((_self.Flags[info.Flag]==nil or _self.Flags[info.Flag].Name=="Unknown") and "None" or _self.Flags[info.Flag].Name)
                end))
            end)()
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Title.Warning
        end

        element.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents
    end
    function Element.CreateDropdown(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")

        info.Callback = info.Callback or utility.BlankFunction
        info.Options = info.Options or {}

        if info.ItemSelecting==nil then
            info.ItemSelecting = false
        end
        info.DefaultItemSelected = info.DefaultItemSelected or "None"

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_8_Dropdown"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Arrow"] = Instance.new("ImageLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Fill"] = Instance.new("Frame");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main1"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
                ["_Secondary"] = Instance.new("Frame");
                ["_ScrollingFrame"] = Instance.new("ScrollingFrame");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_padding"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_Theme5"] = Instance.new("StringValue");
                ["_Category5"] = Instance.new("StringValue");
                ["_Ignore5"] = Instance.new("BoolValue");
                ["_UIListLayout2"] = Instance.new("UIListLayout");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_8_Dropdown"].AutomaticSize = Enum.AutomaticSize.Y
            Converted["_8_Dropdown"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_8_Dropdown"].BackgroundTransparency = 1
            Converted["_8_Dropdown"].Size = UDim2.new(1, 0, 0, 1)
            Converted["_8_Dropdown"].Name = "8_Dropdown"
            Converted["_8_Dropdown"].Parent = game:GetService("CoreGui")

            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Main"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_8_Dropdown"]

            Converted["_Arrow"].Image = "rbxassetid://10260760054"
            Converted["_Arrow"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Arrow"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_Arrow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Arrow"].BackgroundTransparency = 1
            Converted["_Arrow"].Position = UDim2.new(1, -9, 0.5, 0)
            Converted["_Arrow"].Size = UDim2.new(0, 21, 0, 21)
            Converted["_Arrow"].Name = "Arrow"
            Converted["_Arrow"].Parent = Converted["_Main"]

            Converted["_Theme"].Value = "ImageColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Arrow"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_Main"]

            Converted["_Fill"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Fill"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Fill"].BorderSizePixel = 0
            Converted["_Fill"].Position = UDim2.new(0, 0, 1, 0)
            Converted["_Fill"].Size = UDim2.new(1, 0, 0, 8)
            Converted["_Fill"].Visible = false
            Converted["_Fill"].ZIndex = 0
            Converted["_Fill"].Name = "Fill"
            Converted["_Fill"].Parent = Converted["_Main"]

            Converted["_Theme1"].Value = "BackgroundColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Fill"]

            Converted["_Category1"].Value = "Element"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(1, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Main"]

            Converted["_Main1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main1"].BackgroundTransparency = 1
            Converted["_Main1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main1"].Name = "Main"
            Converted["_Main1"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Dropdown"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main1"]

            Converted["_Theme2"].Value = "TextColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Title1"]

            Converted["_Category2"].Value = "Symbols"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme3"].Value = "ImageColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Warning"]

            Converted["_Category3"].Value = "Warning"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Theme4"].Value = "BackgroundColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_Main"]

            Converted["_Category4"].Value = "Element"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            Converted["_Secondary"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Secondary"].BorderSizePixel = 0
            Converted["_Secondary"].ClipsDescendants = true
            Converted["_Secondary"].Position = UDim2.new(0, 0, 0, 35)
            Converted["_Secondary"].Size = UDim2.new(1, 0, 0, 118)
            Converted["_Secondary"].Visible = false
            Converted["_Secondary"].Name = "Secondary"
            Converted["_Secondary"].Parent = Converted["_8_Dropdown"]

            Converted["_ScrollingFrame"].AutomaticCanvasSize = Enum.AutomaticSize.Y
            Converted["_ScrollingFrame"].CanvasSize = UDim2.new(0, 0, 0, 1)
            Converted["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_ScrollingFrame"].ScrollBarThickness = 0
            Converted["_ScrollingFrame"].Active = true
            Converted["_ScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ScrollingFrame"].BackgroundTransparency = 1
            Converted["_ScrollingFrame"].Size = UDim2.new(1, 0, 0, 117)
            Converted["_ScrollingFrame"].Parent = Converted["_Secondary"]

            Converted["_UIListLayout1"].Padding = UDim.new(0, 4)
            Converted["_UIListLayout1"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout1"].Parent = Converted["_ScrollingFrame"]

            Converted["_padding"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_padding"].BackgroundTransparency = 1
            Converted["_padding"].Size = UDim2.new(1, 0, 0, 0)
            Converted["_padding"].Name = "padding"
            Converted["_padding"].Parent = Converted["_ScrollingFrame"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner1"].Parent = Converted["_Secondary"]

            Converted["_Theme5"].Value = "BackgroundColor3"
            Converted["_Theme5"].Name = "Theme"
            Converted["_Theme5"].Parent = Converted["_Secondary"]

            Converted["_Category5"].Value = "Element"
            Converted["_Category5"].Name = "Category"
            Converted["_Category5"].Parent = Converted["_Theme5"]

            Converted["_Ignore5"].Name = "Ignore"
            Converted["_Ignore5"].Parent = Converted["_Theme5"]

            Converted["_UIListLayout2"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout2"].Parent = Converted["_8_Dropdown"]

            Converted["_Element"].Value = "Dropdown"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_8_Dropdown"]

            return Converted["_8_Dropdown"]
        end

        local element = createElement()

        local isOpen,closeDropdown do -- dropdown
            local open = false
            local tween1 = nil
            local tween2

            local openProperty = UDim2.new(1, 0, 0, 118)
            local closeProperty = UDim2.new(1, 0, 0, 0)

            local tweenInfo = TweenInfo.new(0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)

            element.Secondary.Visible = false

            local function toggleDropdown()
                open = not open
                pcall(function()
                    tween1:Cancel()
                    tween1:Destroy()
                    tween2:Cancel()
                    tween2:Destroy()
                end)
                if open then
                    element.Main.Fill.Visible = true
                    element.Secondary.Visible = true
                    element.Secondary.Size = closeProperty
                end
                tween1 = TS:Create(element.Secondary,tweenInfo,{
                    ["Size"] = open and openProperty or closeProperty
                })
                tween2 = TS:Create(element.Main.Arrow,tweenInfo,{
                    ["Rotation"] = open and 180 or 0
                })
                if not open then
                    tween1.Completed:Connect(function(p)
                        if p==Enum.PlaybackState.Completed then
                            element.Main.Fill.Visible = false
                            element.Secondary.Visible = false
                        end
                    end)
                end
                tween1:Play()
                tween2:Play()
            end

            function isOpen()
                return open
            end

            function closeDropdown()
                if open then toggleDropdown() end
            end

            local btn = utility:CreateButtonObject(element.Main)

            btn.Activated:Connect(toggleDropdown)
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Main.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Main.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Main.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Main.Title.Warning
        end

        element.Main.Title.Main.Title.Text = info.Name .. (info.ItemSelecting and (": "..info.DefaultItemSelected) or "")
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents

        local scroll = element.Secondary.ScrollingFrame
        local function makeButton(func)
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_1_button"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Image"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_Title"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Shade"] = Instance.new("Frame");
                ["_UICorner2"] = Instance.new("UICorner");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Theme4"] = Instance.new("StringValue");
                ["_Category4"] = Instance.new("StringValue");
                ["_Ignore4"] = Instance.new("BoolValue");
            }

            --Properties

            Converted["_1_button"].BackgroundColor3 = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_1_button"].Size = UDim2.new(0.970000029, 0, 0, 35)
            Converted["_1_button"].Name = "1_button"

            Converted["_UICorner"].CornerRadius = UDim.new(0, 5)
            Converted["_UICorner"].Parent = Converted["_1_button"]

            Converted["_Image"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Image"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Image"].BackgroundTransparency = 1
            Converted["_Image"].Position = UDim2.new(1, -18, 0.5, 0)
            Converted["_Image"].Size = UDim2.new(0, 24, 0, 24)
            Converted["_Image"].Name = "Image"
            Converted["_Image"].Parent = Converted["_1_button"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 3)
            Converted["_UICorner1"].Parent = Converted["_Image"]

            Converted["_ImageLabel"].Image = "http://www.roblox.com/asset/?id=10967996591"
            Converted["_ImageLabel"].ImageColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ImageLabel"].Parent = Converted["_Image"]

            Converted["_Theme"].Value = "ImageColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_ImageLabel"]

            Converted["_Category"].Value = "Symbols"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(1, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_1_button"]

            Converted["_Main"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main"].BackgroundTransparency = 1
            Converted["_Main"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Button"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main"]

            Converted["_Theme1"].Value = "TextColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Title1"]

            Converted["_Category1"].Value = "Symbols"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme2"].Value = "ImageColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Warning"]

            Converted["_Category2"].Value = "Warning"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Shade"].BackgroundColor3 = Color3.fromRGB(67.00000360608101, 67.00000360608101, 67.00000360608101)
            Converted["_Shade"].BackgroundTransparency = 1
            Converted["_Shade"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Shade"].Name = "Shade"
            Converted["_Shade"].Parent = Converted["_1_button"]

            Converted["_UICorner2"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner2"].Parent = Converted["_Shade"]

            Converted["_Theme3"].Value = "BackgroundColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Shade"]

            Converted["_Category3"].Value = "Shade"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Theme4"].Value = "BackgroundColor3"
            Converted["_Theme4"].Name = "Theme"
            Converted["_Theme4"].Parent = Converted["_1_button"]

            Converted["_Category4"].Value = "Background"
            Converted["_Category4"].Name = "Category"
            Converted["_Category4"].Parent = Converted["_Theme4"]

            Converted["_Ignore4"].Name = "Ignore"
            Converted["_Ignore4"].Parent = Converted["_Theme4"]

            do -- button
                local element = Converted["_1_button"]
                local btn = utility:CreateButtonObject(element)
                local shade = element.Shade
                shade.ZIndex = -1
    
                local goal = 0.95
    
                btn.Activated:Connect(function()
                    utility:DoClickEffect(element)
                    coroutine.wrap(func)(element)
                end)

                local tweenInfo = TweenInfo.new(0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)
    
                local function isMouseHovering()
                    local mx,my = mouse.X,mouse.Y
                    local ap,as = element.AbsolutePosition,element.AbsoluteSize
                    return mx>ap.X and mx<(ap.X+as.X) and my>ap.Y and my<(ap.Y+as.Y)
                end
    
                local tween
    
                local con
                local last = nil
                LPH_JIT_MAX(function()
                    con = mouse.Move:Connect(function()
                        local hovering = isMouseHovering()
    
                        if hovering ~= last then
                            pcall(function()
                                tween:Disconnect()
                                tween:Destroy()
                            end)
                            tween = TS:Create(shade,tweenInfo,{
                                ["BackgroundTransparency"] = hovering and goal or 1
                            })
                            tween:Play()
                        end
    
                        last = hovering
                    end)
                end)()
                element.Destroying:Connect(function()
                    con:Disconnect()
                end)
                return element
            end
        end
        local function getFrameChildren()
            local i = {}
            for _,v in ipairs(scroll:GetChildren()) do
                if v:IsA("Frame") and v.Name ~= "padding" then
                    table.insert(i,v)
                end
            end
            return i
        end
        local function update(tbl)
            local children = getFrameChildren()
            local existing = #children -- ui layout
            local deficit = (#tbl)-existing

            if deficit>0 then
                for _=1,deficit do
                    makeButton(function(obj)
                        if isOpen() then
                            local txt = obj.Title.Main.Title.Text
                            coroutine.wrap(info.Callback)(txt)
                            if info.ItemSelecting then
                                closeDropdown()
                                element.Main.Title.Main.Title.Text = info.Name .. (info.ItemSelecting and (": "..txt) or "")
                            end
                        end
                    end).Parent = scroll
                end
            elseif deficit<0 then
                for i=1,-deficit do
                    children[i]:Destroy()
                end
            end

            children = getFrameChildren()

            for i,v in ipairs(tbl) do
                local obj = children[i]
                obj.Name = string.rep("!",i)
                obj.Title.Warning.Visible = false -- disabled for now because I don't remember why I included this in the first place
                obj.Title.Main.Title.Text = v or ""
            end
        end
        update(info.Options)
        return {
            ["Update"] = function(self,...)
                return update(...)
            end
        }
    end
    function Element.CreateColorPicker(section,info)
        local _self = section._self
        -- Requirements
        utility:Requirement(type(info)=="table","Info must be a table!")
        utility:Requirement(info.Name,"Missing name argument")
        utility:Requirement(info.Flag,"Missing flag argument")

        info.Callback = info.Callback or utility.BlankFunction
        _self.Flags[info.Flag] = _self.Flags[info.Flag] or info.Default or Color3.new(1,1,1)

        if info.SavingDisabled then
            _self.Flags[info.Flag] = info.Default
        end

        section.elementNum = section.elementNum+1

        local elementNum = section.elementNum

        local function createElement()
            -- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)
            local Converted = {
                ["_9_ColorPicker"] = Instance.new("Frame");
                ["_Main"] = Instance.new("Frame");
                ["_UICorner"] = Instance.new("UICorner");
                ["_Fill"] = Instance.new("Frame");
                ["_Theme"] = Instance.new("StringValue");
                ["_Category"] = Instance.new("StringValue");
                ["_Ignore"] = Instance.new("BoolValue");
                ["_CurrentColor"] = Instance.new("Frame");
                ["_UICorner1"] = Instance.new("UICorner");
                ["_ImageLabel"] = Instance.new("ImageLabel");
                ["_UICorner2"] = Instance.new("UICorner");
                ["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
                ["_UIStroke"] = Instance.new("UIStroke");
                ["_Title"] = Instance.new("Frame");
                ["_Main1"] = Instance.new("Frame");
                ["_Title1"] = Instance.new("TextLabel");
                ["_Theme1"] = Instance.new("StringValue");
                ["_Category1"] = Instance.new("StringValue");
                ["_Ignore1"] = Instance.new("BoolValue");
                ["_Warning"] = Instance.new("ImageLabel");
                ["_Theme2"] = Instance.new("StringValue");
                ["_Category2"] = Instance.new("StringValue");
                ["_Ignore2"] = Instance.new("BoolValue");
                ["_UIListLayout"] = Instance.new("UIListLayout");
                ["_Theme3"] = Instance.new("StringValue");
                ["_Category3"] = Instance.new("StringValue");
                ["_Ignore3"] = Instance.new("BoolValue");
                ["_Secondary"] = Instance.new("Frame");
                ["_UICorner3"] = Instance.new("UICorner");
                ["_Frame"] = Instance.new("Frame");
                ["_Frame1"] = Instance.new("Frame");
                ["_Frame2"] = Instance.new("Frame");
                ["_Second"] = Instance.new("Frame");
                ["_UICorner4"] = Instance.new("UICorner");
                ["_UIGradient"] = Instance.new("UIGradient");
                ["_Black"] = Instance.new("Frame");
                ["_UIGradient1"] = Instance.new("UIGradient");
                ["_UICorner5"] = Instance.new("UICorner");
                ["_Frame3"] = Instance.new("Frame");
                ["_ImageLabel1"] = Instance.new("ImageLabel");
                ["_Button"] = Instance.new("TextButton");
                ["_Rainbow"] = Instance.new("Frame");
                ["_Rainbow1"] = Instance.new("UIGradient");
                ["_UICorner6"] = Instance.new("UICorner");
                ["_Frame4"] = Instance.new("Frame");
                ["_UICorner7"] = Instance.new("UICorner");
                ["_ImageLabel2"] = Instance.new("ImageLabel");
                ["_UIAspectRatioConstraint1"] = Instance.new("UIAspectRatioConstraint");
                ["_Button1"] = Instance.new("TextButton");
                ["_UIAspectRatioConstraint2"] = Instance.new("UIAspectRatioConstraint");
                ["_UIListLayout1"] = Instance.new("UIListLayout");
                ["_Element"] = Instance.new("StringValue");
            }

            --Properties

            Converted["_9_ColorPicker"].AutomaticSize = Enum.AutomaticSize.Y
            Converted["_9_ColorPicker"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_9_ColorPicker"].BackgroundTransparency = 1
            Converted["_9_ColorPicker"].Size = UDim2.new(1, 0, 0, 1)
            Converted["_9_ColorPicker"].Name = "9_ColorPicker"

            Converted["_Main"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Main"].Size = UDim2.new(1, 0, 0, 35)
            Converted["_Main"].Name = "Main"
            Converted["_Main"].Parent = Converted["_9_ColorPicker"]

            Converted["_UICorner"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner"].Parent = Converted["_Main"]

            Converted["_Fill"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Fill"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Fill"].BorderSizePixel = 0
            Converted["_Fill"].Position = UDim2.new(0, 0, 1, 0)
            Converted["_Fill"].Size = UDim2.new(1, 0, 0, 8)
            Converted["_Fill"].Visible = false
            Converted["_Fill"].ZIndex = 0
            Converted["_Fill"].Name = "Fill"
            Converted["_Fill"].Parent = Converted["_Main"]

            Converted["_Theme"].Value = "BackgroundColor3"
            Converted["_Theme"].Name = "Theme"
            Converted["_Theme"].Parent = Converted["_Fill"]

            Converted["_Category"].Value = "Element"
            Converted["_Category"].Name = "Category"
            Converted["_Category"].Parent = Converted["_Theme"]

            Converted["_Ignore"].Name = "Ignore"
            Converted["_Ignore"].Parent = Converted["_Theme"]

            Converted["_CurrentColor"].AnchorPoint = Vector2.new(1, 0.5)
            Converted["_CurrentColor"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_CurrentColor"].Position = UDim2.new(1, -10, 0.5, 0)
            Converted["_CurrentColor"].Size = UDim2.new(0, 40, 0, 20)
            Converted["_CurrentColor"].Name = "CurrentColor"
            Converted["_CurrentColor"].Parent = Converted["_Main"]

            Converted["_UICorner1"].CornerRadius = UDim.new(0, 7)
            Converted["_UICorner1"].Parent = Converted["_CurrentColor"]

            Converted["_ImageLabel"].Image = "rbxassetid://10968541736"
            Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel"].BackgroundTransparency = 1
            Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel"].Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
            Converted["_ImageLabel"].Visible = false
            Converted["_ImageLabel"].ZIndex = 3
            Converted["_ImageLabel"].Parent = Converted["_CurrentColor"]

            Converted["_UICorner2"].Parent = Converted["_ImageLabel"]

            Converted["_UIAspectRatioConstraint"].Parent = Converted["_ImageLabel"]

            Converted["_UIStroke"].Color = Color3.fromRGB(18.000000827014446, 18.000000827014446, 18.000000827014446)
            Converted["_UIStroke"].Parent = Converted["_CurrentColor"]

            Converted["_Title"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title"].BackgroundTransparency = 1
            Converted["_Title"].Position = UDim2.new(-0, 9, 0.5, 0)
            Converted["_Title"].Size = UDim2.new(0.936999977, -45, 0, 14)
            Converted["_Title"].Name = "Title"
            Converted["_Title"].Parent = Converted["_Main"]

            Converted["_Main1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Main1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Main1"].BackgroundTransparency = 1
            Converted["_Main1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Main1"].Name = "Main"
            Converted["_Main1"].Parent = Converted["_Title"]

            Converted["_Title1"].Font = Enum.Font.GothamMedium
            Converted["_Title1"].Text = "Color Picker"
            Converted["_Title1"].TextColor3 = Color3.fromRGB(225.00000178813934, 225.00000178813934, 225.00000178813934)
            Converted["_Title1"].TextSize = 14
            Converted["_Title1"].TextTruncate = Enum.TextTruncate.AtEnd
            Converted["_Title1"].TextWrapped = true
            Converted["_Title1"].TextXAlignment = Enum.TextXAlignment.Left
            Converted["_Title1"].AutomaticSize = Enum.AutomaticSize.X
            Converted["_Title1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Title1"].BackgroundTransparency = 1
            Converted["_Title1"].Size = UDim2.new(0, 1, 1, 0)
            Converted["_Title1"].Name = "Title"
            Converted["_Title1"].Parent = Converted["_Main1"]

            Converted["_Theme1"].Value = "TextColor3"
            Converted["_Theme1"].Name = "Theme"
            Converted["_Theme1"].Parent = Converted["_Title1"]

            Converted["_Category1"].Value = "Symbols"
            Converted["_Category1"].Name = "Category"
            Converted["_Category1"].Parent = Converted["_Theme1"]

            Converted["_Ignore1"].Name = "Ignore"
            Converted["_Ignore1"].Parent = Converted["_Theme1"]

            Converted["_Warning"].Image = "http://www.roblox.com/asset/?id=10969141992"
            Converted["_Warning"].ImageColor3 = Color3.fromRGB(255, 249.0000155568123, 53.000004440546036)
            Converted["_Warning"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Warning"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Warning"].BackgroundTransparency = 1
            Converted["_Warning"].Size = UDim2.new(0, 16, 0, 16)
            Converted["_Warning"].Visible = false
            Converted["_Warning"].Name = "Warning"
            Converted["_Warning"].Parent = Converted["_Title"]

            Converted["_Theme2"].Value = "ImageColor3"
            Converted["_Theme2"].Name = "Theme"
            Converted["_Theme2"].Parent = Converted["_Warning"]

            Converted["_Category2"].Value = "Warning"
            Converted["_Category2"].Name = "Category"
            Converted["_Category2"].Parent = Converted["_Theme2"]

            Converted["_Ignore2"].Name = "Ignore"
            Converted["_Ignore2"].Parent = Converted["_Theme2"]

            Converted["_UIListLayout"].Padding = UDim.new(0, 2)
            Converted["_UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
            Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
            Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
            Converted["_UIListLayout"].Parent = Converted["_Title"]

            Converted["_Theme3"].Value = "BackgroundColor3"
            Converted["_Theme3"].Name = "Theme"
            Converted["_Theme3"].Parent = Converted["_Main"]

            Converted["_Category3"].Value = "Element"
            Converted["_Category3"].Name = "Category"
            Converted["_Category3"].Parent = Converted["_Theme3"]

            Converted["_Ignore3"].Name = "Ignore"
            Converted["_Ignore3"].Parent = Converted["_Theme3"]

            Converted["_Secondary"].BackgroundColor3 = Color3.fromRGB(28.000000230968, 28.000000230968, 28.000000230968)
            Converted["_Secondary"].BorderSizePixel = 0
            Converted["_Secondary"].ClipsDescendants = true
            Converted["_Secondary"].Position = UDim2.new(0, 0, 0, 35)
            Converted["_Secondary"].Size = UDim2.new(1, 0, 0, 118)
            Converted["_Secondary"].Visible = false
            Converted["_Secondary"].Name = "Secondary"
            Converted["_Secondary"].Parent = Converted["_9_ColorPicker"]

            Converted["_UICorner3"].CornerRadius = UDim.new(0, 4)
            Converted["_UICorner3"].Parent = Converted["_Secondary"]

            Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame"].BackgroundTransparency = 1
            Converted["_Frame"].Size = UDim2.new(1, 0, 0, 118)
            Converted["_Frame"].Parent = Converted["_Secondary"]

            Converted["_Frame1"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Frame1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame1"].BackgroundTransparency = 1
            Converted["_Frame1"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Frame1"].Size = UDim2.new(0.899999976, 0, 0.880999982, 0)
            Converted["_Frame1"].Parent = Converted["_Frame"]

            Converted["_Frame2"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Frame2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame2"].BackgroundTransparency = 1
            Converted["_Frame2"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_Frame2"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Frame2"].Parent = Converted["_Frame1"]

            Converted["_Second"].Active = true
            Converted["_Second"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Second"].Size = UDim2.new(0.872727275, 0, 0.980769217, 0)
            Converted["_Second"].Name = "Second"
            Converted["_Second"].Parent = Converted["_Frame2"]

            Converted["_UICorner4"].CornerRadius = UDim.new(0, 3)
            Converted["_UICorner4"].Parent = Converted["_Second"]

            Converted["_UIGradient"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
            }
            Converted["_UIGradient"].Parent = Converted["_Second"]

            Converted["_Black"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Black"].BorderSizePixel = 0
            Converted["_Black"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Black"].Name = "Black"
            Converted["_Black"].Parent = Converted["_Second"]

            Converted["_UIGradient1"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
            }
            Converted["_UIGradient1"].Rotation = 90
            Converted["_UIGradient1"].Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 0)
            }
            Converted["_UIGradient1"].Parent = Converted["_Black"]

            Converted["_UICorner5"].CornerRadius = UDim.new(0, 2)
            Converted["_UICorner5"].Parent = Converted["_Black"]

            Converted["_Frame3"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_Frame3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame3"].BackgroundTransparency = 1
            Converted["_Frame3"].Position = UDim2.new(1, 0, 0, 0)
            Converted["_Frame3"].Size = UDim2.new(0, 18, 0, 18)
            Converted["_Frame3"].Parent = Converted["_Black"]

            Converted["_ImageLabel1"].Image = "rbxassetid://4805639000"
            Converted["_ImageLabel1"].SliceCenter = Rect.new(128, 128, 128, 128)
            Converted["_ImageLabel1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel1"].BackgroundTransparency = 1
            Converted["_ImageLabel1"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_ImageLabel1"].Parent = Converted["_Frame3"]

            Converted["_Button"].Font = Enum.Font.SourceSans
            Converted["_Button"].Text = ""
            Converted["_Button"].TextColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_Button"].TextSize = 14
            Converted["_Button"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Button"].BackgroundTransparency = 1
            Converted["_Button"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Button"].Name = "Button"
            Converted["_Button"].Parent = Converted["_Second"]

            Converted["_Rainbow"].AnchorPoint = Vector2.new(1, 0)
            Converted["_Rainbow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Rainbow"].Position = UDim2.new(1, 0, 0, 0)
            Converted["_Rainbow"].Size = UDim2.new(0.0909090936, 0, 0.961538434, 0)
            Converted["_Rainbow"].Name = "Rainbow"
            Converted["_Rainbow"].Parent = Converted["_Frame2"]

            Converted["_Rainbow1"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4.000000236555934)),
                ColorSequenceKeypoint.new(0.20000000298023224, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.4000000059604645, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.6000000238418579, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.800000011920929, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
            }
            Converted["_Rainbow1"].Rotation = 90
            Converted["_Rainbow1"].Name = "Rainbow"
            Converted["_Rainbow1"].Parent = Converted["_Rainbow"]

            Converted["_UICorner6"].CornerRadius = UDim.new(0, 3)
            Converted["_UICorner6"].Parent = Converted["_Rainbow"]

            Converted["_Frame4"].AnchorPoint = Vector2.new(0, 0.5)
            Converted["_Frame4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Frame4"].BackgroundTransparency = 1
            Converted["_Frame4"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Frame4"].Parent = Converted["_Rainbow"]

            Converted["_UICorner7"].CornerRadius = UDim.new(1, 0)
            Converted["_UICorner7"].Parent = Converted["_Frame4"]

            Converted["_ImageLabel2"].Image = "rbxassetid://4805639000"
            Converted["_ImageLabel2"].SliceCenter = Rect.new(128, 128, 128, 128)
            Converted["_ImageLabel2"].AnchorPoint = Vector2.new(0.5, 0.5)
            Converted["_ImageLabel2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_ImageLabel2"].BackgroundTransparency = 1
            Converted["_ImageLabel2"].Position = UDim2.new(0.5, 0, 0.5, 0)
            Converted["_ImageLabel2"].Size = UDim2.new(0, 18, 0, 18)
            Converted["_ImageLabel2"].Parent = Converted["_Frame4"]

            Converted["_UIAspectRatioConstraint1"].Parent = Converted["_Frame4"]

            Converted["_Button1"].Font = Enum.Font.SourceSans
            Converted["_Button1"].Text = ""
            Converted["_Button1"].TextColor3 = Color3.fromRGB(0, 0, 0)
            Converted["_Button1"].TextSize = 14
            Converted["_Button1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Converted["_Button1"].BackgroundTransparency = 1
            Converted["_Button1"].Size = UDim2.new(1, 0, 1, 0)
            Converted["_Button1"].Name = "Button"
            Converted["_Button1"].Parent = Converted["_Rainbow"]

            Converted["_UIAspectRatioConstraint2"].AspectRatio = 2.5999999046325684
            Converted["_UIAspectRatioConstraint2"].Parent = Converted["_Frame2"]

            Converted["_UIListLayout1"].HorizontalAlignment = Enum.HorizontalAlignment.Center
            Converted["_UIListLayout1"].Parent = Converted["_9_ColorPicker"]

            Converted["_Element"].Value = "ColorPicker"
            Converted["_Element"].Name = "Element"
            Converted["_Element"].Parent = Converted["_9_ColorPicker"]

            return Converted["_9_ColorPicker"]
        end

        local element = createElement()

        local movingWithCursor = function()
            return false
        end

        do -- dropdown
            local open = false
            local tween1 = nil

            local openProperty = UDim2.new(1, 0, 0, 118)
            local closeProperty = UDim2.new(1, 0, 0, 0)

            local tweenInfo = TweenInfo.new(0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0)

            element.Secondary.Visible = false

            local function toggleDropdown()
                open = not open
                pcall(function()
                    tween1:Cancel()
                    tween1:Destroy()
                end)
                if open then
                    element.Main.Fill.Visible = true
                    element.Secondary.Visible = true
                    element.Secondary.Size = closeProperty
                end
                tween1 = TS:Create(element.Secondary,tweenInfo,{
                    ["Size"] = open and openProperty or closeProperty
                })
                if not open then
                    tween1.Completed:Connect(function(p)
                        if p==Enum.PlaybackState.Completed then
                            element.Main.Fill.Visible = false
                            element.Secondary.Visible = false
                        end
                    end)
                end
                tween1:Play()
            end

            local currentcolor = element.Main.CurrentColor
            local btn = utility:CreateButtonObject(currentcolor.Parent)
            local pencil = element.Main.CurrentColor.ImageLabel

            local hovering = false
            btn.MouseEnter:Connect(function()
                hovering = true
            end)
            btn.MouseLeave:Connect(function()
                hovering = false
            end)
            table.insert(_self._connections,UIS.WindowFocusReleased:Connect(function()
                hovering = false
            end))
            LPH_JIT_MAX(function()
                table.insert(_self._connections,Run.RenderStepped:Connect(function()
                    pencil.Visible = (not movingWithCursor()) and hovering
                    pencil.ImageColor3 = utility:GetTextContrast(currentcolor.BackgroundColor3)
                    currentcolor.BackgroundColor3 = _self.Flags[info.Flag]
                end))
            end)()
            btn.Activated:Connect(toggleDropdown)
        end

        do -- color picking
            local frame = element.Secondary.Frame.Frame.Frame
            
            local rainbow = frame.Rainbow
            local second = frame.Second
            local rainbowBtn = rainbow.Button
            local secondBtn = second.Button

            local d1 = false
            local d2 = false

            rainbowBtn.MouseButton1Down:Connect(function()
                d1 = true
                d2 = false
            end)

            secondBtn.MouseButton1Down:Connect(function()
                d2 = true
                d1 = false
            end)

            table.insert(_self._connections,UIS.InputEnded:Connect(function(inp)
                if inp.UserInputType==Enum.UserInputType.MouseButton1 then
                    d1 = false
                    d2 = false
                end
            end))

            movingWithCursor = function()
                return d1 or d2
            end

            LPH_JIT_MAX(function()
                local ad1,ad2,l = nil,nil,_self.Flags[info.Flag]
                table.insert(_self._connections,Run.RenderStepped:Connect(function()
                    if d1 then
                        local percentY = math.clamp((mouse.Y-rainbow.AbsolutePosition.Y)/rainbow.AbsoluteSize.Y,0,1)
                        rainbow.Frame.Position = UDim2.fromScale(0,percentY)
                    elseif d2 then
                        local percentX = math.clamp((mouse.X-second.AbsolutePosition.X)/second.AbsoluteSize.X,0,1)
                        local percentY = math.clamp((mouse.Y-second.AbsolutePosition.Y)/second.AbsoluteSize.Y,0,1)
                        second.Black.Frame.Position = UDim2.fromScale(percentX,percentY)
                    end
                    if ad1 or ad2 or l~=_self.Flags[info.Flag] then
                        local baseColor = utility:GetColor(rainbow.Frame.Position.Y.Scale,rainbow.Rainbow.Color.Keypoints)
                        local percent_x = second.Black.Frame.Position.X.Scale
                        local percent_y = second.Black.Frame.Position.Y.Scale
                        local mod1Color = Color3.new(utility:Lerp(1,baseColor.R,percent_x),utility:Lerp(1,baseColor.G,percent_x),utility:Lerp(1,baseColor.B,percent_x))
                        local final = Color3.new(utility:Lerp(mod1Color.R,0,percent_y),utility:Lerp(mod1Color.G,0,percent_y),utility:Lerp(mod1Color.B,0,percent_y))
                        _self.Flags[info.Flag] = final
                        info.Callback(final)
                        l = final
                        second.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),ColorSequenceKeypoint.new(1, baseColor)})
                    end
                    ad1,ad2 = d1,d2
                end))
            end)()
        end

        info.WarningIcon = info.WarningIcon or Library.Icons.Warning
        element.Main.Title.Warning.Image = "http://www.roblox.com/asset/?id="..info.WarningIcon
        if info.Warning then
            element.Main.Title.Warning.ImageColor3 = Color3.new(1,1,1)
            element.Main.Title.Warning.Visible = true
            local hint = utility:CreateHint()
            hint.Value = info.Warning
            hint.Parent = element.Main.Title.Warning
        end

        element.Main.Title.Main.Title.Text = info.Name
        element.Name = string.rep("_",elementNum)..info.Name
        element.Parent = section.holder.Contents

    end
end

print("Atlas UI Library v"..VERSION.." by RoadToGlory#9879 has initiated")

return Library