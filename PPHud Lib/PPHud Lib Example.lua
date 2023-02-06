local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rain-Design/PPHUD/main/Library.lua'))()
local Flags = Library.Flags

local Window = Library:Window({
   Text = "Baseplate"
})

local Tab = Window:Tab({
   Text = "Aiming"
})

local Tab2 = Window:Tab({
   Text = "Visual"
})

local Section = Tab:Section({
   Text = "Aiming"
})

local Section2 = Tab:Section({
   Text = "Anti-Aim"
})

local Section3 = Tab:Section({
   Text = "Ragebot",
   Side = "Right"
})

Section:Check({
   Text = "Aimbot",
   Flag = "Aimbot"
})

Section:Check({
   Text = "Silent-Aim",
   Callback = function(bool)
       warn(bool)
   end
})

Section:Dropdown({
   Text = "Body Part",
   List = {"Head", "Torso", "Random"},
   Callback = function(opt)
       warn(opt)
   end
})

Section:Slider({
   Text = "Hit Chance",
   Minimum = 0,
   Default = 60,
   Maximum = 100,
   Postfix = "%",
   Callback = function(n)
       warn(n)
   end
})

Section:Button({
   Text = "Spawn",
   Callback = function()
       warn("Settings Reseted.")
   end
})

Section2:Check({
   Text = "Spin"
})

Section2:Slider({
   Text = "Pitch Offset",
   Minimum = 100,
   Default = 150,
   Maximum = 500,
   Callback = function(n)
       warn(n)
   end
})

Section2:Slider({
   Text = "Yaw Offset",
   Minimum = 100,
   Default = 150,
   Maximum = 500,
   Callback = function(n)
       warn(n)
   end
})

Section2:Button({
   Text = "Resolve Positions"
})

Section3:Check({
   Text = "Auto-Wall",
   Callback = function(bool)
       warn(bool)
   end
})

Section3:Check({
   Text = "Trigger Bot"
})

Section3:Check({
   Text = "Insta-Kill"
})

Section3:Dropdown({
   Text = "Hitscan Directions",
   List = {"Left", "Right", "Up", "Down", "All"},
   Callback = function(opt)
       warn(opt)
   end
})

Section3:Label({
   Text = "Status: Undetected",
   Color = Color3.fromRGB(100, 190, 31)
})

Tab:Select()