--[[

██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
█░░░░░░██████████░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░███░░░░░░░░░░░░░░█░░░░░░██░░░░░░█░░░░░░░░░░░░░░░░███░░░░░░░░██░░░░░░░░█
█░░▄▀░░░░░░░░░░░░░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀░░██░░▄▀▄▀░░█
█░░▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░███░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░▄▀░░███░░░░▄▀░░██░░▄▀░░░░█
█░░▄▀░░░░░░▄▀░░░░░░▄▀░░█░░▄▀░░█████████░░▄▀░░████░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░████░░▄▀░░█████░░▄▀▄▀░░▄▀▄▀░░███
█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░▄▀░░█████░░░░▄▀▄▀▄▀░░░░███
█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███████░░░░▄▀░░░░█████
█░░▄▀░░██░░░░░░██░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░yue<3▀░░░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░░░█████████░░▄▀░░███████
█░░▄▀░░██████████░░▄▀░░█░░▄▀░░█████████░░▄▀░░██░░▄▀░░█████░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░███████████░░▄▀░░███████
█░░▄▀░░██████████░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░░░░░███████░░▄▀░░███████
█░░▄▀░░██████████░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀▄▀░░███████░░▄▀░░███████
█░░░░░░██████████░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░░░███████░░░░░░███████
██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████

edited: 1/26
developers:
v3rm AbstractPoo	discord Abstract#8007
v3rm 0xDEITY		discord Deity#0228

]]

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HTTPService = game:GetService("HttpService")

local Library = {
	Themes = {
		Legacy = {
			Main = Color3.fromHSV(262/360, 60/255, 34/255),
			Secondary = Color3.fromHSV(240/360, 40/255, 63/255),
			Tertiary = Color3.fromHSV(260/360, 60/255, 148/255),

			StrongText = Color3.fromHSV(0, 0, 1),		
			WeakText = Color3.fromHSV(0, 0, 172/255)
		},
		Serika = {
			Main = Color3.fromRGB(50, 52, 55),
			Secondary = Color3.fromRGB(80, 82, 85),
			Tertiary = Color3.fromRGB(226, 183, 20),

			StrongText = Color3.fromHSV(0, 0, 1),		
			WeakText = Color3.fromHSV(0, 0, 172/255)
		},
		Dark = {
			Main = Color3.fromRGB(30, 30, 35),
			Secondary = Color3.fromRGB(50, 50, 55),
			Tertiary = Color3.fromRGB(70, 130, 180),

			StrongText = Color3.fromHSV(0, 0, 1),		
			WeakText = Color3.fromHSV(0, 0, 172/255)
		},
		Rust = {
			Main = Color3.fromRGB(37, 35, 33),
			Secondary = Color3.fromRGB(65, 63, 63),
			Tertiary = Color3.fromRGB(237, 94, 38),

			StrongText = Color3.fromHSV(0, 0, 1),		
			WeakText = Color3.fromHSV(0, 0, 172/255)
		},
		Aqua = {
			Main = Color3.fromRGB(19, 21, 21),
			Secondary = Color3.fromRGB(65, 63, 63),
			Tertiary = Color3.fromRGB(51, 153, 137),

			StrongText = Color3.fromHSV(0, 0, 1),        
			WeakText = Color3.fromHSV(0, 0, 172/255)
		},
		Vaporwave = {},
		OperaGX = {},
		VisualStudio = {}
	},
	ColorPickerStyles = {
		Legacy = 0,
		Modern = 1
	},
	Toggled = true,
	ThemeObjects = {
		Main = {},
		Secondary = {},
		Tertiary = {},

		StrongText = {},
		WeakText = {}
	},
	WelcomeText = nil,
	DisplayName = nil,
	DragSpeed = 0.06,
	LockDragging = false,
	ToggleKey = Enum.KeyCode.Home,
	UrlLabel = nil,
	Url = nil

}
Library.__index = Library

local selectedTab

Library._promptExists = false
Library._colorPickerExists = false

local GlobalTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

function Library:set_defaults(defaults, options)
	defaults = defaults or {}
	options = options or {}
	for option, value in next, options do
		defaults[option] = value
	end
	return defaults
end

function Library:change_theme(toTheme)
	Library.CurrentTheme = toTheme
	local c = self:lighten(toTheme.Tertiary, 20)
	Library.DisplayName.Text = "Welcome, <font color='rgb(" ..  math.floor(c.R*255) .. "," .. math.floor(c.G*255) .. "," .. math.floor(c.B*255) .. ")'> <b>" .. LocalPlayer.DisplayName .. "</b> </font>"
	for color, objects in next, Library.ThemeObjects do
		local themeColor = Library.CurrentTheme[color]
		for _, obj in next, objects do
			local element, property, theme, colorAlter = obj[1], obj[2], obj[3], obj[4] or 0
			local themeColor = Library.CurrentTheme[theme]
			local modifiedColor = themeColor
			if colorAlter < 0 then
				modifiedColor = Library:darken(themeColor, -1 * colorAlter)
			elseif colorAlter > 0 then
				modifiedColor = Library:lighten(themeColor, colorAlter)
			end
			element:tween{[property] = modifiedColor}
		end
	end
end

function Library:object(class, properties)
	local localObject = Instance.new(class)

	local forcedProps = {
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.SourceSans,
		Text = ""
	}

	for property, value in next, forcedProps do
		pcall(function()
			localObject[property] = value
		end)
	end

	local methods = {}

	methods.AbsoluteObject = localObject

	function methods:tween(options, callback)
		local options = Library:set_defaults({
			Length = 0.2,
			Style = Enum.EasingStyle.Linear,
			Direction = Enum.EasingDirection.InOut
		}, options)
		callback = callback or function() return end


		local ti = TweenInfo.new(options.Length, options.Style, options.Direction)
		options.Length = nil
		options.Style = nil 
		options.Direction = nil

		local tween = TweenService:Create(localObject, ti, options); tween:Play()

		tween.Completed:Connect(function()
			callback()
		end)

		return tween
	end

	function methods:round(radius)
		radius = radius or 6
		Library:object("UICorner", {
			Parent = localObject,
			CornerRadius = UDim.new(0, radius)
		})
		return methods
	end

	function methods:object(class, properties)
		local properties = properties or {}
		properties.Parent = localObject
		return Library:object(class, properties)
	end

	function methods:crossfade(p2, length)
		length = length or .2
		self:tween({ImageTransparency = 1})
		p2:tween({ImageTransparency = 0})
	end

	function methods:fade(state, colorOverride, length, instant)
		length = length or 0.2
		if not rawget(self, "fadeFrame") then
			local frame = self:object("Frame", {
				BackgroundColor3 = colorOverride or self.BackgroundColor3,
				BackgroundTransparency = (state and 1) or 0,
				Size = UDim2.fromScale(1, 1),
				Centered = true,
				ZIndex = 999
			}):round(self.AbsoluteObject:FindFirstChildOfClass("UICorner") and self.AbsoluteObject:FindFirstChildOfClass("UICorner").CornerRadius.Offset or 0)
			rawset(self, "fadeFrame", frame)
		else
			self.fadeFrame.BackgroundColor3 = colorOverride or self.BackgroundColor3
		end

		if instant then
			if state then
				self.fadeFrame.BackgroundTransparency = 0
				self.fadeFrame.Visible = true
			else
				self.fadeFrame.BackgroundTransparency = 1
				self.fadeFrame.Visible = false
			end
		else
			if state then
				self.fadeFrame.BackgroundTransparency = 1
				self.fadeFrame.Visible = true
				self.fadeFrame:tween{BackgroundTransparency = 0, Length = length}
			else
				self.fadeFrame.BackgroundTransparency = 0
				self.fadeFrame:tween({BackgroundTransparency = 1, Length = length}, function()
					self.fadeFrame.Visible = false
				end)
			end
		end	
	end

	function methods:stroke(color, thickness, strokeMode)

		thickness = thickness or 1
		strokeMode = strokeMode or Enum.ApplyStrokeMode.Border
		local stroke = self:object("UIStroke", {
			ApplyStrokeMode = strokeMode,
			Thickness = thickness
		})

		if type(color) == "table" then
			local theme, colorAlter = color[1], color[2] or 0
			local themeColor = Library.CurrentTheme[theme]
			local modifiedColor = themeColor
			if colorAlter < 0 then
				modifiedColor = Library:darken(themeColor, -1 * colorAlter)
			elseif colorAlter > 0 then
				modifiedColor = Library:lighten(themeColor, colorAlter)
			end
			stroke.Color = modifiedColor
			table.insert(Library.ThemeObjects[theme], {stroke, "Color", theme, colorAlter})
		elseif type(color) == "string" then
			local themeColor = Library.CurrentTheme[color]
			stroke.Color = themeColor
			table.insert(Library.ThemeObjects[color], {stroke, "Color", color, 0})
		else
			stroke.Color = color
		end

		return methods
	end

	function methods:tooltip(text)
		local tooltipContainer = methods:object("TextLabel", {
			Theme = {
				BackgroundColor3 = {"Main", 10},
				TextColor3 = {"WeakText"}
			},
			TextSize = 16,
			Text = text,
			Position = UDim2.new(0.5, 0, 0, -8),
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundTransparency = 1,
			TextTransparency = 1
		}):round(5)
		tooltipContainer.Size = UDim2.fromOffset(tooltipContainer.TextBounds.X + 16, tooltipContainer.TextBounds.Y + 8)

		local tooltipArrow = tooltipContainer:object("ImageLabel", {
			Image = "http://www.roblox.com/asset/?id=4292970642",
			Theme = {ImageColor3 = {"Main", 10}},
			AnchorPoint = Vector2.new(0.5, 0),
			Rotation = 180,
			Position = UDim2.fromScale(0.5, 1),
			Size = UDim2.fromOffset(10, 6),
			BackgroundTransparency = 1,
			ImageTransparency = 1
		})

		local hovered = false

		methods.MouseEnter:connect(function()
			hovered = true
			wait(0.2)
			if hovered then
				tooltipContainer:tween{BackgroundTransparency = 0.2, TextTransparency = 0.2}
				tooltipArrow:tween{ImageTransparency = 0.2}
			end
		end)

		methods.MouseLeave:connect(function()
			hovered = false
			tooltipContainer:tween{BackgroundTransparency = 1, TextTransparency = 1}
			tooltipArrow:tween{ImageTransparency = 1}
		end)

		return methods
	end

	local customHandlers = {
		Centered = function(value)
			if value then
				localObject.AnchorPoint = Vector2.new(0.5, 0.5)
				localObject.Position = UDim2.fromScale(0.5, 0.5)
			end	
		end,
		Theme = function(value)
			for property, obj in next, value do
				if type(obj) == "table" then
					local theme, colorAlter = obj[1], obj[2] or 0
					local themeColor = Library.CurrentTheme[theme]
					local modifiedColor = themeColor
					if colorAlter < 0 then
						modifiedColor = Library:darken(themeColor, -1 * colorAlter)
					elseif colorAlter > 0 then
						modifiedColor = Library:lighten(themeColor, colorAlter)
					end
					localObject[property] = modifiedColor
					table.insert(self.ThemeObjects[theme], {methods, property, theme, colorAlter})
				else
					local themeColor = Library.CurrentTheme[obj]
					localObject[property] = themeColor
					table.insert(self.ThemeObjects[obj], {methods, property, obj, 0})
				end
			end
		end,
	}

	for property, value in next, properties do
		if customHandlers[property] then
			customHandlers[property](value)
		else
			localObject[property] = value
		end
	end

	return setmetatable(methods, {
		__index = function(_, property)
			return localObject[property]
		end,
		__newindex = function(_, property, value)
			localObject[property] = value
		end,
	})
end

