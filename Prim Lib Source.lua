local lib = {}

lib.init = function(title, accent, togglekey)
	local window = {}
	local UILib = Instance.new("ScreenGui")
	local uiBorder1 = Instance.new("Frame")
	local uiBorder2 = Instance.new("Frame")
	local uiBorder3 = Instance.new("Frame")
	local uiBack = Instance.new("Frame")
	local uiTop = Instance.new("Frame")
	local uiTopLine = Instance.new("Frame")
	local uiNameLabel = Instance.new("TextLabel")
	local uiBottom = Instance.new("Frame")
	local uiBottomLine = Instance.new("Frame")
	local uiSearchButton = Instance.new("ImageLabel")
	local uiBottomHolder = Instance.new("Frame")
	local UIListLayout1 = Instance.new("UIListLayout")
	local uiTabButton = Instance.new("Frame")
	local uiTabButtonImage = Instance.new("ImageLabel")
	local uiTabButtonLabel = Instance.new("TextLabel")
	local uiTabButtonLine = Instance.new("Frame")
	local uiTabButton_2 = Instance.new("Frame")
	local uiTabButtonLabel_2 = Instance.new("TextLabel")
	local uiTabButtonLine_2 = Instance.new("Frame")
	local uiTabButtonImage_2 = Instance.new("ImageLabel")
	local Mouse = game.Players.LocalPlayer:GetMouse()

	-- [ Library Variables ] --
	lib.accentItems = {}
	lib.titlelabel = uiNameLabel
	lib.title = title or "primordial"
	lib.accent = accent or lib.accent
	lib.togglekey = togglekey or Enum.KeyCode.Insert
	lib.flags = {}
	lib.selectedtab = nil
	lib.selectedtab2 = nil
	lib.totaltabs = 0
	lib.tabbuttons = {}
	lib.visible = true
	lib.closing = false
	lib.inDropdown = false
	lib.tabframes = {}
	lib.inColorPicker =  false

	UILib.Name = game:GetService("HttpService"):GenerateGUID(false)
	UILib.Parent = game.CoreGui
	UILib.ResetOnSpawn = false

	uiBorder1.Name = "uiBorder1"
	uiBorder1.Parent = UILib
	uiBorder1.BackgroundColor3 = Color3.fromRGB(27, 22, 20)
	uiBorder1.BorderSizePixel = 0
	uiBorder1.Position = UDim2.new(0.25784564, 0, 0.0941759646, 0)
	uiBorder1.Size = UDim2.new(0, 570, 0, 600)
	local uiCorner = Instance.new("UICorner",uiBorder1); uiCorner.CornerRadius = UDim.new(0.02,0)

	uiBorder2.Name = "uiBorder2"
	uiBorder2.Parent = uiBorder1
	uiBorder2.BackgroundColor3 = Color3.fromRGB(38, 36, 34)
	uiBorder2.BorderSizePixel = 0
	uiBorder2.Position = UDim2.new(0, 1, 0, 1)
	uiBorder2.Size = UDim2.new(0, 568, 0, 598)
	local uiCorner = Instance.new("UICorner",uiBorder2); uiCorner.CornerRadius = UDim.new(0.02,0)

	uiBorder3.Name = "uiBorder3"
	uiBorder3.Parent = uiBorder2
	uiBorder3.BackgroundColor3 = Color3.fromRGB(35, 34, 32)
	uiBorder3.BorderSizePixel = 0
	uiBorder3.Position = UDim2.new(0, 1, 0, 1)
	uiBorder3.Size = UDim2.new(0, 566, 0, 596)
	local uiCorner = Instance.new("UICorner",uiBorder3); uiCorner.CornerRadius = UDim.new(0.02,0)

	uiBack.Name = "uiBack"
	uiBack.Parent = uiBorder3
	uiBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	uiBack.BorderSizePixel = 0
	uiBack.Position = UDim2.new(0, 1, 0, 1)
	uiBack.Size = UDim2.new(0, 564, 0, 594)
	local uiCorner = Instance.new("UICorner",uiBack); uiCorner.CornerRadius = UDim.new(0.02,0)

	uiTop.Name = "uiTop"
	uiTop.Parent = uiBack
	uiTop.BackgroundColor3 = Color3.fromRGB(53, 52, 51)
	uiTop.BorderSizePixel = 0
	uiTop.Size = UDim2.new(1, 0, 0, 25)
	local uiCorner = Instance.new("UICorner",uiTop); uiCorner.CornerRadius = UDim.new(0.13,0)

	uiTopLine.Name = "uiTopLine"
	uiTopLine.Parent = uiTop
	uiTopLine.BackgroundColor3 = lib.accent
	uiTopLine.BorderSizePixel = 0
	uiTopLine.Position = UDim2.new(0, 0, 1, -1)
	uiTopLine.Size = UDim2.new(1, 0, 0, 2)
	table.insert(lib.accentItems, uiTopLine)

	uiNameLabel.Name = "uiNameLabel"
	uiNameLabel.Parent = uiTop
	uiNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	uiNameLabel.BackgroundTransparency = 1.000
	uiNameLabel.Position = UDim2.new(0.5, -125, 0, 0)
	uiNameLabel.Size = UDim2.new(0, 250, 1, 0)
	uiNameLabel.Font = Enum.Font.Arial
	uiNameLabel.Text = title
	uiNameLabel.TextColor3 = Color3.fromRGB(191, 191, 191)
	uiNameLabel.TextSize = 14.000
	uiNameLabel.TextStrokeColor3 = Color3.fromRGB(14, 14, 14)
	uiNameLabel.TextStrokeTransparency = 0.350

	uiBottom.Name = "uiBottom"
	uiBottom.Parent = uiBack
	uiBottom.BackgroundColor3 = Color3.fromRGB(53, 52, 51)
	uiBottom.BorderSizePixel = 0
	uiBottom.Position = UDim2.new(0, 0, 1, -50)
	uiBottom.Size = UDim2.new(1, 0, 0, 50)
	local uiCorner = Instance.new("UICorner",uiBottom); uiCorner.CornerRadius = UDim.new(0.13,0)

	uiBottomLine.Name = "uiBottomLine"
	uiBottomLine.Parent = uiBottom
	uiBottomLine.BackgroundColor3 = lib.accent
	uiBottomLine.BorderSizePixel = 0
	uiBottomLine.Position = UDim2.new(0, 0, 0, -1)
	uiBottomLine.Size = UDim2.new(1, 0, 0, 2)
	table.insert(lib.accentItems, uiBottomLine)

	uiSearchButton.Name = "uiSearchButton"
	uiSearchButton.Parent = uiBottom
	uiSearchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	uiSearchButton.BackgroundTransparency = 1.000
	uiSearchButton.Position = UDim2.new(0, 9, 0.5, -19)
	uiSearchButton.Size = UDim2.new(0, 40, 0, 40)
	uiSearchButton.Image = "http://www.roblox.com/asset/?id=8595257169"
	uiSearchButton.ImageColor3 = Color3.fromRGB(127, 127, 127)

	uiBottomHolder.Name = "uiBottomHolder"
	uiBottomHolder.Parent = uiBottom
	uiBottomHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	uiBottomHolder.BackgroundTransparency = 1.000
	uiBottomHolder.Position = UDim2.new(0.5, -230, 0, 1)
	uiBottomHolder.Size = UDim2.new(0, 460, 1, -1)

	UIListLayout1.Name = "UIListLayout1"
	UIListLayout1.Parent = uiBottomHolder
	UIListLayout1.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout1.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout1.Padding = UDim.new(0, 5)

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		uiBorder1.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	uiTop.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = uiBorder1.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	uiTop.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	-- [ Library Functions ] --
	lib.setAccent = function(color3)
		if color3 ~= nil and color3.R ~= nil and color3.G ~= nil and color3.B ~= nil then
			lib.accent = color3
			for i,v in pairs(lib.accentItems) do
				if v:IsA("Frame") and v.BackgroundColor3 ~= Color3.fromRGB(35, 35, 35) then
					v.BackgroundColor3 = lib.accent
				elseif v:IsA("TextLabel") and v.TextColor3 ~= Color3.fromRGB(208, 208, 208) then
					v.TextColor3 = lib.accent
				end
			end
		else
			pcall(function()
				warn("Invalid color passed as argument for function setAccent: "..tostring(color3))
			end)
		end
	end
	lib.setToggleKey = function(keycode)
		if keycode ~= nil and keycode.Name ~= nil then
			lib.togglekey = keycode
		else
			pcall(function()
				warn("Invalid keycode passed as argument for function setToggleKey: "..tostring(keycode))
			end)
		end
	end
	lib.setTitle = function(str)
		if str ~= nil then
			lib.titlelabel.Text = str
		else
			pcall(function()
				warn("Invalid string passed as argument for function setTitle: "..tostring(str))
			end)
		end
	end

	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == lib.togglekey and not lib.closing then
			lib.visible = not lib.visible
			if lib.visible then
				UILib.Enabled = true
			end
			lib.closing = true
			if not lib.visible then
				for i,v in pairs(UILib:GetDescendants()) do
					if v:IsA("Frame") then
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
					elseif v:IsA("TextLabel") then
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency = 1.000}):Play()
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextStrokeTransparency = 1.000}):Play()
					elseif v:IsA("ImageLabel") then
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency = 1.000}):Play()
					end
				end
			elseif lib.visible then
				for i,v in pairs(UILib:GetDescendants()) do
					if v:IsA("Frame") and v.Name ~= "uiBottomHolder" then
						if v.Name == "uiTabButton" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						elseif v.Name == "uiTabButtonLine" then
							if lib.selectedtab == v.Parent then
								game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 0.000}):Play()
							else
								game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
							end
						elseif v.Name == "uiTabSectionHolder" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						elseif v.Name == "uiSectionButton" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						elseif v.Name == "uiSectionSlider" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						elseif v.Name == "uiSectionDropdown" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						elseif v.Name == "uiSectionColorpicker" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						elseif v.Name == "uiSectionButton2" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
						else
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 0.000}):Play()
						end
					elseif v:IsA("TextLabel") then
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency = 0.000}):Play()
						game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextStrokeTransparency = 0.350}):Play()
					elseif v:IsA("ImageLabel") then
						if v.Name == "transparencyImage" then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency = 0.89}):Play()
						else
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.23,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency = 0.000}):Play()
						end
					end
				end
			end
			task.wait(0.25)
			if not lib.visible then
				UILib.Enabled = false
			end
			lib.closing = false
		end
	end)

	-- [ Tabs ] --

	window.createTab = function(title, image)
		lib.totaltabs = lib.totaltabs + 1
		local tab = {}
		local uiTabButton = Instance.new("Frame")
		local uiTabButtonLabel = Instance.new("TextLabel")
		local uiTabButtonLine = Instance.new("Frame")
		local uiTabButtonImage = Instance.new("ImageLabel")
		local uiTab = Instance.new("ScrollingFrame")
		local Frame = Instance.new("Frame")
		local xl = 0
		local xr = 0
		local xs = 0

		uiTabButton.Name = "uiTabButton"
		uiTabButton.Parent = uiBottomHolder
		uiTabButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
		uiTabButton.ClipsDescendants = true
		uiTabButton.BackgroundTransparency = 1.000
		uiTabButton.BorderSizePixel = 0
		uiTabButton.Size = UDim2.new(0, 49, 1, 0)
		uiTabButton.ZIndex = 2
		table.insert(lib.tabbuttons, uiTabButton)
		lib.selectedtab2 = uiTab

		uiTabButtonLabel.Name = "uiTabButtonLabel"
		uiTabButtonLabel.Parent = uiTabButton
		uiTabButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		uiTabButtonLabel.BackgroundTransparency = 1.000
		uiTabButtonLabel.Position = UDim2.new(0, 0, 1, -20)
		uiTabButtonLabel.Size = UDim2.new(1, 0, 0, 20)
		uiTabButtonLabel.ZIndex = 2
		uiTabButtonLabel.Font = Enum.Font.Arial
		uiTabButtonLabel.Text = title
		uiTabButtonLabel.TextColor3 = Color3.fromRGB(182, 182, 182)
		uiTabButtonLabel.TextSize = 13.500
		uiTabButtonLabel.TextStrokeColor3 = Color3.fromRGB(14, 14, 14)
		uiTabButtonLabel.TextStrokeTransparency = 0.350
		uiTabButtonLabel.ZIndex = 3

		Frame.Parent = uiTabButton
		Frame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.Position = UDim2.new(0, 0, 0, 49)
		Frame.BorderSizePixel = 0
		if lib.totaltabs > 1 then
		else
			Frame.Position = UDim2.new(0, 0, 0, 0)
			lib.selectedtab = uiTabButton
		end
		Frame.Visible = true
		Frame.ZIndex = 2

		uiTabButtonLine.Name = "uiTabButtonLine"
		uiTabButtonLine.Parent = uiTabButton
		uiTabButtonLine.BackgroundColor3 = lib.accent
		if lib.totaltabs > 1 then
			uiTabButtonLine.BackgroundTransparency = 1.000
		else
			uiTabButtonLine.BackgroundTransparency = 0.000
		end
		uiTabButtonLine.BorderSizePixel = 0
		uiTabButtonLine.Position = UDim2.new(0, 0, 1, -2)
		uiTabButtonLine.Size = UDim2.new(1, 0, 0, 2)
		uiTabButtonLine.ZIndex = 2
		table.insert(lib.accentItems, uiTabButtonLine)

		uiTabButtonImage.Name = "uiTabButtonImage"
		uiTabButtonImage.Parent = uiTabButton
		uiTabButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		uiTabButtonImage.BackgroundTransparency = 1.000
		uiTabButtonImage.Position = UDim2.new(0.5, -13, 0, 5)
		uiTabButtonImage.Size = UDim2.new(0, 26, 0, 26)
		uiTabButtonImage.Image = image
		uiTabButtonImage.ImageColor3 = Color3.fromRGB(182, 182, 182)
		uiTabButtonImage.ScaleType = Enum.ScaleType.Fit
		uiTabButtonImage.ZIndex = 2

		uiTabButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				if lib.selectedtab ~= uiTabButton then
					lib.selectedtab = uiTabButton
					for i,v in pairs(lib.tabbuttons) do
						if v ~= uiTabButton then
							game:GetService("TweenService"):Create(v.Frame,TweenInfo.new(0.33,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position = UDim2.new(0, 0, 0, 49)}):Play()
							game:GetService("TweenService"):Create(v.uiTabButtonLine,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 1.000}):Play()
							game:GetService("TweenService"):Create(v.uiTabButtonLabel,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(182, 182, 182)}):Play()
							game:GetService("TweenService"):Create(v.uiTabButtonImage,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3 = Color3.fromRGB(182, 182, 182)}):Play()
						else
							game:GetService("TweenService"):Create(v.Frame,TweenInfo.new(0.33,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position = UDim2.new(0, 0, 0, 0)}):Play()
							game:GetService("TweenService"):Create(v.uiTabButtonLine,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 0.000}):Play()
							game:GetService("TweenService"):Create(v.uiTabButtonLabel,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(192, 192, 192)}):Play()
							game:GetService("TweenService"):Create(v.uiTabButtonImage,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3 = Color3.fromRGB(192, 192, 192)}):Play()
						end
					end
					for i,v in pairs(lib.tabframes) do
						if v ~= uiTab then
							v.Visible = false
						else
							v.Visible = true
						end
					end
				end
			end
		end)

		uiTab.Name = "uiTab"
		uiTab.Parent = uiBack
		uiTab.Active = true
		uiTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		uiTab.BackgroundTransparency = 1.000
		uiTab.BorderColor3 = Color3.fromRGB(40, 26, 29)
		uiTab.BorderSizePixel = 0
		uiTab.Position = UDim2.new(0, 7, 0, 33)
		uiTab.Size = UDim2.new(1, -13, 1, -93)
		uiTab.CanvasSize = UDim2.new(0, 0, 0, 0)
		uiTab.ScrollBarImageColor3 = lib.accent
		uiTab.ScrollBarThickness = 4
		uiTab.ClipsDescendants = false
		if lib.totaltabs > 1 then
			uiTab.Visible = false
		else
		end

		table.insert(lib.tabframes, uiTab)

		tab.createSection = function(title)
			xs = xs + 1
			local localxs = xs
			local uiTabSection = Instance.new("Frame")
			local uiTabSectionIn = Instance.new("Frame")
			local uiTabSectionLabel = Instance.new("TextLabel")
			local uiTabSectionHolder = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local things = {}

			uiTabSection.Name = "uiTabSection"
			uiTabSection.Parent = uiTab
			uiTabSection.BackgroundColor3 = Color3.fromRGB(27, 22, 20)
			uiTabSection.BorderSizePixel = 0
			uiTabSection.Size = UDim2.new(0, 270, 0, 30)
			local uiCorner = Instance.new("UICorner",uiTabSection); uiCorner.CornerRadius = UDim.new(0,7)
			if xs % 2 == 0 then
				if xl == 0 then
					uiTabSection.Position = UDim2.new(1, -270, 0, xl)
				else
					uiTabSection.Position = UDim2.new(1, -270, 0, xl + 5)
				end
				xl = xl + 35
			else
				if xr == 0 then
					uiTabSection.Position = UDim2.new(0, 0, 0, xr)
				else
					uiTabSection.Position = UDim2.new(0, 0, 0, xr + 5)
				end
				xr = xr + 35
			end
			if xl > 500 then
				uiTab.CanvasSize = UDim2.new(0, 0, 5, 0)
			elseif xr > 500 then
				uiTab.CanvasSize = UDim2.new(0, 0, 5, 0)
			end

			uiTabSectionIn.Name = "uiTabSectionIn"
			uiTabSectionIn.Parent = uiTabSection
			uiTabSectionIn.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
			uiTabSectionIn.BorderSizePixel = 0
			uiTabSectionIn.Position = UDim2.new(0, 1, 0, 1)
			uiTabSectionIn.Size = UDim2.new(1, -2, 1, -2)
			local uiCorner = Instance.new("UICorner",uiTabSectionIn); uiCorner.CornerRadius = UDim.new(0,7)

			uiTabSectionLabel.Name = "uiTabSectionLabel"
			uiTabSectionLabel.Parent = uiTabSectionIn
			uiTabSectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			uiTabSectionLabel.BackgroundTransparency = 1.000
			uiTabSectionLabel.Position = UDim2.new(0, 6, 0, 3)
			uiTabSectionLabel.Size = UDim2.new(1, -4, 0, 20)
			uiTabSectionLabel.Font = Enum.Font.Arial
			uiTabSectionLabel.Text = title
			uiTabSectionLabel.TextColor3 = Color3.fromRGB(218, 218, 218)
			uiTabSectionLabel.TextSize = 14.000
			uiTabSectionLabel.TextStrokeColor3 = Color3.fromRGB(14, 14, 14)
			uiTabSectionLabel.TextStrokeTransparency = 0.350
			uiTabSectionLabel.TextXAlignment = Enum.TextXAlignment.Left

			uiTabSectionHolder.Name = "uiTabSectionHolder"
			uiTabSectionHolder.Parent = uiTabSectionIn
			uiTabSectionHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			uiTabSectionHolder.BackgroundTransparency = 1.000
			uiTabSectionHolder.Position = UDim2.new(0, 11, 0, 25)
			uiTabSectionHolder.Size = UDim2.new(1, -24, 1, -33)

			UIListLayout.Parent = uiTabSectionHolder
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			things.createToggle = function(title, default, flag, callback)
				if localxs % 2 == 0 then
					xl = xl + 20
				else
					xr = xr + 20
				end; uiTabSection.Size = UDim2.new(uiTabSection.Size.X.Scale, uiTabSection.Size.X.Offset, uiTabSection.Size.Y.Scale, uiTabSection.Size.Y.Offset + 20)
				local uiSectionButton = Instance.new("Frame")
				local uiButtonOutline = Instance.new("Frame")
				local uiButton = Instance.new("Frame")
				local uiButtonLabel = Instance.new("TextLabel")
                local togglelib = {}
				lib.flags[flag] = default or false
				

				uiSectionButton.Name = "uiSectionButton"
				uiSectionButton.Parent = uiTabSectionHolder
				uiSectionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSectionButton.BackgroundTransparency = 1.000
				uiSectionButton.Size = UDim2.new(1, 0, 0, 20)

				uiButtonOutline.Name = "uiButtonOutline"
				uiButtonOutline.Parent = uiSectionButton
				uiButtonOutline.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				uiButtonOutline.Position = UDim2.new(0, 6, 0.5, -7)
				uiButtonOutline.Size = UDim2.new(0, 14, 0, 14)
				local uiCorner = Instance.new("UICorner",uiButtonOutline); uiCorner.CornerRadius = UDim.new(0,3)

				uiButton.Name = "uiButton"
				uiButton.Parent = uiButtonOutline
				local uiCorner = Instance.new("UICorner",uiButton); uiCorner.CornerRadius = UDim.new(0,3)
				if default then
					uiButton.BackgroundColor3 = lib.accent
				else
					uiButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				end
				uiButton.Position = UDim2.new(0, 1, 0, 1)
				uiButton.Size = UDim2.new(0, 12, 0, 12)
				table.insert(lib.accentItems, uiButton)

				uiButtonLabel.Name = "uiButtonLabel"
				uiButtonLabel.Parent = uiSectionButton
				uiButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiButtonLabel.BackgroundTransparency = 1.000
				uiButtonLabel.Position = UDim2.new(0, 26, 0, 0)
				uiButtonLabel.Size = UDim2.new(0, 200, 0, 19)
				uiButtonLabel.Font = Enum.Font.Arial
				uiButtonLabel.Text = title
				uiButtonLabel.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiButtonLabel.TextSize = 14.000
				uiButtonLabel.TextStrokeTransparency = 0.350
				uiButtonLabel.TextXAlignment = Enum.TextXAlignment.Left

				uiSectionButton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not lib.inDropdown and not lib.inColorPicker then
						lib.flags[flag] = not lib.flags[flag]
						if lib.flags[flag] then
							game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = lib.accent}):Play()
						else
							game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
						end
						pcall(callback, lib.flags[flag])
					end
				end)

                togglelib.set = function(bool)
                    lib.flags[flag] = bool
                    if lib.flags[flag] then
                        game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = lib.accent}):Play()
                    else
                        game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                    end
                    pcall(callback, lib.flags[flag])
                end

                return togglelib
			end

			things.createSlider = function(title, default, min, max, suffix, flag, callback)
				if localxs % 2 == 0 then
					xl = xl + 36
				else
					xr = xr + 36
				end; uiTabSection.Size = UDim2.new(uiTabSection.Size.X.Scale, uiTabSection.Size.X.Offset, uiTabSection.Size.Y.Scale, uiTabSection.Size.Y.Offset + 36)
				local uiSectionSlider = Instance.new("Frame")
				local uiSliderLabel = Instance.new("TextLabel")
				local uiSliderOutline = Instance.new("Frame")
				local uiSliderBack = Instance.new("Frame")
				local uiSliderFill = Instance.new("Frame")
				local slider = {}
				lib.flags[flag] = default or min
				

				uiSectionSlider.Name = "uiSectionSlider"
				uiSectionSlider.Parent = uiTabSectionHolder
				uiSectionSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSectionSlider.BackgroundTransparency = 1.000
				uiSectionSlider.Size = UDim2.new(1, 0, 0, 36)

				uiSliderLabel.Name = "uiSliderLabel"
				uiSliderLabel.Parent = uiSectionSlider
				uiSliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSliderLabel.BackgroundTransparency = 1.000
				uiSliderLabel.Position = UDim2.new(0, 6, 0, 0)
				uiSliderLabel.Size = UDim2.new(0, 200, 0, 19)
				uiSliderLabel.Font = Enum.Font.Arial
				uiSliderLabel.Text = title.." ("..lib.flags[flag]..suffix..")"
				uiSliderLabel.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiSliderLabel.TextSize = 14.000
				uiSliderLabel.TextStrokeTransparency = 0.350
				uiSliderLabel.TextXAlignment = Enum.TextXAlignment.Left

				uiSliderOutline.Name = "uiSliderOutline"
				uiSliderOutline.Parent = uiSectionSlider
				uiSliderOutline.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				uiSliderOutline.Position = UDim2.new(0, 7, 0, 19)
				uiSliderOutline.Size = UDim2.new(1, -10, 0, 12)
				local uiCorner = Instance.new("UICorner",uiSliderOutline); uiCorner.CornerRadius = UDim.new(0,3)

				uiSliderBack.Name = "uiSliderBack"
				uiSliderBack.Parent = uiSliderOutline
				uiSliderBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				uiSliderBack.Position = UDim2.new(0, 1, 0, 1)
				uiSliderBack.Size = UDim2.new(1, -2, 1, -2)
				local uiCorner = Instance.new("UICorner",uiSliderBack); uiCorner.CornerRadius = UDim.new(0,3)

				uiSliderFill.Name = "uiSliderFill"
				uiSliderFill.Parent = uiSliderBack
				uiSliderFill.BackgroundColor3 = lib.accent
				uiSliderFill.Size = UDim2.new(1, 0, 1, 0)
				uiSliderFill.BorderSizePixel = 0
				table.insert(lib.accentItems, uiSliderFill)
				local uiCorner = Instance.new("UICorner",uiSliderFill); uiCorner.CornerRadius = UDim.new(0,3)

				local sliding
				local inContact

				local function round(num, bracket)
					bracket = bracket or 1
					local a = math.floor(num/bracket + (math.sign(num) * 0.5)) * bracket
					if a < 0 then
						a = a + bracket
					end
					return a
				end

				slider.set = function(value3)
					value3 = round(value3, 1)
					value3 = math.clamp(value3, min, max)
					local value = math.clamp(value3, min, max)
					if min >= 0 then
						uiSliderFill:TweenSize(UDim2.new((value - min) / (max - min), 0, 1, 0), "Out", "Quad", 0.1, true)
					else
						uiSliderFill:TweenPosition(UDim2.new((0 - min) / (max - min), 0, 0, 0), "Out", "Quad", 0.1, true)
						uiSliderFill:TweenSize(UDim2.new(value / (max - min), 0, 1, 0), "Out", "Quad", 0.1, true)
					end
					lib.flags[flag] = value3
					pcall(callback, value3)
					uiSliderLabel.Text = title.." ("..value3..suffix..")"
					value3 = nil
				end

				uiSliderBack.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not lib.inDropdown and not lib.inColorPicker then
						sliding = true
						slider.set(min + ((input.Position.X - uiSliderBack.AbsolutePosition.X) / uiSliderBack.AbsoluteSize.X) * (max - min))
					end
					if input.UserInputType == Enum.UserInputType.MouseMovement and not lib.inDropdown and not lib.inColorPicker then
						inContact = true
					end
				end)

				game:service"UserInputService".InputChanged:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement and sliding then
						slider.set(min + ((input.Position.X - uiSliderBack.AbsolutePosition.X) / uiSliderBack.AbsoluteSize.X) * (max - min))
					end
				end)

				uiSliderBack.InputEnded:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliding = false
					end
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						inContact = false
					end
				end)

				slider.set(lib.flags[flag])

				return slider
			end

			things.createColorpicker = function(title, default, addon, flag, callback)
				if localxs % 2 == 0 then
					xl = xl + 20
				else
					xr = xr + 20
				end; uiTabSection.Size = UDim2.new(uiTabSection.Size.X.Scale, uiTabSection.Size.X.Offset, uiTabSection.Size.Y.Scale, uiTabSection.Size.Y.Offset + 20)
				local uiSectionColorpicker = Instance.new("Frame")
				local uiColorOutline = Instance.new("Frame")
				local uiColorButton = Instance.new("Frame")
				local uiColorOutline2 = Instance.new("Frame")
				local uiColorIn = Instance.new("Frame")
				local uiColorFrame = Instance.new("Frame")
				local uiColorOverlay1 = Instance.new("ImageLabel")
				local uiColorOverlay12 = Instance.new("ImageLabel")
				local uiColorSlider = Instance.new("Frame")
				local UIGradient = Instance.new("UIGradient")
				local uiGradientSlider = Instance.new("Frame")
				local UIGradient_2 = Instance.new("UIGradient")
				local uiColorClose = Instance.new("TextLabel")
				local uiColorLabel = Instance.new("TextLabel")
				local uiButton;
				local transparency = -1
				local daX = 0
				local daY = 0
				local colorpickerlib = {}
				lib.flags[flag] = default
				lib.flags[flag.."2"] = false
				lib.flags[flag.."3"] = -1
				
				uiSectionColorpicker.Name = "uiSectionColorpicker"
				uiSectionColorpicker.Parent = uiTabSectionHolder
				uiSectionColorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSectionColorpicker.BackgroundTransparency = 1.000
				uiSectionColorpicker.Size = UDim2.new(1, 0, 0, 20)

				uiColorOutline.Name = "uiColorOutline"
				uiColorOutline.Parent = uiSectionColorpicker
				uiColorOutline.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				uiColorOutline.Position = UDim2.new(1, -25, 0.5, -7)
				uiColorOutline.Size = UDim2.new(0, 22, 0, 14)
				local uiCorner = Instance.new("UICorner",uiColorOutline); uiCorner.CornerRadius = UDim.new(0,3)

				uiColorButton.Name = "uiColorButton"
				uiColorButton.Parent = uiColorOutline
				uiColorButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiColorButton.Position = UDim2.new(0, 1, 0, 1)
				uiColorButton.Size = UDim2.new(0, 20, 0, 12)
				local uiCorner = Instance.new("UICorner",uiColorButton); uiCorner.CornerRadius = UDim.new(0,3)

				uiColorOutline2.Name = "uiColorOutline2"
				uiColorOutline2.Parent = uiColorOutline
				uiColorOutline2.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				uiColorOutline2.Position = UDim2.new(1, 23, 0, 0)
				uiColorOutline2.Size = UDim2.new(0, 170, 0, 170)
				uiColorOutline2.Visible = false
				uiColorOutline2.ZIndex = 3
				local uiCorner = Instance.new("UICorner",uiColorOutline2); uiCorner.CornerRadius = UDim.new(0,3)

				uiColorIn.Name = "uiColorIn"
				uiColorIn.Parent = uiColorOutline2
				uiColorIn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				uiColorIn.Position = UDim2.new(0, 1, 0, 1)
				uiColorIn.Size = UDim2.new(0, 168, 0, 168)
				uiColorIn.ZIndex = 4
				local uiCorner = Instance.new("UICorner",uiColorIn); uiCorner.CornerRadius = UDim.new(0,3)

				uiColorFrame.Name = "uiColorFrame"
				uiColorFrame.Parent = uiColorIn
				uiColorFrame.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
				uiColorFrame.BorderSizePixel = 0
				uiColorFrame.Position = UDim2.new(0, 6, 0, 6)
				uiColorFrame.Size = UDim2.new(0, 135, 0, 135)
				uiColorFrame.ZIndex = 4
				local uiCorner = Instance.new("UICorner",uiColorFrame); uiCorner.CornerRadius = UDim.new(0,8)

				uiColorOverlay1.Name = "uiColorOverlay1"
				uiColorOverlay1.Parent = uiColorFrame
				uiColorOverlay1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiColorOverlay1.BackgroundTransparency = 1.000
				uiColorOverlay1.BorderSizePixel = 0
				uiColorOverlay1.Size = UDim2.new(1, 0, 1, 0)
				uiColorOverlay1.ZIndex = 5
				uiColorOverlay1.Image = "rbxassetid://5107152095"
				uiColorOverlay1.SliceScale = 0.000

				uiColorOverlay12.Name = "uiColorOverlay12"
				uiColorOverlay12.Parent = uiColorFrame
				uiColorOverlay12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiColorOverlay12.BackgroundTransparency = 1.000
				uiColorOverlay12.BorderSizePixel = 0
				uiColorOverlay12.Size = UDim2.new(1, 0, 1, 0)
				uiColorOverlay12.ZIndex = 4
				uiColorOverlay12.Image = "rbxassetid://5107152351"
				uiColorOverlay12.SliceScale = 0.000

				uiColorSlider.Name = "uiColorSlider"
				uiColorSlider.Parent = uiColorIn
				uiColorSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiColorSlider.BorderSizePixel = 0
				uiColorSlider.Position = UDim2.new(1, -21, 0, 6)
				uiColorSlider.Size = UDim2.new(0, 15, 0, 134)
				uiColorSlider.ZIndex = 4
				local uiCorner = Instance.new("UICorner",uiColorSlider); uiCorner.CornerRadius = UDim.new(0,3)

				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
				UIGradient.Rotation = 90
				UIGradient.Parent = uiColorSlider

				uiGradientSlider.Name = "uiGradientSlider"
				uiGradientSlider.Parent = uiColorIn
				uiGradientSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiGradientSlider.BorderSizePixel = 0
				uiGradientSlider.Position = UDim2.new(0, 7, 1, -21)
				uiGradientSlider.Size = UDim2.new(0, 134, 0, 15)
				uiGradientSlider.ZIndex = 4
				local uiCorner = Instance.new("UICorner",uiGradientSlider); uiCorner.CornerRadius = UDim.new(0,3)

				UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
				UIGradient_2.Parent = uiGradientSlider

				local transparencyImage = Instance.new("ImageLabel") -- UPDATE\
				local uiCorner = Instance.new("UICorner",transparencyImage); uiCorner.CornerRadius = UDim.new(0,3)

				transparencyImage.Name = "transparencyImage"
				transparencyImage.Parent = uiGradientSlider
				transparencyImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				transparencyImage.BackgroundTransparency = 1.000
				transparencyImage.Size = UDim2.new(1, 0, 1, 0)
				transparencyImage.ZIndex = 5
				transparencyImage.Image = "http://www.roblox.com/asset/?id=8657422630"
				transparencyImage.ImageTransparency = 0.900
				transparencyImage.SliceCenter = Rect.new(0, 0, 5, 0)
				transparencyImage.SliceScale = 0.015

				uiColorClose.Name = "uiColorClose"
				uiColorClose.Parent = uiColorIn
				uiColorClose.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiColorClose.BackgroundTransparency = 1.000
				uiColorClose.Position = UDim2.new(1, -22, 1, -22)
				uiColorClose.Size = UDim2.new(0, 15, 0, 15)
				uiColorClose.ZIndex = 4
				uiColorClose.Font = Enum.Font.ArialBold
				uiColorClose.Text = "X"
				uiColorClose.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiColorClose.TextSize = 14.000

				uiColorLabel.Name = "uiColorLabel"
				uiColorLabel.Parent = uiSectionColorpicker
				uiColorLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiColorLabel.BackgroundTransparency = 1.000
				if not addon then
					uiColorLabel.Position = UDim2.new(0, 6, 0, 0)
				else
					uiColorLabel.Position = UDim2.new(0, 26, 0, 0)
				end
				if not addon then
					uiColorLabel.Size = UDim2.new(0, 200, 0, 19)
				else
					uiColorLabel.Size = UDim2.new(0, 170, 0, 19)
				end
				uiColorLabel.Font = Enum.Font.Arial
				uiColorLabel.Text = title
				uiColorLabel.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiColorLabel.TextSize = 14.000
				uiColorLabel.TextStrokeTransparency = 0.220
				uiColorLabel.TextXAlignment = Enum.TextXAlignment.Left

				if addon then
					local uiButtonOutline = Instance.new("Frame")
					uiButton = Instance.new("Frame")

					uiButtonOutline.Name = "uiButtonOutline"
					uiButtonOutline.Parent = uiSectionColorpicker
					uiButtonOutline.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
					uiButtonOutline.Position = UDim2.new(0, 6, 0.5, -7)
					uiButtonOutline.Size = UDim2.new(0, 14, 0, 14)
					local uiCorner = Instance.new("UICorner",uiButtonOutline); uiCorner.CornerRadius = UDim.new(0,3)

					uiButton.Name = "uiButton"
					uiButton.Parent = uiButtonOutline
					uiButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					uiButton.Position = UDim2.new(0, 1, 0, 1)
					uiButton.Size = UDim2.new(0, 12, 0, 12)
					local uiCorner = Instance.new("UICorner",uiButton); uiCorner.CornerRadius = UDim.new(0,3)

					uiButton.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and not lib.inDropdown then
							lib.flags[flag.."2"] = not lib.flags[flag.."2"]
							if lib.flags[flag.."2"] then
								game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = lib.accent}):Play()
							else
								game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
							end
							pcall(callback, uiColorButton.BackgroundColor3, transparency, lib.flags[flag.."2"])
						end
					end)

					uiColorLabel.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and not lib.inDropdown then
							lib.flags[flag.."2"] = not lib.flags[flag.."2"]
							if lib.flags[flag.."2"] then
								game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = lib.accent}):Play()
							else
								game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
							end
							pcall(callback, uiColorButton.BackgroundColor3, transparency, lib.flags[flag.."2"])
						end
					end)

					table.insert(lib.accentItems, uiButton)
				end

				local TransInput, HueInput, ColorInput;

				local ColorH =
					1 -
					(math.clamp(daY - uiColorSlider.AbsolutePosition.Y, 0, uiColorSlider.AbsoluteSize.Y) /
						uiColorSlider.AbsoluteSize.Y)
				local ColorS =
					(math.clamp(daX - uiColorFrame.AbsolutePosition.X, 0, uiColorFrame.AbsoluteSize.X) /
						uiColorFrame.AbsoluteSize.X)
				local ColorV =
					1 -
					(math.clamp(daX - uiColorFrame.AbsolutePosition.Y, 0, uiColorFrame.AbsoluteSize.Y) /
						uiColorFrame.AbsoluteSize.Y)


				local function UpdateColorPicker(nope)
					uiColorButton.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					uiColorFrame.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

					if not addon then
					    lib.flags[flag] = uiColorButton.BackgroundColor3
					    lib.flags[flag.."3"] = transparency
						pcall(callback, uiColorButton.BackgroundColor3, transparency)
					else
						pcall(callback, uiColorButton.BackgroundColor3, transparency, lib.flags[flag.."2"])
					end
				end

				uiColorButton.BackgroundColor3 = default
				uiColorFrame.BackgroundColor3 = default

				uiColorFrame.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if ColorInput then
								ColorInput:Disconnect()
							end

							ColorInput =
								game:service"RunService".RenderStepped:Connect(
									function()
										local ColorX =
										(math.clamp(Mouse.X - uiColorFrame.AbsolutePosition.X, 0, uiColorFrame.AbsoluteSize.X) /
											uiColorFrame.AbsoluteSize.X)
										local ColorY =
										(math.clamp(Mouse.Y - uiColorFrame.AbsolutePosition.Y, 0, uiColorFrame.AbsoluteSize.Y) /
											uiColorFrame.AbsoluteSize.Y)

										daX = UDim2.new(ColorX - 0.05, 0, ColorY - 0.05, 0)
										ColorS = ColorX
										ColorV = 1 - ColorY

										UpdateColorPicker(true);  ColorX = nil; ColorY = nil
									end
								)
						end
					end
				)

				uiColorFrame.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if ColorInput then
								ColorInput:Disconnect()
							end
						end
					end
				)

				uiColorSlider.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then

							if HueInput then
								HueInput:Disconnect()
							end

							HueInput =
								game:service"RunService".RenderStepped:Connect(
									function()
										local HueY =
										(math.clamp(Mouse.Y - uiColorSlider.AbsolutePosition.Y, 0, uiColorSlider.AbsoluteSize.Y) /
											uiColorSlider.AbsoluteSize.Y)

										daY = UDim2.new(0, 0, HueY - 0.05, 0)
										if HueY - 0.061 >= 0 then
										ColorH = HueY - 0.061
									else
										ColorH = 0
									end

										UpdateColorPicker(true); HueY = nil
									end
								)
						end
					end
				)

				uiColorSlider.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if HueInput then
								HueInput:Disconnect()
							end
						end
					end
				)

				uiGradientSlider.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then

							if TransInput then
								TransInput:Disconnect()
							end

							TransInput =
								game:service"RunService".RenderStepped:Connect(
									function()
										transparency =
										(math.clamp(Mouse.X - uiGradientSlider.AbsolutePosition.X, 0, uiGradientSlider.AbsoluteSize.X) /
											uiGradientSlider.AbsoluteSize.X)
											transparency = transparency - 1

										UpdateColorPicker(true)
									end
								)
						end
					end
				)

				uiGradientSlider.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if TransInput then
								TransInput:Disconnect()
							end
						end
					end
				)

				uiColorButton.InputBegan:Connect(function(input, gpe)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
					    if lib.inColorPicker == uiColorButton then
    						uiColorOutline2.Visible = not uiColorOutline2.Visible
    						if uiColorOutline2.Visible then
    						    lib.inColorPicker = uiColorButton
    						else
    						    lib.inColorPicker = false
    						end
    					elseif lib.inColorPicker == false then
    					    uiColorOutline2.Visible = not uiColorOutline2.Visible
    						if uiColorOutline2.Visible then
    						    lib.inColorPicker = uiColorButton
    						else
    						    lib.inColorPicker = false
    						end
    					end
					end
				end)

				uiColorClose.InputBegan:Connect(function(input, gpe)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						uiColorOutline2.Visible = not uiColorOutline2.Visible
						lib.inColorPicker = false
					end
				end)

				colorpickerlib.set = function(clr, trans, tog)
					uiColorButton.BackgroundColor3 = Color3.fromRGB(clr[1],clr[2],clr[3]); uiColorFrame.BackgroundColor3 = Color3.fromRGB(clr[1],clr[2],clr[3])
					transparency = trans
					lib.flags[flag] = Color3.fromRGB(clr[1],clr[2],clr[3])
					if addon then
					    lib.flags[flag.."2"] = tog
					end
					lib.flags[flag.."3"] = trans
					if addon then
					     if addon then
    						if lib.flags[flag.."2"] then
    							game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = lib.accent}):Play()
    						else
    							game:GetService("TweenService"):Create(uiButton,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    						end
    					end
						pcall(callback, uiColorButton.BackgroundColor3, trans, tog)
					else
						pcall(callback, uiColorButton.BackgroundColor3, trans)
					end
				end

				return colorpickerlib
			end

			things.createDropdown = function(title, options, flag, callback)
				if localxs % 2 == 0 then
					xl = xl + 42
				else
					xr = xr + 42
				end; uiTabSection.Size = UDim2.new(uiTabSection.Size.X.Scale, uiTabSection.Size.X.Offset, uiTabSection.Size.Y.Scale, uiTabSection.Size.Y.Offset + 42)
				local uiSectionDropdown = Instance.new("Frame")
				local uiDropdownLabel = Instance.new("TextLabel")
				local uiDropdownOutline = Instance.new("Frame")
				local uiDropdownBack = Instance.new("Frame")
				local uiSliderSelectionsLabel = Instance.new("TextLabel")
				local uiDropdownBack2 = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local dropdownLabels = {}
				local dropdownLib = {}
				local size = 0
				local closing = false
				local open = false
				lib.flags[flag] = "none"
				
				uiSectionDropdown.Name = "uiSectionDropdown"
				uiSectionDropdown.Parent = uiTabSectionHolder
				uiSectionDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSectionDropdown.BackgroundTransparency = 1.000
				uiSectionDropdown.Size = UDim2.new(1, 0, 0, 42)

				uiDropdownLabel.Name = "uiDropdownLabel"
				uiDropdownLabel.Parent = uiSectionDropdown
				uiDropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiDropdownLabel.BackgroundTransparency = 1.000
				uiDropdownLabel.Position = UDim2.new(0, 8, 0, 0)
				uiDropdownLabel.Size = UDim2.new(0, 200, 0, 19)
				uiDropdownLabel.Font = Enum.Font.Arial
				uiDropdownLabel.Text = title
				uiDropdownLabel.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiDropdownLabel.TextSize = 14.000
				uiDropdownLabel.TextStrokeTransparency = 0.350
				uiDropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

				uiDropdownOutline.Name = "uiDropdownOutline"
				uiDropdownOutline.Parent = uiSectionDropdown
				uiDropdownOutline.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				uiDropdownOutline.Position = UDim2.new(0, 7, 0, 19)
				uiDropdownOutline.Size = UDim2.new(1, -10, 0, 19)
				local uiCorner = Instance.new("UICorner",uiDropdownOutline); uiCorner.CornerRadius = UDim.new(0,3)

				uiDropdownBack.Name = "uiDropdownBack"
				uiDropdownBack.Parent = uiDropdownOutline
				uiDropdownBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				uiDropdownBack.Position = UDim2.new(0, 1, 0, 1)
				uiDropdownBack.Size = UDim2.new(1, -2, 1, -2)
				uiDropdownBack.ZIndex = 4
				local uiCorner = Instance.new("UICorner",uiDropdownBack); uiCorner.CornerRadius = UDim.new(0,3)

				uiSliderSelectionsLabel.Name = "uiSliderSelectionsLabel"
				uiSliderSelectionsLabel.Parent = uiDropdownBack
				uiSliderSelectionsLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSliderSelectionsLabel.BackgroundTransparency = 1.000
				uiSliderSelectionsLabel.Position = UDim2.new(0, 5, 0, 0)
				uiSliderSelectionsLabel.Size = UDim2.new(1, -25, 0, 17)
				uiSliderSelectionsLabel.ZIndex = 4
				uiSliderSelectionsLabel.Font = Enum.Font.Arial
				uiSliderSelectionsLabel.Text = "none"
				uiSliderSelectionsLabel.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiSliderSelectionsLabel.TextSize = 11.000
				uiSliderSelectionsLabel.TextStrokeTransparency = 0.350
				uiSliderSelectionsLabel.TextWrapped = true
				uiSliderSelectionsLabel.TextXAlignment = Enum.TextXAlignment.Left

				uiDropdownBack2.Name = "uiDropdownBack2"
				uiDropdownBack2.Parent = uiDropdownBack
				uiDropdownBack2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				uiDropdownBack2.BorderColor3 = Color3.fromRGB(53, 53, 53)
				uiDropdownBack2.Position = UDim2.new(0, 1, 1, 0)
				uiDropdownBack2.Size = UDim2.new(1, -2, 0, 0)
				uiDropdownBack2.Visible = false
				uiDropdownBack2.ZIndex = 5
				uiDropdownBack2.ClipsDescendants = true

				UIListLayout.Parent = uiDropdownBack2
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

				for i,v in pairs(options) do
					size = size + 17
					local uiSliderSelection = Instance.new("TextLabel")
					table.insert(dropdownLabels, uiSliderSelection)
					uiSliderSelection.Name = "uiSliderSelection"
					uiSliderSelection.Parent = uiDropdownBack2
					uiSliderSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					uiSliderSelection.BackgroundTransparency = 1.000
					uiSliderSelection.Position = UDim2.new(0, 4, 0, 0)
					uiSliderSelection.Size = UDim2.new(1, -8, 0, 17)
					uiSliderSelection.ZIndex = 5
					uiSliderSelection.Font = Enum.Font.Arial
					uiSliderSelection.Text = v
					uiSliderSelection.TextColor3 = Color3.fromRGB(208, 208, 208)
					uiSliderSelection.TextSize = 11.000
					uiSliderSelection.TextStrokeTransparency = 0.350
					uiSliderSelection.TextWrapped = true
					uiSliderSelection.TextXAlignment = Enum.TextXAlignment.Left

					table.insert(lib.accentItems, uiSliderSelection)

					uiSliderSelection.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if lib.flags[flag] ~= uiSliderSelection.Text then
								game:GetService("TweenService"):Create(uiSliderSelection,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = lib.accent}):Play()
								for i,v in pairs(dropdownLabels) do
									if v ~= uiSliderSelection then
										game:GetService("TweenService"):Create(v,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(208, 208, 208)}):Play()
									end
								end
								lib.flags[flag] = v
							else
								for i,v in pairs(dropdownLabels) do
									game:GetService("TweenService"):Create(v,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(208, 208, 208)}):Play()
								end
								lib.flags[flag] = "none"
							end
							uiSliderSelectionsLabel.Text = lib.flags[flag]
							pcall(callback, lib.flags[flag])
						end
					end)
				end
				
				dropdownLib.set = function(option)
					for i,v in pairs(dropdownLabels) do
						if v.Text == option then
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = lib.accent}):Play()
						else
							game:GetService("TweenService"):Create(v,TweenInfo.new(0.33,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(208, 208, 208)}):Play()
						end
					end
					uiSliderSelectionsLabel.Text = option
					lib.flags[flag] = option
				end

				uiSliderSelectionsLabel.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if open and lib.inDropdown then
							if not closing then
								open = not open
								uiDropdownBack2.Visible = true
								closing = true
								if open then
									game:GetService("TweenService"):Create(uiDropdownBack2,TweenInfo.new(0.33,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size = UDim2.new(1, -2, 0, size)}):Play()
									lib.inDropdown = true
								else
									lib.inDropdown = false
									game:GetService("TweenService"):Create(uiDropdownBack2,TweenInfo.new(0.33,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size = UDim2.new(1, -2, 0, 0)}):Play()
								end
								wait(0.25)
								if not open then
									uiDropdownBack2.Visible = false
								end
								closing = false
							end
						elseif not open and not lib.inDropdown then
							if not closing then
								open = not open
								uiDropdownBack2.Visible = true
								closing = true
								if open then
									game:GetService("TweenService"):Create(uiDropdownBack2,TweenInfo.new(0.33,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size = UDim2.new(1, -2, 0, size)}):Play()
									lib.inDropdown = true
								else
									lib.inDropdown = false
									game:GetService("TweenService"):Create(uiDropdownBack2,TweenInfo.new(0.33,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size = UDim2.new(1, -2, 0, 0)}):Play()
								end
								wait(0.25)
								if not open then
									uiDropdownBack2.Visible = false
								end
								closing = false
							end
						end
					end
				end)
				
				return dropdownLib
			end

			things.createButton = function(title, callback)
				if localxs % 2 == 0 then
					xl = xl + 27
				else
					xr = xr + 27
				end; uiTabSection.Size = UDim2.new(uiTabSection.Size.X.Scale, uiTabSection.Size.X.Offset, uiTabSection.Size.Y.Scale, uiTabSection.Size.Y.Offset + 27)
				local uiSliderSelection = Instance.new("TextLabel")
				local uiSectionButton = Instance.new("Frame")
				local uiButton = Instance.new("Frame")
				local uiButtonBack = Instance.new("Frame")
				local uiButtonLabel = Instance.new("TextLabel")

				uiSectionButton.Name = "uiSectionButton2"
				uiSectionButton.Parent = uiTabSectionHolder
				uiSectionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiSectionButton.BackgroundTransparency = 1.000
				uiSectionButton.Size = UDim2.new(1, 0, 0, 27)

				uiButton.Name = "uiButton"
				uiButton.Parent = uiSectionButton
				uiButton.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				uiButton.Position = UDim2.new(0, 7, 0, 3)
				uiButton.Size = UDim2.new(1, -10, 0, 21)
				local uiCorner = Instance.new("UICorner",uiButton); uiCorner.CornerRadius = UDim.new(0,3)

				uiButtonBack.Name = "uiButtonBack"
				uiButtonBack.Parent = uiButton
				uiButtonBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				uiButtonBack.Position = UDim2.new(0, 1, 0, 1)
				uiButtonBack.Size = UDim2.new(1, -2, 1, -2)
				uiButtonBack.ZIndex = 2
				uiButtonBack.ClipsDescendants = true

				uiButtonLabel.Name = "uiButtonLabel"
				uiButtonLabel.Parent = uiButtonBack
				uiButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				uiButtonLabel.BackgroundTransparency = 1.000
				uiButtonLabel.Size = UDim2.new(1, 0, 1, 0)
				uiButtonLabel.ZIndex = 3
				uiButtonLabel.Font = Enum.Font.Arial
				uiButtonLabel.Text = title
				uiButtonLabel.TextColor3 = Color3.fromRGB(208, 208, 208)
				uiButtonLabel.TextSize = 12.000
				uiButtonLabel.TextStrokeTransparency = 0.220
				uiButtonLabel.TextWrapped = true

				local uiCorner = Instance.new("UICorner",uiButtonBack); uiCorner.CornerRadius = UDim.new(0,3)

				uiSectionButton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not lib.inDropdown and not lib.inColorPicker then
						local Frame = Instance.new("Frame")
						Frame.Parent = uiButtonBack
						Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						Frame.BackgroundTransparency = 1
						Frame.Size = UDim2.new(0, 0, 0, 30)
						Frame.ZIndex = 3
						local uiCorner = Instance.new("UICorner",Frame); uiCorner.CornerRadius = UDim.new(1,0)
						spawn(function()
							while Frame ~= nil do
								Frame.Position = UDim2.new(0.5, -Frame.Size.X.Offset/2, 0.5, -Frame.Size.Y.Offset/2)
								game:service"RunService".Stepped:Wait()
							end
						end)
						game:GetService("TweenService"):Create(Frame,TweenInfo.new(0.33,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0.700}):Play()
						spawn(function()
							game:GetService("TweenService"):Create(Frame,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size = UDim2.new(0, 250, 0, 30)}):Play()
							wait(0.244)
							game:GetService("TweenService"):Create(Frame,TweenInfo.new(0.38,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency = 1.00}):Play()
							wait(0.36)
							Frame:Destroy()
						end)
						pcall(callback)
					end
				end)
			end

			return things
		end

		return tab
	end

	return window
end

return lib