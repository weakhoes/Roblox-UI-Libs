local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('leadmarker is so hot', 'leadmarker')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')
local tab1 = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('Bruh XD')
local section1 = tab.new_section(':DDD HI')

-- // Sector \\ --
local sector = section.new_sector('OK', 'Left')
local sector1 = section.new_sector('BRUHHHH', 'Right')

-- // Elements \\ -- (Type, Name, State, Callback)
local button = sector.element('Button', 'Button', nil, function()

end)

local toggle = sector.element('Toggle', 'Toggle', false, function(v)
   print(v.Toggle) -- :nerd:
end)
toggle:add_color({Color = Color3.fromRGB(84, 101, 255)}, nil, function(v)
   print(v.Color)    
end)

local dropdown = sector.element('Dropdown', 'Dropdown', {options = {'one', 'two', 'three'}}, function(v)
   print(v.Dropdown)
end)

local slider = sector.element('Slider', 'Slider', {default = {min = 1, max = 100, default = 50}}, function(v)
   print(v.Slider)
end)

local combo = sector.element('Combo', 'Combo', {options = {'bruh', 'otherbruh'}}, function(v)
   table.foreach(v.Combo, print)
end)