function Library:show(state)
	self.Toggled = state
	self.mainFrame.ClipsDescendants = true
	if state then
		self.mainFrame:tween({Size = self.mainFrame.oldSize, Length = 0.25}, function()
			rawset(self.mainFrame, "oldSize", (state and self.mainFrame.oldSize) or self.mainFrame.Size)
			self.mainFrame.ClipsDescendants = false
		end)
		wait(0.15)
		self.mainFrame:fade(not state, self.mainFrame.BackgroundColor3, 0.15)
	else		
		self.mainFrame:fade(not state, self.mainFrame.BackgroundColor3, 0.15)
		wait(0.1)
		self.mainFrame:tween{Size = UDim2.new(), Length = 0.25}
	end
end

function Library:darken(color, f)
	local h, s, v = Color3.toHSV(color)
	f = 1 - ((f or 15) / 80)
	return Color3.fromHSV(h, math.clamp(s/f, 0, 1), math.clamp(v*f, 0, 1))
end

function Library:lighten(color, f)
	local h, s, v = Color3.toHSV(color)
	f = 1 - ((f or 15) / 80)
	return Color3.fromHSV(h, math.clamp(s*f, 0, 1), math.clamp(v/f, 0, 1))
end

--[[ old lighten/darken functions, may revert if contrast gets fucked up

	function Library:darken(color, f)
		local h, s, v = Color3.toHSV(color)
		f = f or 15
		return Color3.fromHSV(h, s, math.clamp(v - (f/255), 0, 1))
	end

	function Library:lighten(color, f)
		local h, s, v = Color3.toHSV(color)
		f = f or 15
		return Color3.fromHSV(h, s, math.clamp(v + (f/255), 0, 1))
	end
	
]]

local updateSettings = function() end

function Library:set_status(txt)
	self.statusText.Text = txt
end

function Library:create(options)

	local settings = {
		Theme = "Dark"
	}

	if readfile and writefile and isfile then
		if not isfile("MercurySettings.json") then
			writefile("MercurySettings.json", HTTPService:JSONEncode(settings))
		end
		settings = HTTPService:JSONDecode(readfile("MercurySettings.json"))
		Library.CurrentTheme = Library.Themes[settings.Theme]
		updateSettings = function(property, value)
			settings[property] = value
			writefile("MercurySettings.json", HTTPService:JSONEncode(settings))
		end
	end

	options = self:set_defaults({
		Name = "Mercury",
		Size = UDim2.fromOffset(600, 400),
		Theme = self.Themes[settings.Theme],
		Link = "https://github.com/deeeity/mercury-lib"
	}, options)

	if getgenv and getgenv().MercuryUI then
		getgenv():MercuryUI()
		getgenv().MercuryUI = nil
	end



	if options.Link:sub(-1, -1) == "/" then
		options.Link = options.Link:sub(1, -2)
	end

	if options.Theme.Light then
		self.darken, self.lighten = self.lighten, self.darken
	end

	self.CurrentTheme = options.Theme

	local gui = self:object("ScreenGui", {
		Parent = (RunService:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui"),
		ZIndexBehavior = Enum.ZIndexBehavior.Global
	})

	local notificationHolder = gui:object("Frame", {
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -30,1, -30),
		Size = UDim2.new(0, 300, 1, -60)
	})

	local _notiHolderList = notificationHolder:object("UIListLayout", {
		Padding = UDim.new(0, 20),
		VerticalAlignment = Enum.VerticalAlignment.Bottom
	})

	local core = gui:object("Frame", {
		Size = UDim2.new(),
		Theme = {BackgroundColor3 = "Main"},
		Centered = true,
		ClipsDescendants = true		
	}):round(10)

	core:fade(true, nil, 0.2, true)


	core:fade(false, nil, 0.4)
	core:tween({Size = options.Size, Length = 0.3}, function()
		core.ClipsDescendants = false
	end)

	do
		local S, Event = pcall(function()
			return core.MouseEnter
		end)

		if S then
			core.Active = true;

			Event:connect(function()
				local Input = core.InputBegan:connect(function(Key)
					if Key.UserInputType == Enum.UserInputType.MouseButton1 then
						local ObjectPosition = Vector2.new(Mouse.X - core.AbsolutePosition.X, Mouse.Y - core.AbsolutePosition.Y)
						while RunService.RenderStepped:wait() and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do

							if Library.LockDragging then
								local FrameX, FrameY = math.clamp(Mouse.X - ObjectPosition.X, 0, gui.AbsoluteSize.X - core.AbsoluteSize.X), math.clamp(Mouse.Y - ObjectPosition.Y, 0, gui.AbsoluteSize.Y - core.AbsoluteSize.Y)
								core:tween{
									Position = UDim2.fromOffset(FrameX + (core.Size.X.Offset * core.AnchorPoint.X), FrameY + (core.Size.Y.Offset * core.AnchorPoint.Y)),
									Length = Library.DragSpeed
								}
							else
								core:tween{
									Position = UDim2.fromOffset(Mouse.X - ObjectPosition.X + (core.Size.X.Offset * core.AnchorPoint.X), Mouse.Y - ObjectPosition.Y + (core.Size.Y.Offset * core.AnchorPoint.Y)),
									Length = Library.DragSpeed	
								}
							end	
							--[[core.AbsoluteObject:TweenPosition(
								UDim2.new(0, Mouse.X - ObjectPosition.X + (core.Size.X.Offset * core.AnchorPoint.X), 0, Mouse.Y - ObjectPosition.Y + (core.Size.Y.Offset * core.AnchorPoint.Y)),           
								Enum.EasingDirection.In,
								Enum.EasingStyle.Sine,
								Library.DragSpeed,
								true
								
								--
								core:tween{
								Position = UDim2.new(0, Mouse.X - ObjectPosition.X + (core.Size.X.Offset * core.AnchorPoint.X), 0, Mouse.Y - ObjectPosition.Y + (core.Size.Y.Offset * core.AnchorPoint.Y)),
								Direction = Enum.EasingDirection.Out,
								Style = Enum.EasingStyle.Quad,
								Length = Library.DragSpeed
							}
							)]]
						end
					end
				end)

				local Leave
				Leave = core.MouseLeave:connect(function()
					Input:disconnect()
					Leave:disconnect()
				end)
			end)
		end
	end

	rawset(core, "oldSize", options.Size)

	self.mainFrame = core

	local tabButtons = core:object("ScrollingFrame", {
		Size = UDim2.new(1, -40, 0, 25),
		Position = UDim2.fromOffset(5, 5),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.X,
		AutomaticCanvasSize = Enum.AutomaticSize.X
	})

	tabButtons:object("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4)
	})

	local closeButton = core:object("ImageButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(1, -11, 0, 11),
		Theme = {ImageColor3 = "StrongText"},
		Image = "http://www.roblox.com/asset/?id=8497487650",
		AnchorPoint = Vector2.new(1)
	})

	closeButton.MouseEnter:connect(function()
		closeButton:tween{ImageColor3 = Color3.fromRGB(255, 124, 142)}
	end)

	closeButton.MouseLeave:connect(function()
		closeButton:tween{ImageColor3 = Library.CurrentTheme.StrongText}
	end)

	local function closeUI()
		core.ClipsDescendants = true
		core:fade(true)
		wait(0.1)
		core:tween({Size = UDim2.new()}, function()
			gui.AbsoluteObject:Destroy()
		end)
	end

	if getgenv then
		getgenv().MercuryUI = closeUI
	end

	closeButton.MouseButton1Click:connect(function()
		closeUI()
	end)

	local urlBar = core:object("Frame", {
		Size = UDim2.new(1, -10, 0, 25),
		Position = UDim2.new(0, 5,0, 35),
		Theme = {BackgroundColor3 = "Secondary"}
	}):round(5)

	local searchIcon = urlBar:object("ImageLabel", {
		AnchorPoint = Vector2.new(0, .5),
		Position = UDim2.new(0, 5,0.5, 0);
		Theme = {ImageColor3 = "Tertiary"},
		Size = UDim2.fromOffset(16, 16),
		Image = "http://www.roblox.com/asset/?id=8497489946",
		BackgroundTransparency = 1
	})

	local link = urlBar:object("TextLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 26, 0.5, 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -30, .6, 0),
		Text = options.Link .. "/home",
		Theme = {TextColor3 = "WeakText"},
		TextSize = 14,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	Library.UrlLabel = link
	Library.Url = options.Link

	local shadowHolder = core:object("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0
	})

	local shadow = shadowHolder:object("ImageLabel", {
		Centered = true,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 47,1, 47),
		ZIndex = 0,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = .6,
		SliceCenter = Rect.new(47, 47, 450, 450),
		ScaleType = Enum.ScaleType.Slice,
		SliceScale = 1
	})

	local content = core:object("Frame", {
		Theme = {BackgroundColor3 = {"Secondary", -10}},
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -20),
		Size = UDim2.new(1, -10, 1, -86)
	}):round(7) -- Sept

	local status = core:object("TextLabel", {
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 1, -6),
		Size = UDim2.new(0.2, 0, 0, 10),
		Font = Enum.Font.SourceSans,
		Text = "Status | Idle",
		Theme = {TextColor3 = "Tertiary"},
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local homeButton = tabButtons:object("TextButton", {
		Name = "hehehe siuuuuuuuuu",
		BackgroundTransparency = 0,
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(0, 125, 0, 25)
	}):round(5)

	local homeButtonText = homeButton:object("TextLabel", {
		Theme = {TextColor3 = "StrongText"},
		AnchorPoint = Vector2.new(0, .5),
		BackgroundTransparency = 1,
		TextSize = 14,
		Text = options.Name,
		Position = UDim2.new(0, 25, 0.5, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -45, 0.5, 0),
		Font = Enum.Font.SourceSans,
		TextTruncate = Enum.TextTruncate.AtEnd
	})

	local homeButtonIcon = homeButton:object("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		Image = "http://www.roblox.com/asset/?id=8569322835",
		Theme = {ImageColor3 = "StrongText"}
	})

	local homePage = content:object("Frame", {
		Size = UDim2.fromScale(1, 1),
		Centered = true,
		BackgroundTransparency = 1
	})

	local tabs = {}
	selectedTab = homeButton

	tabs[#tabs+1] = {homePage, homeButton}

	do
		local down = false
		local hovered = false

		homeButton.MouseEnter:connect(function()
			hovered = true
			homeButton:tween{BackgroundTransparency = ((selectedTab == homeButton) and 0.15) or 0.3}
		end)

		homeButton.MouseLeave:connect(function()
			hovered = false
			homeButton:tween{BackgroundTransparency = ((selectedTab == homeButton) and 0.15) or 1}
		end)

		homeButton.MouseButton1Down:connect(function()
			down = true
			homeButton:tween{BackgroundTransparency = 0}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				down = false
				homeButton:tween{BackgroundTransparency = ((selectedTab == homeButton) and 0.15) or (hovered and 0.3) or 1}
			end

		end)

		homeButton.MouseButton1Click:Connect(function()
			for _, tabInfo in next, tabs do
				local page = tabInfo[1]
				local button = tabInfo[2]
				page.Visible = false
			end
			selectedTab:tween{BackgroundTransparency = ((selectedTab == homeButton) and 0.15) or 1}
			selectedTab = homeButton
			homePage.Visible = true
			homeButton.BackgroundTransparency = 0
			Library.UrlLabel.Text = Library.Url .. "/home"
		end)
	end

	self.SelectedTabButton = homeButton

	local homePageLayout = homePage:object("UIListLayout", {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Vertical,
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})

	local homePagePadding = homePage:object("UIPadding", {
		PaddingTop = UDim.new(0, 10)
	})

	local profile = homePage:object("Frame", {
		AnchorPoint = Vector2.new(0, .5),
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 100)
	}):round(7)

	local profilePictureContainer = profile:object("ImageLabel", {
		Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100),
		Theme = {BackgroundColor3 = {"Secondary", 10}},
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5),
		Size = UDim2.fromOffset(80, 80)
	}):round(100)

	local displayName; do
		local h, s, v = Color3.toHSV(options.Theme.Tertiary)
		local c = self:lighten(options.Theme.Tertiary, 20)

		local displayName = profile:object("TextLabel", {
			RichText = true,
			Text = "Welcome, <font color='rgb(" ..  math.floor(c.R*255) .. "," .. math.floor(c.G*255) .. "," .. math.floor(c.B*255) .. ")'> <b>" .. LocalPlayer.DisplayName .. "</b> </font>",
			TextScaled = true,
			Position = UDim2.new(0, 105,0, 10),
			Theme = {TextColor3 = {"Tertiary", 10}},
			Size = UDim2.new(0, 400,0, 40),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left
		})
		Library.DisplayName = displayName
	end

	local profileName = profile:object("TextLabel", {
		Text = "@" .. LocalPlayer.Name,
		TextScaled = true,
		Position = UDim2.new(0, 105,0, 47),
		Theme = {TextColor3 = "Tertiary"},
		Size = UDim2.new(0, 400,0, 20),
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local timeDisplay = profile:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 105, 1, -10),
		Size = UDim2.new(0, 400,0, 20),
		AnchorPoint = Vector2.new(0, 1),
		Theme = {TextColor3 = {"WeakText", -20}},
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = tostring(os.date("%X")):sub(1, os.date("%X"):len()-3)
	})

	do
		local desiredInterval = 1
		local counter = 0
		RunService.Heartbeat:Connect(function(step)
			counter += step  
			if counter >= desiredInterval then
				counter -= desiredInterval
				local date = tostring(os.date("%X"))
				timeDisplay.Text = date:sub(1, date:len()-3)
			end
		end)
	end

	local settingsTabIcon = profile:object("ImageButton", {
		BackgroundTransparency = 1,
		Theme = {ImageColor3 = "WeakText"},
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -10, 1, -10),
		AnchorPoint = Vector2.new(1, 1),
		Image = "http://www.roblox.com/asset/?id=8559790237"
	}):tooltip("settings")

	local creditsTabIcon = profile:object("ImageButton", {
		BackgroundTransparency = 1,
		Theme = {ImageColor3 = "WeakText"},
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -44, 1, -10),
		AnchorPoint = Vector2.new(1, 1),
		Image = "http://www.roblox.com/asset/?id=8577523456"
	}):tooltip("credits")

	local quickAccess = homePage:object("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -20, 0, 180)
	})

	quickAccess:object("UIGridLayout", {
		CellPadding = UDim2.fromOffset(10, 10),
		CellSize = UDim2.fromOffset(55, 55),
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center
	})

	quickAccess:object("UIPadding", {
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 70),
		PaddingRight = UDim.new(0, 70),
		PaddingTop = UDim.new(0, 5)
	})


	local mt = setmetatable({
		core = core,
		notifs = notificationHolder,
		statusText = status,
		container = content,
		navigation = tabButtons,
		Theme = options.Theme,
		Tabs = tabs,
		quickAccess = quickAccess,
		homeButton = homeButton,
		homePage = homePage,
		nilFolder = core:object("Folder"),
	}, Library)

	local settingsTab = Library.tab(mt, {
		Name = "Settings",
		Internal = settingsTabIcon,
		Icon = "rbxassetid://8559790237"
	})

	settingsTab:_theme_selector()

	settingsTab:keybind{
		Name = "Toggle Key",
		Description = "Key to show/hide the UI.",
		Keybind = Enum.KeyCode.Delete,
		Callback = function()
			self.Toggled = not self.Toggled
			Library:show(self.Toggled)
		end,
	}

	settingsTab:toggle{
		Name = "Lock Dragging",
		Description = "Makes sure you can't drag the UI outside of the window.",
		StartingState = true,
		Callback = function(state)
			Library.LockDragging = state
		end,
	}

	settingsTab:slider{
		Name = "UI Drag Speed",
		Description = "How smooth the dragging looks.",
		Max = 20,
		Default = 14,
		Callback = function(value)
			Library.DragSpeed = (20 - value)/100
		end,
	}

	local creditsTab = Library.tab(mt, {
		Name = "Credits",
		Internal = creditsTabIcon,
		Icon = "http://www.roblox.com/asset/?id=8577523456"
	})

	rawset(mt, "creditsContainer", creditsTab.container)

	creditsTab:credit{Name = "Abstract", Description = "UI Library Developer", Discord = "Abstract#8007", V3rmillion = "AbstractPoo"}
	creditsTab:credit{Name = "Deity", Description = "UI Library Developer", Discord = "Deity#0228", V3rmillion = "0xDEITY"}

	return mt
