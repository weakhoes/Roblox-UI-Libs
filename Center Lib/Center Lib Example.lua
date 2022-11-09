local SimpleShindoUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/naypramx/Ui__Project/Script/SimpleShindoUi"))()

local Main = SimpleShindoUi:new()

local Tab = Main:Tap('Centerhub')

local page = Tab:page()

local Labelz = page:Label('Label!')

page:Toggle('Toggle!',false,function(t)
    print(t)
end)
page:Button('Button!',function()
    print('t')
end)
page:Slider('Slider!',1,100,20,function(t)
    print(t)
end)
local drope = page:drop('Dropdown!',"Nothings",false,{'DinoHub','CenterHub'},function(t)
    print(t) -- ห้ามนำไปแจกต่อนะจ๊ะ XD
end)

local page2 = Tab:page()
page2:Button('Clear Dropdown!',function()
    drope:clear()
end)
page2:Button('Refresh Dropdown!',function()
    drope:add({"Simple"}) -- มันทำไงวะ -- ห้ามนำไปแจกต่อนะจ๊ะ XD
end)