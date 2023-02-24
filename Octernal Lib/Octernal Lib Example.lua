
local m_thread = task
do
    setreadonly(m_thread, false)

    function m_thread.spawn_loop(p_time, p_callback)
        m_thread.spawn(
            function()
                while true do
                    p_callback()
                    m_thread.wait(p_time)
                end
            end
        )
    end

    setreadonly(m_thread, true)
end

local library, pointers = loadstring(game:HttpGet("https://pastebin.com/raw/Q43KL2RS"))()
do


    local window = library:New({name = "Octernal" , size = Vector2.new(555, 610), Accent = Color3.fromRGB(192, 118, 227)})

    local legitbot = window:Page({name = "Legit", size = 80})
    do
    end
  
     
    local settings_page = window:Page({name = "Configuration", side = "Left", size = 110})
    do
        local config_section = settings_page:Section({name = "Configuration", side = "Left"})
        do
            local current_list = {}
            local function update_config_list()
                local list = {}
                for idx, file in ipairs(listfiles("Linux/configs")) do
                    local file_name = file:gsub("Linux/configs\\", ""):gsub(".txt", "")
                    list[#list + 1] = file_name
                end

                local is_new = #list ~= #current_list
                if not is_new then
                    for idx, file in ipairs(list) do
                        if file ~= current_list[idx] then
                            is_new = true
                            break
                        end
                    end
                end

                if is_new then
                    current_list = list
                    pointers["settings/configuration/list"]:UpdateList(list, false, true)
                end
            end

            config_section:Listbox({pointer = "settings/configuration/list"})
            config_section:Textbox(
                {
                    pointer = "settings/configuration/name",
                    placeholder = "Config Name",
                    text = "",
                    middle = true,
                    reset_on_focus = false
                }
            )


            config_section:ButtonHolder({Buttons = {{"Create",  function()local config_name = pointers["settings/configuration/name"]:get()
                if config_name == "" or isfile("Linux/configs/" .. config_name .. ".txt") then
                    return
                end

                writefile("Linux/configs/" .. config_name .. ".txt", "")
                update_config_list() end}, {"Delete", function()
                local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                if selected_config then
                    delfile("Linux/configs/" .. selected_config .. ".txt")
                    update_config_list()
                end
                end}}})
            config_section:ButtonHolder({Buttons = {{"Load", function()
                local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                if selected_config then
                    window:LoadConfig(readfile("Linux/configs/" .. selected_config .. ".txt"))
                end
            end}, {"Save", function()
                local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                if selected_config then
                    writefile("Linux/configs/" .. selected_config .. ".txt", window:GetConfig())
                end
            end}}})




            m_thread.spawn_loop(3, update_config_list)
    end

    local menu_section = settings_page:Section({name = "Menu"})
    do
        --
        local function gs(a)
            return game:GetService(a)
        end
        --
        local actionservice = gs("ContextActionService")
        --
        menu_section:Keybind(
            {
                pointer = "settings/menu/bind",
                name = "Bind",
                default = Enum.KeyCode.End,
                callback = function(p_state)
                    window.uibind = p_state
                end
            }
        )
        menu_section:Toggle(
            {
                pointer = "sabcd_aa",
                name = "Cursor",
                default = true,
                callback = function(p_state)
                    local userInputService = game:GetService("UserInputService")
                    if p_state == true then
                        userInputService.MouseIconEnabled = true
                    else
                        userInputService.MouseIconEnabled = false
                    end


                end
            }
        )

        menu_section:Toggle(
            {
                pointer = "settings/menu/watermark",
                name = "Watermark",
                default = false,
                callback = function(p_state)
                    window.watermark:Update("Visible", p_state)
                end
            }
        )
        menu_section:Toggle(
            {
                pointer = "settings/menu/keybind_list",
                name = "Keybind List",
                callback = function(p_state)
                    window.keybindslist:Update("Visible", p_state)
                end
            }
        )

        menu_section:Toggle(
            {
                pointer = "freezemovement",
                name = "Disable Movement if UI Open",
                callback = function(bool)
                    if bool and window.isVisible then
                        actionservice:BindAction(
                            "FreezeMovement",
                            function()
                                return Enum.ContextActionResult.Sink
                            end,
                            false,
                            unpack(Enum.PlayerActions:GetEnumItems())
                        )
                    else
                        actionservice:UnbindAction("FreezeMovement")
                    end
                end
            }
        )


        menu_section:Button(
            {
                name = "Unload",
                confirmation = true,
                callback = function()
                    window:Unload()
                end
            }
        )

        menu_section:Button(
            {
                name = "force close",
                confirmation = true,
                callback = function()
                    window:Fade()
                end
            }
        )

    end

    local other_section = settings_page:Section({name = "Other", side = "Right"})
    do
        other_section:Button(
            {
                name = "Copy JobId",
                callback = function()
                    setclipboard(game.JobId)
                end
            }
        )
        other_section:Button(
            {
                name = "Copy GameID",
                callback = function()
                    setclipboard(game.GameId)
                end
            }
        )
        other_section:Button(
            {
                name = "Copy Game Invite",
                callback = function()
                    setclipboard(
                        "Roblox.GameLauncher.joinGameInstance(" .. game.PlaceId .. ',"' .. game.JobId .. '")'
                    )
                end
            }
        )
        other_section:Button(
            {
                name = "Rejoin",
                confirmation = true,
                callback = function()
                    m_game:teleport(game.PlaceId, game.JobId)
                end
            }
        )

        other_section:Button(
            {
                name = "test",
                confirmation = true,
                callback = function()
                    Window.notificationlist:AddNotification({text = "no.regrets loaded. have fun"})
                end
            }
        )
    end

    local themes_section = settings_page:Section({name = "Themes", side = "Right"})
    do

        themes_section:Dropdown(
            {
                Name = "Theme",
                Options = {"Default", "Abyss", "Spotify", "np.rip", "AimWare", "Mint", "Ubuntu", "Bitch Bot", "BubbleGum", "Slime"},
                Default = "Default",
                Pointer = "themes/xd/",
                callback = function(callback)
                    if callback == "Default" then
                        library:UpdateColor("Accent", Color3.fromRGB(189, 182, 240))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(30, 30, 30))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(25, 25, 25))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Spotify" then
                        library:UpdateColor("Accent", Color3.fromRGB(103, 212, 91))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(30, 30, 30))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(25, 25, 25))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "AimWare" then
                        library:UpdateColor("Accent", Color3.fromRGB(250, 47, 47))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(41, 40, 40))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(38, 38, 38))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "np.rip" then
                        library:UpdateColor("Accent", Color3.fromRGB(242, 150, 92))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(22, 12, 46))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(17, 8, 31))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "Abyss" then
                        library:UpdateColor("Accent", Color3.fromRGB(81, 72, 115))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(41, 41, 41))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(31, 30, 30))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Mint" then
                        library:UpdateColor("Accent", Color3.fromRGB(0, 255, 139))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(20, 20, 20))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(20, 20, 20))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Ubuntu" then
                        library:UpdateColor("Accent", Color3.fromRGB(226, 88, 30))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(62,62,62))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(50, 50, 50))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "Bitch Bot" then
                        library:UpdateColor("Accent", Color3.fromRGB(126,72,163))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(62,62,62))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(50, 50, 50))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(50, 50, 50))
                    elseif callback == "BubbleGum" then
                      library:UpdateColor("Accent", Color3.fromRGB(169, 83, 245))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(22, 12, 46))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(17, 8, 31))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    elseif callback == "Slime" then
                        
                           library:UpdateColor("Accent", Color3.fromRGB(64, 247, 141))
                        library:UpdateColor("lightcontrast", Color3.fromRGB(22, 12, 46))
                        library:UpdateColor("darkcontrast", Color3.fromRGB(17, 8, 31))
                        library:UpdateColor("outline", Color3.fromRGB(0, 0, 0))
                        library:UpdateColor("inline", Color3.fromRGB(46, 46, 46))
                    end
                end
            }
        )

        themes_section:Dropdown(
            {
                Name = "Accent Effects",
                Options = {"Rainbow", "Fade", "Disguard Fade", "Disguard Rainbow"},
                Default = "None",
                Pointer = "themes/xd/",
                callback = function(callback)
                    if callback == "Rainbow" then
                        if callback then

                            ching =
                                game:GetService("RunService").Heartbeat:Connect(
                                    function()
                                        chings:Disconnect()
                                        library:UpdateColor("Accent", Color3.fromHSV(tick() % 5 / 5, 1, 1))
                                    end
                                )
                        else
                            if ching then
                                ching:Disconnect()
                            end
                        end

                    elseif callback == "Disguard Rainbow" then
                        ching:Disconnect()


                    elseif callback == "Disguard Fade" then

                        chings:Disconnect()

                    elseif callback == "Fade" then
                        if callback then

                            chings =
                                game:GetService("RunService").Heartbeat:Connect(
                                    function()
                                        ching:Disconnect()
                                        local r = (math.sin(workspace.DistributedGameTime/2)/2)+0.5
                                        local g = (math.sin(workspace.DistributedGameTime)/2)+0.5
                                        local b = (math.sin(workspace.DistributedGameTime*1.5)/2)+0.5
                                        local color = Color3.new(r, g, b)
                                        library:UpdateColor("Accent", color)
                                    end
                                )
                        else
                            if chings then
                                chings:Disconnect()
                            end
                        end

                    end
                end
            }
        )
        themes_section:Slider(
            {
                Name = "Switch Speed",
                Minimum = 0,
                Maximum = 10,
                Default = 1,
                Decimals = .1,
                suffix = "",
                Pointer = "reload delay",
                callback = function(a)
                end
            }
        )

        themes_section:Colorpicker(
            {
                pointer = "themes/menu/accent",
                name = "Accent",
                default = Color3.fromRGB(100, 61, 200),
                callback = function(p_state)
                    library:UpdateColor("Accent", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Light Contrast",
                default = Color3.fromRGB(30, 30, 30),
                callback = function(p_state)
                    library:UpdateColor("lightcontrast", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Dark Constrast",
                default = Color3.fromRGB(25, 25, 25),
                callback = function(p_state)
                    library:UpdateColor("darkcontrast", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Outline",
                default = Color3.fromRGB(0, 0, 0),
                callback = function(p_state)
                    library:UpdateColor("outline", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Inline",
                default = Color3.fromRGB(50, 50, 50),
                callback = function(p_state)
                    library:UpdateColor("inline", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Text Color",
                default = Color3.fromRGB(255, 255, 255),
                callback = function(p_state)
                    library:UpdateColor("textcolor", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Text Border",
                default = Color3.fromRGB(0, 0, 0),
                callback = function(p_state)
                    library:UpdateColor("textborder", p_state)
                end
            }
        )
        themes_section:Colorpicker(
            {
                pointer = "settings/menu/accent",
                name = "Cursor Outline",
                default = Color3.fromRGB(10, 10, 10),
                callback = function(p_state)
                    library:UpdateColor("cursoroutline", p_state)
                end
            }
        )
    end
end
window.uibind = Enum.KeyCode.End
window:Initialize()
end