end

function Library:notification(options)
	options = self:set_defaults({
		Title = "Notification",
		Text = "Your character has been reset.",
		Duration = 3,
		Callback = function() end
	}, options)

	local fadeOut;

	local noti = self.notifs:object("Frame", {
		BackgroundTransparency = 1,
		Theme = {BackgroundColor3 = "Main"},
		Size = UDim2.new(0, 300,0, 0)
	}):round(10)

	local _notiPadding = noti:object("UIPadding", {
		PaddingBottom = UDim.new(0, 11),
		PaddingTop = UDim.new(0, 11),
		PaddingLeft = UDim.new(0, 11),
		PaddingRight = UDim.new(0, 11)
	})

	local dropShadow = noti:object("Frame", {
		ZIndex = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	})

	local _shadow = dropShadow:object("ImageLabel", {
		Centered = true,
		Position = UDim2.fromScale(.5, .5),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 70,1, 70),
		ZIndex = 0,
		Image = "rbxassetid://6014261993",
		ImageColor3 = Color3.fromRGB(0,0,0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450)
	})

	local durationHolder = noti:object("Frame", {
		BackgroundTransparency = 1,
		Theme = {BackgroundColor3 = "Secondary"},
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0,0, 4)
	}):round(100)

	local length = durationHolder:object("Frame", {
		BackgroundTransparency = 1,
		Theme = {BackgroundColor3 = "Tertiary"},
		Size = UDim2.fromScale(1, 1)
	}):round(100)

	local icon = noti:object("ImageLabel", {
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Position = UDim2.fromOffset(1, 1),
		Size = UDim2.fromOffset(18, 18),
		Image = "rbxassetid://8628681683",
		Theme = {ImageColor3 = "Tertiary"}
	})

	local exit = noti:object("ImageButton", {
		Image = "http://www.roblox.com/asset/?id=8497487650",
		AnchorPoint = Vector2.new(1, 0),
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		Position = UDim2.new(1, -3,0, 3),
		Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1,
		ImageTransparency = 1
	})

	exit.MouseButton1Click:Connect(function()
		fadeOut()
	end)

	local text = noti:object("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Text,
		Position = UDim2.new(0, 0,0, 23),
		Size = UDim2.new(1, 0, 100, 0),
		TextSize = 16,
		TextTransparency = 1,
		TextWrapped = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextTransparency = 1
	})

	text:tween({Size = UDim2.new(1, 0, 0, text.TextBounds.Y)})

	local title = noti:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(23, 0),
		Size = UDim2.new(1, -60,0, 20),
		Font = Enum.Font.SourceSansBold,
		Text = options.Title,
		Theme = {TextColor3 = "Tertiary"},
		TextSize = 17,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextTransparency = 1
	})

	fadeOut = function()
		task.delay(0.3, function()
			noti.AbsoluteObject:Destroy()
			options.Callback()
		end)

		icon:tween({ImageTransparency = 1, Length = 0.2})
		exit:tween({ImageTransparency = 1, Length = 0.2})
		durationHolder:tween({BackgroundTransparency = 1, Length = 0.2})
		length:tween({BackgroundTransparency = 1, Length = 0.2})
		text:tween({TextTransparency = 1, Length = 0.2})
		title:tween({TextTransparency = 1, Length = 0.2}, function()
			_shadow:tween({ImageTransparency = 1, Length = 0.2})
			noti:tween({BackgroundTransparency = 1, Length = 0.2, Size = UDim2.fromOffset(300, 0)})
		end)

	end

	_shadow:tween({ImageTransparency = .6, Length = 0.2})
	noti:tween({BackgroundTransparency = 0, Length = 0.2, Size = UDim2.fromOffset(300, text.TextBounds.Y + 63)}, function()
		icon:tween({ImageTransparency = 0, Length = 0.2})
		exit:tween({ImageTransparency = 0, Length = 0.2})
		durationHolder:tween({BackgroundTransparency = 0, Length = 0.2})
		length:tween({BackgroundTransparency = 0, Length = 0.2})
		text:tween({TextTransparency = 0, Length = 0.2})
		title:tween({TextTransparency = 0, Length = 0.2})
	end)

	length:tween({Size = UDim2.fromScale(0, 1), Length = options.Duration}, function()
		fadeOut()
	end)
end

