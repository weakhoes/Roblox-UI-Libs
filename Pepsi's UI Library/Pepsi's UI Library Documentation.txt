local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops

local PepsisWorld = library:CreateWindow({
Name = "Pepsi's World",
Themeable = {
Info = "Discord Server: VzYTJ7Y"
}
})

local GeneralTab = PepsisWorld:CreateTab({
Name = "General"
})
local FarmingSection = GeneralTab:CreateSection({
Name = "Farming"
})
FarmingSection:AddToggle({
Name = "EXP Grinder",
Flag = "FarmingSection_EXPGrinder"
})
FarmingSection:AddToggle({
Name = "Trick Spammer",
Flag = "FarmingSection_TrickSpammer",
Keybind = 1,
Callback = print
})
FarmingSection:AddSlider({
Name = "Trick Rate",
Flag = "FarmingSection_TrickRate",
Value = 0.15,
Precise = 2,
Min = 0,
Max = 1
})
FarmingSection:AddToggle({
Name = "TP To Coins",
Flag = "FarmingSection_TPCoins"
})
FarmingSection:AddToggle({
Name = "Collect Coins",
Flag = "FarmingSection_CollectCoins",
Callback = print
})
FarmingSection:AddSlider({
Name = "Coin Distance",
Flag = "FarmingSection_CoinDistance",
Value = 175,
Min = 0,
Max = 200,
Format = function(Value)
if Value == 0 then
return "Collection Distance: Infinite"
else
return "Collection Distance: " .. tostring(Value)
end
end
})

local BoardControlSection = GeneralTab:CreateSection({
Name = "Board Control"
})
BoardControlSection:AddToggle({
Name = "Anti Trip/Ragdoll",
Flag = "BoardControlSection_AntiTripRagdoll",
Callback = print
})
BoardControlSection:AddToggle({
Name = "No Wear & Tear",
Flag = "BoardControlSection_NoWearTear"
})
BoardControlSection:AddToggle({
Name = "No Trick Cooldown",
Flag = "BoardControlSection_NoTrickCooldown",
Callback = print
})
BoardControlSection:AddToggle({
Name = "Extend Combo Timout",
Flag = "BoardControlSection_ExtendComboTimeout"
})
BoardControlSection:AddSlider({
Name = "Timeout Extension",
Flag = "BoardControlSection_CoinDistance",
Value = 3,
Min = 0,
Max = 20,
Format = function(Value)
if Value == 0 then
return "Combo Timeout: Never"
else
return "Combo Timeout: " .. tostring(Value) .. "s"
end
end
})

local MiscSection = GeneralTab:CreateSection({
Name = "Misc",
Side = "Right"
})
MiscSection:AddToggle({
Name = "Unlock Gamepasses",
Flag = "MiscSection_UnlockGamepasses",
Callback = print
})
MiscSection:AddToggle({
Name = "Auto Compete",
Flag = "MiscSection_AutoCompete",
Callback = print
})
MiscSection:AddButton({
Name = "Repair Board",
Callback = function()
print("Fixed")
end
})
MiscSection:AddKeybind({
Name = "Test Key",
Callback = print
})
MiscSection:AddToggle({
Name = "Test Toggle/Key",
Keybind = {
Mode = "Dynamic" -- Dynamic means to use the 'hold' method, if the user keeps the button pressed for longer than 0.65 seconds; else use toggle method
},
Callback = print
})

local FunSection = GeneralTab:CreateSection({
Name = "Fun Cosmetics"
})
FunSection:AddToggle({
Name = "Ragdoll Assumes Flight",
Flag = "FunSection_AssumesFlight"
})
FunSection:AddToggle({
Name = "Ragdoll On Player Collision",
Flag = "FunSection_RagdollOnPlayerCollision"
})
FunSection:AddToggle({
Name = "Un-Ragdoll When Motionless",
Flag = "FunSection_UnRagdollWhenMotionless"
})
FunSection:AddToggle({
Name = "Extend Ragdoll Duration",
Flag = "FunSection_ExtendRagdollDuration"
})
FunSection:AddSlider({
Name = "Coin Distance",
Flag = "FarmingSection_Coin Distance",
Value = 4,
Min = 0,
Max = 60,
Textbox = true,
Format = function(Value)
if Value == 0 then
return "Ragdoll Extension: Indefinite"
else
return "Ragdoll Extension: " .. tostring(Value) .. "s"
end
end
})
