if not game:IsLoaded() then
	game.Loaded:wait() 
end

local library = {}
local request = request or http_request or (identifyexecutor() == "Synapse X" and syn.request) or (http and http.request)
loadstring(request({Url="https://raw.githubusercontent.com/cypherdh/Script-Library/main/InstanceProtect",Method="GET"}).Body)()
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
function library:CreateWindow(name, version, icon)
	name = name or "Name"
	version = version or "Version"
	icon = icon or math.random()
	local MyGui = Instance.new("ScreenGui")
	local Window = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TitleBar = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local MainTitle = Instance.new("TextLabel")
	local TitleUnderline = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local Bar = Instance.new("Frame")
	local Bar_2 = Instance.new("Frame")
	local Close = Instance.new("ImageButton")
	local Minimize = Instance.new("ImageButton")
	local _4pxShadow2px_2 = Instance.new("ImageLabel")

	local RandomString = ""
	for i = 1, math.random(3,20) do
		RandomString = RandomString..string.char(math.random(97,122))
	end
	ProtectInstance(MyGui)
	ProtectInstance(Window)

	MyGui.Name = RandomString
	MyGui.Parent = cloneref(game:GetService("CoreGui"))
	MyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Window.Name = "Window"
	Window.Parent = MyGui
	Window.BackgroundColor3 = Color3.fromRGB(49, 49, 59)
	Window.Position = UDim2.new(0.5, -300, 0.600000024, -200)
	Window.Size = UDim2.new(0, 0, 0, 0)
	Window.ClipsDescendants = true

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Window

	TitleBar.Name = "TitleBar"
	TitleBar.Parent = Window
	TitleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleBar.BackgroundTransparency = 1.000
	TitleBar.Size = UDim2.new(1, 0, 0, 30)

	Icon.Name = "Icon"
	Icon.Parent = TitleBar
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.Position = UDim2.new(0, 6, 0, 6)
	Icon.Size = UDim2.new(0, 18, 0, 18)
	Icon.Image = "rbxassetid://"..icon
	Icon.ImageColor3 = Color3.fromRGB(135, 255, 135)

	MainTitle.Name = "Title"
	MainTitle.Parent = TitleBar
	MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainTitle.BackgroundTransparency = 1.000
	MainTitle.Position = UDim2.new(0, 30, 0, 1)
	MainTitle.Size = UDim2.new(1, -30, 1, 0)
	MainTitle.Font = Enum.Font.Gotham
	MainTitle.Text = name.." | "..version --"Title | Version"
	MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	MainTitle.TextSize = 12.000
	MainTitle.TextXAlignment = Enum.TextXAlignment.Left

	TitleUnderline.Name = "TitleUnderline"
	TitleUnderline.Parent = TitleBar
	TitleUnderline.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
	TitleUnderline.BorderSizePixel = 0
	TitleUnderline.Position = UDim2.new(0, 0, 1, 0)
	TitleUnderline.Size = UDim2.new(1, 0, 0, 1)

	UIGradient.Parent = TitleUnderline

	Bar.Name = "Bar"
	Bar.Parent = TitleUnderline
	Bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Bar.BackgroundTransparency = 0.750
	Bar.BorderSizePixel = 0
	Bar.Position = UDim2.new(0, 6, 0, 0)
	Bar.Size = UDim2.new(0, 18, 1, 0)

	Bar_2.Name = "Bar"
	Bar_2.Parent = TitleUnderline
	Bar_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Bar_2.BackgroundTransparency = 0.750
	Bar_2.BorderSizePixel = 0
	Bar_2.Position = UDim2.new(1, -24, 0, 0)
	Bar_2.Size = UDim2.new(0, 18, 1, 0)

	Close.Name = "Close"
	Close.Parent = TitleBar
	Close.BackgroundTransparency = 1.000
	Close.Position = UDim2.new(0.953333378, 0, 0.0666666627, 0)
	Close.Size = UDim2.new(0, 25, 0, 25)
	Close.ZIndex = 2
	Close.Image = "rbxassetid://3926305904"
	Close.ImageRectOffset = Vector2.new(284, 4)
	Close.ImageRectSize = Vector2.new(24, 24)

	Minimize.Name = "Minimize"
	Minimize.Parent = TitleBar
	Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Minimize.BackgroundTransparency = 1.000
	Minimize.Position = UDim2.new(0.953, -24, -0.2, 6)
	Minimize.Size = UDim2.new(0, 26, 0, 30)
	Minimize.Image = "http://www.roblox.com/asset/?id=6035067836"

	_4pxShadow2px_2.Name = "4pxShadow(2px)"
	_4pxShadow2px_2.Parent = Window
	_4pxShadow2px_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	_4pxShadow2px_2.BackgroundTransparency = 1.000
	_4pxShadow2px_2.Position = UDim2.new(0, -15, 0, -15)
	_4pxShadow2px_2.Selectable = true
	_4pxShadow2px_2.Size = UDim2.new(1, 30, 1, 30)
	_4pxShadow2px_2.Image = "http://www.roblox.com/asset/?id=5761504593"
	_4pxShadow2px_2.ImageColor3 = Color3.fromRGB(49, 49, 59)
	_4pxShadow2px_2.ImageTransparency = 0.300
	_4pxShadow2px_2.ScaleType = Enum.ScaleType.Slice
	_4pxShadow2px_2.SliceCenter = Rect.new(17, 17, 283, 283)

	Close.MouseButton1Click:Connect(function()
		TS:Create(Window, TweenInfo.new(0.5), {Size = UDim2.new(0, 600, 0, 0)}):Play()
		repeat
			wait()
		until Window.Size == UDim2.new(0, 600, 0, 0)
		wait(0.1)
		TS:Create(Window, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
		repeat
			wait()
		until Window.Size == UDim2.new(0, 0, 0, 0)
		MyGui:Remove()
	end)

	Minimize.MouseButton1Click:Connect(function()
		if not MinimizeGui then
			MinimizeGui = true
			if Window.Size == UDim2.new(0, 600,0, 400) then
				TS:Create(Window, TweenInfo.new(0.25), {Size = UDim2.new(0, 600,0, 32)}):Play()
				repeat wait() until Window.Size == UDim2.new(0, 600,0, 32)
				if Page and Page.Visible == true then
					Page.Visible = false
				end
				if Tabs and Tabs.Visible == true then
					Tabs.Visible = false
				end
			end
		else
			MinimizeGui = false
			if Window.Size == UDim2.new(0, 600,0, 32) then
				if Page and Page.Visible == true then
					Page.Visible = false
				end
				if Tabs and Tabs.Visible == true then
					Tabs.Visible = false
				end
				TS:Create(Window, TweenInfo.new(0.25), {Size = UDim2.new(0, 600,0, 400)}):Play()
			end
		end
	end)


	function dragify(Frame)
		dragToggle = nil
		local dragSpeed = 0.25
		dragInput = nil
		dragStart = nil
		local dragPos = nil
		function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			TS:Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end

	dragify(Window)
	TS:Create(Window, TweenInfo.new(0.5), {Size = UDim2.new(0, 600, 0, 0)}):Play()
	repeat wait() until Window.Size == UDim2.new(0, 600, 0, 0)
	wait(0.1)
	TS:Create(Window, TweenInfo.new(0.5), {Size = UDim2.new(0, 600, 0, 400)}):Play()

	--end
	local tabs = {}

	function tabs:CreateTab(name)
		name = name or "Section 1"
		--Create Tab
		local Tabs = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local SectionLabel = Instance.new("TextLabel")
		local UIListLayout = Instance.new("UIListLayout")
		--local PageButton = Instance.new("TextButton") --LATER
		local Indicator = Instance.new("Frame")

		Tabs.Name = "Tabs"
		Tabs.Parent = Window
		Tabs.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
		Tabs.Position = UDim2.new(0, 5, 0, 36)
		Tabs.Size = UDim2.new(0, 140, 1, -41)

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = Tabs

		SectionLabel.Name = "SectionLabel"
		SectionLabel.Parent = Tabs
		SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SectionLabel.BackgroundTransparency = 1.000
		SectionLabel.Position = UDim2.new(0, 7, 0, 0)
		SectionLabel.Size = UDim2.new(1, -7, 0, 30)
		SectionLabel.Font = Enum.Font.GothamBlack
		SectionLabel.Text = name --"Section 1"
		SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		SectionLabel.TextSize = 12.000
		SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

		UIListLayout.Parent = Tabs
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		--LATER
		--[[PageButton.Name = "PageButton"
		PageButton.Parent = Tabs
		PageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageButton.BackgroundTransparency = 1.000
		PageButton.Size = UDim2.new(1, -14, 0, 20)
		PageButton.Font = Enum.Font.Gotham
		PageButton.Text = "Page 1"
		PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		PageButton.TextSize = 12.000
		PageButton.TextXAlignment = Enum.TextXAlignment.Left]]

		Indicator.Name = "Indicator"
		Indicator.Parent = Tabs
		Indicator.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
		Indicator.BorderSizePixel = 0
		Indicator.BackgroundTransparency = 1
		Indicator.Position = UDim2.new(0, -14, 0, 4)
		Indicator.Size = UDim2.new(0, 2, 1, -8)
		Indicator.Visible = false
		--end
		local mytabbuttons = {}
		function mytabbuttons:CreateFrame(name)
			name = name or "Page 1"
			--Creating Page

			local Page = Instance.new("ScrollingFrame")
			local UICorner_3 = Instance.new("UICorner")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local SearchBar = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")
			local SearchIcon = Instance.new("ImageLabel")
			local Bar_3 = Instance.new("Frame")
			local SearchBox = Instance.new("TextBox")
			local Section = Instance.new("Frame")
			local UICorner_5 = Instance.new("UICorner")
			local SectionContainer = Instance.new("Frame")

			local Header = Instance.new("Frame")
			local UICorner_23 = Instance.new("UICorner")
			local UIGradient_2 = Instance.new("UIGradient")
			local _4pxShadow2px_2 = Instance.new("ImageLabel")


			Page.Name = "Page"
			Page.Parent = Window
			Page.Active = true
			Page.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
			Page.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Page.BorderSizePixel = 0
			Page.Position = UDim2.new(0, 150, 0, 36)
			Page.Size = UDim2.new(1, -155, 1, -41)
			Page.ScrollBarThickness = 5
			Page.ScrollBarImageColor3 = Color3.fromRGB(135, 255, 135)
			Page.AutomaticCanvasSize = "Y"
			Page.Visible = false

			UICorner_3.CornerRadius = UDim.new(0, 4)
			UICorner_3.Parent = Page

			UIListLayout_2.Parent = Page
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 4)

			UIPadding.Parent = Page
			UIPadding.PaddingBottom = UDim.new(0, 4)
			UIPadding.PaddingLeft = UDim.new(0, 4)
			UIPadding.PaddingRight = UDim.new(0, 4)
			UIPadding.PaddingTop = UDim.new(0, 4)

			SearchBar.Name = "SearchBar"
			SearchBar.Parent = Page
			SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
			SearchBar.Size = UDim2.new(1, 0, 0, 30)

			UICorner_4.CornerRadius = UDim.new(0, 4)
			UICorner_4.Parent = SearchBar

			SearchIcon.Name = "SearchIcon"
			SearchIcon.Parent = SearchBar
			SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchIcon.BackgroundTransparency = 1.000
			SearchIcon.Position = UDim2.new(0, 6, 0, 6)
			SearchIcon.Size = UDim2.new(0, 18, 0, 18)
			SearchIcon.Image = "rbxassetid://10045418551"
			SearchIcon.ImageColor3 = Color3.fromRGB(135, 255, 135)

			Bar_3.Name = "Bar"
			Bar_3.Parent = SearchBar
			Bar_3.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
			Bar_3.Position = UDim2.new(0, 30, 0, 10)
			Bar_3.Size = UDim2.new(0, 1, 1, -20)

			SearchBox.Name = "SearchBox"
			SearchBox.Parent = SearchBar
			SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchBox.BackgroundTransparency = 1.000
			SearchBox.Position = UDim2.new(0, 40, 0, 1)
			SearchBox.Size = UDim2.new(1, -40, 1, 0)
			SearchBox.Font = Enum.Font.Gotham
			SearchBox.PlaceholderColor3 = Color3.fromRGB(227, 225, 228)
			SearchBox.PlaceholderText = "Search Here"
			SearchBox.Text = ""
			SearchBox.TextColor3 = Color3.fromRGB(227, 225, 228)
			SearchBox.TextSize = 12.000
			SearchBox.TextXAlignment = Enum.TextXAlignment.Left

			Section.Name = "Section"
			Section.Parent = Page
			Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Section.BackgroundTransparency = 1.000
			Section.BorderSizePixel = 0
			Section.Position = UDim2.new(0.0170000363, 0, 0.0968660116, 0)
			Section.Size = UDim2.new(0.966000021, 0, 0.159766689, 117)

			UICorner_5.CornerRadius = UDim.new(0, 4)
			UICorner_5.Parent = Section

			SectionContainer.Name = "SectionContainer"
			SectionContainer.Parent = Section
			SectionContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
			SectionContainer.BorderSizePixel = 0
			SectionContainer.ClipsDescendants = true
			SectionContainer.Position = UDim2.new(0, 0, 1.25310734e-07, 0)
			SectionContainer.Size = UDim2.new(1, 0, 1.0033654, -1)
			SectionContainer.ZIndex = 2

			Header.Name = "Header"
			Header.Parent = Section
			Header.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
			Header.BorderSizePixel = 0
			Header.Size = UDim2.new(1, 0, 0, 8)

			UICorner_23.CornerRadius = UDim.new(0, 4)
			UICorner_23.Parent = Header

			UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.75), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(1.00, 0.75)}
			UIGradient_2.Parent = Header

			local UIPadding_2 = Instance.new("UIPadding")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local UICorner_8 = Instance.new("UICorner")

			UIPadding_2.Parent = SectionContainer
			UIPadding_2.PaddingBottom = UDim.new(0, 4)
			UIPadding_2.PaddingLeft = UDim.new(0, 4)
			UIPadding_2.PaddingRight = UDim.new(0, 4)
			UIPadding_2.PaddingTop = UDim.new(0, 4)

			UIListLayout_3.Archivable = false
			UIListLayout_3.Parent = SectionContainer
			UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 4)

			UICorner_8.CornerRadius = UDim.new(0, 4)
			UICorner_8.Parent = SectionContainer
			--End

			function UpdateResults()
				local search = string.lower(SearchBox.Text)
				for i, v in	 pairs(SectionContainer:GetChildren()) do
					if v:IsA("Frame") then
						if search ~= "" then
							if v.Name == "Button" then
								local item = string.lower(v.Title.Text)
								if string.find(item, search) then
									v.Visible = true
								else
									v.Visible = false
								end
							elseif v.Name == "Label" then
								local item = string.lower(v.LabelContent.Text)
								if string.find(item, search) then
									v.Visible = true
								else
									v.Visible = false
								end
							elseif v.Name == "Slider" then
								local item = string.lower(v.Title.Text)
								if string.find(item, search) then
									v.Visible = true
								else
									v.Visible = false
								end
							elseif v.Name == "TextBox" then
								local item = string.lower(v.Container.TextInput.Text)
								if string.find(item, search) then
									v.Visible = true
								else
									v.Visible = false
								end
							elseif v.Name == "Keybind" then
								local item = string.lower(v.Container.Title.Text)
								if string.find(item, search) then
									v.Visible = true
								else
									v.Visible = false
								end
							elseif v.Name == "Toggle" then
								local item = string.lower(v.Title.Text)
								if string.find(item, search) then
									v.Visible = true
								else
									v.Visible = false
								end
							end
						else
							v.Visible = true
						end
					end
				end
			end

			SearchBox.Changed:Connect(UpdateResults)

			local size = 0
			SectionContainer.ChildAdded:Connect(function(me)
				if me:IsA("Frame") and me.Name == "Toggle"  then
					size = size + 43
				elseif me:IsA("Frame") and me.Name == "Button" then
					size = size + 43 
				elseif me:IsA("Frame") and me.Name == "Label" then
					size = size + 31  -- ADDING 1 TO MAKE SURE FRAME IS BIGGER
				elseif me:IsA("Frame") and me.Name == "TextBox" then
					size = size + 37
				elseif me:IsA("Frame") and me.Name == "Keybind" then
					size = size + 31
				elseif me:IsA("Frame") and me.Name == "Slider" then
					size = size + 47
				elseif me:IsA("Frame") and me.Name == "ColorPicker" then
					size = size + 47
				end
				Section.Size = UDim2.new(1,0,0,size)
				--[[for i,v in pairs(SectionContainer:GetChildren()) do
					if v:IsA("Frame") and v.Name == "Toggle" then
						print(v.Name)
						size = size + 46
					elseif v:IsA("Frame") and v.Name == "Button" then
						print(v.Name)
						size = size + 46
					elseif v:IsA("Frame") and v.Name == "Label" then
						print(v.Name)
						size = size + 46
					elseif v:IsA("Frame") and v.Name == "Slider" then
						print(v.Name)
						size = size + 46
					elseif v:IsA("Frame") and v.Name == "TextBox" then
						print(v.Name)
						size = size + 46
					elseif v:IsA("Frame") and v.Name == "Keybind" then
						print(v.Name)
						size = size + 46
					end
					Section.Size = UDim2.new(1,0,0,size)
				end]]
			end)

			local PageButton = Instance.new("TextButton")
			PageButton.Name = "PageButton"
			PageButton.Parent = Tabs
			PageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PageButton.BackgroundTransparency = 1.000
			PageButton.Size = UDim2.new(1, -14, 0, 20)
			PageButton.Font = Enum.Font.Gotham
			PageButton.Text = name
			PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			PageButton.TextSize = 12.000
			PageButton.TextTransparency = 0.5
			PageButton.TextXAlignment = Enum.TextXAlignment.Left

			PageButton.MouseButton1Down:Connect(function()
				if Indicator.Visible == false then
					Indicator.Visible = true
				end
				TS:Create(Indicator, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
				wait()
				TS:Create(Indicator, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
				for i, v in next, Tabs:GetChildren() do
					if v:IsA("TextButton") and v.Name == "PageButton" then
						TS:Create(v, TweenInfo.new(0.5), {TextTransparency = 0.5}):Play()
					end
				end
				wait()
				TS:Create(PageButton, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
				Indicator.Parent = PageButton

				for i,v in pairs(Window:GetChildren()) do
					if v:IsA("ScrollingFrame") and v.Name ~= "Tabs" and v.Name ~= "TitleBar" and v.Name ~= "UICorner" then
						v.Visible = false
					end
				end

				Page.Visible = true
			end)

			local pagebuttons = {}

			function pagebuttons:CreateButton(name, desc, callback)
				name = name or "Button"
				desc = desc or "Description"
				callback = callback or function() end
				local UpdateButton = {}
				local Button = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Description = Instance.new("TextLabel")
				local Caller = Instance.new("TextButton")
				local Ripple = Instance.new('LocalScript')
				local Sample = Instance.new("ImageLabel")

				Button.Name = "Button"
				Button.Parent = SectionContainer
				Button.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Button.Size = UDim2.new(1, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Button


				Title.Name = "Title"
				Title.Parent = Button
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 7, 0, 1)
				Title.Size = UDim2.new(1, -7, 0.5, 0)
				Title.Font = Enum.Font.GothamBlack
				Title.Text = name
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Description.Name = "Description"
				Description.Parent = Button
				Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Description.BackgroundTransparency = 1.000
				Description.Position = UDim2.new(0, 7, 0.5, -1)
				Description.Size = UDim2.new(1, -7, 0.5, 0)
				Description.Font = Enum.Font.Gotham
				Description.Text = desc
				Description.TextColor3 = Color3.fromRGB(159, 159, 159)
				Description.TextSize = 12.000
				Description.TextXAlignment = Enum.TextXAlignment.Left

				Caller.Name = "Caller"
				Caller.Parent = Button
				Caller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Caller.BackgroundTransparency = 0.999
				Caller.ClipsDescendants = true
				Caller.Size = UDim2.new(0, 429, 0, 39)
				Caller.Font = Enum.Font.SourceSans
				Caller.Text = ""
				Caller.TextColor3 = Color3.fromRGB(0, 0, 0)
				Caller.TextSize = 14.000
				Caller.TextTransparency = 1.000


				Caller.MouseButton1Click:Connect(function()
					callback()
				end)

				spawn(function()
					local function QCZV_fake_script() -- Caller.Handler 
						local Ripple = Instance.new('LocalScript', Caller)
						local ms = game.Players.LocalPlayer:GetMouse()

						Sample.Name = "Sample"
						Sample.Parent = Ripple
						Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Sample.BackgroundTransparency = 1.000
						Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
						Sample.ImageColor3 = Color3.fromRGB(135, 255, 135)
						Sample.ImageTransparency = 0.600

						local btn = Caller
						local sample = Sample

						btn.MouseButton1Click:Connect(function()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						end)
					end
					coroutine.wrap(QCZV_fake_script)()
				end)

				function UpdateButton:UpdateButton(name)
					ButtonText.Text = name
				end
				return UpdateButton
			end

			function pagebuttons:CreateLabel(name)
				name = name or "Label"
				local UpdateLabel2 = {}
				local Label = Instance.new("Frame")
				local UICorner_16 = Instance.new("UICorner")
				local _4pxShadow2px = Instance.new("ImageLabel")
				local LabelContent = Instance.new("TextLabel")


				Label.Name = "Label"
				Label.Parent = SectionContainer
				Label.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Label.BackgroundTransparency = 0.500
				Label.Size = UDim2.new(1, 0, 0, 24)

				UICorner_16.CornerRadius = UDim.new(0, 4)
				UICorner_16.Parent = Label

				_4pxShadow2px.Name = "4pxShadow(2px)"
				_4pxShadow2px.Parent = Label
				_4pxShadow2px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				_4pxShadow2px.BackgroundTransparency = 1.000
				_4pxShadow2px.Position = UDim2.new(0, -15, 0, -15)
				_4pxShadow2px.Selectable = true
				_4pxShadow2px.Size = UDim2.new(1, 30, 1, 30)
				_4pxShadow2px.Image = "http://www.roblox.com/asset/?id=5761504593"
				_4pxShadow2px.ImageColor3 = Color3.fromRGB(135, 255, 135)
				_4pxShadow2px.ImageTransparency = 0.700
				_4pxShadow2px.ScaleType = Enum.ScaleType.Slice
				_4pxShadow2px.SliceCenter = Rect.new(17, 17, 283, 283)

				LabelContent.Name = "LabelContent"
				LabelContent.Parent = Label
				LabelContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelContent.BackgroundTransparency = 1.000
				LabelContent.Position = UDim2.new(0, 7, 0, 0)
				LabelContent.Size = UDim2.new(1, -7, 1, 0)
				LabelContent.Font = Enum.Font.Gotham
				LabelContent.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelContent.Text = name
				LabelContent.TextSize = 12.000
				LabelContent.TextXAlignment = Enum.TextXAlignment.Left
				function UpdateLabel2:UpdateLabel(name)
					LabelContent.Text = name
				end
				return UpdateLabel2
			end

			function pagebuttons:CreateSlider(name,min,max,callback)
				name = name or "Slider"
				min = min or 16
				max = max or 100
				local library4 = {}
				library4["Value"] = nil
				local Slider = Instance.new("Frame")
				local UICorner_17 = Instance.new("UICorner")
				local Title_4 = Instance.new("TextLabel")
				local Tracker = Instance.new("Frame")
				local Indicator_3 = Instance.new("Frame")
				local TextButton_2 = Instance.new("TextButton")
				local UICorner_18 = Instance.new("UICorner")
				local Fade = Instance.new("Frame")
				local UICorner_19 = Instance.new("UICorner")
				local Value = Instance.new("Frame")
				local UICorner_20 = Instance.new("UICorner")
				local ValueText = Instance.new("TextLabel")
				local Shadow_1 = Instance.new("ImageLabel")
				local Shadow_2 = Instance.new("ImageLabel")

				Slider.Name = "Slider"
				Slider.Parent = SectionContainer
				Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Slider.Size = UDim2.new(1, 0, 0, 40)

				UICorner_17.CornerRadius = UDim.new(0, 4)
				UICorner_17.Parent = Slider

				Title_4.Name = "Title"
				Title_4.Parent = Slider
				Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_4.BackgroundTransparency = 1.000
				Title_4.Position = UDim2.new(0, 7, 0, 0)
				Title_4.Size = UDim2.new(1, -7, 0, 30)
				Title_4.Font = Enum.Font.GothamBlack
				Title_4.Text = name
				Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_4.TextSize = 12.000
				Title_4.TextXAlignment = Enum.TextXAlignment.Left

				Tracker.Name = "Tracker"
				Tracker.Parent = Slider
				Tracker.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
				Tracker.BorderSizePixel = 0
				Tracker.Position = UDim2.new(0, 7, 1, -10)
				Tracker.Size = UDim2.new(1, -14, 0, 2)

				Indicator_3.Name = "Indicator"
				Indicator_3.Parent = Tracker
				Indicator_3.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Indicator_3.BorderSizePixel = 0
				Indicator_3.Size = UDim2.new(0, 0, 1, 0)

				Shadow_1.Name = "Shadow_1"
				Shadow_1.Parent = Indicator_3
				Shadow_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Shadow_1.BackgroundTransparency = 1.000
				Shadow_1.Position = UDim2.new(0, -15, 0, -15)
				Shadow_1.Selectable = true
				Shadow_1.Size = UDim2.new(1, 30, 1, 30)
				Shadow_1.Image = "http://www.roblox.com/asset/?id=5761504593"
				Shadow_1.ImageColor3 = Color3.fromRGB(135, 255, 135)
				Shadow_1.ImageTransparency = 1
				Shadow_1.ScaleType = Enum.ScaleType.Slice
				Shadow_1.SliceCenter = Rect.new(17, 17, 283, 283)

				TextButton_2.Parent = Indicator_3
				TextButton_2.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				TextButton_2.Position = UDim2.new(1, -4, 0.5, -4)
				TextButton_2.Size = UDim2.new(0, 8, 0, 8)
				TextButton_2.Font = Enum.Font.SourceSans
				TextButton_2.Text = ""
				TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_2.TextSize = 14.000

				Shadow_2.Name = "Shadow_2"
				Shadow_2.Parent = TextButton_2
				Shadow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Shadow_2.BackgroundTransparency = 1.000
				Shadow_2.Position = UDim2.new(0, -15, 0, -15)
				Shadow_2.Selectable = true
				Shadow_2.Size = UDim2.new(1, 30, 1, 30)
				Shadow_2.Image = "http://www.roblox.com/asset/?id=5761504593"
				Shadow_2.ImageColor3 = Color3.fromRGB(135, 255, 135)
				Shadow_2.ImageTransparency = 1
				Shadow_2.ScaleType = Enum.ScaleType.Slice
				Shadow_2.SliceCenter = Rect.new(17, 17, 283, 283)

				UICorner_18.CornerRadius = UDim.new(0.5, 0)
				UICorner_18.Parent = TextButton_2

				Fade.Name = "Fade"
				Fade.Parent = TextButton_2
				Fade.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Fade.BackgroundTransparency = 1.000
				Fade.Position = UDim2.new(-0.5, 0, -0.5, 0)
				Fade.Size = UDim2.new(2, 0, 2, 0)

				UICorner_19.CornerRadius = UDim.new(0.5, 0)
				UICorner_19.Parent = Fade

				Value.Name = "Value"
				Value.Parent = Slider
				Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Value.BackgroundTransparency = 0.830
				Value.Position = UDim2.new(1, -47, 0, 4)
				Value.Size = UDim2.new(0, 43, 0, 22)

				UICorner_20.CornerRadius = UDim.new(0, 4)
				UICorner_20.Parent = Value

				ValueText.Name = "ValueText"
				ValueText.Parent = Value
				ValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueText.BackgroundTransparency = 1.000
				ValueText.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ValueText.Size = UDim2.new(1, 0, 1, 0)
				ValueText.Font = Enum.Font.Gotham
				ValueText.Text = min
				ValueText.TextColor3 = Color3.fromRGB(227, 225, 228)
				ValueText.TextSize = 12.000



				local value
				local dragging
				local SliderBar = Tracker
				local Sliderbutton = TextButton_2
				local Slider_2 = Indicator_3
				local mr = math.round
				function library4:SetValue(input)
					local pos = UDim2.new(math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1), 0, 0, (SliderBar.AbsoluteSize.Y))
					Slider_2:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					local value = math.floor(( ((pos.X.Scale * max) / max) * (max - min) + min ) * 100) / 100
					ValueText.Text = tostring(mr(value))
					library4["Value"] = value
					spawn(function() callback(value) wait() ValueText.Text = mr(value) end)
				end;

				Sliderbutton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						TS:Create(Fade,TweenInfo.new(.1),{BackgroundTransparency=0.8}):Play()
						TS:Create(Shadow_1,TweenInfo.new(.1),{ImageTransparency=0.7}):Play()
						TS:Create(Shadow_2,TweenInfo.new(.1),{ImageTransparency=0.7}):Play()
					end
				end)

				Sliderbutton.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
						TS:Create(Fade,TweenInfo.new(.1),{BackgroundTransparency=1}):Play()
						TS:Create(Shadow_1,TweenInfo.new(.1),{ImageTransparency=1}):Play()
						TS:Create(Shadow_2,TweenInfo.new(.1),{ImageTransparency=1}):Play()
					end
				end)

				Sliderbutton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						library4:SetValue(input)
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						library4:SetValue(input)
					end
				end)
				return library4	
			end

			function pagebuttons:CreateBox(name, icon, callback)
				name = name or "Input Text Here..."
				if icon == "Default" then
					icon = 10045753138
				else
					icon = icon
				end
				callback = callback or function() end
				local UpdateBox = {}
				local TextBox = Instance.new("Frame")
				local Footer_3 = Instance.new("Frame")
				local UICorner_21 = Instance.new("UICorner")
				local Container_3 = Instance.new("Frame")
				local UICorner_22 = Instance.new("UICorner")
				local TextInput = Instance.new("TextBox")
				local EditIcon = Instance.new("ImageLabel")

				TextBox.Name = "TextBox"
				TextBox.Parent = SectionContainer
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1.000
				TextBox.Size = UDim2.new(1, 0, 0, 30)

				Footer_3.Name = "Footer"
				Footer_3.Parent = TextBox
				Footer_3.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Footer_3.BackgroundTransparency = 0.750
				Footer_3.Position = UDim2.new(0, 0, 1, -8)
				Footer_3.Size = UDim2.new(1, 0, 0, 8)

				UICorner_21.CornerRadius = UDim.new(0, 4)
				UICorner_21.Parent = Footer_3

				Container_3.Name = "Container"
				Container_3.Parent = TextBox
				Container_3.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Container_3.BorderSizePixel = 0
				Container_3.Size = UDim2.new(1, 0, 1, -1)
				Container_3.ZIndex = 2

				UICorner_22.CornerRadius = UDim.new(0, 4)
				UICorner_22.Parent = Container_3

				TextInput.Name = "TextInput"
				TextInput.Parent = Container_3
				TextInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextInput.BackgroundTransparency = 1.000
				TextInput.Position = UDim2.new(0, 30, 0, 0)
				TextInput.Size = UDim2.new(1, -30, 1, 0)
				TextInput.Font = Enum.Font.Gotham
				TextInput.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				TextInput.PlaceholderText = name --"Input Text Here..."
				TextInput.Text = ""
				TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextInput.TextSize = 12.000
				TextInput.TextXAlignment = Enum.TextXAlignment.Left


				TextInput.FocusLost:Connect(function()
					callback(TextInput.Text)
				end)


				EditIcon.Name = "EditIcon"
				EditIcon.Parent = Container_3
				EditIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				EditIcon.BackgroundTransparency = 1.000
				EditIcon.Position = UDim2.new(0, 6, 0, 6)
				EditIcon.Size = UDim2.new(0, 18, 0, 18)
				EditIcon.Image = "rbxassetid://"..icon
				EditIcon.ImageColor3 = Color3.fromRGB(135, 255, 135)
				function UpdateBox:UpdateBox(name)
					TextInput.PlaceholderText = name
				end
				return UpdateBox
			end

			function pagebuttons:CreateBind(name, defaultkey, callback)
				local name = name or "Keybind"
				local defaultkey = defaultkey or "Unknown"
				local callback = callback or function() end
				local UpdateBind = {}
				local Keybind = Instance.new("Frame")
				local Footer_2 = Instance.new("Frame")
				local UICorner_13 = Instance.new("UICorner")
				local Container_2 = Instance.new("Frame")
				local UICorner_14 = Instance.new("UICorner")
				local Title_3 = Instance.new("TextLabel")
				local KButton = Instance.new("TextButton")
				local Sample = Instance.new("ImageLabel")
				local UICorner_15 = Instance.new("UICorner")

				Keybind.Name = "Keybind"
				Keybind.Parent = SectionContainer
				Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Keybind.BackgroundTransparency = 1.000
				Keybind.Size = UDim2.new(1, 0, 0, 30)

				Footer_2.Name = "Footer"
				Footer_2.Parent = Keybind
				Footer_2.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Footer_2.BackgroundTransparency = 0.750
				Footer_2.Position = UDim2.new(0, 0, 1, -8)
				Footer_2.Size = UDim2.new(1, 0, 0, 8)

				UICorner_13.CornerRadius = UDim.new(0, 4)
				UICorner_13.Parent = Footer_2

				Container_2.Name = "Container"
				Container_2.Parent = Keybind
				Container_2.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Container_2.BorderSizePixel = 0
				Container_2.Size = UDim2.new(1, 0, 1, -1)
				Container_2.ZIndex = 2

				UICorner_14.CornerRadius = UDim.new(0, 4)
				UICorner_14.Parent = Container_2

				Title_3.Name = "Title"
				Title_3.Parent = Container_2
				Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_3.BackgroundTransparency = 1.000
				Title_3.Position = UDim2.new(0.0169024151, 0, 0, 0)
				Title_3.Size = UDim2.new(0, 55, 0, 29)
				Title_3.Font = Enum.Font.GothamBlack
				Title_3.Text = name
				Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_3.TextSize = 12.000
				Title_3.TextXAlignment = Enum.TextXAlignment.Left

				KButton.Name = "KButton"
				KButton.Parent = Container_2
				KButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				KButton.BackgroundTransparency = 0.830
				KButton.Position = UDim2.new(0.814999998, 0, 0.129999995, 0)
				KButton.Size = UDim2.new(0, 72, 0, 22)
				KButton.Font = Enum.Font.Gotham
				KButton.ClipsDescendants = true
				KButton.Text = defaultkey
				KButton.TextColor3 = Color3.fromRGB(227, 225, 228)
				KButton.TextSize = 12.000

				Sample.Name = "Sample"
				Sample.Parent = Ripple
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = Color3.fromRGB(135, 255, 135)
				Sample.ImageTransparency = 0.600

				UICorner_15.CornerRadius = UDim.new(0, 4)
				UICorner_15.Parent = KButton

				local keybindtoggle = false
				KButton.MouseButton1Click:Connect(function()
					if keybindtoggle == false then
						keybindtoggle = true
						KButton.Text = ". . ."
						Thing = game:GetService("UserInputService").InputBegan:Connect(function(Key, IsNotFocused)
							if IsNotFocused then return end
							if Key.UserInputType == Enum.UserInputType.Keyboard then
								KButton.Text = Key.KeyCode.Name
								callback(Key.KeyCode.Name)
								CurrentKey = Key.KeyCode.Name
								keybindtoggle = false
								Thing:Disconnect()
							else
								KButton.Text = "Unknown"
								Thing:Disconnect()
							end
						end)
					else
						keybindtoggle = false
					end
				end)

				game:GetService("UserInputService").InputBegan:Connect(function(Key, IsNotFocused)
					if IsNotFocused then return end
					if Key.UserInputType == Enum.UserInputType.Keyboard and Key.KeyCode.Name == CurrentKey then
						local btn = KButton
						local sample = Sample
						local c = sample:Clone()
						c.Parent = btn
						c.Position = UDim2.new(btn.Position)
						local len, size = 0.35, nil
						if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
							size = (btn.AbsoluteSize.X * 1.5)
						else
							size = (btn.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(len / 12)
						end
						c:Destroy()
					end
				end)

				KButton.Text = defaultkey

				function UpdateBind:UpdateBind(name)
					Title_3.Text = name
				end
				return UpdateBind
			end

			function pagebuttons:CreateToggle(title , desc, callback)
				title = title or "Title"
				desc = desc or "Description"
				callback = callback or function() end
				local UpdateToggle = {}
				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ToggleTitle = Instance.new("TextLabel")
				local Description = Instance.new("TextLabel")
				local Indicator = Instance.new("Frame")
				local UIStroke = Instance.new("UIStroke")
				local Dot = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local UICorner_3 = Instance.new("UICorner")
				local TButton = Instance.new("TextButton")
				local UICorner_4 = Instance.new("UICorner")

				Toggle.Name = "Toggle"
				Toggle.Parent = SectionContainer
				Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				Toggle.Size = UDim2.new(1, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Toggle

				ToggleTitle.Name = "Title"
				ToggleTitle.Parent = Toggle
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleTitle.BackgroundTransparency = 1.000
				ToggleTitle.Position = UDim2.new(0, 7, 0, 1)
				ToggleTitle.Size = UDim2.new(1, -7, 0.5, 0)
				ToggleTitle.Font = Enum.Font.GothamBlack
				ToggleTitle.Text = title
				ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleTitle.TextSize = 12.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

				Description.Name = "Description"
				Description.Parent = Toggle
				Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Description.BackgroundTransparency = 1.000
				Description.Position = UDim2.new(0, 7, 0.5, -1)
				Description.Size = UDim2.new(1, -7, 0.5, 0)
				Description.Font = Enum.Font.Gotham
				Description.Text = desc
				Description.TextColor3 = Color3.fromRGB(159, 159, 159)
				Description.TextSize = 12.000
				Description.TextXAlignment = Enum.TextXAlignment.Left

				Indicator.Name = "Indicator"
				Indicator.Parent = Toggle
				Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Indicator.BackgroundTransparency = 1.000
				Indicator.Position = UDim2.new(1, -29, 0, 11)
				Indicator.Size = UDim2.new(0, 18, 0, 18)

				UIStroke.Name = "UIStroke"
				UIStroke.Parent = Indicator
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
				UIStroke.Color = Color3.fromRGB(135, 255, 135)
				UIStroke.LineJoinMode = Enum.LineJoinMode.Round
				UIStroke.Thickness = 2
				UIStroke.Transparency = 0

				Dot.Name = "Dot"
				Dot.Parent = Indicator
				Dot.BackgroundColor3 = Color3.fromRGB(135, 255, 135)
				Dot.BackgroundTransparency = 1.000
				Dot.Position = UDim2.new(0, 2, 0, 2)
				Dot.Size = UDim2.new(1, -4, 1, -4)

				UICorner_2.CornerRadius = UDim.new(0.5, 0)
				UICorner_2.Parent = Dot

				UICorner_3.CornerRadius = UDim.new(0.5, 0)
				UICorner_3.Parent = Indicator

				TButton.Name = "TButton"
				TButton.Parent = Toggle
				TButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TButton.BackgroundTransparency = 0.990
				TButton.Position = UDim2.new(0.919974327, 0, 0.174999997, 0)
				TButton.Size = UDim2.new(0, 25, 0, 26)
				TButton.Font = Enum.Font.SourceSans
				TButton.Text = ""
				TButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				TButton.TextSize = 14.000

				UICorner_4.CornerRadius = UDim.new(0.5, 0)
				UICorner_4.Parent = TButton

				TButton.MouseButton1Click:Connect(function()
					if not f then
						f = true
						TS:Create(Dot,TweenInfo.new(.1),{BackgroundTransparency=0}):Play()
						callback(true)
					else
						f = false
						TS:Create(Dot,TweenInfo.new(.1),{BackgroundTransparency=1}):Play()
						callback(false)
					end
				end)
				function UpdateToggle:UpdateToggle(title, desc)
					ToggleTitle.Text = title
					Description.Text = desc
				end
				return UpdateToggle
			end


			function pagebuttons:CreateColorPicker(name, callback)
				-- Very Buggy
				name = name or "ColorPicker"
				callback = callback or function() end
				local ColorPicker = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local ColourGradientFrame = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local ColourGradient = Instance.new("UIGradient")
				local Slider = Instance.new("TextButton")
				local UICorner_3 = Instance.new("UICorner")
				local ColourPreview = Instance.new("Frame")
				local DarknessGradientFrame = Instance.new("TextButton")
				local Slider_2 = Instance.new("TextButton")
				local DarknessGradient = Instance.new("UIGradient")
				local Value2 = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local ValueText2 = Instance.new("TextLabel")

				ColorPicker.Name = "ColorPicker"
				ColorPicker.Parent = SectionContainer
				ColorPicker.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
				ColorPicker.Size = UDim2.new(1, 0, 0, 40)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ColorPicker

				Title.Name = "Title"
				Title.Parent = ColorPicker
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 7, 0, 0)
				Title.Size = UDim2.new(1, -7, 0, 30)
				Title.Font = Enum.Font.GothamBlack
				Title.Text = name
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				ColourGradientFrame.Name = "ColourGradientFrame"
				ColourGradientFrame.Parent = ColorPicker
				ColourGradientFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ColourGradientFrame.BorderSizePixel = 0
				ColourGradientFrame.Position = UDim2.new(0.0170000009, 0, 0.699999988, 0)
				ColourGradientFrame.Size = UDim2.new(0, 403, 0, 8)
				ColourGradientFrame.AutoButtonColor = false
				ColourGradientFrame.Font = Enum.Font.SourceSans
				ColourGradientFrame.Text = ""
				ColourGradientFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
				ColourGradientFrame.TextSize = 14.000

				UICorner_2.CornerRadius = UDim.new(0, 9)
				UICorner_2.Parent = ColourGradientFrame

				ColourGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))}
				ColourGradient.Name = "ColourGradient"
				ColourGradient.Parent = ColourGradientFrame

				Slider.Name = "Slider"
				Slider.Parent = ColourGradientFrame
				Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider.Size = UDim2.new(0, 4, 0, 8)
				Slider.Font = Enum.Font.SourceSans
				Slider.Text = ""
				Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
				Slider.TextSize = 14.000

				UICorner_3.CornerRadius = UDim.new(5, 9)
				UICorner_3.Parent = Slider

				ColourPreview.Name = "ColourPreview"
				ColourPreview.Parent = ColorPicker
				ColourPreview.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
				ColourPreview.BorderSizePixel = 0
				ColourPreview.Position = UDim2.new(-0.0155634917, 0, 0.651912689, 0)
				ColourPreview.Size = UDim2.new(0.00590497162, 0, 0.0980872661, 0)
				ColourPreview.Visible = false

				DarknessGradientFrame.Name = "DarknessGradientFrame"
				DarknessGradientFrame.Parent = ColorPicker
				DarknessGradientFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DarknessGradientFrame.BorderSizePixel = 0
				DarknessGradientFrame.Position = UDim2.new(0.947692037, 0, 0.803900123, 0)
				DarknessGradientFrame.Size = UDim2.new(0.00933223031, 0, 0.0797876194, 0)
				DarknessGradientFrame.Visible = false
				DarknessGradientFrame.AutoButtonColor = false
				DarknessGradientFrame.Font = Enum.Font.SourceSans
				DarknessGradientFrame.Text = ""
				DarknessGradientFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
				DarknessGradientFrame.TextSize = 14.000

				Slider_2.Name = "Slider"
				Slider_2.Parent = DarknessGradientFrame
				Slider_2.BackgroundColor3 = Color3.fromRGB(255, 149, 0)
				Slider_2.BorderSizePixel = 0
				Slider_2.Size = UDim2.new(0.00300000003, 0, 1, 0)
				Slider_2.AutoButtonColor = false
				Slider_2.Font = Enum.Font.SourceSans
				Slider_2.Text = ""
				Slider_2.TextColor3 = Color3.fromRGB(0, 0, 0)
				Slider_2.TextSize = 14.000

				DarknessGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
				DarknessGradient.Name = "DarknessGradient"
				DarknessGradient.Parent = DarknessGradientFrame

				Value2.Name = "Value"
				Value2.Parent = ColorPicker
				Value2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Value2.BackgroundTransparency = 0.830
				Value2.Position = UDim2.new(0.915488005, -47, 0, 4)
				Value2.Size = UDim2.new(0, 78, 0, 17)

				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = Value2

				ValueText2.Name = "ValueText"
				ValueText2.Parent = Value2
				ValueText2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueText2.BackgroundTransparency = 1.000
				ValueText2.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ValueText2.ClipsDescendants = true
				ValueText2.Size = UDim2.new(1, 0, 1, 0)
				ValueText2.Font = Enum.Font.Gotham
				ValueText2.Text = "0, 0, 0"
				ValueText2.TextColor3 = Color3.fromRGB(227, 225, 228)
				ValueText2.TextSize = 12.000
				ValueText2.TextWrapped = true


				local colourGradientFrame = ColourGradientFrame
				local colourSlider = Slider_2

				local darknessGradientFrame =  DarknessGradientFrame
				local darknessSlider = Slider

				local colourPreview = ColourPreview


				local mouse = game:GetService("Players").LocalPlayer:GetMouse()

				local movingColourSlider = false
				local movingDarknessSlider = false


				colourSlider.MouseButton1Down:Connect(function()

					movingColourSlider = true
				end)
				colourGradientFrame.MouseButton1Down:Connect(function()

					movingColourSlider = true
				end)

				darknessSlider.MouseButton1Down:Connect(function()

					movingDarknessSlider = true
				end)
				darknessGradientFrame.MouseButton1Down:Connect(function()

					movingDarknessSlider = true
				end)


				colourSlider.MouseButton1Up:Connect(function()

					movingColourSlider = false
				end)
				colourGradientFrame.MouseButton1Up:Connect(function()

					movingColourSlider = false
				end)

				darknessSlider.MouseButton1Up:Connect(function()

					movingDarknessSlider = false
				end)
				darknessGradientFrame.MouseButton1Up:Connect(function()

					movingDarknessSlider = false
				end)


				mouse.Button1Up:Connect(function()

					movingColourSlider = false
					movingDarknessSlider = false
				end)



				mouse.Move:Connect(function()

					if movingColourSlider then

						local xOffset = (mouse.X - colourGradientFrame.AbsolutePosition.X)

						xOffset = math.clamp(xOffset, 0, colourGradientFrame.AbsoluteSize.X)

						local sliderPosNew = UDim2.new(0, xOffset, colourSlider.Position.Y)
						colourSlider.Position = sliderPosNew
					end

					if movingDarknessSlider then

						local xOffset = (mouse.X - colourGradientFrame.AbsolutePosition.X)

						xOffset = math.clamp(xOffset, 0, colourGradientFrame.AbsoluteSize.X)

						local sliderPosNew = UDim2.new(0, xOffset, colourSlider.Position.Y)
						darknessSlider.Position = sliderPosNew
					end
				end)



				function returnColour(percentage, gradientKeyPoints)

					local leftColour = gradientKeyPoints[1]
					local rightColour = gradientKeyPoints[#gradientKeyPoints]

					local lerpPercent = 0.5
					local colour = leftColour.Value


					for i = 1, #gradientKeyPoints - 1 do

						if gradientKeyPoints[i].Time <= percentage and gradientKeyPoints[i + 1].Time >= percentage then

							leftColour = gradientKeyPoints[i]
							rightColour = gradientKeyPoints[i + 1]

							lerpPercent = (percentage - leftColour.Time) / (rightColour.Time - leftColour.Time)

							colour = leftColour.Value:Lerp(rightColour.Value, lerpPercent)

							return colour
						end
					end
				end

				function updateColourPreview()

					local colourMinXPos = colourGradientFrame.AbsolutePosition.X
					local colourMaxXPos = colourMinXPos + colourGradientFrame.AbsoluteSize.X

					local colourXPixelSize = colourMaxXPos - colourMinXPos

					local colourSliderX = colourSlider.AbsolutePosition.X

					local colourXPos = (colourSliderX - colourMinXPos) / colourXPixelSize


					local darknessMinXPos = darknessGradientFrame.AbsolutePosition.X
					local darknessMaxXPos = darknessMinXPos + darknessGradientFrame.AbsoluteSize.X

					local darknessXPixelSize = darknessMaxXPos - darknessMinXPos

					local darknessSliderX = darknessSlider.AbsolutePosition.X

					local darknessXPos = (darknessSliderX - darknessMinXPos) / darknessXPixelSize


					--local darkness = returnColour(darknessXPos, darknessGradientFrame.DarknessGradient.Color.Keypoints)
					--local darknessR, darknessG, darknessB = 255 - math.floor(darkness.R * 255), 255 - math.floor(darkness.G * 255), 255 - math.floor(darkness.B * 255)


					local colour = returnColour(colourXPos, colourGradientFrame.ColourGradient.Color.Keypoints)
					local colourR, colourG, colourB = math.floor(colour.R * 255), math.floor(colour.G * 255), math.floor(colour.B * 255)

					local resultColour = Color3.fromRGB(colourR, colourG, colourB)

					colourPreview.BackgroundColor3 = resultColour

					if ValueText2.Text ~= "0, 0, 0" then
						ValueText2.TextScaled = true
					end
					ValueText2.Text = tostring(resultColour)
					callback(resultColour)
				end


				colourSlider:GetPropertyChangedSignal("Position"):Connect(updateColourPreview)
				darknessSlider:GetPropertyChangedSignal("Position"):Connect(updateColourPreview)
			end





			function CreateNotification(Name, Description, Callback)
				Name = Name or "Name"
				Description = Description or "Description"
				Callback = Callback or function() end

				local Notification2 = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local _4pxShadow2px = Instance.new("ImageLabel")
				local TitleBar = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Corners = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")
				local Negative = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local _4pxShadow2px_2 = Instance.new("ImageLabel")
				local No = Instance.new("ImageButton")
				local Sample = Instance.new("ImageLabel")
				local Positive = Instance.new("Frame")
				local UICorner_5 = Instance.new("UICorner")
				local _4pxShadow2px_3 = Instance.new("ImageLabel")
				local Yes = Instance.new("ImageButton")
				local Sample_2 = Instance.new("ImageLabel")

				Notification2.Name = "Notification 2"
				Notification2.Parent = MyGui
				Notification2.BackgroundColor3 = Color3.fromRGB(49, 49, 59)
				Notification2.Position = UDim2.new(1.25, -390, 0, 900)
				Notification2.Size = UDim2.new(0, 344, 0, 64)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Notification2

				_4pxShadow2px.Name = "4pxShadow(2px)"
				_4pxShadow2px.Parent = Notification2
				_4pxShadow2px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				_4pxShadow2px.BackgroundTransparency = 1.000
				_4pxShadow2px.Position = UDim2.new(0, -15, 0, -15)
				_4pxShadow2px.Selectable = true
				_4pxShadow2px.Size = UDim2.new(1, 30, 1, 30)
				_4pxShadow2px.Image = "http://www.roblox.com/asset/?id=5761504593"
				_4pxShadow2px.ImageColor3 = Color3.fromRGB(212, 212, 255)
				_4pxShadow2px.ImageTransparency = 0.300
				_4pxShadow2px.ScaleType = Enum.ScaleType.Slice
				_4pxShadow2px.SliceCenter = Rect.new(17, 17, 283, 283)

				TitleBar.Name = "Title Bar"
				TitleBar.Parent = Notification2
				TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
				TitleBar.Size = UDim2.new(0, 344, 0, 22)

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = TitleBar

				Title.Name = "Title"
				Title.Parent = TitleBar
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Title.Size = UDim2.new(0, 342, 0, 22)
				Title.Font = Enum.Font.SourceSansSemibold
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 17.000

				Corners.Name = "Corners"
				Corners.Parent = TitleBar
				Corners.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
				Corners.Position = UDim2.new(0, 0, 0.799998879, 0)
				Corners.Size = UDim2.new(0, 344, 0, 6)

				UICorner_3.CornerRadius = UDim.new(0, 1)
				UICorner_3.Parent = Corners

				TextLabel.Parent = Notification2
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.Position = UDim2.new(0.020144796, 0, 0.399999619, 0)
				TextLabel.Size = UDim2.new(0, 335, 0, 33)
				TextLabel.Font = Enum.Font.SourceSansSemibold
				TextLabel.Text = Description
				TextLabel.TextColor3 = Color3.fromRGB(222, 222, 222)
				TextLabel.TextSize = 16.000
				TextLabel.TextWrapped = true
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel.TextYAlignment = Enum.TextYAlignment.Top

				Negative.Name = "Negative"
				Negative.Parent = Notification2
				Negative.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
				Negative.Position = UDim2.new(1.01569772, 0, 0.5625, 0)
				Negative.Size = UDim2.new(0, 33, 0, 28)

				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = Negative

				_4pxShadow2px_2.Name = "4pxShadow(2px)"
				_4pxShadow2px_2.Parent = Negative
				_4pxShadow2px_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				_4pxShadow2px_2.BackgroundTransparency = 1.000
				_4pxShadow2px_2.Position = UDim2.new(0, -15, 0, -15)
				_4pxShadow2px_2.Selectable = true
				_4pxShadow2px_2.Size = UDim2.new(1, 30, 1, 30)
				_4pxShadow2px_2.Image = "http://www.roblox.com/asset/?id=5761504593"
				_4pxShadow2px_2.ImageColor3 = Color3.fromRGB(212, 212, 255)
				_4pxShadow2px_2.ImageTransparency = 0.300
				_4pxShadow2px_2.ScaleType = Enum.ScaleType.Slice
				_4pxShadow2px_2.SliceCenter = Rect.new(17, 17, 283, 283)

				No.Name = "No"
				No.Parent = Negative
				No.BackgroundTransparency = 1.000
				No.LayoutOrder = 4
				No.Position = UDim2.new(0.136363745, 0, 0.0357143879, 0)
				No.Size = UDim2.new(0, 25, 0, 25)
				No.ZIndex = 2
				No.Image = "rbxassetid://3926305904"
				No.ImageColor3 = Color3.fromRGB(255, 26, 26)
				No.ImageRectOffset = Vector2.new(924, 724)
				No.ImageRectSize = Vector2.new(36, 36)
				No.ImageTransparency = 0.100

				Sample.Name = "Sample"
				Sample.Parent = No
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = Color3.fromRGB(203, 203, 203)
				Sample.ImageTransparency = 0.700

				Positive.Name = "Positive"
				Positive.Parent = Notification2
				Positive.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
				Positive.Position = UDim2.new(1.01744187, 0, 0, 0)
				Positive.Size = UDim2.new(0, 33, 0, 28)

				UICorner_5.CornerRadius = UDim.new(0, 4)
				UICorner_5.Parent = Positive

				_4pxShadow2px_3.Name = "4pxShadow(2px)"
				_4pxShadow2px_3.Parent = Positive
				_4pxShadow2px_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				_4pxShadow2px_3.BackgroundTransparency = 1.000
				_4pxShadow2px_3.Position = UDim2.new(0, -15, 0, -15)
				_4pxShadow2px_3.Selectable = true
				_4pxShadow2px_3.Size = UDim2.new(1, 30, 1, 30)
				_4pxShadow2px_3.Image = "http://www.roblox.com/asset/?id=5761504593"
				_4pxShadow2px_3.ImageColor3 = Color3.fromRGB(212, 212, 255)
				_4pxShadow2px_3.ImageTransparency = 0.300
				_4pxShadow2px_3.ScaleType = Enum.ScaleType.Slice
				_4pxShadow2px_3.SliceCenter = Rect.new(17, 17, 283, 283)

				Yes.Name = "Yes"
				Yes.Parent = Positive
				Yes.BackgroundTransparency = 1.000
				Yes.ClipsDescendants = true
				Yes.LayoutOrder = 4
				Yes.Position = UDim2.new(0.106060594, 0, 0.0357142985, 0)
				Yes.Size = UDim2.new(0, 25, 0, 25)
				Yes.ZIndex = 2
				Yes.Image = "rbxassetid://3926305904"
				Yes.ImageColor3 = Color3.fromRGB(68, 255, 47)
				Yes.ImageRectOffset = Vector2.new(644, 204)
				Yes.ImageRectSize = Vector2.new(36, 36)
				Yes.ImageTransparency = 0.100

				Sample_2.Name = "Sample"
				Sample_2.Parent = Yes
				Sample_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample_2.BackgroundTransparency = 1.000
				Sample_2.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample_2.ImageColor3 = Color3.fromRGB(203, 203, 203)
				Sample_2.ImageTransparency = 0.700

				Instance.new("Sound", game:GetService("SoundService")).SoundId = "rbxassetid://1788243907"; game:GetService("SoundService").Sound:Play()

				TS:Create(Notification2, TweenInfo.new(0.3, Enum.EasingStyle.Linear),{
					Position = UDim2.new(
						1, -390, 0, 900
					)
				}):Play()

				No.MouseButton1Click:Connect(function()
					spawn(function()
						local ms = game:GetService("Players").LocalPlayer:GetMouse()
						local btn = No
						local sample = Sample
						local c = sample:Clone()
						c.Parent = btn
						local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local len, size = 0.35, nil
						if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
							size = (btn.AbsoluteSize.X * 1.5)
						else
							size = (btn.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(len / 12)
						end
						c:Destroy()
					end)
					spawn(function() Callback(false) end)
					wait(.12)
					TS:Create(Notification2, TweenInfo.new(0.3, Enum.EasingStyle.Linear),{
						Position = UDim2.new(
							1.25, -390, 0, 900
						)
					}):Play()
					wait(.5)
					Notification2:Remove()
				end)

				Yes.MouseButton1Click:Connect(function()
					spawn(function()
						local ms = game:GetService("Players").LocalPlayer:GetMouse()
						local btn = Yes
						local sample = Sample_2
						local c = sample:Clone()
						c.Parent = btn
						local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local len, size = 0.35, nil
						if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
							size = (btn.AbsoluteSize.X * 1.5)
						else
							size = (btn.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(len / 12)
						end
						c:Destroy()
					end)
					Callback(true)
					wait(.12)
					TS:Create(Notification2, TweenInfo.new(0.3, Enum.EasingStyle.Linear),{
						Position = UDim2.new(
							1.25, -390, 0, 900
						)
					}):Play()
					wait(.5)
					Notification2:Remove()
				end)

			end

			return pagebuttons

		end
		return mytabbuttons
	end
	return tabs
end

return library