function Library:tab(options)
	options = self:set_defaults({
		Name = "New Tab",
		Icon = "rbxassetid://8569322835"
	}, options)

	local tab = self.container:object("ScrollingFrame", {
		AnchorPoint = Vector2.new(0, 1),
		Visible = false,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromScale(1, 1),
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y
	})

	local quickAccessButton
	local quickAccessIcon

	if not options.Internal then
		quickAccessButton = self.quickAccess:object("TextButton", {
			Theme = {BackgroundColor3 = "Secondary"}
		}):round(5):tooltip(options.Name)

		quickAccessIcon = quickAccessButton:object("ImageLabel", {
			BackgroundTransparency = 1,
			Theme = {ImageColor3 = "StrongText"},
			Image = options.Icon,
			Size = UDim2.fromScale(0.5, 0.5),
			Centered = true
		})
	else
		quickAccessButton = options.Internal
	end

	local layout = tab:object("UIListLayout", {
		Padding = UDim.new(0, 10),
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})

	tab:object("UIPadding", {
		PaddingTop = UDim.new(0, 10)
	})

	local tabButton = Library:object("TextButton", {
		BackgroundTransparency = 1,
		Parent = self.nilFolder.AbsoluteObject,
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(0, 125, 0, 25),
		Visible = false
	}):round(5)

	self.Tabs[#self.Tabs+1] = {tab, tabButton, options.Name}

	do
		local down = false
		local hovered = false

		tabButton.MouseEnter:connect(function()
			hovered = true
			tabButton:tween{BackgroundTransparency = ((selectedTab == tabButton) and 0.15) or 0.3}
		end)

		tabButton.MouseLeave:connect(function()
			hovered = false
			tabButton:tween{BackgroundTransparency = ((selectedTab == tabButton) and 0.15) or 1}
		end)

		tabButton.MouseButton1Down:connect(function()
			down = true
			tabButton:tween{BackgroundTransparency = 0}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				down = false
				tabButton:tween{BackgroundTransparency = ((selectedTab == tabButton) and 0.15) or (hovered and 0.3) or 1}
			end

		end)

		tabButton.MouseButton1Click:Connect(function()
			for _, tabInfo in next, self.Tabs do
				local page = tabInfo[1]
				local button = tabInfo[2]
				page.Visible = false
			end
			selectedTab:tween{BackgroundTransparency = ((selectedTab == tabButton) and 0.15) or 1}
			selectedTab = tabButton
			tab.Visible = true
			tabButton.BackgroundTransparency = 0
			Library.UrlLabel.Text = Library.Url .. "/" .. options.Name:lower()
		end)

		quickAccessButton.MouseEnter:connect(function()
			quickAccessButton:tween{BackgroundColor3 = Library.CurrentTheme.Tertiary}
		end)

		quickAccessButton.MouseLeave:connect(function()
			quickAccessButton:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
		end)

		quickAccessButton.MouseButton1Click:connect(function()
			if not tabButton.Visible then
				tabButton.Parent = self.navigation.AbsoluteObject
				tabButton.Size = UDim2.new(0, 50, tabButton.Size.Y.Scale, tabButton.Size.Y.Offset)
				tabButton.Visible = true
				tabButton:fade(false, Library.CurrentTheme.Main, 0.1)			
				tabButton:tween({Size = UDim2.new(0, 125, tabButton.Size.Y.Scale, tabButton.Size.Y.Offset), Length = 0.1})
				for _, tabInfo in next, self.Tabs do
					local page = tabInfo[1]
					local button = tabInfo[2]
					page.Visible = false
				end
				selectedTab:tween{BackgroundTransparency = ((selectedTab == tabButton) and 0.15) or 1}
				selectedTab = tabButton
				tab.Visible = true
				tabButton.BackgroundTransparency = 0
				Library.UrlLabel.Text = Library.Url .. "/" .. options.Name:lower()
			end
		end)
	end

	local tabButtonText = tabButton:object("TextLabel", {
		Theme = {TextColor3 = "StrongText"},
		AnchorPoint = Vector2.new(0, .5),
		BackgroundTransparency = 1,
		TextSize = 14,
		Text = options.Name,
		Position = UDim2.new(0, 25, 0.5, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -45, 0.5, 0),
		Font = Enum.Font.SourceSans,
		TextTruncate = Enum.TextTruncate.AtEnd
	})

	local tabButtonIcon = tabButton:object("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		Image = options.Icon,
		Theme = {ImageColor3 = "StrongText"}
	})

	local tabButtonClose = tabButton:object("ImageButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -5, 0.5, 0),
		Size = UDim2.fromOffset(14, 14),
		Image = "rbxassetid://8497487650",
		Theme = {ImageColor3 = "StrongText"}
	})

	tabButtonClose.MouseButton1Click:connect(function()
		tabButton:fade(true, Library.CurrentTheme.Main, 0.1)
		tabButton:tween({Size = UDim2.new(0, 50, tabButton.Size.Y.Scale, tabButton.Size.Y.Offset), Length = 0.1}, function()
			tabButton.Visible = false
			tab.Visible = false
			tabButton.Parent = self.nilFolder.AbsoluteObject
			wait()
		end)

		local visible = {}
		for _, tab in next, self.Tabs do
			if not tab[2] == selectedTab then tab[1].Visible = false end
			if tab[2].Visible then
				visible[#visible+1] = tab
			end
		end

		local lastTab = visible[#visible]

		if selectedTab == self.homeButton then
			tab.Visible = false
		elseif #visible == 2 then
			selectedTab.Visible = false
			tab.Visible = false
			self.homePage.Visible = true
			self.homeButton:tween{BackgroundTransparency = 0.15}
			selectedTab = self.homeButton
			Library.UrlLabel.Text = Library.Url .. "/home"	
		elseif tabButton == lastTab[2] then
			lastTab = visible[#visible-1]
			tab.Visible = false
			lastTab[2]:tween{BackgroundTransparency = 0.15}
			lastTab[1].Visible = true
			selectedTab = lastTab[2]
			Library.UrlLabel.Text = Library.Url .. "/" .. lastTab[3]:lower()
		else
			tab.Visible = false
			lastTab[2]:tween{BackgroundTransparency = 0.15}
			lastTab[1].Visible = true
			selectedTab = lastTab[2]
			Library.UrlLabel.Text = Library.Url .. "/" .. lastTab[3]:lower()
		end
	end)

	return setmetatable({
		statusText = self.statusText,
		container = tab,
		Theme = self.Theme,
		core = self.core,
		layout = layout
	}, Library)
end

function Library:_resize_tab()
	if self.container.ClassName == "ScrollingFrame" then
		self.container.CanvasSize = UDim2.fromOffset(0, self.layout.AbsoluteContentSize.Y + 20)
	else
		self.sectionContainer.Size = UDim2.new(1, -24, 0, self.layout.AbsoluteContentSize.Y + 20)
		self.parentContainer.CanvasSize = UDim2.fromOffset(0, self.parentLayout.AbsoluteContentSize.Y + 20)
	end
end

function Library:toggle(options)
	options = self:set_defaults({
		Name = "Toggle",
		StartingState = false,
		Description = nil,
		Callback = function(state) end
	}, options)

	if options.StartingState then options.Callback(true) end

	local toggleContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local on = "http://www.roblox.com/asset/?id=8498709213"
	local off = "http://www.roblox.com/asset/?id=8498691125"

	local toggled = options.StartingState

	local onIcon = toggleContainer:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -11,0.5, 0),
		Size = UDim2.new(0, 26,0, 26),
		Image = on,
		Theme = {ImageColor3 = "Tertiary"},
		ImageTransparency = (toggled and 0) or 1
	})

	local offIcon = toggleContainer:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -11,0.5, 0),
		Size = UDim2.new(0, 26,0, 26),
		Image = off,
		Theme = {ImageColor3 = "WeakText"},
		ImageTransparency = (toggled and 1) or 0
	})

	local text = toggleContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 0),
		Size = (options.Description and UDim2.new(0.5, -10, 0, 22)) or UDim2.new(0.5, -10, 1, 0),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = toggleContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end

	local function toggle()
		toggled = not toggled
		if toggled then
			offIcon:crossfade(onIcon, 0.1)
		else
			onIcon:crossfade(offIcon, 0.1)
		end
		options.Callback(toggled)
	end

	do
		local hovered = false
		local down = false

		toggleContainer.MouseEnter:connect(function()
			hovered = true
			toggleContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		toggleContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				toggleContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		toggleContainer.MouseButton1Down:connect(function()
			toggleContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 20)}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				toggleContainer:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Secondary)) or Library.CurrentTheme.Secondary}
			end
		end)

		toggleContainer.MouseButton1Click:connect(function()
			toggle()
		end)
	end
	self:_resize_tab()

	local methods = {}

	function methods:Toggle()
		toggle()
	end

	function methods:SetState(state)
		toggled = state
		if toggled then
			offIcon:crossfade(onIcon, 0.1)
		else
			onIcon:crossfade(offIcon, 0.1)
		end
		options.Callback(toggled)
	end

	return methods
end

function Library:dropdown(options)
	options = self:set_defaults({
		Name = "Dropdown",
		StartingText = "Select...",
		Items = {},
		Callback = function(item) return end
	}, options)


	local newSize = 0
	local open = false

	local dropdownContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local text = dropdownContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 15),
		Size = UDim2.new(0.5, -10, 0, 22),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = dropdownContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end

	local icon = dropdownContainer:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -11, 0, 12),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://8498840035",
		Theme = {ImageColor3 = "Tertiary"}
	})

	local selectedText = dropdownContainer:object("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {"Secondary", -20},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, -50, 0, 16),
		Size = UDim2.fromOffset(200, 20),
		TextSize = 14,
		Text = options.StartingText
	}):round(5):stroke("Tertiary")

	local itemContainer = dropdownContainer:object("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5,0, 55),
		Size = UDim2.new(1, -10, 0, 0),
		ClipsDescendants = true
	})

	selectedText.Size = UDim2.fromOffset(selectedText.TextBounds.X + 20, 20)

	local _gridItemContainer = itemContainer:object("UIGridLayout", {
		CellPadding = UDim2.fromOffset(0, 5),
		CellSize = UDim2.new(1, 0, 0, 20),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top
	})

	local layout = self.layout
	local container = self.container


	local items = setmetatable({}, {
		__newindex = function(self, i, v)
			rawset(self, i, v)
			if v ~= nil then
				newSize = (25 * #self) + 5
				itemContainer.Size = UDim2.new(1, -10, 0, newSize)
			end
		end
	})

	for i, v in next, options.Items do
		if typeof(v) == "table" then
			items[i] = v
		else
			items[i] = {tostring(v), v}
		end
	end

	local toggle;

	for i, item in next, items do
		local label = item[1]
		local value = item[2]

		local newItem = itemContainer:object("TextButton", {
			Theme = {
				BackgroundColor3 = {"Secondary", 25},
				TextColor3 = {"StrongText", 25}
			},
			Text = label,
			TextSize = 14
		}):round(5)

		items[i] = {{label, value}, newItem} 

		do
			local hovered = false
			local down = false

			newItem.MouseEnter:connect(function()
				hovered = true
				newItem:tween{BackgroundColor3 = Library.CurrentTheme.Tertiary}
			end)

			newItem.MouseLeave:connect(function()
				hovered = false
				if not down then
					newItem:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 25)}
				end
			end)

			newItem.MouseButton1Down:connect(function()
				newItem:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Tertiary, 10)}
			end)

			UserInputService.InputEnded:connect(function(key)
				if key.UserInputType == Enum.UserInputType.MouseButton1 then
					newItem:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Tertiary, 5)) or self:lighten(Library.CurrentTheme.Secondary, 25)}
				end
			end)

			newItem.MouseButton1Click:connect(function()
				toggle()
				selectedText.Text = newItem.Text
				selectedText:tween{Size = UDim2.fromOffset(selectedText.TextBounds.X + 20, 20), Length = 0.05}
				options.Callback(value)
			end)
		end
	end

	do
		local hovered = false
		local down = false

		newSize = (25 * #items) + 5
		itemContainer.Size = (not open and UDim2.new(1, -10, 0, 0)) or UDim2.new(1, -10, 0, newSize)

		toggle = function()
			newSize = (25 * #items) + 5
			open = not open
			if open then
				itemContainer:tween{Size = UDim2.new(1, -10, 0, newSize)}
				dropdownContainer:tween({Size = UDim2.new(1, -20, 0, 52 + newSize)}, function()
					self:_resize_tab()
				end)
				icon:tween{Rotation = 180, Position = UDim2.new(1, -11, 0, 15)}
			else
				itemContainer:tween{Size = UDim2.new(1, -10, 0, 0)}
				dropdownContainer:tween({Size = UDim2.new(1, -20, 0, 52)}, function()
					self:_resize_tab()
				end)
				icon:tween{Rotation = 0, Position = UDim2.new(1, -11, 0, 12)}
			end
		end

		dropdownContainer.MouseEnter:connect(function()
			hovered = true
			dropdownContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		dropdownContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				dropdownContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		dropdownContainer.MouseButton1Down:connect(function()
			dropdownContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 20)}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				dropdownContainer:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Secondary)) or Library.CurrentTheme.Secondary}
			end
		end)

		dropdownContainer.MouseButton1Click:connect(function()
			toggle()
		end)
	end
	self:_resize_tab()

	local methods = {}

	function methods:Set(text)
		selectedText.Text = text
		selectedText:tween{Size = UDim2.fromOffset(selectedText.TextBounds.X + 20, 20), Length = 0.05}
	end

	function methods:RemoveItems(fitems)
		for _, v in next, fitems do
			for _2, v2 in next, items do
				local label = v2[1][1]
				if label:lower() == tostring(v):lower() then
					v2[2].AbsoluteObject:Destroy()
					items[_2] = nil
					table.remove(items, _2)
					newSize = (25 * #items) + 5
					itemContainer:tween{Size = (not open and UDim2.new(1, -10, 0, 0)) or UDim2.new(1, -10, 0, newSize)}
					dropdownContainer:tween({Size = (not open and UDim2.new(1, -20, 0, 52)) or UDim2.new(1, -20, 0, 52 + newSize)})
				end
			end
		end
	end

	function methods:Clear()
		table.clear(items)
		itemContainer:tween{Size = UDim2.new(1, -10, 0, 0)}
		dropdownContainer:tween({Size = UDim2.new(1, -20, 0, 52)}, function()
			for i, v in next, itemContainer.AbsoluteObject:GetChildren() do
				if v.ClassName == "TextButton" then
					v:Destroy()
				end
			end
		end)
		if open then toggle() end
	end

	function methods:AddItems(fitems)
		for i, v in next, fitems do
			if typeof(v) == "table" then
				items[#items+1] = v
			else
				items[#items+1] = {tostring(v), v}
			end
		end

		newSize = (25 * #items) + 5
		itemContainer:tween{Size = (not open and UDim2.new(1, -10, 0, 0)) or UDim2.new(1, -10, 0, newSize)}
		dropdownContainer:tween({Size = (not open and UDim2.new(1, -20, 0, 52)) or UDim2.new(1, -20, 0, 52 + newSize)})

		for i, item in next, items do
			local label = item[1]
			local value = item[2]

			if type(label) == "table" then continue end

			local newItem = itemContainer:object("TextButton", {
				Theme = {
					BackgroundColor3 = {"Secondary", 25},
					TextColor3 = {"StrongText", 25}
				},
				Text = label,
				TextSize = 14
			}):round(5)

			items[i] = {{label, value}, newItem}

			do
				local hovered = false
				local down = false

				newItem.MouseEnter:connect(function()
					hovered = true
					newItem:tween{BackgroundColor3 = Library.CurrentTheme.Tertiary}
				end)

				newItem.MouseLeave:connect(function()
					hovered = false
					if not down then
						newItem:tween{BackgroundColor3 = Library:lighten(Library.CurrentTheme.Secondary, 25)}
					end
				end)

				newItem.MouseButton1Down:connect(function()
					newItem:tween{BackgroundColor3 = Library:lighten(Library.CurrentTheme.Tertiary, 10)}
				end)

				UserInputService.InputEnded:connect(function(key)
					if key.UserInputType == Enum.UserInputType.MouseButton1 then
						newItem:tween{BackgroundColor3 = (hovered and Library:lighten(Library.CurrentTheme.Tertiary, 5)) or Library:lighten(Library.CurrentTheme.Secondary, 25)}
					end
				end)

				newItem.MouseButton1Click:connect(function()
					toggle()
					selectedText.Text = newItem.Text
					selectedText:tween{Size = UDim2.fromOffset(selectedText.TextBounds.X + 20, 20), Length = 0.05}
					options.Callback(value)
				end)
			end		
		end

		Library._resize_tab({
			container = container,
			layout = layout
		})
	end

	return methods
end

function Library:section(options)
	options = self:set_defaults({
		Name = "Section"
	}, options)

	local sectionContainer = self.container:object("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 52)
	}):round(7):stroke("Secondary", 2)

	local text = sectionContainer:object("TextLabel", {
		Position = UDim2.new(0.5),
		Text = options.Name,
		TextSize = 18,
		Theme = {
			TextColor3 = "StrongText",
			BackgroundColor3 = {"Secondary", -10}
		},
		TextXAlignment = Enum.TextXAlignment.Center,
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
	text.Size = UDim2.fromOffset(text.TextBounds.X + 4, text.TextBounds.Y)


	local functionContainer = sectionContainer:object("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1
	})


	local layout = functionContainer:object("UIListLayout", {
		Padding = UDim.new(0, 10),
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})

	functionContainer:object("UIPadding", {
		PaddingTop = UDim.new(0, 10)
	})

	return setmetatable({
		statusText = self.statusText,
		container = functionContainer,
		sectionContainer = sectionContainer,
		parentContainer = self.container,
		Theme = self.Theme,
		core = self.core,
		parentLayout = self.layout,
		layout = layout
	}, Library)
end

function Library:button(options)
	options = self:set_defaults({
		Name = "Button",
		Description = nil,
		Callback = function() end
	}, options)

	local buttonContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local text = buttonContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 0),
		Size = (options.Description and UDim2.new(0.5, -10, 0, 22)) or UDim2.new(0.5, -10, 1, 0),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = buttonContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end

	local icon = buttonContainer:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -11, 0.5, 0),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://8498776661",
		Theme = {ImageColor3 = "Tertiary"}
	})

	do
		local hovered = false
		local down = false

		buttonContainer.MouseEnter:connect(function()
			hovered = true
			buttonContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		buttonContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				buttonContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		buttonContainer.MouseButton1Down:connect(function()
			buttonContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 20)}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				buttonContainer:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Secondary)) or Library.CurrentTheme.Secondary}
			end
		end)

		buttonContainer.MouseButton1Click:connect(function()
			options.Callback()
		end)
	end
	self:_resize_tab()

	local methods = {}

	function methods:Fire()
		options.Callback()
	end

	function methods:SetText(txt)
		text.Text = txt
	end

	return methods
