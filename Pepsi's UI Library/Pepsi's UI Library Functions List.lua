Library v0.32 [
   CreateWindow: Function (
       (table | nil) Options [
           (string | nil) Name = "Window Name"
           (JSON | nil) DefaultTheme/Theme = "[...]"
           (boolean | nil) Themeable/DefaultTheme/Theme = true or false | Options [
               (string | number | nil) Image = "rbxassetid://7483871523" | 7483871523
               (boolean | nil) Credit = true or false // You're removing my credits? Kinda hurts.
               (string | table | nil) Info = "Extra info displayed in designer" | Lines ["line 1", "line 2", "line 3", "and so on..."]
(string | number | table | nil) Background/Backdrop/Grahpic = "rbxassetid://13337" | 13337 | Options [
(string | number | nil) 1/Asset = "rbxassetid://13337" | 13337
(number | nil) 2/Transparency = 0.5 | 50 // Both examples will make the backdrop half visible
(boolean | number | nil) 3/Visible = true or false | 1 or 0 // 1: true, 0: false
]
           ]
       ]
   ) -> Window [
       CreateTab: Function (
           (table | nil) Options [
               (string | nil) Name = "Tab Name"
               (string | number | nil) Image = "rbxassetid://133337" | 133337
           ]
       ) -> Tab [
           CreateSection: Function (
               (table) Options [
                   (string | nil) Name = "Section Name"
                   (string | nil) Side = "Left" or "Right"
               ]
           ) -> Section [
               AddLabel: Function (
                   (table) Options [
                       (string | nil) Text/Value/Name = "Label Text"
                       (string | nil) Flag = "FlagName"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                   ]
               ) -> Label [
                   Options: Table
                   Name: String
                   Type: String
                   Default: String
                   Parent: Section
                   Instance: Instance
                   Set: Function (NewText) -> NewText
RawSet: Function (NewText) -> NewText // Same function as Set. For backwards compatibility.
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentText
Update: Function -> CurrentText // Same function as Get, exists for compat.
               ]
               AddToggle: Function (
                   (table) Options [
                       (string) Name = "Toggle Name"
                       (boolean | nil) Value/Enabled = true or false
                       (function | nil) Callback = Function (NewValue, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (boolean | nil) Locked = true or false
                       (table | boolean | EnumItem | nil) Keybind/Key/KeyBind = Keybind [
                           (string | nil) Flag = "ToggleKeybindFlag"
                           (EnumItem | nil) Value = Enum.KeyCode.F
                           (function | nil) Callback = Function (NewValue, OldValue)
                           (function | nil) Pressed = Function
                           (string | nil) Mode = "Dynamic" or "Hold" or "Toggle"
                           (number | nil) DynamicTime = 0.65
                           (table | nil) Location = Table
                           (string | nil) LocationFlag = "LocationFlag"
                           (table | nil) KeyNames = Table
                       ]
                       (function | nil) Condition = Function (NewValue, LastValue) // Will only allow the toggle state to be changed, if this function returns true
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> ToggleInfo [
                   Options: Table
                   Type: String
                   Name: String
                   Default: Boolean
                   Parent: Section
                   Instance: Instance
                   SetLocked: Function (LockedState) -> LockState
                   Unlock: function
                   Lock: Function
                   Update: Function -> CurrentValue
                   Set: Function (NewValue) -> NewValue
                   RawSet: Function (NewValue, Condition) -> NewValue // Sets the flag without firing the callback
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
                   SetCondition: Function (NewCondition) -> NewCondition
               ]
               AddTextbox: Function (
                   (table) Options [
                       (string) Name = "Textbox Name"
                       (string | number) Value = "String" or 1337
                       (function | nil) Callback = Function (NewValue, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (string | nil) Placeholder = "Text to display by default"
                       (string | nil) Type = "number"
                       (number | nil) Min = 0
                       (number | nil) Max = 100
                       (number | nil) Decimals/Precision/Precise = 2
                       (boolean | nil) Hex = true or false
                       (boolean | nil) Binary = true or false
                       (number | nil) Base = 10
                       (boolean | nil) Rich/RichText/RichTextBox = true or false
                       (boolean | nil) Lines/MultiLine = true or false
                       (boolean | nil) Scaled/TextScaled = true or false
                       (EnumItem | nil) Font/TextFont = Enum.Font.Code
                       (function | nil) PreFormat = Function (Value)
                       (function | nil) PostFormat = Function (Value)
                       (table | nil) CustomProperties = Properties [
                        TextTruncate = Enum.TextTruncate.None
                       ]
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Textbox [
                   Options: Table
                   Name: String
                   Type: String
                   Default: String/Number
                   Parent: Section
                   Instance: Textbox
                   Update: Function -> CurrentValue
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets the flag without firing the callback
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
               ]
               AddSlider: Function (
                   (table) Options [
                       (string) Name = "Slider Name"
                       (number | nil) Value = 0
                       (function | nil) Callback = Function (Value, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (number) Min = 0
                       (number) Max = 100
                       (number | nil) Decimals/Precision/Precise = 2
                       (string | function | nil) Format = "Value %s" | Function (Value, LastValue)
                       (boolean | nil) IllegalInput = true or false // Allow textbox to break min & max limits
                       (boolean | table | nil) Textbox/InputBox/CustomInput = true | Options [
                           (boolean | nil) Hex = true or false
                           (boolean | nil) Binary = true or false
                           (number | nil) Base = 10
                           (function | nil) PreFormat = Function (Value)
                           (function | nil) PostFormat = Function (Value)
                           (boolean | nil) IllegalInput = true or false // Allow textbox to break min & max limits
                       ]
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Slider [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Number
                   Parent: Section
                   Instance: Instance
                   Update: Function (FromValue) -> CurrentValue
                   Set: Function (NewValue) -> NewValue
                RawSet: Function (NewValue) -> NewValue // Changes value without firing callback
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
                   SetConstraints: Function (NewMin, NewMax)
                   SetMin: Function (NewMin)
                   SetMax: Function (NewMax)
               ]
               AddButton: Function (
                   (table) Options [
                       (string) Name = "Button Name"
                       (function | nil) Callback = Function (NumPresses)
(boolean | nil) Locked = true or false
(function | nil) Condition = Function (NumPresses) // Will only allow the button to be pressed, if this function returns true
                   ]
                   (table | nil) Options ...
               ) -> Buttons [
                   Options: Table
                   Name: String
                   Type: String
                   Parent: Section
                   Instance: Instance
                   Update: Function -> ButtonName
                   Press: Function (...)
                   SetLocked: Function (LockedState) -> LockState
                   Unlock: function
                   Lock: Function
SetCondition: Function(NewCondition) -> NewCondition
RawPress: Function (...) // Does not update press count
                   Get: Function -> Callback, NumPresses
SetText: Function (NewText) -> NewText
SetCallback: Function (NewCallback) -> NewCallback
               ]
               AddKeybind: Function (
                   (table) Options [
                       (string) Name = "Keybind Name"
                       (EnumItem | nil) Value = Enum.KeyCode.F
                       (function | nil) Callback = Function (NewValue, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (function | nil) Pressed = Function (InputObject, GameProcessed)
                       (table | nil) KeyNames = Table
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Keybind [
                   Options: Table
                   Name: String
                   Type: String
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
               ]
               AddDropdown: Function (
                   (table) Options [
                       (string) Name = "Dropdown Name"
                       (any) Value = Value
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (table | Instance | Enum) List = Table | workspace | Enum.Font
                       (string | function | table | nil) Filter = "StringToMatch" | Function (ValueToCheck) | Table [
                           (boolean | nil) [0] = InverseBool
                           (any) [1] ... = "StringToMatch" | Enum.Font.Code/ValuesToMatch
                       ]
                       (string | function | table | nil) Method = "GetDescendants" | workspace.GetDescendants | Parameters [
                        (string | function) [1/Method] = "GetFriendsOnline" | Player.GetFriendsOnline
                        (any) [1/2/Args/Arguments] ... = 50
                       ]
                       (string | nil) BlankValue/NoValueString/Nothing = "No Selection"
                       (boolean | function | nil) Sort = true or false | Function
                       (boolean | string | nil) Multi/Multiple/MultiSelect = true or false | "Text to display"
                       (function | nil) ItemAdded/AddedCallback = Function (Item, AllItems)
                       (function | nil) ItemRemoved/RemovedCallback = Function (Item, AllItems)
                       (function | nil) ItemChanged/ChangedCallback = Function (Item, SelectedState, Items)
                       (function | nil) ItemsCleared/ClearedCallback = Function (Items, PreviousItems)
(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Dropdown [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Value
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultValue
                   Get: Function -> CurrentValue
                   UpdateList: Function (
                    (table | Instance | Enum) List = Table | workspace | Enum.Font
                    (boolean | nil) ValidateValues = true or false | nil // When set to true, will call Validate() on it
                   ) -> NewList
                   Validate: Function (
                    (any | nil) InvalidValue = "Optional value to be set, if the list's current value is no longer in list"
                   ) -> IsValidBool
               ]
               AddSearchBox: Function (
                   (table) Options [
                       (string) Name = "SearchBox Name"
                       (any) Value = Value
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (table | Instance | Enum) List = Table | workspace | Enum.Font
                       (string | function | table | nil) Filter = "StringToMatch" | Function (ValueToCheck) | Table [
                           (boolean | nil) [0] = InverseBool
                           (string | any | nil) [1] ... = "StringToMatch" | Enum.Font.Code
                       ]
                       (string | function | table | nil) Method = "GetDescendants" | workspace.GetDescendants | Parameters [
                        (string | function) [1/Method] = "GetFriendsOnline" | Player.GetFriendsOnline
                        (any) [1/2/Args/Arguments] ... = 50
                       ]
                       (boolean | function | nil) Sort = true or false | Function
                       (string | nil) BlankValue/NoValueString/Nothing = "No Selection"
                       (boolean | string | nil) Multi/Multiple/MultiSelect = true or false | "Text to display"
                       (function | nil) ItemAdded/AddedCallback = Function (Item, AllItems)
                       (function | nil) ItemRemoved/RemovedCallback = Function (Item, AllItems)
                       (function | nil) ItemChanged/ChangedCallback = Function (Item, SelectedState, Items)
                       (function | nil) ItemsCleared/ClearedCallback = Function (Items, PreviousItems)
(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
(boolean | nil) RegEx = true or false // Enables use of %d and %w, etc (False by default)
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> SearchBox [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Value
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultValue
                   Get: Function -> CurrentValue
                   UpdateList: Function (
                    (table | Instance | Enum) List = Table | workspace | Enum.Font
                    (boolean | nil) ValidateValues = true or false | nil // When set to true, will call Validate() on it
                   ) -> NewList
                   Validate: Function (
                    (any | nil) InvalidValue = "Optional value to be set, if the list's current value is no longer in list"
                   ) -> IsValidBool
               ]
               AddColorpicker: Function (
                   (table) Options [
                       (string) Name = "Colorpicker Name"
                       (string | Color3 | nil) Value = "rainbow" or "random" | Color3.new()
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (boolean | nil) Rainbow = true or false
                       (boolean | nil) Random = true or false
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Colorpicker [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Color3
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultColor
                   Get: Function -> CurrentValue
                   SetRainbow: Function (
                       (boolean | nil) RainbowMode = true or false
                   )
               ]
               AddPersistence: Function (
                   (table) Options [
                       (string) Name = "Persistence Name"
                       (string | nil) Value = "FileName"
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (string | nil) Workspace = "FolderName"
                       (boolean | string | number | table | nil) Persistive/Flags = true | "all" | 1 (Window) or 2 (Tab) or 3 (Section) | FlagNames [...]
                       (string | nil) Suffix = "Mods"
                       (function | nil) LoadCallback = Function (FilePath, FileName) // 'PreLoad'
                       (function | nil) SaveCallback = Function (FilePath, FileName)
                       (function | nil) PostLoadCallback = Function (FilePath, FileName)
                       (function | nil) PostSaveCallback = Function (FilePath, FileName)
(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Persistence [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Value
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultFile
                   Get: Function -> CurrentValue
SaveFile: Function (FileName) // Mimics the Save Button with optional file input
LoadFile: Function (FileName) // Mimics the Load Button with optional file input
LoadJSON: Function (JSON) // Mimics the Load Button with specific json
LoadFileRaw: Function (FileName) // Mimics the Load Button with optional file input using Obj:RawSet
LoadJSONRaw: Function (JSON) // Mimics the Load Button with specific json using Obj:RawSet
GetJSON: Function (Func) // Gets the json, and passes it as the first argument of Func. Set to true to use setclipboard
               ]
           ]
           Flags: Table
       ]
       CreateDesigner: Function (
           (table) Options [
(string | number | table | nil) Background/Backdrop/Grahpic = "rbxassetid://13337" | 13337 | Options [
(string | number | nil) 1/Asset = "rbxassetid://13337" | 13337
(number | nil) 2/Transparency = 0.5 | 50 // Both examples will make the backdrop half visible
(boolean | number | nil) 3/Visible = true or false | 1 or 0 // 1: true, 0: false
]
               (string | number | nil) Image = "rbxassetid://7483871523" | 7483871523
               (string | table | nil) Info = "Extra info displayed in designer" | Lines ["line 1", "line 2", "line 3", "and so on..."]
               (boolean | nil) Credit = true
           ]
       ) -> Designer [
           Options: Table
           Parent: Window
           Name: String
           Type: String
           Instance: Instance,
           SetBackground: Function (
            (string | boolean | number | nil) AssetString = "rbxassetid://7483871523" | true or false (as Visible arg) | 7483871523 or transparency (0-100 or 0-1) | nil (Toggle visibility)
            (number | boolean | nil) Transparency = 0.7 or 70 | true or false (as Visible arg)
            (number | boolean | nil) Visible = true/1 or false/0 | nil (Dont change)
           )
       ]
       MoveTabSlider: Function (
           (Instance) tabObject = tabVar
       )
       GoHome: Function
       Flags: Table
   ]
   Designer: Designer
   LP: LocalPlayer
   Players: game.Players
   Mouse: LP:GetMouse()
   Unload: Function
ResetAll: Function // Resets all elements to their default value
SaveFile: Function (FileName) // Only if designer is present; this would save all non-deisgner elements
LoadFile: Function (FileName)
LoadJSON: Function (JSON)
LoadFileRaw: Function (FileName)
LoadJSONRaw: Function (JSON)
GetJSON: Function (Func)
signals: Table // All :connection()'s go in that table, and are disconnected upon unloading the gui. Feel free to add yours here, too
   (function | nil) UnloadCallback = Function
(EnumItem/Keycode | nil) scrollupbutton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) scrolldownbutton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
   Subs: Shared Functions [
updatecolors: Function // Re-Applys all colors from designer
Wait: Function (Time) // Only waits & returns true if the library has not been unloaded
removeSpaces: Function (String)
Color3ToHex: Function (Color3)
Color3FromHex: Function (String/Hex)
textToSize: Function (String)
Instance_new: Function (Class, Parent) // Automatically protects instances with syn.protect_gui, and adds the instance to library.objects (all objects destroyed when unloading)
   ]
]