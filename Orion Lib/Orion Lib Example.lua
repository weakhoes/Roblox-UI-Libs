local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

OrionLib:MakeNotification({
	Name = "Script",
	Content = "Script Açıldı İyi Oyunlar",
	Image = "rbxassetid://4483345998",
	Time = 5
})


local Window = OrionLib:MakeWindow({Name = "Orion Example", HidePremium = false, SaveConfig = true, ConfigFolder = "Orion"})

--Player Tab--

local PlayerTab = Window:MakeTab({
	Name = "Reach",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local PlayerSection = PlayerTab:AddSection({
	Name = "Reach"
})
ReachSection:AddButton({
		Name = "200 STUD"
     Callback = function()
			while wait(0.3) do
    local args = {
    [1] = workspace.TPSSystem.TPS,
    [2] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
    [3] = 30,
    [4] = Vector3.new(4000000, 300, 4000000)
}

workspace.FE.Actions.KickG1:FireServer(unpack(args))
			end
		})

--Player Tab End--

--Settings Tab--

local SettingsTab = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local SettingsSection = SettingsTab:AddSection({
	Name = "Settings"
})

SettingsSection:AddButton({
	Name = "Destroy UI",
	Callback = function()
        OrionLib:Destroy()
  	end    
})

--Settings End--

OrionLib:Init() --UI Lib End