end

function Library:color_picker(options)
	options = self:set_defaults({
		Name = "Color Picker",
		Description = nil,
		Style = Library.ColorPickerStyles.Legacy,
		Followup = false,
		Callback = function(color) end
	}, options)

	local buttonContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local text = buttonContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 0),
		Size = (options.Description and UDim2.new(0.5, -10, 0, 22)) or UDim2.new(0.5, -10, 1, 0),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = buttonContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end

	local icon = buttonContainer:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -11, 0.5, 0),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://8604555937",
		ImageColor3 = Library.CurrentTheme.Tertiary
	})

	do
		local hovered = false
		local down = false

		buttonContainer.MouseEnter:connect(function()
			hovered = true
			buttonContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		buttonContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				buttonContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		buttonContainer.MouseButton1Down:connect(function()
			buttonContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 20)}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				buttonContainer:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Secondary)) or Library.CurrentTheme.Secondary}
			end
		end)

		buttonContainer.MouseButton1Click:connect(function()
			if Library._colorPickerExists then return end
			Library._colorPickerExists = true
			local hue, sat, val;
			local updatePicker, updateHue;

			local fadeOut;

			local selectedColor = Color3.fromRGB(255, 0, 0);

			local darkener = self.core:object("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2
			}):round(10)


			if options.Style == 1 then
				do
					local arrow = darkener:object("ImageLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 365,0, 102),
						Size = UDim2.new(0, 56,0, 48),
						ZIndex = 10,
						Image = "rbxassetid://8579148508",
						ImageColor3 = selectedColor,
						ImageTransparency = 1,
						Rotation = 180
					})

					local text = darkener:object("ImageLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 364,0, 158),
						Rotation = -4,
						Size = UDim2.new(0, 141,0, 37),
						ZIndex = 10,
						Image = "rbxassetid://8579166120",
						ImageColor3 = selectedColor,
						ImageTransparency = 0
					})

					local cpHolder = darkener:object("Frame", {
						AnchorPoint = Vector2.new(.5, .5),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.5, -50,0.5, 0),
						Size = UDim2.fromOffset(160, 240),
						ZIndex = 12
					})

					local _cpShadowHolder = cpHolder:object("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 11
					})

					local _cpShadow = _cpShadowHolder:object("ImageLabel", {
						Centered = true,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 47,1, 47),
						ZIndex = 11,
						Image = "rbxassetid://6015897843",
						ImageColor3 = Color3.new(0, 0, 0),
						ImageTransparency = 1,
						SliceCenter = Rect.new(49, 49, 450, 450),
						ScaleType = Enum.ScaleType.Slice,
						SliceScale = 1
					})

					local btnHolder = cpHolder:object("Frame", {
						AnchorPoint = Vector2.new(1, 1),
						BackgroundColor3 = Color3.new(0, 0, 0),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 1),
						Size = UDim2.new(1, -5,0, 50),
						ZIndex = 12
					})

					local button = btnHolder:object("TextButton", {
						Centered = true,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						Size = UDim2.fromOffset(80, 20),
						ZIndex = 12,
						Text = "SELECT",
						TextSize = 13,
						Theme = {TextColor3 = {"Tertiary", -10}, BackgroundColor3 = {"Tertiary", -10}}
					}):round(8):stroke({"Tertiary", -10})

					do
						local hovered = false
						local down = false

						button.MouseEnter:connect(function()
							hovered = true
							button:tween{BackgroundTransparency = 0, TextColor3 = self:lighten(Library.CurrentTheme.StrongText, 15)}
						end)

						button.MouseLeave:connect(function()
							hovered = false
							if not down then
								button:tween{BackgroundTransparency = 1, TextColor3 = self:darken(Library.CurrentTheme.Tertiary, 10)}
							end
						end)

						button.MouseButton1Down:connect(function()
							button:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Tertiary, 20)}
						end)

						UserInputService.InputEnded:connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								button:tween{BackgroundTransparency = (hovered and 0) or 1}
								if hovered then
									button:tween{BackgroundColor3 = Library.CurrentTheme.Tertiary}
								end
							end
						end)

						button.MouseButton1Click:connect(function()
							fadeOut()
							icon:tween({ImageColor3 = selectedColor})
							options.Callback(selectedColor)
							task.delay(0.35, function()
								Library._colorPickerExists = false
							end)
						end)
					end

					local hueBar = cpHolder:object("TextButton", {
						BackgroundColor3 = Color3.new(255, 255, 255),
						BorderSizePixel = 0,
						Text = "",
						Size = UDim2.new(0, 5, 1, 0),
						ZIndex = 12,
						ClipsDescendants = true,
						BackgroundTransparency = 1
					})

					local _hueBarGradient = hueBar:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
							ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
							ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
							ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
							ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
							ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
						},
						Rotation = 90
					})

					local hueDraggable = hueBar:object("ImageButton", {
						BackgroundTransparency = 1,
						ImageTransparency = 1,
						Position = UDim2.new(-2, 3,0, -10),
						Size = UDim2.fromOffset(20, 20),
						ZIndex = 12,
						Image = "rbxassetid://8579244616"
					})

					local pickerArea = cpHolder:object("TextButton", {
						Text = "",
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0),
						Size = UDim2.new(1, -5,1, -50),
						ZIndex = 12,
						ClipsDescendants = true
					})

					local color = pickerArea:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 13,
						BackgroundColor3 = selectedColor,
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					})

					local brightness = pickerArea:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 14,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					})

					local _brightness = brightness:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255 ,255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255 ,255, 255))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}
					})

					local black = pickerArea:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 16,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					})

					local _black = black:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						},
						Rotation = -90
					})

					local colorPickerDraggable = pickerArea:object("TextButton", {
						Text = "",
						AnchorPoint = Vector2.new(.5, .5),
						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(6, 6),
						Position = UDim2.new(0, 152, 0, 3),
						ZIndex = 20
					}):round(100)

					local _colorPickerDraggableStroke = colorPickerDraggable:object("UIStroke", {
						Color = Color3.fromRGB(255, 255 ,255),
						Thickness = 1.6,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 1
					})

					-- HUE
					do
						updateHue = function()
							hue = math.clamp((Mouse.Y - hueBar.AbsolutePosition.Y) / (hueBar.AbsoluteSize.Y), 0, 1)
							local tempVal = math.clamp((Mouse.Y - pickerArea.AbsolutePosition.Y) / (pickerArea.AbsoluteSize.Y), 0, 1)
							local newYPos = math.clamp((Mouse.Y - hueBar.AbsolutePosition.Y) / (hueBar.AbsoluteSize.Y) * hueBar.AbsoluteSize.Y, 0, hueBar.AbsoluteSize.Y)
							selectedColor = Color3.fromHSV(hue, sat, val)
							color:tween({Length = 0.05, BackgroundColor3 = Color3.fromHSV(hue, 1, 1)})
							text:tween({ImageColor3 = selectedColor, Length = 0.05})
							arrow:tween({ImageColor3 = selectedColor, Length = 0.05})
							hueDraggable:tween({Length = 0.05, Position = UDim2.new(-2, 3, 0, math.clamp(newYPos - 10, -10, hueBar.AbsoluteSize.Y + 10)), ImageColor3 = Color3.fromHSV(1, 0, -tempVal)})
						end


						local down = false

						hueBar.MouseButton1Down:Connect(function()
							down = true
							while RunService.RenderStepped:Wait() and down do
								updateHue()
							end
						end)

						hueDraggable.MouseButton1Down:connect(function()
							down = true
							while RunService.RenderStepped:Wait() and down do
								updateHue()
							end
						end)

						UserInputService.InputEnded:Connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								if down then
									down = false
								end
							end
						end)
					end
					-- END HUE

					-- SAT & VALUE [PICKER]
					do
						local down = false

						updatePicker = function()
							sat = math.clamp((Mouse.X - pickerArea.AbsolutePosition.X) / (pickerArea.AbsoluteSize.X), 0, 1)
							val = 1 - math.clamp((Mouse.Y - pickerArea.AbsolutePosition.Y) / (pickerArea.AbsoluteSize.Y), 0, 1)

							local newXPos = math.clamp((Mouse.X - pickerArea.AbsolutePosition.X) / (pickerArea.AbsoluteSize.X) * pickerArea.AbsoluteSize.X, 0, pickerArea.AbsoluteSize.X)
							local newYPos = math.clamp((Mouse.Y - pickerArea.AbsolutePosition.Y) / (pickerArea.AbsoluteSize.Y) * pickerArea.AbsoluteSize.Y, 0, pickerArea.AbsoluteSize.Y)

							selectedColor = Color3.fromHSV(hue, sat, val)

							colorPickerDraggable:tween({Position = UDim2.fromOffset(newXPos, newYPos), Length = 0.05})
							text:tween({ImageColor3 = selectedColor, Length = 0.05})
							arrow:tween({ImageColor3 = selectedColor, Length = 0.05})
						end

						pickerArea.MouseButton1Down:Connect(function()
							down = true
							while RunService.RenderStepped:wait() and down do
								updatePicker()
							end
						end)

						UserInputService.InputEnded:Connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								if down then
									down = false
								end
							end
						end)
					end
					-- END SAT & VALUE

					-- opening (fade in)
					darkener:tween({BackgroundTransparency = .4, Length = 0.1})
					arrow:tween({ImageTransparency = 0, Length = 0.1})
					text:tween({ImageTransparency = 0, Length = 0.1})
					_cpShadow:tween({ImageTransparency = .6, Length = 0.1})
					btnHolder:tween({BackgroundTransparency = 0, Length = 0.1})
					button:tween({TextTransparency = 0, Length = 0.1})
					hueBar:tween({BackgroundTransparency = 0, Length = 0.1})
					hueDraggable:tween({ImageTransparency = 0, Length = 0.1})
					color:tween{BackgroundTransparency = 0, Length = 0.1}
					brightness:tween{BackgroundTransparency = 0, Length = 0.1}
					black:tween{BackgroundTransparency = 0, Length = 0.1}
					_colorPickerDraggableStroke:tween{Transparency = 0, Length = 0.1}

					-- closing fade in
					fadeOut = function()
						darkener:tween({BackgroundTransparency = 1, Length = 0.1})
						arrow:tween({ImageTransparency = 1, Length = 0.1})
						text:tween({ImageTransparency = 1, Length = 0.1})
						_cpShadow:tween({ImageTransparency = 1, Length = 0.1})
						btnHolder:tween({BackgroundTransparency = 1, Length = 0.1})
						button:tween({TextTransparency = 1, Length = 0.1})
						hueBar:tween({BackgroundTransparency = 1, Length = 0.1})
						hueDraggable:tween({ImageTransparency = 1, Length = 0.1})
						color:tween{BackgroundTransparency = 1, Length = 0.1}
						brightness:tween{BackgroundTransparency = 1, Length = 0.1}
						black:tween{BackgroundTransparency = 1, Length = 0.1}
						_colorPickerDraggableStroke:tween({Transparency = 1, Length = 0.1}, function()
							task.delay(0.25, function()
								darkener.AbsoluteObject:Destroy()
							end)
						end)
					end
				end
			else
				do
					-- legacy
					local holder = darkener:object("Frame", {
						Centered = true,
						Theme = {BackgroundColor3 = "Secondary"},
						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(255, 170),
					}):round(6)

					local _holderStroke = holder:object("UIStroke", {
						Transparency = 1,
						Theme = {Color = "Tertiary"},
						Thickness = 1.6
					})

					local _padding = holder:object("UIPadding", {
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 5),
						PaddingBottom = UDim.new(0, 5)
					})

					local pickerArea = holder:object("TextButton", {
						Text = "",
						BackgroundTransparency = 1,
						Size = UDim2.new(0.5, -5,1, -25),
					}):round(6)

					local _pickerAreaStroke = pickerArea:object("UIStroke", {
						Transparency = 1,
						Theme = {Color = "Tertiary"},
						Thickness = 1.6
					})

					local color = pickerArea:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						BackgroundColor3 = selectedColor,
						BackgroundTransparency = 1,
						ZIndex = 10
					}):round(6)

					local brightness = pickerArea:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 11,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					}):round(6)

					local _brightness = brightness:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255 ,255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255 ,255, 255))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}
					})

					local black = pickerArea:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 12,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}):round(6)

					local _black = black:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						},
						Rotation = -90
					})

					local colorPickerDraggable = pickerArea:object("TextButton", {
						Centered = true,
						Text = "",
						AnchorPoint = Vector2.new(.5, .5),
						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(6, 6),
						ZIndex = 20
					}):round(100)

					local _colorPickerDraggableStroke = colorPickerDraggable:object("UIStroke", {
						Transparency = 1,
						Color = Color3.fromRGB(255, 255, 255),
						Thickness = 1.6,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					})

					local hueArea = holder:object("TextButton", {
						Text = "",
						AnchorPoint = Vector2.new(0, 1),
						Position = UDim2.fromScale(0, 1),
						Size = UDim2.new(0.5, -5,0, 20),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						ZIndex = 11
					}):round(6)

					local _hueAreaStroke = hueArea:object("UIStroke", {
						Transparency = 1,
						Theme = {Color = "Tertiary"},
						Thickness = 1.6
					})

					local _hueAreaGradient = hueArea:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
							ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
							ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
							ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
							ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
							ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
						}
					})

					local hueDraggable = hueArea:object("TextButton", {
						Centered = true,
						Text = "",
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 3, 1, 0),
						ZIndex = 20
					})

					local _hueDraggableStroke = hueDraggable:object("UIStroke", {
						Transparency = 1,
						Color = Color3.fromRGB(255, 255, 255),
						Thickness = 1.6,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					})

					local label = holder:object("TextLabel", {
						Text = "Color Picker",
						Font = Enum.Font.SourceSansBold,
						AnchorPoint = Vector2.new(1,0),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0),
						Size = UDim2.new(0.5, 0,0, 20),
						Theme = {TextColor3 = {"Tertiary", 15}},
						TextSize = 15,
						TextTransparency = 1
					})

					local infos = holder:object("Frame", {
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0,0, 25),
						Size = UDim2.new(0.5, 0,0, 60)
					})

					local _infosList = infos:object("UIListLayout", {
						Padding = UDim.new(0, 4),
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.Name
					})

					local r = infos:object("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = "1",
						Text = tostring(selectedColor.R * 255),
						Theme = {BackgroundColor3 = {"Secondary", 12}},
						Size = UDim2.new(1, -10,0, 18),
						TextColor3 = Color3.fromHSV(0, 0.8, 1),
						TextSize = 14,
						BackgroundTransparency = 1,
						TextTransparency = 1
					}):round(4)

					local g = infos:object("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = "2",
						Text = tostring(selectedColor.G * 255),
						Theme = {BackgroundColor3 = {"Secondary", 12}},
						Size = UDim2.new(1, -10,0, 18),
						TextColor3 = Color3.fromHSV(120/360, 0.8, 1),
						TextSize = 14,
						BackgroundTransparency = 1,
						TextTransparency = 1
					}):round(4)

					local b = infos:object("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						Text = tostring(selectedColor.B * 255),
						Name = "3",
						Theme = {BackgroundColor3 = {"Secondary", 12}},
						Size = UDim2.new(1, -10,0, 18),
						TextColor3 = Color3.fromHSV(240/360, 0.8, 1),
						TextSize = 14,
						BackgroundTransparency = 1,
						TextTransparency = 1
					}):round(4)

					local pickBtn = holder:object("ImageButton", {
						AnchorPoint = Vector2.new(1, 1),
						Theme = {BackgroundColor3 = "Tertiary"},
						Position = UDim2.fromScale(1, 1),
						Size = UDim2.new(0.5, 0,0, 20),
						Image = "rbxassetid://8593962406",
						ScaleType = Enum.ScaleType.Fit,
						BackgroundTransparency = 1,
						ImageTransparency = 1
					}):round(6)

					local previewLight = holder:object("Frame", {
						AnchorPoint = Vector2.new(1, 1),
						BackgroundColor3 = selectedColor,
						Position = UDim2.new(1, -65,1, -25),
						Size = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1
					}):round(5)

					local _previewLightIcon = previewLight:object("ImageLabel", {
						Centered = true,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(.6, .6),
						Image = "rbxassetid://8593995344",
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						ImageTransparency = 1
					})

					local previewDark = holder:object("Frame", {
						AnchorPoint = Vector2.new(1, 1),
						BackgroundColor3 = selectedColor,
						Position = UDim2.new(1, -15,1, -25),
						Size = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1
					}):round(5)

					local _previewDarkIcon = previewDark:object("ImageLabel", {
						Centered = true,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(.6, .6),
						Image = "rbxassetid://8593995344",
						ImageColor3 = Color3.fromRGB(0, 0, 0),
						ImageTransparency = 1
					})


					-- hacky fix for zindex issue
					for _, v in next, darkener.AbsoluteObject:GetDescendants() do
						pcall(function()
							v.ZIndex += 3
						end)
					end

					local function globalUpdate()
						r.Text = tostring(math.floor(selectedColor.R * 255))
						g.Text = tostring(math.floor(selectedColor.G * 255))
						b.Text = tostring(math.floor(selectedColor.B * 255))
						previewDark:tween({BackgroundColor3 = selectedColor})
						previewLight:tween({BackgroundColor3 = selectedColor})
					end
					-- HUE
					do
						updateHue = function()
							hue = math.clamp((Mouse.X - hueArea.AbsolutePosition.X) / (hueArea.AbsoluteSize.X), 0, 1)
							local newXPos = math.clamp((Mouse.X - hueArea.AbsolutePosition.X) / (hueArea.AbsoluteSize.X) * hueArea.AbsoluteSize.X, 0, hueArea.AbsoluteSize.X)
							selectedColor = Color3.fromHSV(hue, sat, val)
							color:tween({Length = 0.05, BackgroundColor3 = Color3.fromHSV(hue, 1, 1)})
							hueDraggable:tween({Length = 0.05, Position = UDim2.new(0, math.clamp(newXPos, 0, hueArea.AbsoluteSize.X), .5, 0)})

							globalUpdate()
						end


						local down = false

						hueArea.MouseButton1Down:Connect(function()
							down = true
							while RunService.RenderStepped:Wait() and down do
								updateHue()
							end
						end)

						hueDraggable.MouseButton1Down:connect(function()
							down = true
							while RunService.RenderStepped:Wait() and down do
								updateHue()
							end
						end)

						UserInputService.InputEnded:Connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								if down then
									down = false
								end
							end
						end)
					end


					-- SAT & VALUE [PICKER]
					do
						local down = false

						updatePicker = function()
							sat = math.clamp((Mouse.X - pickerArea.AbsolutePosition.X) / (pickerArea.AbsoluteSize.X), 0, 1)
							val = 1 - math.clamp((Mouse.Y - pickerArea.AbsolutePosition.Y) / (pickerArea.AbsoluteSize.Y), 0, 1)

							local newXPos = math.clamp((Mouse.X - pickerArea.AbsolutePosition.X) / (pickerArea.AbsoluteSize.X) * pickerArea.AbsoluteSize.X, 0, pickerArea.AbsoluteSize.X)
							local newYPos = math.clamp((Mouse.Y - pickerArea.AbsolutePosition.Y) / (pickerArea.AbsoluteSize.Y) * pickerArea.AbsoluteSize.Y, 0, pickerArea.AbsoluteSize.Y)

							selectedColor = Color3.fromHSV(hue, sat, val)

							globalUpdate()

							colorPickerDraggable:tween({Position = UDim2.fromOffset(newXPos, newYPos), Length = 0.05})
						end

						pickerArea.MouseButton1Down:Connect(function()
							down = true
							while RunService.RenderStepped:wait() and down do
								updatePicker()
							end
						end)

						UserInputService.InputEnded:Connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								if down then
									down = false
								end
							end
						end)
					end

					-- input n shit
					do
						local down = false
						local hovered = false

						pickBtn.MouseEnter:connect(function()
							hovered = true
							pickBtn:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Tertiary, 10)}
						end)

						pickBtn.MouseLeave:connect(function()
							hovered = false
							if not down then
								pickBtn:tween{BackgroundColor3 = Library.CurrentTheme.Tertiary}
							end
						end)

						pickBtn.MouseButton1Down:connect(function()
							pickBtn:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Tertiary, 20)}
						end)

						UserInputService.InputEnded:connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								pickBtn:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Tertiary)) or Library.CurrentTheme.Tertiary}
							end
						end)

						pickBtn.MouseButton1Click:connect(function()
							fadeOut()
							icon:tween({ImageColor3 = selectedColor})
							options.Callback(selectedColor)
							task.delay(0.35, function()
								Library._colorPickerExists = false
							end)
						end)
					end

					--show fade in
					holder:tween({BackgroundTransparency = 0, Length = 0.1})
					_holderStroke:tween({Transparency = 0, Length = 0.1})
					pickerArea:tween({BackgroundTransparency = 0, Length = 0.1})
					_pickerAreaStroke:tween({Transparency = 0, Length = 0.1})
					color:tween({BackgroundTransparency = 0, Length = 0.1})
					brightness:tween({BackgroundTransparency = 0, Length = 0.1})
					black:tween({BackgroundTransparency = 0, Length = 0.1})
					_colorPickerDraggableStroke:tween({Transparency = 0, Length = 0.1})
					hueArea:tween({BackgroundTransparency = 0, Length = 0.1})
					_hueAreaStroke:tween({Transparency = 0, Length = 0.1})
					_hueDraggableStroke:tween({Transparency = 0, Length = 0.1})
					label:tween{TextTransparency = 0, Length = 0.1}
					r:tween({
						BackgroundTransparency = 0,
						TextTransparency = 0,
						Length = 0.1
					})
					g:tween({
						BackgroundTransparency = 0,
						TextTransparency = 0,
						Length = 0.1
					})
					b:tween({
						BackgroundTransparency = 0,
						TextTransparency = 0,
						Length = 0.1
					})
					pickBtn:tween({
						BackgroundTransparency = 0,
						ImageTransparency = 0,
						Length = 0.1
					})
					previewLight:tween({BackgroundTransparency = 0, Length = 0.1})
					_previewLightIcon:tween({ImageTransparency = 0, Length = 0.1})
					previewDark:tween({BackgroundTransparency = 0, Length = 0.1})
					_previewDarkIcon:tween({ImageTransparency = 0, Length = 0.1})
					darkener:tween({BackgroundTransparency = 0.5, Length = 0.1})
					-- fade out
					-- closing fade in
					fadeOut = function()
						holder:tween({BackgroundTransparency = 1, Length = 0.1})
						_holderStroke:tween({Transparency = 1, Length = 0.1})
						pickerArea:tween({BackgroundTransparency = 1, Length = 0.1})
						_pickerAreaStroke:tween({Transparency = 1, Length = 0.1})
						color:tween({BackgroundTransparency = 1, Length = 0.1})
						brightness:tween({BackgroundTransparency = 1, Length = 0.1})
						black:tween({BackgroundTransparency = 1, Length = 0.1})
						_colorPickerDraggableStroke:tween({Transparency = 1, Length = 0.1})
						hueArea:tween({BackgroundTransparency = 1, Length = 0.1})
						_hueAreaStroke:tween({Transparency = 1, Length = 0.1})
						_hueDraggableStroke:tween({Transparency = 1, Length = 0.1})
						label:tween{TextTransparency = 1, Length = 0.1}
						r:tween({
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Length = 0.1
						})
						g:tween({
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Length = 0.1
						})
						b:tween({
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Length = 0.1
						})
						pickBtn:tween({
							BackgroundTransparency = 1,
							ImageTransparency = 1,
							Length = 0.1
						})
						previewLight:tween({BackgroundTransparency = 1, Length = 0.1})
						_previewLightIcon:tween({ImageTransparency = 1, Length = 0.1})
						previewDark:tween({BackgroundTransparency = 1, Length = 0.1})
						_previewDarkIcon:tween({ImageTransparency = 1, Length = 0.1})

						darkener:tween({BackgroundTransparency = 1, Length = 0.1}, function()
							task.delay(0.25, function()
								darkener.AbsoluteObject:Destroy()
							end)
						end)
					end
				end
			end
		end)
	end
	self:_resize_tab()
end

function Library:credit(options)
	options = self:set_defaults({
		Name = "Creditor",
		Description = nil
	}, options)
	options.V3rmillion = options.V3rmillion or options.V3rm

	local creditContainer = (self.creditsContainer or self.container):object("Frame", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local name = creditContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 0),
		Size = (options.Description and UDim2.new(0.5, -10, 0, 22)) or UDim2.new(0.5, -10, 1, 0),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = creditContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end

	if setclipboard then
		if options.Discord then
			local discordContainer = creditContainer:object("TextButton", {
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.fromOffset(24, 24),
				Position = UDim2.new(1, -8, 1, -8),
				BackgroundColor3 = Color3.fromRGB(88, 101, 242)
			}):round(5):tooltip("copy discord")
			local discord = discordContainer:object("Frame", {
				Size = UDim2.new(1, -6, 1, -6),
				Centered = true,
				BackgroundTransparency = 1
			})

			local tr = discord:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 0),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(1, 0, 0, -0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594150191",
				ScaleType = Enum.ScaleType.Crop
			})

			local tl = discord:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0, 0, 0, -0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594187532",
				ScaleType = Enum.ScaleType.Crop
			})

			local bl = discord:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 1),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0, 0, 1, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594194954",
				ScaleType = Enum.ScaleType.Crop
			})

			local br = discord:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(1, 0, 1, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594206483",
				ScaleType = Enum.ScaleType.Crop
			})

			discordContainer.MouseButton1Click:connect(function()
				setclipboard(options.Discord)
			end)
		end

		if options.V3rmillion then
			local v3rmillionContainer = creditContainer:object("TextButton", {
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.fromOffset(24, 24),
				Position = UDim2.new(1, -40, 1, -8),
				Theme = {BackgroundColor3 = {"Main", 10}}
			}):round(5):tooltip("copy v3rm")
			local v3rmillion = v3rmillionContainer:object("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=8594086769",
				Size = UDim2.new(1, -4, 1, -4),
				Centered = true,
				BackgroundTransparency = 1
			})

			v3rmillionContainer.MouseButton1Click:connect(function()
				setclipboard(options.V3rmillion)
			end)
		end
	end


	self._resize_tab({
		container = self.creditsContainer or self.container,
		layout = (self.creditsContainer and self.creditsContainer.AbsoluteObject.UIListLayout) or self.layout
	})
end

function Library:_theme_selector()

	local themesCount = 0

	for _ in next, Library.Themes do
		themesCount += 1
	end

	local themeContainer = self.container:object("Frame", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 127)
	}):round(7)

	local text = themeContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(0.5, -10, 0, 22),
		Text = "Theme",
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local colorThemesContainer = themeContainer:object("Frame", {
		Size = UDim2.new(1, 0, 1, -32),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 1, -5),
		AnchorPoint = Vector2.new(0.5, 1)
	})

	local grid = colorThemesContainer:object("UIGridLayout", {
		CellPadding = UDim2.fromOffset(10, 10),
		CellSize = UDim2.fromOffset(102, 83),
		VerticalAlignment = Enum.VerticalAlignment.Center
	})

	colorThemesContainer:object("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 5)
	})

	for themeName, themeColors in next, Library.Themes do
		local count = 0

		for _, color in next, themeColors do
			if not (type(color) == "boolean") then
				count += 1
			end
		end

		if count >= 5 then
			local theme = colorThemesContainer:object("TextButton", {
				BackgroundTransparency = 1
			})

			local themeColorsContainer = theme:object("Frame", {
				Size = UDim2.new(1, 0, 1, -20),
				BackgroundTransparency = 1
			}):round(5):stroke("WeakText", 1)

			local themeNameLabel = theme:object("TextLabel", {
				BackgroundTransparency = 1,
				Text = themeName,
				TextSize = 16,
				Theme = {TextColor3 = "StrongText"},
				Size = UDim2.new(1, 0, 0, 20),
				Position = UDim2.fromScale(0, 1),
				AnchorPoint = Vector2.new(0, 1)
			})

			local colorMain = themeColorsContainer:object("Frame", {
				Centered = true,
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = themeColors.Main
			}):round(4)

			local colorSecondary = colorMain:object("Frame", {
				Centered = true,
				Size = UDim2.new(1, -16, 1, -16),
				BackgroundColor3 = themeColors.Secondary
			}):round(4)

			colorSecondary:object("UIListLayout", {
				Padding = UDim.new(0, 5)
			})

			colorSecondary:object("UIPadding", {
				PaddingTop = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5)
			})

			local colorTertiary = colorSecondary:object("Frame", {
				Size = UDim2.new(1, -20, 0, 9),
				BackgroundColor3 = themeColors.Tertiary
			}):round(100)

			local colorStrong = colorSecondary:object("Frame", {
				Size = UDim2.new(1, -30, 0, 9),
				BackgroundColor3 = themeColors.StrongText
			}):round(100)

			local colorTertiary = colorSecondary:object("Frame", {
				Size = UDim2.new(1, -40, 0, 9),
				BackgroundColor3 = themeColors.WeakText
			}):round(100)

			theme.MouseButton1Click:connect(function()
				Library:change_theme(Library.Themes[themeName])
				updateSettings("Theme", themeName)
			end)
		end
	end
	self:_resize_tab()
end


function Library:keybind(options)
	options = self:set_defaults({
		Name = "Keybind",
		Keybind = nil,
		Description = nil,
		Callback = function() end
	}, options)

	local keybindContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local text = keybindContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 0),
		Size = (options.Description and UDim2.new(0.5, -10, 0, 22)) or UDim2.new(0.5, -10, 1, 0),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = keybindContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end


	local keybindDisplay = keybindContainer:object("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {"Secondary", -20},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, -20,0, 16),
		Size = UDim2.new(0, 50,0, 20),
		TextSize = 12,
		Text = (options.Keybind and tostring(options.Keybind.Name):upper()) or "?"
	}):round(5):stroke("Tertiary")

	keybindDisplay.Size = UDim2.fromOffset(keybindDisplay.TextBounds.X + 20, 20)

	do
		local hovered = false
		local down = false
		local listening = false

		keybindContainer.MouseEnter:connect(function()
			hovered = true
			keybindContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		keybindContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				keybindContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		keybindContainer.MouseButton1Down:connect(function()
			keybindContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 20)}
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				keybindContainer:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Secondary)) or Library.CurrentTheme.Secondary}
			end
		end)

		UserInputService.InputBegan:Connect(function(key, gameProcessed)
			if listening and not UserInputService:GetFocusedTextBox() then
				if key.UserInputType == Enum.UserInputType.Keyboard then
					if key.KeyCode ~= Enum.KeyCode.Escape then
						options.Keybind = key.KeyCode
					end
					keybindDisplay.Text = (options.Keybind and tostring(options.Keybind.Name):upper()) or "?"
					keybindDisplay:tween{Size = UDim2.fromOffset(keybindDisplay.TextBounds.X + 20, 20), Length = 0.05}
					listening = false
				end
			else
				if key.KeyCode == options.Keybind then
					options.Callback()
				end
			end
		end)

		keybindContainer.MouseButton1Click:connect(function()
			if not listening then listening = true; keybindDisplay.Text = "..." end
		end)
	end
	self:_resize_tab()

	local methods = {}

	function methods:Set(keycode)
		options.Keybind = keycode
		keybindDisplay.Text = (options.Keybind and tostring(options.Keybind.Name):upper()) or "?"
		keybindDisplay:tween{Size = UDim2.fromOffset(keybindDisplay.TextBounds.X + 20, 20), Length = 0.05}
	end

	return methods
end

function Library:prompt(options)
	options = self:set_defaults({
		Followup = false,
		Title = "Prompt",
		Text = "yo momma dead",
		Buttons = {
			ok = function()
				return true
			end
		}
	}, options)

	if Library._promptExists and not options.Followup then return end
	Library._promptExists = true

	local count = 0; for a, _ in next, options.Buttons do
		count += 1
	end

	local darkener = self.core:object("Frame", {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}):round(10)

	local promptContainer = darkener:object("Frame", {
		Theme = {BackgroundColor3 = "Main"},
		BackgroundTransparency = 1,
		Centered = true,
		Size = UDim2.fromOffset(200, 120)
	}):round(6)

	local _promptContainerStroke = promptContainer:object("UIStroke", {
		Theme = {Color = "Tertiary"},
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Transparency = 1
	})

	local _padding = promptContainer:object("UIPadding", {
		PaddingTop = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	})

	local promptTitle = promptContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 20),
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.SourceSansBold,
		Text = options.Title,
		Theme = {TextColor3 = {"Tertiary", 15}},
		TextSize = 16,
		TextTransparency = 1
	})

	local promptText = promptContainer:object("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0,0, 26),
		Size = UDim2.new(1, -20,1, -60),
		TextSize = 14,
		Theme = {TextColor3 = "StrongText"},

		Text = options.Text,
		TextTransparency = 1,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.AtEnd
	})

	local buttonHolder = promptContainer:object("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0,1, -5),
		Size = UDim2.new(1, 0,0, 20)
	})

	local _gridButtonHolder = buttonHolder:object("UIGridLayout", {
		CellPadding = UDim2.new(0, 10,0, 5),
		CellSize = UDim2.new(1/count, -10, 1, 0),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})

	darkener:tween({BackgroundTransparency = 0.4, Length = 0.1})
	promptContainer:tween({BackgroundTransparency = 0, Length = 0.1})
	promptTitle:tween({TextTransparency = 0, Length = 0.1})
	_promptContainerStroke:tween({Transparency = 0, Length = 0.1})
	promptText:tween({TextTransparency = 0, Length = 0.1})

	local _temporaryPromptButtons = {}

	for text, callback in next, options.Buttons do
		local button = buttonHolder:object("TextButton", {
			AnchorPoint = Vector2.new(1, 1),
			Theme = {BackgroundColor3 = "Tertiary"},
			Text = tostring(text):upper(),
			TextSize = 13,
			Font = Enum.Font.SourceSansBold,
			BackgroundTransparency = 1,
			TextTransparency = 1
		}):round(4)

		table.insert(_temporaryPromptButtons, button)

		do
			button:tween({TextTransparency = 0, BackgroundTransparency = 0})

			local hovered = false
			local down = false

			button.MouseEnter:connect(function()
				hovered = true
				button:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Tertiary, 10)}
			end)

			button.MouseLeave:connect(function()
				hovered = false
				if not down then
					button:tween{BackgroundColor3 = Library.CurrentTheme.Tertiary}
				end
			end)

			button.MouseButton1Down:connect(function()
				button:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Tertiary, 20)}
			end)

			UserInputService.InputEnded:connect(function(key)
				if key.UserInputType == Enum.UserInputType.MouseButton1 then
					button:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Tertiary)) or Library.CurrentTheme.Tertiary}
				end
			end)

			button.MouseButton1Click:connect(function()
				promptContainer:tween({BackgroundTransparency = 1, Length = 0.1})
				promptTitle:tween({TextTransparency = 1, Length = 0.1})
				_promptContainerStroke:tween({Transparency = 1, Length = 0.1})
				promptText:tween({TextTransparency = 1, Length = 0.1})
				for i, b in next, _temporaryPromptButtons do
					b:tween({TextTransparency = 1, BackgroundTransparency = 1, Length = 0.1})
				end
				darkener:tween({BackgroundTransparency = 1, Length = 0.1}, function()
					darkener.AbsoluteObject:Destroy()
					task.delay(0.25, function()
						Library._promptExists = false
					end)
					callback()
				end)
			end)
		end
	end
end

function Library:cp(options)
	return Library.color_picker(self, options)
end
function Library:colorpicker(options)
	return Library.color_picker(self, options)
end

function Library:slider(options)
	options = self:set_defaults({
		Name = "Slider",
		Default = 50,
		Min = 0,
		Max = 100,
		Callback = function() end
	}, options)


	local sliderContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 56)
	}):round(7)

	local text = sliderContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(0.5, -10, 0, 22),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = sliderContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
		sliderContainer.Size = UDim2.new(1, -20, 0, 76)
	end

	local valueText = sliderContainer:object("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),

		Theme = {
			BackgroundColor3 = {"Secondary", -20},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, -10, 0, 10),
		Size = UDim2.new(0, 50,0, 20),
		TextSize = 12,
		Text = options.Default
	}):round(5):stroke("Tertiary")

	valueText.Size = UDim2.fromOffset(valueText.TextBounds.X + 20, 20)

	local sliderBar = sliderContainer:object("Frame", {
		Theme = {BackgroundColor3 = {"Secondary", -20}},
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.new(1, -20, 0, 5),
		Position = UDim2.new(0.5, 0, 1, -12)
	}):round(100)

	local sliderLine = sliderBar:object("Frame", {
		Size = UDim2.fromScale(((options.Default - options.Min) / (options.Max - options.Min)), 1),
		Theme = {BackgroundColor3 = "Tertiary"}

	}):round(100)

	local sliderBall = sliderLine:object("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(14, 14),
		Theme = {BackgroundColor3 = {"Tertiary", 20}}
	}):round(100)

	do
		local hovered = false
		local down = false

		sliderContainer.MouseEnter:connect(function()
			hovered = true
			sliderContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		sliderContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				sliderContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		UserInputService.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				down = false
				sliderContainer:tween{BackgroundColor3 = (hovered and self:lighten(Library.CurrentTheme.Secondary)) or Library.CurrentTheme.Secondary}
			end
		end)

		sliderContainer.MouseButton1Down:connect(function()
			sliderContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 20)}
			down = true
			local tween = valueText:tween{Size = UDim2.fromOffset(valueText.TextBounds.X + 20, 20)}
			while RunService.RenderStepped:wait() and down do
				local percentage = math.clamp((Mouse.X - sliderBar.AbsolutePosition.X) / (sliderBar.AbsoluteSize.X), 0, 1)
				local value = ((options.Max - options.Min) * percentage) + options.Min
				value = math.floor(value)
				valueText.Text = value
				if tween.PlaybackState == Enum.PlaybackState.Completed then
					tween = valueText:tween{Size = UDim2.fromOffset(valueText.TextBounds.X + 20, 20)}
				end
				sliderLine:tween{
					Length = 0.06,
					Size = UDim2.fromScale(percentage, 1)
				}
				options.Callback(value)
			end
		end)
	end
	self:_resize_tab()

	local methods = {}

	function methods:Set(value)
		sliderLine:tween{Size = UDim2.fromScale(((value - options.Min) / (options.Max - options.Min)), 1)}
	end

	return methods
end

function Library:textbox(options)
	options = self:set_defaults({
		Name = "Text Box",
		Placeholder = "Type something..",
		Description = nil,
		Callback = function(t) end
	}, options)

	local textboxContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52)
	}):round(7)

	local text = textboxContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (options.Description and 5) or 0),
		Size = (options.Description and UDim2.new(0.5, -10, 0, 22)) or UDim2.new(0.5, -10, 1, 0),
		Text = options.Name,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	if options.Description then
		local description = textboxContainer:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, -10, 0, 20),
			Text = options.Description,
			TextSize = 18,
			Theme = {TextColor3 = "WeakText"},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end


	local textBox = textboxContainer:object("TextBox", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {"Secondary", -20},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, -50,0, 16),
		Size = UDim2.new(0, 50,0, 20),
		TextSize = 12,
		PlaceholderText = options.Placeholder,
		ClipsDescendants = true
	}):round(5):stroke("Tertiary")

	local writeIcon = textboxContainer:object("ImageLabel", {
		Image = "http://www.roblox.com/asset/?id=8569329416",
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -13, 0.5, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Theme = {ImageColor3 = "StrongText"}
	})



	textBox.Size = UDim2.fromOffset(textBox.TextBounds.X + 20, 20)

	do
		local hovered = false
		local down = false
		local focused = false

		textboxContainer.MouseEnter:connect(function()
			textboxContainer:tween{BackgroundColor3 = self:lighten(Library.CurrentTheme.Secondary, 10)}
		end)

		textboxContainer.MouseLeave:connect(function()
			hovered = false
			if not down then
				textboxContainer:tween{BackgroundColor3 = Library.CurrentTheme.Secondary}
			end
		end)

		textBox.Focused:connect(function()
			focused = true
			while focused and RunService.RenderStepped:wait() do
				textBox.AbsoluteObject:TweenSize(
					UDim2.fromOffset(math.clamp(textBox.TextBounds.X + 20, 0, 0.5 * textboxContainer.AbsoluteSize.X), 20),
					Enum.EasingDirection.InOut,
					Enum.EasingStyle.Linear,
					0.1,
					true
				)
			end
		end)

		textBox.FocusLost:connect(function()
			focused = false
			textBox.AbsoluteObject:TweenSize(
				UDim2.fromOffset(math.clamp(textBox.TextBounds.X + 20, 0, 0.5 * textboxContainer.AbsoluteSize.X), 20),
				Enum.EasingDirection.InOut,
				Enum.EasingStyle.Linear,
				0.1,
				true
			)
			options.Callback(textBox.Text)
		end)
	end
	self:_resize_tab()

	local methods = {}

	function methods:Set(text)
		textBox.Text = text
	end

	return methods
end

function Library:label(options)

	options = self:set_defaults({
		Text = "Label title",
		Description = "Label text",
	}, options)

	local labelContainer = self.container:object("TextButton", {
		Theme = {BackgroundColor3 = "Secondary"},
		Size = UDim2.new(1, -20, 0, 52),
		BackgroundTransparency = 1
	}):round(7):stroke("Secondary", 2)

	local text = labelContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(0.5, -10, 0, 22),
		Text = options.Text,
		TextSize = 22,
		Theme = {TextColor3 = "StrongText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local description = labelContainer:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 1, -5),
		Size = UDim2.new(0.5, -10, 1, -22),
		Text = options.Description,
		TextSize = 18,
		AnchorPoint = Vector2.new(0, 1),
		Theme = {TextColor3 = "WeakText"},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	self:_resize_tab()

	local methods = {}

	function methods:SetText(txt)
		text.Text = txt
	end
	
	function methods:SetDescription(txt)
		description.Text = txt
	end

	return methods
end

return setmetatable(Library, {
	__index = function(_, i)
		return rawget(Library, i:lower())
	end
})