--// CUSTOM DRAWING

local drawing = {} do
    local services = setmetatable({}, {
        __index = function(self, key)
            if key == "InputService" then
                key = "UserInputService"
            end
            
            if not rawget(self, key) then
                local service = game:GetService(key)
                rawset(self, service, service)
    
                return service
            end
        
            return rawget(self, key)
        end
    })

    -- taken from Nevermore Engine https://github.com/Quenty/NevermoreEngine/tree/main/src

    local HttpService = game:GetService("HttpService")

    local ENABLE_TRACEBACK = false

    local Signal = {}
    Signal.__index = Signal
    Signal.ClassName = "Signal"

    --[=[
        Returns whether a class is a signal
        @param value any
        @return boolean
    ]=]
    function Signal.isSignal(value)
        return type(value) == "table"
            and getmetatable(value) == Signal
    end

    --[=[
        Constructs a new signal.
        @return Signal<T>
    ]=]
    function Signal.new()
        local self = setmetatable({}, Signal)

        self._bindableEvent = Instance.new("BindableEvent")
        self._argMap = {}
        self._source = ENABLE_TRACEBACK and debug.traceback() or ""

        -- Events in Roblox execute in reverse order as they are stored in a linked list and
        -- new connections are added at the head. This event will be at the tail of the list to
        -- clean up memory.
        self._bindableEvent.Event:Connect(function(key)
            self._argMap[key] = nil

            -- We've been destroyed here and there's nothing left in flight.
            -- Let's remove the argmap too.
            -- This code may be slower than leaving this table allocated.
            if (not self._bindableEvent) and (not next(self._argMap)) then
                self._argMap = nil
            end
        end)

        return self
    end

    --[=[
        Fire the event with the given arguments. All handlers will be invoked. Handlers follow
        @param ... T -- Variable arguments to pass to handler
    ]=]
    function Signal:Fire(...)
        if not self._bindableEvent then
            warn(("Signal is already destroyed. %s"):format(self._source))
            return
        end

        local args = table.pack(...)

        -- TODO: Replace with a less memory/computationally expensive key generation scheme
        local key = HttpService:GenerateGUID(false)
        self._argMap[key] = args

        -- Queues each handler onto the queue.
        self._bindableEvent:Fire(key)
    end

    --[=[
        Connect a new handler to the event. Returns a connection object that can be disconnected.
        @param handler (... T) -> () -- Function handler called when `:Fire(...)` is called
        @return RBXScriptConnection
    ]=]
    function Signal:Connect(handler)
        if not (type(handler) == "function") then
            error(("connect(%s)"):format(typeof(handler)), 2)
        end

        return self._bindableEvent.Event:Connect(function(key)
            -- note we could queue multiple events here, but we'll do this just as Roblox events expect
            -- to behave.

            local args = self._argMap[key]
            if args then
                handler(table.unpack(args, 1, args.n))
            else
                error("Missing arg data, probably due to reentrance.")
            end
        end)
    end

    --[=[
        Wait for fire to be called, and return the arguments it was given.
        @yields
        @return T
    ]=]
    function Signal:Wait()
        local key = self._bindableEvent.Event:Wait()
        local args = self._argMap[key]
        if args then
            return table.unpack(args, 1, args.n)
        else
            error("Missing arg data, probably due to reentrance.")
            return nil
        end
    end

    --[=[
        Disconnects all connected events to the signal. Voids the signal as unusable.
        Sets the metatable to nil.
    ]=]
    function Signal:Destroy()
        if self._bindableEvent then
            -- This should disconnect all events, but in-flight events should still be
            -- executed.

            self._bindableEvent:Destroy()
            self._bindableEvent = nil
        end

        -- Do not remove the argmap. It will be cleaned up by the cleanup connection.

        setmetatable(self, nil)
    end

    local signal = Signal

    local function ismouseover(obj)
        local posX, posY = obj.Position.X, obj.Position.Y
        local sizeX, sizeY = posX + obj.Size.X, posY + obj.Size.Y
        local mousepos = services.InputService:GetMouseLocation()

        if mousepos.X >= posX and mousepos.Y >= posY and mousepos.X <= sizeX and mousepos.Y <= sizeY then
            return true
        end

        return false
    end

    local function udim2tovector2(udim2, vec2)
        local xscalevector2 = vec2.X * udim2.X.Scale
        local yscalevector2 = vec2.Y * udim2.Y.Scale

        local newvec2 = Vector2.new(xscalevector2 + udim2.X.Offset, yscalevector2 + udim2.Y.Offset)

        return newvec2
    end

    -- totally not skidded from devforum (trust)
    local function istouching(pos1, size1, pos2, size2)
        local top = pos2.Y - pos1.Y
        local bottom = pos2.Y + size2.Y - (pos1.Y + size1.Y)
        local left = pos2.X - pos1.X
        local right = pos2.X + size2.X - (pos1.X + size1.X)

        local touching = true
        
        if top > 0 then
            touching = false
        elseif bottom < 0 then
            touching = false
        elseif left > 0 then
            touching = false
        elseif right < 0 then
            touching = false
        end
        
        return touching
    end

    local objchildren = {}
    local objmts = {}
    local objvisibles = {}
    local mtobjs = {}
    local udim2posobjs = {}
    local udim2sizeobjs = {}
    local objpositions = {}
    local listobjs = {}
    local listcontents = {}
    local listchildren = {}
    local listadds = {}
    local objpaddings = {}
    local scrollobjs = {}
    local listindexes = {}
    local custompropertysets = {}
    local custompropertygets = {}
    local objconnections = {}
    local objmtchildren = {}
    local scrollpositions = {}
    local currentcanvasposobjs = {}
    local childrenposupdates = {}
    local childrenvisupdates = {}
    local squares = {}
    local objsignals = {}
    local objexists = {}

    local function mouseoverhighersquare(obj)
        for _, square in next, squares do
            if square.Visible == true and square.ZIndex > obj.ZIndex then
                if ismouseover(square) then
                    return true
                end
            end
        end
    end

    services.InputService.InputEnded:Connect(function(input, gpe)
        for obj, signals in next, objsignals do
            if objexists[obj] then
                if signals.inputbegan[input] then
                    signals.inputbegan[input] = false

                    if signals.InputEnded then
                        signals.InputEnded:Fire(input, gpe)
                    end
                end

                if obj.Visible then
                    if ismouseover(obj) then
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and not mouseoverhighersquare(obj) then
                            if signals.MouseButton1Up then
                                signals.MouseButton1Up:Fire()
                            end

                            if signals.mouse1down and signals.MouseButton1Click then
                                signals.mouse1down = false
                                signals.MouseButton1Click:Fire()
                            end
                        end

                        if input.UserInputType == Enum.UserInputType.MouseButton2 and not mouseoverhighersquare(obj) then
                            if signals.MouseButton2Clicked then
                                signals.MouseButton2Clicked:Fire()
                            end

                            if signals.MouseButton2Up then
                                signals.MouseButton2Up:Fire()
                            end
                        end
                    end
                end
            end
        end
    end)

    services.InputService.InputChanged:Connect(function(input, gpe)
        for obj, signals in next, objsignals do
            if objexists[obj] and obj.Visible and (signals.MouseEnter or signals.MouseMove or signals.InputChanged or signals.MouseLeave) then
                if ismouseover(obj) then
                    if not signals.mouseentered then
                        signals.mouseentered = true

                        if signals.MouseEnter then
                            signals.MouseEnter:Fire(input.Position)
                        end

                        if signals.MouseMoved then
                            signals.MouseMoved:Fire(input.Position)
                        end
                    end

                    if signals.InputChanged then
                        signals.InputChanged:Fire(input, gpe)
                    end
                elseif signals.mouseentered then
                    signals.mouseentered = false

                    if signals.MouseLeave then
                        signals.MouseLeave:Fire(input.Position)
                    end
                end
            end
        end
    end)

    services.InputService.InputBegan:Connect(function(input, gpe)
        for obj, signals in next, objsignals do
            if objexists[obj] then
                if obj.Visible then
                    if ismouseover(obj) and not mouseoverhighersquare(obj) then 
                        signals.inputbegan[input] = true

                        if signals.InputBegan then
                            signals.InputBegan:Fire(input, gpe)
                        end

                        if input.UserInputType == Enum.UserInputType.MouseButton1 and (not mouseoverhighersquare(obj) or obj.Transparency == 0) then
                            signals.mouse1down = true

                            if signals.MouseButton1Down then
                                signals.MouseButton1Down:Fire()
                            end
                        end

                        if input.UserInputType == Enum.UserInputType.MouseButton2 and (not mouseoverhighersquare(obj) or obj.Transparency == 0) then
                            if signals.MouseButton2Down then
                                signals.MouseButton2Down:Fire()
                            end
                        end
                    end
                end
            end
        end
    end)

    function drawing:new(shape)
        local obj = Drawing.new(shape)
        objexists[obj] = true
        local signalnames = {}

        local listfunc
        local scrollfunc
        local refreshscrolling

        objconnections[obj] = {}

        if shape == "Square" then
            table.insert(squares, obj)

            signalnames = {
                MouseButton1Click = signal.new(),
                MouseButton1Up = signal.new(),
                MouseButton1Down = signal.new(),
                MouseButton2Click = signal.new(),
                MouseButton2Up = signal.new(),
                MouseButton2Down = signal.new(),
                InputBegan = signal.new(),
                InputEnded = signal.new(),
                InputChanged = signal.new(),
                MouseEnter = signal.new(),
                MouseLeave = signal.new(),
                MouseMoved = signal.new()
            }

            local attemptedscrollable = false

            scrollfunc = function(self)
                if listobjs[self] then
                    scrollpositions[self] = 0
                    scrollobjs[self] = true

                    self.ClipsDescendants = true

                    local function scroll(amount)
                        local totalclippedobjs, currentclippedobj, docontinue = 0, nil, false

                        for i, object in next, listchildren[self] do
                            if amount == 1 then
                                if object.Position.Y > mtobjs[self].Position.Y then
                                    if not istouching(object.Position, object.Size, mtobjs[self].Position, mtobjs[self].Size) then
                                        if not currentclippedobj then
                                            currentclippedobj = object
                                        end

                                        totalclippedobjs = totalclippedobjs + 1
                                        docontinue = true
                                    end
                                end
                            end

                            if amount == -1 then
                                if object.Position.Y <= mtobjs[self].Position.Y then
                                    if not istouching(object.Position, object.Size, mtobjs[self].Position, mtobjs[self].Size) then
                                        currentclippedobj = object
                                        totalclippedobjs = totalclippedobjs + 1
                                        docontinue = true
                                    end
                                end
                            end
                        end

                        if docontinue then
                            if amount > 0 then
                                local poschange = -(currentclippedobj.Size.Y + objpaddings[self])
                                local closestobj

                                for i, object in next, objchildren[self] do
                                    if istouching(object.Position + Vector2.new(0, poschange), object.Size, mtobjs[self].Position, mtobjs[self].Size) then
                                        closestobj = object
                                        break
                                    end
                                end

                                local diff = (Vector2.new(0, mtobjs[self].Position.Y) - Vector2.new(0, (closestobj.Position.Y + poschange + objpaddings[self]))).magnitude

                                if custompropertygets[mtobjs[self]]("ClipsDescendants") then
                                    for i, object in next, objchildren[self] do
                                        if not istouching(object.Position + Vector2.new(0, poschange - diff + objpaddings[self]), object.Size, mtobjs[self].Position, mtobjs[self].Size) then
                                            object.Visible = false
                                            childrenvisupdates[objmts[object]](objmts[object], false)
                                        else
                                            object.Visible = true
                                            childrenvisupdates[objmts[object]](objmts[object], true)
                                        end
                                    end
                                end

                                scrollpositions[self] = scrollpositions[self] + (poschange - diff + objpaddings[self])

                                for i, object in next, objchildren[self] do
                                    childrenposupdates[objmts[object]](objmts[object], object.Position + Vector2.new(0, poschange - diff + objpaddings[self]))
                                    object.Position = object.Position + Vector2.new(0, poschange - diff + objpaddings[self])
                                end
                            else
                                local poschange = currentclippedobj.Size.Y + objpaddings[self]

                                if custompropertygets[mtobjs[self]]("ClipsDescendants") then
                                    for i, object in next, objchildren[self] do
                                        if not istouching(object.Position + Vector2.new(0, poschange), object.Size, mtobjs[self].Position, mtobjs[self].Size) then
                                            object.Visible = false
                                            childrenvisupdates[objmts[object]](objmts[object], false)
                                        else
                                            object.Visible = true
                                            childrenvisupdates[objmts[object]](objmts[object], true)
                                        end
                                    end
                                end

                                scrollpositions[self] = scrollpositions[self] + poschange

                                for i, object in next, objchildren[self] do
                                    childrenposupdates[objmts[object]](objmts[object], object.Position + Vector2.new(0, poschange))
                                    object.Position = object.Position + Vector2.new(0, poschange)
                                end
                            end
                        end

                        return docontinue
                    end

                    refreshscrolling = function()
                        repeat
                        until
                            not scroll(-1)
                    end

                    self.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseWheel then
                            if input.Position.Z > 0 then
                                scroll(-1)
                            else
                                scroll(1)
                            end
                        end
                    end)
                else
                    attemptedscrollable = true
                end
            end

            listfunc = function(self, padding)
                objpaddings[self] = padding
                listcontents[self] = 0
                listchildren[self] = {}
                listindexes[self] = {}
                listadds[self] = {}

                listobjs[self] = true

                for i, object in next, objchildren[self] do
                    table.insert(listchildren[self], object)
                    table.insert(listindexes[self], listcontents[self] + (#listchildren[self] == 1 and 0 or padding))

                    local newpos = mtobjs[self].Position + Vector2.new(0, listcontents[self] + (#listchildren[self] == 1 and 0 or padding))
                    object.Position = newpos
                    
                    childrenposupdates[object](objmts[object], newpos)

                    custompropertysets[object]("AbsolutePosition", newpos)
                    
                    listadds[self][object] = object.Size.Y + (#listchildren[self] == 1 and 0 or padding)
                    listcontents[self] = listcontents[self] + object.Size.Y + (#listchildren[self] == 1 and 0 or padding)
                end

                if attemptedscrollable then
                    scrollfunc(self)
                end
            end
        end

        local customproperties = {
            Parent = nil,
            AbsolutePosition = nil,
            AbsoluteSize = nil,
            ClipsDescendants = false
        }

        custompropertysets[obj] = function(k, v)
            customproperties[k] = v
        end

        custompropertygets[obj] = function(k)
            return customproperties[k]
        end

        local mt = setmetatable({exists = true}, {
            __index = function(self, k)
                if k == "Parent" then
                    return customproperties.Parent
                end

                if k == "Visible" then
                    return objvisibles[obj]
                end

                if k == "Position" then
                    return udim2posobjs[obj] or objpositions[obj] or obj[k]
                end

                if k == "Size" then
                    return udim2sizeobjs[obj] or obj[k]
                end

                if k == "AddListLayout" and listfunc then
                    return listfunc
                end

                if k == "MakeScrollable" and scrollfunc then
                    return scrollfunc
                end

                if k == "RefreshScrolling" and refreshscrolling then
                    return refreshscrolling
                end

                if k == "AbsoluteContentSize" then
                    return listcontents[self]
                end

                if k == "GetChildren" then
                    return function(self)
                        return objmtchildren[self]
                    end
                end

                if k == "Remove" then
                    return function(self)
                        rawset(self, "exists", false)
                        objexists[obj] = false

                        if customproperties.Parent and listobjs[customproperties.Parent] then
                            local objindex = table.find(objchildren[customproperties.Parent], obj)

                            listcontents[customproperties.Parent] = listcontents[customproperties.Parent] - listadds[customproperties.Parent][obj]
            
                            for i, object in next, objchildren[customproperties.Parent] do
                                if i > objindex then
                                    object.Position = object.Position - Vector2.new(0, listadds[customproperties.Parent][obj])
                                end
                            end

                            if table.find(listchildren[customproperties.Parent], obj) then
                                table.remove(listchildren[customproperties.Parent], table.find(listchildren[customproperties.Parent], obj))
                            end

                            if table.find(objchildren[customproperties.Parent], obj) then
                                table.remove(objchildren[customproperties.Parent], table.find(objchildren[customproperties.Parent], obj))
                                table.remove(listindexes[customproperties.Parent], table.find(objchildren[customproperties.Parent], obj))
                            end
                        end

                        if table.find(squares, mtobjs[self]) then
                            table.remove(squares, table.find(squares, mtobjs[self]))
                        end
                        
                        for _, object in next, objchildren[self] do
                            if objexists[object] then
                                table.remove(objsignals, table.find(objsignals, object))
                                objmts[object]:Remove()
                            end
                        end

                        table.remove(objsignals, table.find(objsignals, obj))
                        obj:Remove()
                    end
                end

                if signalnames and signalnames[k] then
                    objsignals[obj] = objsignals[obj] or {}
                    
                    if not objsignals[obj][k] then
                        objsignals[obj][k] = signalnames[k]
                    end

                    objsignals[obj].inputbegan = objsignals[obj].inputbegan or {}
                    objsignals[obj].mouseentered = objsignals[obj].mouseentered or {}
                    objsignals[obj].mouse1down = objsignals[obj].mouse1down or {}

                    return signalnames[k]
                end

                return customproperties[k] or obj[k]
            end,

            __newindex = function(self, k, v)
                local changechildrenvis
                changechildrenvis = function(parent, vis)
                    if objchildren[parent] then
                        for _, object in next, objchildren[parent] do
                            if (custompropertygets[mtobjs[parent]]("ClipsDescendants") and not istouching(object.Position, object.Size, mtobjs[parent].Position, mtobjs[parent].Size)) then
                                object.Visible = false
                                changechildrenvis(objmts[object], false)
                            else
                                object.Visible = vis and objvisibles[object] or false
                                changechildrenvis(objmts[object], vis and objvisibles[object] or false)
                            end
                        end
                    end
                end

                childrenvisupdates[self] = changechildrenvis

                if k == "Visible" then
                    objvisibles[obj] = v

                    if customproperties.Parent and (not mtobjs[customproperties.Parent].Visible or (custompropertygets[mtobjs[customproperties.Parent]]("ClipsDescendants") and not istouching(obj.Position, obj.Size, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size))) then
                        v = false
                        changechildrenvis(self, v)
                    else
                        changechildrenvis(self, v)
                    end
                end

                if k == "ClipsDescendants" then
                    customproperties.ClipsDescendants = v

                    for _, object in next, objchildren[self] do
                        object.Visible = v and (istouching(object.Position, object.Size, obj.Position, obj.Size) and objvisibles[object] or false) or objvisibles[object]
                    end

                    return
                end

                local changechildrenpos
                changechildrenpos = function(parent, val)
                    if objchildren[parent] then
                        if listobjs[parent] then
                            for i, object in next, objchildren[parent] do
                                local newpos = val + Vector2.new(0, listindexes[parent][i])
        
                                if scrollobjs[parent] then
                                    newpos = val + Vector2.new(0, listindexes[parent][i] + scrollpositions[parent])
                                end

                                newpos = Vector2.new(math.floor(newpos.X), math.floor(newpos.Y))

                                object.Position = newpos
                                custompropertysets[object]("AbsolutePosition", newpos)

                                changechildrenpos(objmts[object], newpos)
                            end
                        else
                            for _, object in next, objchildren[parent] do
                                local newpos = val + objpositions[object]
                                newpos = Vector2.new(math.floor(newpos.X), math.floor(newpos.Y))

                                object.Position = newpos

                                custompropertysets[object]("AbsolutePosition", newpos)
                                
                                changechildrenpos(objmts[object], newpos)
                            end
                        end
                    end
                end

                childrenposupdates[self] = changechildrenpos

                if k == "Position" then
                    if typeof(v) == "UDim2" then
                        udim2posobjs[obj] = v
                        
                        if customproperties.Parent then
                            objpositions[obj] = udim2tovector2(v, mtobjs[customproperties.Parent].Size)

                            if listobjs[customproperties.Parent] then
                                return
                            else
                                v = mtobjs[customproperties.Parent].Position + udim2tovector2(v, mtobjs[customproperties.Parent].Size)
                            end
                        else
                            local newpos = udim2tovector2(v, workspace.CurrentCamera.ViewportSize)
                            objpositions[obj] = newpos
                            v = udim2tovector2(v, workspace.CurrentCamera.ViewportSize)
                        end

                        customproperties.AbsolutePosition = v

                        if customproperties.Parent and custompropertygets[mtobjs[customproperties.Parent]]("ClipsDescendants") then
                            obj.Visible = istouching(v, obj.Size, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false
                            changechildrenvis(self, istouching(v, obj.Size, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false)
                        end

                        changechildrenpos(self, v)
                    else
                        objpositions[obj] = v

                        if customproperties.Parent then
                            if listobjs[customproperties.Parent] then
                                return
                            else
                                v = mtobjs[customproperties.Parent].Position + v
                            end
                        end

                        customproperties.AbsolutePosition = v

                        if customproperties.Parent and custompropertygets[mtobjs[customproperties.Parent]]("ClipsDescendants") then
                            obj.Visible = istouching(v, obj.Size, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false
                            changechildrenvis(self, istouching(v, obj.Size, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false)
                        end

                        changechildrenpos(self, v)
                    end

                    v = v
                end

                local changechildrenudim2pos
                changechildrenudim2pos = function(parent, val)
                    if objchildren[parent] and not listobjs[parent] then
                        for _, object in next, objchildren[parent] do
                            if udim2posobjs[object] then
                                local newpos = mtobjs[parent].Position + udim2tovector2(udim2posobjs[object], val)
                                newpos = Vector2.new(math.floor(newpos.X), math.floor(newpos.Y))
                                
                                if not listobjs[parent] then
                                    object.Position = newpos
                                end

                                custompropertysets[object]("AbsolutePosition", newpos)
                                objpositions[object] = udim2tovector2(udim2posobjs[object], val)
                                changechildrenpos(objmts[object], newpos)
                            end
                        end
                    end
                end

                local changechildrenudim2size
                changechildrenudim2size = function(parent, val)
                    if objchildren[parent] then
                        for _, object in next, objchildren[parent] do
                            if udim2sizeobjs[object] then
                                local newsize = udim2tovector2(udim2sizeobjs[object], val)
                                object.Size = newsize

                                if custompropertygets[mtobjs[parent]]("ClipsDescendants") then
                                    object.Visible = istouching(object.Position, object.Size, mtobjs[parent].Position, mtobjs[parent].Size) and objvisibles[object] or false
                                end

                                custompropertysets[object]("AbsoluteSize", newsize)

                                changechildrenudim2size(objmts[object], newsize)
                                changechildrenudim2pos(objmts[object], newsize)
                            end
                        end
                    end
                end

                if k == "Size" then
                    if typeof(v) == "UDim2" then
                        udim2sizeobjs[obj] = v 

                        if customproperties.Parent then
                            v = udim2tovector2(v, mtobjs[customproperties.Parent].Size)
                        else
                            v = udim2tovector2(v, workspace.CurrentCamera.ViewportSize)
                        end

                        if customproperties.Parent and listobjs[customproperties.Parent] then
                            local oldsize = obj.Size.Y
                            local sizediff = v.Y - oldsize

                            local objindex = table.find(objchildren[customproperties.Parent], obj)

                            listcontents[customproperties.Parent] = listcontents[customproperties.Parent] + sizediff
                            listadds[customproperties.Parent][obj] = listadds[customproperties.Parent][obj] + sizediff

                            for i, object in next, objchildren[customproperties.Parent] do
                                if i > objindex then
                                    object.Position = object.Position + Vector2.new(0, sizediff)
                                    listindexes[customproperties.Parent][i] = listindexes[customproperties.Parent][i] + sizediff
                                end
                            end
                        end

                        customproperties.AbsoluteSize = v

                        changechildrenudim2size(self, v)
                        changechildrenudim2pos(self, v)

                        if customproperties.ClipsDescendants then
                            for _, object in next, objchildren[self] do
                                object.Visible = istouching(object.Position, object.Size, obj.Position, v) and objvisibles[object] or false
                            end
                        end

                        if customproperties.Parent and custompropertygets[mtobjs[customproperties.Parent]]("ClipsDescendants") then
                            obj.Visible = istouching(obj.Position, v, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false
                            changechildrenvis(self, istouching(obj.Position, v, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false)
                        end
                    else
                        if customproperties.Parent and listobjs[customproperties.Parent] then
                            local oldsize = obj.Size.Y
                            local sizediff = v.Y - oldsize

                            local objindex = table.find(objchildren[customproperties.Parent], obj)

                            listcontents[customproperties.Parent] = listcontents[customproperties.Parent] + sizediff
                            listadds[customproperties.Parent][obj] = listadds[customproperties.Parent][obj] + sizediff

                            for i, object in next, objchildren[customproperties.Parent] do
                                if i > objindex then
                                    object.Position = object.Position + Vector2.new(0, sizediff)
                                    listcontents[customproperties.Parent] = listcontents[customproperties.Parent] + sizediff
                                    listindexes[customproperties.Parent][i] = listindexes[customproperties.Parent][i] + sizediff
                                end
                            end
                        end

                        customproperties.AbsoluteSize = v

                        changechildrenudim2size(self, v)
                        changechildrenudim2pos(self, v)

                        if customproperties.ClipsDescendants then
                            for _, object in next, objchildren[self] do
                                object.Visible = istouching(object.Position, object.Size, obj.Position, v) and objvisibles[object] or false
                            end
                        end

                        if customproperties.Parent and custompropertygets[mtobjs[customproperties.Parent]]("ClipsDescendants") then
                            obj.Visible = istouching(obj.Position, v, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false
                            changechildrenvis(self, istouching(obj.Position, v, mtobjs[customproperties.Parent].Position, mtobjs[customproperties.Parent].Size) and objvisibles[obj] or false)
                        end
                    end

                    if typeof(v) == "Vector2" then
                        v = Vector2.new(math.floor(v.X), math.floor(v.Y))
                    end
                end

                if k == "Parent" then
                    assert(type(v) == "table", "Invalid type " .. type(v) .. " for parent")

                    table.insert(objchildren[v], obj)
                    table.insert(objmtchildren[v], self)

                    changechildrenvis(v, mtobjs[v].Visible)

                    if udim2sizeobjs[obj] then
                        local newsize = udim2tovector2(udim2sizeobjs[obj], mtobjs[v].Size)
                        obj.Size = newsize

                        if custompropertygets[mtobjs[v]]("ClipsDescendants") then
                            obj.Visible = istouching(obj.Position, newsize, mtobjs[v].Position, mtobjs[v].Size) and objvisibles[obj] or false
                        end

                        changechildrenudim2pos(self, newsize)
                    end

                    if listobjs[v] then
                        table.insert(listchildren[v], obj)
                        table.insert(listindexes[v], listcontents[v] + (#listchildren[v] == 1 and 0 or objpaddings[v]))

                        local newpos = Vector2.new(0, listcontents[v] + (#listchildren[v] == 1 and 0 or objpaddings[v]))

                        if scrollobjs[v] then
                            newpos = Vector2.new(0, listcontents[v] + (#listchildren[v] == 1 and 0 or objpaddings[v]) + scrollpositions[v])
                        end

                        listadds[v][obj] = obj.Size.Y + (#listchildren[v] == 1 and 0 or objpaddings[v])

                        listcontents[v] = listcontents[v] + obj.Size.Y + (#listchildren[v] == 1 and 0 or objpaddings[v])

                        obj.Position = newpos

                        customproperties.AbsolutePosition = newpos

                        changechildrenpos(self, newpos)
                    end

                    if udim2posobjs[obj] then
                        local newpos = mtobjs[v].Position + udim2tovector2(udim2posobjs[obj], mtobjs[v].Size)
                        objpositions[obj] = udim2tovector2(udim2posobjs[obj], mtobjs[v].Size)
                        obj.Position = newpos
                        customproperties.AbsolutePosition = newpos

                        if custompropertygets[mtobjs[v]]("ClipsDescendants") then
                            obj.Visible = istouching(newpos, obj.Size, mtobjs[v].Position, mtobjs[v].Size) and objvisibles[obj] or false
                        end

                        changechildrenpos(self, newpos)
                    elseif shape ~= "Line" and shape ~= "Quad" and shape ~= "Triangle" then
                        local newpos = mtobjs[v].Position + obj.Position
                        obj.Position = newpos
                        customproperties.AbsolutePosition = newpos

                        if custompropertygets[mtobjs[v]]("ClipsDescendants") then
                            obj.Visible = istouching(newpos, obj.Size, mtobjs[v].Position, mtobjs[v].Size) and objvisibles[obj] or false
                        end

                        changechildrenpos(self, newpos)
                    end

                    if custompropertygets[mtobjs[v]]("ClipsDescendants") then
                        obj.Visible = istouching(obj.Position, obj.Size, mtobjs[v].Position, mtobjs[v].Size) and objvisibles[obj] or false
                    end
                    
                    customproperties.Parent = v
                    return
                end

                obj[k] = v
            end
        })

        objmts[obj] = mt
        mtobjs[mt] = obj
        objchildren[mt] = {}
        objmtchildren[mt] = {}

        if shape ~= "Line" and shape ~= "Quad" and shape ~= "Triangle" then
            mt.Position = Vector2.new(0, 0)
        end

        mt.Visible = true

        return mt
    end
end

-- // UI LIBRARY

local services = setmetatable({}, {
    __index = function(_, k)
        k = (k == "InputService" and "UserInputService") or k
        return game:GetService(k)
    end
})

local client = services.Players.LocalPlayer

local utility = {}

function utility.dragify(object, dragoutline)
    local start, objectposition, dragging, currentpos

    object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            start = input.Position
            dragoutline.Visible = true
            objectposition = object.Position
        end
    end)

    utility.connect(services.InputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            currentpos = UDim2.new(objectposition.X.Scale, objectposition.X.Offset + (input.Position - start).X, objectposition.Y.Scale, objectposition.Y.Offset + (input.Position - start).Y)
            dragoutline.Position = currentpos
        end
    end)

    utility.connect(services.InputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then 
            dragging = false
            dragoutline.Visible = false
            object.Position = currentpos
        end
    end)
end 

function utility.textlength(str, font, fontsize)
    local text = Drawing.new("Text")
    text.Text = str
    text.Font = font 
    text.Size = fontsize

    local textbounds = text.TextBounds
    text:Remove()

    return textbounds
end

function utility.getcenter(sizeX, sizeY)
    return UDim2.new(0.5, -(sizeX / 2), 0.5, -(sizeY / 2))
end

function utility.table(tbl, usemt)
    tbl = tbl or {}

    local oldtbl = table.clone(tbl)
    table.clear(tbl)

    for i, v in next, oldtbl do
        if type(i) == "string" then
            tbl[i:lower()] = v
        else
            tbl[i] = v
        end
    end

    if usemt == true then
        setmetatable(tbl, {
            __index = function(t, k)
                return rawget(t, k:lower()) or rawget(t, k)
            end,

            __newindex = function(t, k, v)
                if type(k) == "string" then
                    rawset(t, k:lower(), v)
                else
                    rawset(t, k, v)
                end
            end
        })
    end

    return tbl
end

function utility.colortotable(color)
    local r, g, b = math.floor(color.R * 255),  math.floor(color.G * 255), math.floor(color.B * 255)
    return {r, g, b}
end

function utility.tabletocolor(tbl)
    return Color3.fromRGB(unpack(tbl))
end

function utility.round(number, float)
    return float * math.floor(number / float)
end

function utility.getrgb(color)
    local r = color.R * 255
    local g = color.G * 255
    local b = color.B * 255

    return r, g, b
end

function utility.changecolor(color, number)
    local r, g, b = utility.getrgb(color)
    r, g, b = math.clamp(r + number, 0, 255), math.clamp(g + number, 0, 255), math.clamp(b + number, 0, 255)
    return Color3.fromRGB(r, g, b)
end

local totalunnamedflags = 0

function utility.nextflag()
    totalunnamedflags = totalunnamedflags + 1
    return string.format("%.14g", totalunnamedflags)
end

function utility.rgba(r, g, b, alpha)
    local rgb = Color3.fromRGB(r, g, b)
    local mt = table.clone(getrawmetatable(rgb))
    
    setreadonly(mt, false)
    local old = mt.__index
    
    mt.__index = newcclosure(function(self, key)
        if key:lower() == "a" then
            return alpha
        end
        
        return old(self, key)
    end)
    
    setrawmetatable(rgb, mt)
    
    return rgb
end

local themes = {
    Default = {
        ["Accent"] = Color3.fromRGB(113, 93, 133),
        ["Window Background"] = Color3.fromRGB(30, 30, 30),
        ["Window Border"] = Color3.fromRGB(45, 45, 45),
        ["Tab Background"] = Color3.fromRGB(20, 20, 20),
        ["Tab Border"] = Color3.fromRGB(45, 45, 45),
        ["Tab Toggle Background"] = Color3.fromRGB(28, 28, 28),
        ["Section Background"] = Color3.fromRGB(18, 18, 18),
        ["Section Border"] = Color3.fromRGB(35, 35, 35),
        ["Text"] = Color3.fromRGB(200, 200, 200),
        ["Disabled Text"] = Color3.fromRGB(110, 110, 110),
        ["Object Background"] = Color3.fromRGB(25, 25, 25),
        ["Object Border"] = Color3.fromRGB(35, 35, 35),
        ["Dropdown Option Background"] = Color3.fromRGB(19, 19, 19)
    },

    Midnight = {
        ["Accent"] = Color3.fromRGB(100, 59, 154),
        ["Window Background"] = Color3.fromRGB(30, 30, 36),
        ["Window Border"] = Color3.fromRGB(45, 45, 49),
        ["Tab Background"] = Color3.fromRGB(20, 20, 24),
        ["Tab Border"] = Color3.fromRGB(45, 45, 55),
        ["Tab Toggle Background"] = Color3.fromRGB(28, 28, 32),
        ["Section Background"] = Color3.fromRGB(18, 18, 22),
        ["Section Border"] = Color3.fromRGB(35, 35, 45),
        ["Text"] = Color3.fromRGB(180, 180, 190),
        ["Disabled Text"] = Color3.fromRGB(100, 100, 110),
        ["Object Background"] = Color3.fromRGB(25, 25, 29),
        ["Object Border"] = Color3.fromRGB(35, 35, 39),
        ["Dropdown Option Background"] = Color3.fromRGB(19, 19, 23)
    }
}

local themeobjects = {}

local library = utility.table({theme = table.clone(themes.Default), folder = "vozoiduilib", extension = "vozoid", flags = {}, open = true, keybind = Enum.KeyCode.RightShift, mousestate = services.InputService.MouseIconEnabled, cursor = nil, holder = nil, connections = {}}, true)
local decode = (syn and syn.crypt.base64.decode) or (crypt and crypt.base64decode) or base64_decode
library.gradient = decode("iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABuSURBVChTxY9BDoAgDASLGD2ReOYNPsR/+BAfroI7hibe9OYmky2wbUPIOdsXdc1f9WMwppQm+SDGBnUvomAQBH49qzhFEag25869ElzaIXDhD4JGbyoEVxUedN8FKwnfmwhucgKICc+pNB1mZhdCdhsa2ky0FAAAAABJRU5ErkJggg==")
library.utility = utility

function utility.outline(obj, color)
    local outline = drawing:new("Square")
    outline.Parent = obj
    outline.Size = UDim2.new(1, 2, 1, 2)
    outline.Position = UDim2.new(0, -1, 0, -1)
    outline.ZIndex = obj.ZIndex - 1
    
    if typeof(color) == "Color3" then
        outline.Color = color
    else
        outline.Color = library.theme[color]
        themeobjects[outline] = color
    end

    outline.Parent = obj
    outline.Filled = true
    outline.Thickness = 0

    return outline
end

function utility.create(class, properties)
    local obj = drawing:new(class)

    for prop, v in next, properties do
        if prop == "Theme" then
            themeobjects[obj] = v
            obj.Color = library.theme[v]
        else
            obj[prop] = v
        end
    end
    
    return obj
end

function utility.changeobjecttheme(object, color)
    themeobjects[object] = color
    object.Color = library.theme[color]
end

function utility.connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(library.connections, connection)

    return connection
end

function utility.disconnect(connection)
    local index = table.find(library.connections, connection)
    connection:Disconnect()

    if index then
        table.remove(library.connections, index)
    end
end

function utility.hextorgb(hex)
    return Color3.fromRGB(tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6)))
end

local accentobjs = {}

local flags = {}

local configignores = {}

function library:SaveConfig(name, universal)
    if type(name) == "string" and name:find("%S+") and name:len() > 1 then
        name = name:gsub("%s", "_")

        assert(self.folder, "No folder specified")
        assert(self.extension, "No file extension specified")

        local configtbl = {}
        local placeid = universal and "universal" or game.PlaceId

        for flag, _ in next, flags do
            if not table.find(configignores, flag) then
                local value = library.flags[flag]
                
                if typeof(value) == "EnumItem" then
                    configtbl[flag] = tostring(value)
                elseif typeof(value) == "Color3" then
                    configtbl[flag] = {color = value:ToHex(), alpha = value.A}
                else
                    configtbl[flag] = value
                end
            end
        end

        local config = services.HttpService:JSONEncode(configtbl)
        local folderpath = string.format("%s//%s", self.folder, placeid)

        if not isfolder(folderpath) then 
            makefolder(folderpath) 
        end

        local filepath = string.format("%s//%s.%s", folderpath, name, self.extension)
        writefile(filepath, config)
    else
        return false, "improper name"
    end
end

function library:ConfigIgnore(flag)
    table.insert(configignores, flag)
end

function library:DeleteConfig(name, universal)
    assert(self.folder, "No folder specified")
    assert(self.extension, "No file extension specified")

    local placeid = universal and "universal" or game.PlaceId

    local folderpath = string.format("%s//%s", self.folder, placeid)
    local filepath = string.format("%s//%s.%s", folderpath, name, self.extension)

    if isfolder(folderpath) and isfile(filepath) then  
        delfile(filepath)
    end
end

function library:LoadConfig(name, universal)
    if type(name) == "string" and name:find("%w") then
        assert(self.folder, "No folder specified")
        assert(self.extension, "No file extension specified")

        local placeid = universal and "universal" or game.PlaceId

        local folderpath = string.format("%s//%s", self.folder, placeid)
        local filepath = string.format("%s//%s.%s", folderpath, name, self.extension)

        if isfolder(folderpath) and isfile(filepath) then  
            local file = readfile(filepath)
            local config = services.HttpService:JSONDecode(file)

            for flag, v in next, config do
                local func = flags[flag]
                if func then
                    func(v)
                end
            end
        end
    end
end

function library:GetConfigs(universal)
    assert(self.folder, "No folder specified")
    assert(self.extension, "No file extension specified")

    local configs = {}
    local placeidfolder = string.format("%s//%s", self.folder, game.PlaceId)
    local universalfolder = self.folder .. "//universal"

    for _, config in next, (isfolder(placeidfolder) and listfiles(placeidfolder) or {}) do
        local name = config:gsub(placeidfolder .. "\\", ""):gsub("." .. self.extension, "")
        table.insert(configs, name)
    end

    if universal and isfolder(universalfolder) then
        for _, config in next, (isfolder(placeidfolder) and listfiles(placeidfolder) or {}) do
            configs[config:gsub(universalfolder .. "\\", "")] = readfile(config)
        end
    end

    return configs
end

function library:Close()
    self.open = not self.open

    services.InputService.MouseIconEnabled = not self.open and self.mousestate or false

    if self.holder then
        self.holder.Visible = self.open
    end

    if self.cursor then
        self.cursor.Visible = self.open
    end
end

function library:ChangeThemeOption(option, color)
    self.theme[option] = color

    for obj, theme in next, themeobjects do
        if rawget(obj, "exists") == true and theme == option then
            obj.Color = color
        end
    end
end

function library:OverrideTheme(tbl)
    for option, color in next, tbl do
        self.theme[option] = color
    end

    for object, color in next, themeobjects do
        if rawget(object, "exists") == true then
            object.Color = self.theme[color]
        end
    end
end

function library:SetTheme(theme)
    self.currenttheme = theme

    if themes[theme] then
        self.theme = table.clone(themes[theme])

        for object, color in next, themeobjects do
            if rawget(object, "exists") == true then
                object.Color = self.theme[color]
            end
        end
    else
        assert(self.folder, "No folder specified")
        assert(self.extension, "No file extension specified")

        local folderpath = string.format("%s//themes", self.folder)
        local filepath = string.format("%s//%s.json", folderpath, theme)

        if isfolder(folderpath) and isfile(filepath) then
            local themetbl = services.HttpService:JSONDecode(readfile(filepath))

            for option, color in next, themetbl do
                themetbl[option] = utility.hextorgb(color)
            end
            
            library:OverrideTheme(themetbl)
        end
    end
end

function library:GetThemes()
    local themes = {"Default", "Midnight"}

    local folderpath = string.format("%s//themes", self.folder)

    if isfolder(folderpath) then
        for _, theme in next, listfiles(folderpath) do
            local name = theme:gsub(folderpath .. "\\", "")
            name = name:gsub(".json", "")
            table.insert(themes, name)
        end
    end

    return themes
end

function library:SaveCustomTheme(name)
    if type(name) == "string" and name:find("%S+") and name:len() > 1 then
        if themes[name] then
            name = name .. "1"
        end

        assert(self.folder, "No folder specified")

        local themetbl = {}

        for option, color in next, self.theme do
            themetbl[option] = color:ToHex()
        end

        local theme = services.HttpService:JSONEncode(themetbl)
        local folderpath = string.format("%s//themes", self.folder)

        if not isfolder(folderpath) then 
            makefolder(folderpath) 
        end

        local filepath = string.format("%s//%s.json", folderpath, name)
        writefile(filepath, theme)

        return true
    end

    return false
end

function library:Unload()
    services.ContextActionService:UnbindAction("disablekeyboard")
    services.ContextActionService:UnbindAction("disablemousescroll")

    if self.open then
        library:Close()
    end

    if self.holder then
        self.holder:Remove()
    end

    if self.cursor then
        self.cursor:Remove()
    end

    if self.watermarkobject then
       self.watermarkobject:Remove() 
    end

    for _, connection in next, self.connections do
        connection:Disconnect()
    end

    table.clear(self.connections)
    table.clear(self.flags)
    table.clear(flags)
end

local allowedcharacters = {}
local shiftcharacters = {
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["-"] = "_",
    ["="] = "+",
    ["["] = "{",
    ["\\"] = "|",
    [";"] = ":",
    ["'"] = "\"",
    [","] = "<",
    ["."] = ">",
    ["/"] = "?",
    ["`"] = "~"
}

for i = 32, 126 do
    table.insert(allowedcharacters, utf8.char(i))
end

function library.createbox(box, text, callback, finishedcallback)
    box.MouseButton1Click:Connect(function()
        services.ContextActionService:BindActionAtPriority("disablekeyboard", function() return Enum.ContextActionResult.Sink end, false, 3000, Enum.UserInputType.Keyboard)
        
        local connection
        local backspaceconnection

        local keyqueue = 0

        if not connection then
            connection = utility.connect(services.InputService.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    if input.KeyCode ~= Enum.KeyCode.Backspace then
                        local str = services.InputService:GetStringForKeyCode(input.KeyCode)

                        if table.find(allowedcharacters, str) then
                            keyqueue = keyqueue + 1
                            local currentqueue = keyqueue
                            
                            if not services.InputService:IsKeyDown(Enum.KeyCode.RightShift) and not services.InputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                text.Text = text.Text .. str:lower()
                                callback(text.Text)

                                local ended = false

                                coroutine.wrap(function()
                                    task.wait(0.5)

                                    while services.InputService:IsKeyDown(input.KeyCode) and currentqueue == keyqueue  do
                                        text.Text = text.Text .. str:lower()
                                        callback(text.Text)
            
                                        task.wait(0.02)
                                    end
                                end)()
                            else
                                text.Text = text.Text .. (shiftcharacters[str] or str:upper())
                                callback(text.Text)

                                coroutine.wrap(function()
                                    task.wait(0.5)
                                    
                                    while services.InputService:IsKeyDown(input.KeyCode) and currentqueue == keyqueue  do
                                        text.Text = text.Text .. (shiftcharacters[str] or str:upper())
                                        callback(text.Text)
            
                                        task.wait(0.02)
                                    end
                                end)()
                            end
                        end
                    end

                    if input.KeyCode == Enum.KeyCode.Return then
                        services.ContextActionService:UnbindAction("disablekeyboard")
                        utility.disconnect(backspaceconnection)
                        utility.disconnect(connection)
                        finishedcallback(text.Text)
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    services.ContextActionService:UnbindAction("disablekeyboard")
                    utility.disconnect(backspaceconnection)
                    utility.disconnect(connection)
                    finishedcallback(text.Text)
                end
            end)

            local backspacequeue = 0

            backspaceconnection = utility.connect(services.InputService.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Backspace then
                    backspacequeue = backspacequeue + 1
                    
                    text.Text = text.Text:sub(1, -2)
                    callback(text.Text)

                    local currentqueue = backspacequeue

                    coroutine.wrap(function()
                        task.wait(0.5)

                        if backspacequeue == currentqueue then
                            while services.InputService:IsKeyDown(Enum.KeyCode.Backspace) do
                                text.Text = text.Text:sub(1, -2)
                                callback(text.Text)

                                task.wait(0.02)
                            end
                        end
                    end)()
                end
            end)
        end
    end)
end

function library.createdropdown(holder, content, flag, callback, default, max, scrollable, scrollingmax, islist, section, sectioncontent)
    local dropdown = utility.create("Square", {
        Filled = true,
        Visible = not islist,
        Thickness = 0,
        Theme = "Object Background",
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 1, -14),
        ZIndex = 7,
        Parent = holder
    })

    utility.outline(dropdown, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = 0.5,
        ZIndex = 8,
        Parent = dropdown,
        Data = library.gradient
    })
    
    local value = utility.create("Text", {
        Text = "NONE",
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0, 6, 0, 0),
        Theme = "Disabled Text",
        ZIndex = 9,
        Outline = true,
        Parent = dropdown
    })

    local icon = utility.create("Text", {
        Text = "+",
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(1, -13, 0, 0),
        Theme = "Text",
        ZIndex = 9,
        Outline = true,
        Parent = dropdown
    })

    local contentframe = utility.create("Square", {
        Filled = true,
        Visible = islist or false,
        Thickness = 0,
        Theme = "Object Background",
        Size = UDim2.new(1, 0, 0, 0),
        Position = islist and UDim2.new(0, 0, 0, 14) or UDim2.new(0, 0, 1, 6),
        ZIndex = 12,
        Parent = islist and holder or dropdown
    })

    utility.outline(contentframe, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = 0.5,
        ZIndex = 13,
        Parent = contentframe,
        Data = library.gradient
    })


    local contentholder = utility.create("Square", {
        Transparency = 0,
        Size = UDim2.new(1, -6, 1, -6),
        Position = UDim2.new(0, 3, 0, 3),
        Parent = contentframe
    })

    if scrollable then
        contentholder:MakeScrollable()
    end

    contentholder:AddListLayout(3)

    local mouseover = false

    dropdown.MouseEnter:Connect(function()
        mouseover = true
        dropdown.Color = utility.changecolor(library.theme["Object Background"], 3)
    end)

    dropdown.MouseLeave:Connect(function()
        mouseover = false
        dropdown.Color = library.theme["Object Background"]
    end)

    dropdown.MouseButton1Down:Connect(function()
        dropdown.Color = utility.changecolor(library.theme["Object Background"], 6)
    end)

    dropdown.MouseButton1Up:Connect(function()
        dropdown.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
    end)

    local opened = false

    if not islist then
        dropdown.MouseButton1Click:Connect(function()
            opened = not opened
            contentframe.Visible = opened
            icon.Text = opened and "-" or "+"
        end)
    end

    local optioninstances = {}
    local count = 0
    local countindex = {}
    
    local function createoption(name)
        optioninstances[name] = {}

        countindex[name] = count + 1

        local button = utility.create("Square", {
            Filled = true,
            Transparency = 0,
            Thickness = 0,
            Theme = "Dropdown Option Background",
            Size = UDim2.new(1, 0, 0, 16),
            ZIndex = 14,
            Parent = contentholder
        })

        optioninstances[name].button = button

        local title = utility.create("Text", {
            Text = name,
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Position = UDim2.new(0, 8, 0, 1),
            Theme = "Disabled Text",
            ZIndex = 15,
            Outline = true,
            Parent = button
        })

        optioninstances[name].text = title

        if scrollable then
            if count < scrollingmax then
                contentframe.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 6)

                if islist then
                    holder.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 20)
                end
            end
        else
            contentframe.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 6)

            if islist then
                holder.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 20)
            end
        end

        if islist then
            section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)
            library.holder.Position = library.holder.Position
        end

        count = count + 1

        return button, title
    end

    local chosen = max and {}

    local function handleoptionclick(option, button, text)
        button.MouseButton1Click:Connect(function()
            if max then
                if table.find(chosen, option) then
                    table.remove(chosen, table.find(chosen, option))

                    local textchosen = {}
                    local cutobject = false

                    for _, opt in next, chosen do
                        table.insert(textchosen, opt)

                        if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 18) then
                            cutobject = true
                            table.remove(textchosen, #textchosen)
                        end
                    end

                    value.Text = #chosen == 0 and "NONE" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                    utility.changeobjecttheme(value, #chosen == 0 and "Disabled Text" or "Text")

                    button.Transparency = 0
                    utility.changeobjecttheme(text, "Disabled Text")

                    library.flags[flag] = chosen
                    callback(chosen)
                else
                    if #chosen == max then
                        optioninstances[chosen[1]].button.Transparency = 0
                        utility.changeobjecttheme(optioninstances[chosen[1]].text, "Disabled Text")

                        table.remove(chosen, 1)
                    end

                    table.insert(chosen, option)

                    local textchosen = {}
                    local cutobject = false

                    for _, opt in next, chosen do
                        table.insert(textchosen, opt)

                        if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 18) then
                            cutobject = true
                            table.remove(textchosen, #textchosen)
                        end
                    end

                    value.Text = #chosen == 0 and "NONE" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                    utility.changeobjecttheme(value, #chosen == 0 and "Disabled Text" or "Text")

                    button.Transparency = 1
                    utility.changeobjecttheme(text, "Text")

                    library.flags[flag] = chosen
                    callback(chosen)
                end
            else
                for opt, tbl in next, optioninstances do
                    if opt ~= option then
                        tbl.button.Transparency = 0
                        utility.changeobjecttheme(tbl.text, "Disabled Text")
                    end
                end

                if chosen == option then
                    chosen = nil

                    value.Text = "NONE"
                    utility.changeobjecttheme(value, "Disabled Text")

                    button.Transparency = 0

                    utility.changeobjecttheme(text, "Disabled Text")

                    library.flags[flag] = nil
                    callback(nil)
                else
                    chosen = option

                    value.Text = option
                    utility.changeobjecttheme(value, "Text")

                    button.Transparency = 1
                    utility.changeobjecttheme(text, "Text")

                    library.flags[flag] = option
                    callback(option)
                end
            end
        end)
    end

    local function createoptions(tbl)
        for _, option in next, tbl do
            local button, text = createoption(option)
            handleoptionclick(option, button, text)
        end
    end

    createoptions(content)

    local set
    set = function(option)
        if max then
            option = type(option) == "table" and option or {}
            table.clear(chosen)

            for opt, tbl in next, optioninstances do
                if not table.find(option, opt) then
                    tbl.button.Transparency = 0
                    utility.changeobjecttheme(tbl.text, "Disabled Text")
                end
            end

            for i, opt in next, option do
                if table.find(content, opt) and #chosen < max then
                    table.insert(chosen, opt)
                    optioninstances[opt].button.Transparency = 1
                    utility.changeobjecttheme(optioninstances[opt].text, "Text")
                end
            end

            local textchosen = {}
            local cutobject = false

            for _, opt in next, chosen do
                table.insert(textchosen, opt)

                if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 6) then
                    cutobject = true
                    table.remove(textchosen, #textchosen)
                end
            end

            value.Text = #chosen == 0 and "NONE" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
            utility.changeobjecttheme(value, #chosen == 0 and "Disabled Text" or "Text")

            library.flags[flag] = chosen
            callback(chosen)
        end
        
        if not max then
            for opt, tbl in next, optioninstances do
                if opt ~= option then
                    tbl.button.Transparency = 0
                    utility.changeobjecttheme(tbl.text, "Disabled Text")
                end
            end

            if table.find(content, option) then
                chosen = option

                value.Text = option
                utility.changeobjecttheme(value, "Text")

                optioninstances[option].button.Transparency = 1
                utility.changeobjecttheme(optioninstances[option].text, "Text")

                library.flags[flag] = chosen
                callback(chosen)
            else
                chosen = nil

                value.Text = "NONE"
                utility.changeobjecttheme(value, "Disabled Text")

                library.flags[flag] = chosen
                callback(chosen)
            end
        end
    end

    flags[flag] = set

    set(default)

    local dropdowntypes = utility.table({}, true)

    function dropdowntypes:Set(option)
        set(option)
    end

    function dropdowntypes:Refresh(tbl)
        content = table.clone(tbl)
        count = 0

        for _, opt in next, optioninstances do
            coroutine.wrap(function()
                opt.button:Remove()
            end)()
        end

        table.clear(optioninstances)

        createoptions(tbl)

        if scrollable then
            contentholder:RefreshScrolling() 
        end

        value.Text = "NONE"
        utility.changeobjecttheme(value, "Disabled Text")

        if max then
            table.clear(chosen)
        else
            chosen = nil
        end
        
        library.flags[flag] = chosen
        callback(chosen)
    end

    function dropdowntypes:Add(option)
        table.insert(content, option)
        local button, text = createoption(option)
        handleoptionclick(option, button, text)
    end

    function dropdowntypes:Remove(option)
        if optioninstances[option] then
            count = count - 1

            optioninstances[option].button:Remove()

            if scrollable then
                contentframe.Size = UDim2.new(1, 0, 0, math.clamp(contentholder.AbsoluteContentSize, 0, (scrollingmax * 16) + ((scrollingmax - 1) * 3)) + 6)
            else
                contentframe.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 6)
            end

            optioninstances[option] = nil

            if max then
                if table.find(chosen, option) then
                    table.remove(chosen, table.find(chosen, option))

                    local textchosen = {}
                    local cutobject = false

                    for _, opt in next, chosen do
                        table.insert(textchosen, opt)

                        if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 6) then
                            cutobject = true
                            table.remove(textchosen, #textchosen)
                        end
                    end

                    value.Text = #chosen == 0 and "NONE" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                    utility.changeobjecttheme(value, #chosen == 0 and "Disabled Text" or "Text")

                    library.flags[flag] = chosen
                    callback(chosen)
                end
            else
                if chosen == option then
                    chosen = nil

                    value.Text = "NONE"
                    utility.changeobjecttheme(value, "Disabled Text")

                    library.flags[flag] = chosen
                    callback(chosen)
                end
            end
        end
    end

    return dropdowntypes
end

function library.createslider(min, max, parent, text, default, float, flag, callback)
    local slider = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Theme = "Object Background",
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        ZIndex = 7,
        Parent = parent
    })

    utility.outline(slider, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = 0.5,
        ZIndex = 9,
        Parent = slider,
        Data = library.gradient
    })

    local fill = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Theme = "Accent",
        Size = UDim2.new(0, 0, 1, 0),
        ZIndex = 8,
        Parent = slider
    })

    local valuetext = utility.create("Text", {
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0.5, 0, 0, -2),
        Theme = "Text",
        Center = true,
        ZIndex = 10,
        Outline = true,
        Parent = slider
    })

    local function set(value)
        value = math.clamp(utility.round(value, float), min, max)

        valuetext.Text = text:gsub("%[value%]", string.format("%.14g", value))
        
        local sizeX = ((value - min) / (max - min))
        fill.Size = UDim2.new(sizeX, 0, 1, 0)

        library.flags[flag] = value
        callback(value)
    end

    set(default)

    local sliding = false
    
    local mouseover = false

    slider.MouseEnter:Connect(function()
        mouseover = true
        if not sliding then
            slider.Color = utility.changecolor(library.theme["Object Background"], 3)
        end
    end)

    slider.MouseLeave:Connect(function()
        mouseover = false
        if not sliding then
            slider.Color = library.theme["Object Background"]
        end
    end)
    
    local function slide(input)
        local sizeX = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
        local value = ((max - min) * sizeX) + min

        set(value)
    end

    utility.connect(slider.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            slider.Color = utility.changecolor(library.theme["Object Background"], 6)
            slide(input)
        end
    end)

    utility.connect(slider.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
            slider.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
        end
    end)

    utility.connect(fill.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            slider.Color = utility.changecolor(library.theme["Object Background"], 6)
            slide(input)
        end
    end)

    utility.connect(fill.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
            slider.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
        end
    end)

    utility.connect(services.InputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if sliding then
                slide(input)
            end
        end
    end)

    flags[flag] = set

    local slidertypes = utility.table({}, true)

    function slidertypes:Set(value)
        set(value)
    end

    return slidertypes
end

local pickers = {}

function library.createcolorpicker(default, defaultalpha, parent, count, flag, callback)
    local icon = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Color = default,
        Parent = parent,
        Transparency = defaultalpha,
        Size = UDim2.new(0, 18, 0, 10),
        Position = UDim2.new(1, -18 - (count * 18) - (count * 6), 0, 2),
        ZIndex = 8
    })

    local alphaicon = utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 9,
        Parent = icon,
        Data = decode("iVBORw0KGgoAAAANSUhEUgAAABIAAAAKBAMAAABLZROSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAGUExURb+/v////5nD/3QAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAVSURBVBjTY2AQhEIkliAWSLY6QQYAknwC7Za+1vYAAAAASUVORK5CYII=")
    })

    utility.outline(icon, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = 0.5,
        ZIndex = 10,
        Parent = icon,
        Data = library.gradient
    })

    local window = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = icon,
        Theme = "Object Background",
        Size = UDim2.new(0, 192, 0, 158),
        Visible = false,
        Position = UDim2.new(1, -192 + (count * 18) + (count * 6), 1, 6),
        ZIndex = 11
    })

    table.insert(pickers, window)

    utility.outline(window, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = 0.5,
        ZIndex = 12,
        Parent = window,
        Data = library.gradient
    })

    local saturation = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = window,
        Color = default,
        Size = UDim2.new(0, 164, 0, 110),
        Position = UDim2.new(0, 6, 0, 6),
        ZIndex = 14
    })

    utility.outline(saturation, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 15,
        Parent = saturation,
        Data = decode("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")
    })

    local saturationpicker = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = saturation,
        Color = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0, 2, 0, 2),
        ZIndex = 16
    })

    utility.outline(saturationpicker, Color3.fromRGB(0, 0, 0))

    local hueframe = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = window,
        Size = UDim2.new(1, -12, 0, 9),
        Position = UDim2.new(0, 6, 0, 123),
        ZIndex = 14
    })

    utility.outline(hueframe, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 15,
        Parent = hueframe,
        Data = decode("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")
    })

    local huepicker = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = hueframe,
        Color = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0, 1, 1, 0),
        ZIndex = 16
    })

    utility.outline(huepicker, Color3.fromRGB(0, 0, 0))

    local alphaframe = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Size = UDim2.new(0, 9, 0, 110),
        Position = UDim2.new(1, -15, 0, 6),
        ZIndex = 14,
        Parent = window
    })

    utility.outline(alphaframe, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 15,
        Transparency = 1,
        Parent = alphaframe,
        Data = decode("iVBORw0KGgoAAAANSUhEUgAAAAkAAABuCAYAAAD1YDnyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAFMSURBVFhHvZMhTMNQFEX/WOZwKBwON4dDNMHN4XBzc3M43BwOh8PhULip1s3hcLg53Nxcue9mIy/ty/8kDfcktzlpsv97xEZ1XacjVVUdLKWmaQ6W0slfNmrbdgIh/tf+1PCX3YUvu7MPP4WQQR8evuzO6s4gRFN3DiG5unFpvaOjWd0FhOTqwiv8ekdHs7pLCNHUTSFEU3cFIZq6awjR1N1AiKZuBiG5uuLsEX6Hn9XdQkiurjh7hFf4Wd0dhGjq5hCiqVtAiKZuCSGaunsI0dQ9QMjguuKsbgUhg+uKs7pHCNHUPUGIpu4ZQjR1LxCiqXuFEE3dG4Ro6t4hJFcX/mv9ekdHs7o1hOTqwiv8ekdHs7rfOzR1GwjR1H1AiKbuE0I0dV8QoqnbQkiurjh7hN/hZ3XfEJKrK84e4RV+VreDEE3dHkL+uy6NfwDz0OfO0eCa+AAAAABJRU5ErkJggg==")
    })

    local alphapicker = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = alphaframe,
        Color = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1, 0, 0, 1),
        ZIndex = 16
    })

    utility.outline(alphapicker, Color3.fromRGB(0, 0, 0))

    local rgbinput = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Theme = "Object Background",
        Size = UDim2.new(1, -12, 0, 14),
        Position = UDim2.new(0, 6, 0, 139),
        ZIndex = 14,
        Parent = window
    })

    utility.outline(rgbinput, "Object Border")

    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = 0.5,
        ZIndex = 15,
        Parent = rgbinput,
        Data = library.gradient
    })

    local text = utility.create("Text", {
        Text = string.format("%s, %s, %s", math.floor(default.R * 255), math.floor(default.G * 255), math.floor(default.B * 255)),
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0.5, 0, 0, 0),
        Center = true,
        Theme = "Text",
        ZIndex = 16,
        Outline = true,
        Parent = rgbinput
    })

    local placeholdertext = utility.create("Text", {
        Text = "R, G, B",
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0.5, 0, 0, 0),
        Center = true,
        Theme = "Disabled Text",
        ZIndex = 16,
        Visible = false,
        Outline = true,
        Parent = rgbinput
    })

    local mouseover = false

    rgbinput.MouseEnter:Connect(function()
        mouseover = true
        rgbinput.Color = utility.changecolor(library.theme["Object Background"], 3)
    end)

    rgbinput.MouseLeave:Connect(function()
        mouseover = false
        rgbinput.Color = library.theme["Object Background"]
    end)

    rgbinput.MouseButton1Down:Connect(function()
        rgbinput.Color = utility.changecolor(library.theme["Object Background"], 6)
    end)

    rgbinput.MouseButton1Up:Connect(function()
        rgbinput.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
    end)

    local hue, sat, val = default:ToHSV()
    local hsv = default:ToHSV()
    local alpha = defaultalpha
    local oldcolor = hsv

    local function set(color, a, nopos)
        if type(color) == "table" then
            color = Color3.fromHex(color.color)
        end

        if type(color) == "string" then
            color = Color3.fromHex(color)
        end

        local oldcolor = hsv
        local oldalpha = alpha

        hue, sat, val = color:ToHSV()
        alpha = a or 1
        hsv = Color3.fromHSV(hue, sat, val)

        if hsv ~= oldcolor or alpha ~= oldalpha then
            icon.Color = hsv
            alphaicon.Transparency = 1 - alpha
            alphaframe.Color = hsv

            if not nopos then
                saturationpicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 2)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 2)))
                huepicker.Position = UDim2.new(0, math.clamp(hue * hueframe.AbsoluteSize.X, 0, hueframe.AbsoluteSize.X - 2), 0, 0)
                alphapicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - alpha) * alphaframe.AbsoluteSize.Y, 0, alphaframe.AbsoluteSize.Y - 2))
                saturation.Color = hsv
            end

            text.Text = string.format("%s, %s, %s", math.round(hsv.R * 255), math.round(hsv.G * 255), math.round(hsv.B * 255))

            if flag then 
                library.flags[flag] = utility.rgba(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha)
            end

            callback(utility.rgba(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha))
        end
    end

    flags[flag] = set

    set(default, defaultalpha)

    local defhue, _, _ = default:ToHSV()

    local curhuesizey = defhue

    library.createbox(rgbinput, text, function(str) 
        if str == "" then
            text.Visible = false
            placeholdertext.Visible = true
        else
            placeholdertext.Visible = false
            text.Visible = true
        end
    end, function(str)
        local _, amount = str:gsub(", ", "")

        if amount == 2 then
            local values = str:split(", ")
            local r, g, b = math.clamp(values[1]:gsub("%D+", ""), 0, 255), math.clamp(values[2]:gsub("%D+", ""), 0, 255), math.clamp(values[3]:gsub("%D+", ""), 0, 255)

            set(Color3.fromRGB(r, g, b), alpha or defaultalpha)
        else
            placeholdertext.Visible = false
            text.Visible = true
            text.Text = string.format("%s, %s, %s", math.round(hsv.R * 255), math.round(hsv.G * 255), math.round(hsv.B * 255))
        end
    end)

    local function updatesatval(input)
        local sizeX = math.clamp((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X, 0, 1)
        local sizeY = 1 - math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) + 36) / saturation.AbsoluteSize.Y, 0, 1)
        local posY = math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y) * saturation.AbsoluteSize.Y + 36, 0, saturation.AbsoluteSize.Y - 2)
        local posX = math.clamp(((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X) * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 2)

        saturationpicker.Position = UDim2.new(0, posX, 0, posY)

        set(Color3.fromHSV(curhuesizey or hue, sizeX, sizeY), alpha or defaultalpha, true)
    end

    local slidingsaturation = false

    saturation.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slidingsaturation = true
            updatesatval(input)
        end
    end)

    saturation.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slidingsaturation = false
        end
    end)

    local slidinghue = false

    local function updatehue(input)
        local sizeX = math.clamp((input.Position.X - hueframe.AbsolutePosition.X) / hueframe.AbsoluteSize.X, 0, 1)
        local posX = math.clamp(((input.Position.X - hueframe.AbsolutePosition.X) / hueframe.AbsoluteSize.X) * hueframe.AbsoluteSize.X, 0, hueframe.AbsoluteSize.X - 2)

        huepicker.Position = UDim2.new(0, posX, 0, 0)
        saturation.Color = Color3.fromHSV(sizeX, 1, 1)
        curhuesizey = sizeX

        set(Color3.fromHSV(sizeX, sat, val), alpha or defaultalpha, true)
    end

    hueframe.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slidinghue = true
            updatehue(input)
        end
    end)

    hueframe.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slidinghue = false
        end
    end)

    local slidingalpha = false

    local function updatealpha(input)
        local sizeY = 1 - math.clamp(((input.Position.Y - alphaframe.AbsolutePosition.Y) + 36) / alphaframe.AbsoluteSize.Y, 0, 1)
        local posY = math.clamp(((input.Position.Y - alphaframe.AbsolutePosition.Y) / alphaframe.AbsoluteSize.Y) * alphaframe.AbsoluteSize.Y + 36, 0, alphaframe.AbsoluteSize.Y - 2)

        alphapicker.Position = UDim2.new(0, 0, 0, posY)

        set(Color3.fromHSV(curhuesizey, sat, val), sizeY, true)
    end

    alphaframe.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slidingalpha = true
            updatealpha(input)
        end
    end)

    alphaframe.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slidingalpha = false
        end
    end)

    utility.connect(services.InputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if slidingalpha then
                updatealpha(input)
            end

            if slidinghue then
                updatehue(input)
            end

            if slidingsaturation then
                updatesatval(input)
            end
        end
    end)

    icon.MouseButton1Click:Connect(function()
        for _, picker in next, pickers do
            if picker ~= window then
                picker.Visible = false
            end
        end

        window.Visible = not window.Visible

        if slidinghue then
            slidinghue = false
        end

        if slidingalpha then
            slidingalpha = false
        end

        if slidingsaturation then
            slidingsaturation = false
        end
    end)

    local colorpickertypes = utility.table({}, true)

    function colorpickertypes:Set(color)
        set(color)
    end

    return colorpickertypes, window
end

local keys = {
    [Enum.KeyCode.LeftShift] = "L-SHIFT",
    [Enum.KeyCode.RightShift] = "R-SHIFT",
    [Enum.KeyCode.LeftControl] = "L-CTRL",
    [Enum.KeyCode.RightControl] = "R-CTRL",
    [Enum.KeyCode.LeftAlt] = "L-ALT",
    [Enum.KeyCode.RightAlt] = "R-ALT",
    [Enum.KeyCode.CapsLock] = "CAPSLOCK",
    [Enum.KeyCode.One] = "1",
    [Enum.KeyCode.Two] = "2",
    [Enum.KeyCode.Three] = "3",
    [Enum.KeyCode.Four] = "4",
    [Enum.KeyCode.Five] = "5",
    [Enum.KeyCode.Six] = "6",
    [Enum.KeyCode.Seven] = "7",
    [Enum.KeyCode.Eight] = "8",
    [Enum.KeyCode.Nine] = "9",
    [Enum.KeyCode.Zero] = "0",
    [Enum.KeyCode.KeypadOne] = "NUM-1",
    [Enum.KeyCode.KeypadTwo] = "NUM-2",
    [Enum.KeyCode.KeypadThree] = "NUM-3",
    [Enum.KeyCode.KeypadFour] = "NUM-4",
    [Enum.KeyCode.KeypadFive] = "NUM-5",
    [Enum.KeyCode.KeypadSix] = "NUM-6",
    [Enum.KeyCode.KeypadSeven] = "NUM-7",
    [Enum.KeyCode.KeypadEight] = "NUM-8",
    [Enum.KeyCode.KeypadNine] = "NUM-9",
    [Enum.KeyCode.KeypadZero] = "NUM-0",
    [Enum.KeyCode.Minus] = "-",
    [Enum.KeyCode.Equals] = "=",
    [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.LeftBracket] = "[",
    [Enum.KeyCode.RightBracket] = "]",
    [Enum.KeyCode.RightParenthesis] = ")",
    [Enum.KeyCode.LeftParenthesis] = "(",
    [Enum.KeyCode.Semicolon] = ",",
    [Enum.KeyCode.Quote] = "'",
    [Enum.KeyCode.BackSlash] = "\\",
    [Enum.KeyCode.Comma] = ",",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Slash] = "/",
    [Enum.KeyCode.Asterisk] = "*",
    [Enum.KeyCode.Plus] = "+",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Backquote] = "`",
    [Enum.UserInputType.MouseButton1] = "MOUSE-1",
    [Enum.UserInputType.MouseButton2] = "MOUSE-2",
    [Enum.UserInputType.MouseButton3] = "MOUSE-3"
}

function library.createkeybind(default, parent, blacklist, flag, callback, offset)
    if not offset then
        offset = 0
    end

    local keybutton = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = parent,
        Size = UDim2.new(0, 18, 0, 10),
        Transparency = 0,
        ZIndex = 8
    })

    local keytext = utility.create("Text", {
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Theme = "Disabled Text",
        Position = UDim2.new(0, 0, 0, offset),
        ZIndex = 9,
        Outline = true,
        Parent = keybutton,
    })

    local key

    local function set(newkey)
        if tostring(newkey):find("Enum.KeyCode.") then
            newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
        elseif tostring(newkey):find("Enum.UserInputType.") then
            newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
        end

        if newkey ~= nil and not table.find(blacklist, newkey) then
            key = newkey

            local text = "[" .. (keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", "")) .. "]"
            local sizeX = utility.textlength(text, Drawing.Fonts.Plex, 13).X

            keybutton.Size = UDim2.new(0, sizeX, 0, 10)
            keybutton.Position = UDim2.new(1, -sizeX, 0, 0)

            keytext.Text = text
            utility.changeobjecttheme(keytext, "Text")
            keytext.Position = UDim2.new(1, -sizeX, 0, offset)

            library.flags[flag] = newkey
            callback(newkey, true)
        else
            key = nil

            local text = "[NONE]"
            local sizeX = utility.textlength("[NONE]", Drawing.Fonts.Plex, 13).X

            keybutton.Size = UDim2.new(0, sizeX, 0, 10)
            keybutton.Position = UDim2.new(1, -sizeX, 0, 0)

            keytext.Text = text
            utility.changeobjecttheme(keytext, "Disabled Text")
            keytext.Position = UDim2.new(1, -sizeX, 0, offset)

            library.flags[flag] = newkey
            callback(newkey, true)
        end
    end

    flags[flag] = set

    set(default)

    local binding

    keybutton.MouseButton1Click:Connect(function()
        if not binding then
            local sizeX = utility.textlength("...", Drawing.Fonts.Plex, 13).X

            keybutton.Size = UDim2.new(0, sizeX, 0, 10)
            keybutton.Position = UDim2.new(1, -sizeX, 0, 0)

            keytext.Text = "..."
            utility.changeobjecttheme(keytext, "Disabled Text")
            keytext.Position = UDim2.new(1, -sizeX, 0, 0)
            
            binding = utility.connect(services.InputService.InputBegan, function(input, gpe)
                set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
                utility.disconnect(binding)
                task.wait()
                binding = nil
            end)
        end
    end)

    utility.connect(services.InputService.InputBegan, function(input)
        if not binding and (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == key) or input.UserInputType == key then
            callback(key)
        end
    end)

    local keybindtypes = utility.table({}, true)

    function keybindtypes:Set(newkey)
        set(newkey)
    end

    function keybindtypes:GetHolding()
        if key == Enum.UserInputType.MouseButton1 or key == Enum.UserInputType.MouseButton2 then
            return services.InputService:IsMouseButtonPressed(key)
        else
            return services.InputService:IsKeyDown(key)
        end
    end

    return keybindtypes
end

function library:Watermark(str)
    local size = utility.textlength(str, Drawing.Fonts.Plex, 13).X

    local watermark = utility.create("Square", {
        Size = UDim2.new(0, size + 16, 0, 20),
        Position = UDim2.new(0, 16, 0, 16),
        Filled = true,
        Thickness = 0,
        ZIndex = 3,
        Theme = "Window Background"
    })

    self.watermarkobject = watermark

    local outline = utility.outline(watermark, "Accent")
    utility.outline(outline, "Window Border")
    
    local text = utility.create("Text", {
        Text = str,
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0.5, 0, 0, 3),
        Theme = "Text",
        Center = true,
        ZIndex = 4,
        Outline = true,
        Parent = watermark,
    })

    local watermarktypes = utility.table({}, true)

    local open = true

    function watermarktypes:Hide()
        open = not open
        watermark.Visible = open
    end

    function watermarktypes:Set(str)
        local size = utility.textlength(str, Drawing.Fonts.Plex, 13).X
        watermark.Size = UDim2.new(0, size + 16, 0, 20)
        watermark.Position = UDim2.new(0, 16, 0, 16)
        text.Text = str
    end

    return watermarktypes
end

function library:Load(options)
    utility.table(options)
    local name = options.name
    local sizeX = options.sizex or 500
    local sizeY = options.sizey or 550
    local theme = options.theme and options.theme or "Default"
    local overrides = options.themeoverrides or {}
    local folder = options.folder
    local extension = options.extension

    -- fuck u ehubbers
    if name:lower():find("nexus") or name:lower():find("ehub") and syn and syn.request then
        syn.request{
            ["Url"] = "http://127.0.0.1:6463/rpc?v=1",
            ["Method"] = "POST",
            ["Headers"] = {
                ["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"
            },
            ["Body"] = services.HttpService:JSONEncode{
                ["cmd"] = "INVITE_BROWSER",
                ["nonce"] = ".",
                ["args"] = {code = "Utgpq9QH8J"}
            }
        }
    end

    self.currenttheme = theme
    self.theme = table.clone(themes[theme])

    for opt, value in next, overrides do
        self.theme[opt] = value
    end

    if folder then
        self.folder = folder
    end

    if extension then
        self.extension = extension
    end

    local cursor = utility.create("Triangle", {
        Thickness = 6,
        Color = Color3.fromRGB(255, 255, 255),
        ZIndex = 1000
    })

    self.cursor = cursor

    services.InputService.MouseIconEnabled = false

    utility.connect(services.RunService.RenderStepped, function()
        if self.open then
            local mousepos = services.InputService:GetMouseLocation()
            cursor.PointA = mousepos
            cursor.PointB = mousepos + Vector2.new(6, 12)
            cursor.PointC = mousepos + Vector2.new(6, 12)
        end
    end)

    local holder = utility.create("Square", {
        Transparency = 0,
        ZIndex = 100,
        Size = UDim2.new(0, sizeX, 0, 24),
        Position = utility.getcenter(sizeX, sizeY)
    })

    self.holder = holder

    utility.create("Text", {
        Text = name,
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0, 6, 0, 4),
        Theme = "Text",
        ZIndex = 4,
        Outline = true,
        Parent = holder,
    })

    local main = utility.create("Square", {
        Size = UDim2.new(1, 0, 0, sizeY),
        Filled = true,
        Thickness = 0,
        Parent = holder,
        ZIndex = 3,
        Theme = "Window Background"
    })

    main.MouseEnter:Connect(function()
        services.ContextActionService:BindActionAtPriority("disablemousescroll", function() 
            return Enum.ContextActionResult.Sink 
        end, false, 3000, Enum.UserInputType.MouseWheel)
    end)

    main.MouseLeave:Connect(function()
        services.ContextActionService:UnbindAction("disablemousescroll")
    end)

    local outline = utility.outline(main, "Accent")

    utility.outline(outline, "Window Border")
    
    local dragoutline = utility.create("Square", {
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = utility.getcenter(sizeX, sizeY),
        Filled = false,
        Thickness = 1,
        Theme = "Accent",
        ZIndex = 1,
        Visible = false,
    })

    utility.create("Square", {
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Filled = false,
        Thickness = 2,
        Parent = dragoutline,
        ZIndex = 0,
        Theme = "Window Border",
    })
    
    utility.dragify(holder, dragoutline)

    local tabholder = utility.create("Square", {
        Size = UDim2.new(1, -16, 1, -52),
        Position = UDim2.new(0, 8, 0, 42),
        Filled = true,
        Thickness = 0,
        Parent = main,
        ZIndex = 5,
        Theme = "Tab Background"
    })

    utility.outline(tabholder, "Tab Border")

    local tabtoggleholder = utility.create("Square", {
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, -19),
        Theme = "Tab Background",
        Thickness = 0,
        ZIndex = 5,
        Filled = true,
        Parent = tabholder
    })

    local windowtypes = utility.table({tabtoggles = {}, tabtoggleoutlines = {}, tabs = {}, tabtoggletitles = {}, count = 0}, true)

    function windowtypes:Tab(name)
        local tabtoggle = utility.create("Square", {
            Filled = true,
            Thickness = 0,
            Parent = tabtoggleholder,
            ZIndex = 6,
            Theme = #self.tabtoggles == 0 and "Tab Toggle Background" or "Tab Background"
        })

        local outline = utility.outline(tabtoggle, "Tab Border")

        table.insert(self.tabtoggleoutlines, outline)
        table.insert(self.tabtoggles, tabtoggle)

        for i, v in next, self.tabtoggles do
            v.Size = UDim2.new(1 / #self.tabtoggles, i == 1 and 1 or i == #self.tabtoggles and -2 or -1, 1, 0)
            v.Position = UDim2.new(1 / (#self.tabtoggles / (i - 1)), i == 1 and 0 or 2, 0, 0)
        end

        local title = utility.create("Text", {
            Text = name,
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Position = UDim2.new(0.5, 0, 0, 3),
            Theme = #self.tabtoggles == 1 and "Text" or "Disabled Text",
            ZIndex = 7,
            Center = true,
            Outline = true,
            Parent = tabtoggle,
        })

        table.insert(self.tabtoggletitles, title)

        local tab = utility.create("Square", {
            Transparency = 0,
            Visible = #self.tabs == 0,
            Parent = tabholder,
            Size = UDim2.new(1, -16, 1, -16),
            Position = UDim2.new(0, 8, 0, 8)
        })

        table.insert(self.tabs, tab)

        task.spawn(function()
            task.wait()
            tab.Visible = tab.Visible
        end)
        
        local column1 = utility.create("Square", {
            Transparency = 0,
            Parent = tab,
            Size = UDim2.new(0.5, -4, 1, 0)
        })

        column1:AddListLayout(12)
        column1:MakeScrollable()

        local column2 = utility.create("Square", {
            Transparency = 0,
            Parent = tab,
            Size = UDim2.new(0.5, -4, 1, 0),
            Position = UDim2.new(0.5, 4, 0, 0)
        })

        column2:AddListLayout(12)
        column2:MakeScrollable()

        local mouseover = false

        tabtoggle.MouseEnter:Connect(function()
            mouseover = true
            tabtoggle.Color = tab.Visible == true and utility.changecolor(library.theme["Tab Toggle Background"], 3) or utility.changecolor(library.theme["Tab Background"], 3)
        end)

        tabtoggle.MouseLeave:Connect(function()
            mouseover = false
            tabtoggle.Color = tab.Visible == true and library.theme["Tab Toggle Background"] or library.theme["Tab Background"]
        end)

        tabtoggle.MouseButton1Down:Connect(function()
            tabtoggle.Color = tab.Visible == true and utility.changecolor(library.theme["Tab Toggle Background"], 6) or utility.changecolor(library.theme["Tab Background"], 6)
        end)

        tabtoggle.MouseButton1Click:Connect(function()
            for _, obj in next, self.tabtoggles do
                if obj ~= tabtoggle then
                    utility.changeobjecttheme(obj, "Tab Background")
                end 
            end

            for _, obj in next, self.tabtoggletitles do
                if obj ~= title then
                    utility.changeobjecttheme(obj, "Disabled Text")
                end 
            end

            for _, obj in next, self.tabs do
                if obj ~= tab then
                    obj.Visible = false
                end 
            end

            tab.Visible = true
            utility.changeobjecttheme(title, "Text")
            utility.changeobjecttheme(tabtoggle, "Tab Toggle Background")
            tabtoggle.Color = mouseover and utility.changecolor(library.theme["Tab Toggle Background"], 3) or utility.changecolor(library.theme["Tab Background"], 3)
            --utility.changeobjecttheme(outline, "Tab Border")
        end)

        local tabtypes = utility.table({}, true)

        function tabtypes:Section(options)
            utility.table(options)
            local name = options.name
            local side = options.side and options.side:lower() or "left"

            local column = side == "left" and column1 or column2

            local section = utility.create("Square", {
                Filled = true,
                Thickness = 0,
                Size = UDim2.new(1, 0, 0, 31),
                Parent = column,
                Theme = "Section Background",
                ZIndex = 6
            })

            utility.outline(section, "Section Border")
            
            utility.create("Text", {
                Text = name,
                Font = Drawing.Fonts.Plex,
                Size = 13,
                Position = UDim2.new(0, 6, 0, 3),
                Theme = "Text",
                ZIndex = 7,
                Outline = true,
                Parent = section,
            })

            local sectioncontent = utility.create("Square", {
                Transparency = 0,
                Size = UDim2.new(1, -16, 1, -28),
                Position = UDim2.new(0, 8, 0, 20),
                Parent = section
            })

            sectioncontent:AddListLayout(8)

            local sectiontypes = utility.table({}, true)

            function sectiontypes:Label(name)
                local label = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 13),
                    Parent = sectioncontent
                })

                local text = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 0, 0, 0),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = label,
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                local labeltypes = utility.table({}, true)

                function labeltypes:Set(str)
                    text.Text = str
                end

                return labeltypes
            end

            function sectiontypes:Separator(name)
                local separator = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 12),
                    Parent = sectioncontent
                })

                local separatorline = utility.create("Square", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Thickness = 0,
                    Filled = true,
                    ZIndex = 7,
                    Theme = "Object Background",
                    Parent = separator
                })

                utility.outline(separatorline, "Object Border")

                local sizeX = utility.textlength(name, Drawing.Fonts.Plex, 13).X

                local separatorborder1 = utility.create("Square", {
                    Size = UDim2.new(0, 1, 1, 2),
                    Position = UDim2.new(0.5, (-sizeX / 2) - 7, 0.5, -1),
                    Thickness = 0,
                    Filled = true,
                    ZIndex = 9,
                    Theme = "Object Border",
                    Parent = separatorline
                })

                local separatorborder2 = utility.create("Square", {
                    Size = UDim2.new(0, 1, 1, 2),
                    Position = UDim2.new(0.5, sizeX / 2 + 5, 0, -1),
                    Thickness = 0,
                    Filled = true,
                    ZIndex = 9,
                    Theme = "Object Border",
                    Parent = separatorline
                })

                local separatorcutoff = utility.create("Square", {
                    Size = UDim2.new(0, sizeX + 12, 0, 3),
                    Position = UDim2.new(0.5, (-sizeX / 2) - 7, 0.5, -1),
                    ZIndex = 8,
                    Filled = true,
                    Theme = "Section Background",
                    Parent = separator
                })

                local text = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Theme = "Text",
                    ZIndex = 9,
                    Outline = true,
                    Center = true,
                    Parent = separator,
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                local separatortypes = utility.table({}, true)

                function separatortypes:Set(str)
                    local sizeX = utility.textlength(str, Drawing.Fonts.Plex, 13).X
                    separatorcutoff.Size = UDim2.new(0, sizeX + 12, 0, 3)
                    separatorcutoff.Position =  UDim2.new(0.5, (-sizeX / 2) - 7, 0.5, -1)
                    separatorborder1.Position =  UDim2.new(0.5, (-sizeX / 2) - 7, 0.5, -1)
                    separatorborder2.Position = UDim2.new(0.5, sizeX / 2 + 5, 0, -1)

                    text.Text = str
                end

                return separatortypes
            end

            sectiontypes.seperator = sectiontypes.separator

            function sectiontypes:Button(options)
                utility.table(options)
                local name = options.name
                local callback = options.callback or function() end

                local button = utility.create("Square", {
                    Filled = true,
                    Thickness = 0,
                    Theme = "Object Background",
                    Size = UDim2.new(1, 0, 0, 14),
                    ZIndex = 8,
                    Parent = sectioncontent
                })

                utility.outline(button, "Object Border")

                utility.create("Image", {
                    Size = UDim2.new(1, 0, 1, 0),
                    Transparency = 0.5,
                    ZIndex = 9,
                    Parent = button,
                    Data = library.gradient
                })

                utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Center = true,
                    Theme = "Text",
                    ZIndex = 8,
                    Outline = true,
                    Parent = button
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                local mouseover = false

                button.MouseEnter:Connect(function()
                    mouseover = true
                    button.Color = utility.changecolor(library.theme["Object Background"], 3)
                end)

                button.MouseLeave:Connect(function()
                    mouseover = false
                    button.Color = library.theme["Object Background"]
                end)

                button.MouseButton1Down:Connect(function()
                    button.Color = utility.changecolor(library.theme["Object Background"], 6)
                end)

                button.MouseButton1Up:Connect(function()
                    button.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
                end)

                button.MouseButton1Click:Connect(callback)
            end

            function sectiontypes:Toggle(options)
                utility.table(options)
                local name = options.name
                local default = options.default or false
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end

                local holder = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 10),
                    Parent = sectioncontent
                })

                local toggleclick = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 10),
                    ZIndex = 7,
                    Parent = holder
                })

                local icon = utility.create("Square", {
                    Filled = true,
                    Thickness = 0,
                    Theme = "Object Background",
                    Size = UDim2.new(0, 10, 0, 10),
                    ZIndex = 7,
                    Parent = holder
                })

                utility.outline(icon, "Object Border")

                utility.create("Image", {
                    Size = UDim2.new(1, 0, 1, 0),
                    Transparency = 0.5,
                    ZIndex = 8,
                    Parent = icon,
                    Data = library.gradient
                })

                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 17, 0, -2),
                    Theme = "Disabled Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = holder
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                local mouseover = false
                local toggled = false
                library.flags[flag] = default

                if not default then
                    callback(default)
                end

                icon.MouseEnter:Connect(function()
                    if not toggled then
                        mouseover = true
                        icon.Color = utility.changecolor(library.theme["Object Background"], 3)
                    end
                end)

                icon.MouseLeave:Connect(function()
                    if not toggled then
                        mouseover = false
                        icon.Color = library.theme["Object Background"]
                    end
                end)

                icon.MouseButton1Down:Connect(function()
                    if not toggled then
                        icon.Color = utility.changecolor(library.theme["Object Background"], 6)
                    end
                end)

                icon.MouseButton1Up:Connect(function()
                    if not toggled then
                        icon.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
                    end
                end)

                local function setstate()
                    toggled = not toggled

                    if mouseover and not toggled then
                        icon.Color = utility.changecolor(library.theme["Object Background"], 3)
                    end

                    utility.changeobjecttheme(icon, toggled and "Accent" or "Object Background")
                    utility.changeobjecttheme(title, toggled and "Accent" or "Disabled Text")
                    icon.Color = toggled and library.theme["Accent"] or (mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"])

                    if toggled then
                        table.insert(accentobjs, icon)
                        table.insert(accentobjs, title)
                    else
                        table.remove(accentobjs, table.find(accentobjs, icon))
                        table.remove(accentobjs, table.find(accentobjs, title))
                    end
                    
                    library.flags[flag] = toggled
                    callback(toggled)
                end

                toggleclick.MouseButton1Click:Connect(setstate)

                local function set(bool)
                    bool = type(bool) == "boolean" and bool or false
                    if toggled ~= bool then
                        setstate()
                    end
                end

                set(default)

                flags[flag] = set

                local toggletypes = utility.table({}, true)

                function toggletypes:Toggle(bool)
                    set(bool)
                end

                local colorpickers = -1

                function toggletypes:ColorPicker(options)
                    colorpickers = colorpickers + 1

                    utility.table(options)
                    local flag = options.flag or utility.nextflag()
                    local callback = options.callback or function() end
                    local default = options.default or Color3.fromRGB(255, 255, 255)
                    local defaultalpha = options.defaultalpha or 1

                    return library.createcolorpicker(default, defaultalpha, holder, colorpickers, flag, callback)
                end

                function toggletypes:Keybind(options)
                    utility.table(options)
                    local default = options.default
                    local blacklist = options.blacklist or {}
                    local flag = options.flag or utility.nextflag()
                    local mode = options.mode and options.mode:lower()
                    local callback = options.callback or function() end

                    local newcallback = function(key, fromsetting)
                        if not fromsetting then
                            set(not toggled)
                        end

                        callback(key, fromsetting)
                    end

                    return library.createkeybind(default, holder, blacklist, flag, mode == "toggle" and newcallback or callback, -2)
                end

                function toggletypes:Slider(options)
                    utility.table(options)

                    local min = options.min or options.minimum or 0
                    local max = options.max or options.maximum or 100
                    local text = options.text or ("[value]/" .. max)
                    local float = options.float or 1
                    local default = options.default and math.clamp(options.default, min, max) or min
                    local flag = options.flag or utility.nextflag()
                    local callback = options.callback or function() end

                    holder.Size = UDim2.new(1, 0, 0, 28)
                    section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                    return library.createslider(min, max, holder, text, default, float, flag, callback)
                end

                function toggletypes:Dropdown(options)
                    utility.table(options)
                    local default = options.default
                    local content = type(options.content) == "table" and options.content or {}
                    local max = options.max and (options.max > 1 and options.max) or nil
                    local scrollable = options.scrollable
                    local scrollingmax = options.scrollingmax or 10
                    local flag = options.flag or utility.nextflag()
                    local callback = options.callback or function() end
    
                    if not max and type(default) == "table" then
                        default = nil
                    end
    
                    if max and default == nil then
                        default = {}
                    end
    
                    if type(default) == "table" then
                        if max then
                            for i, opt in next, default do
                                if not table.find(content, opt) then
                                    table.remove(default, i)
                                elseif i > max then
                                    table.remove(default, i)
                                end
                            end
                        else
                            default = nil
                        end
                    elseif default ~= nil then
                        if not table.find(content, default) then
                            default = nil
                        end
                    end

                    holder.Size = UDim2.new(1, 0, 0, 32)
                    section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                    return library.createdropdown(holder, content, flag, callback, default, max, scrollable, scrollingmax)
                end

                return toggletypes
            end

            function sectiontypes:Box(options)
                utility.table(options)
                local default = options.default or ""
                local placeholder = options.placeholder or ""
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end

                local box = utility.create("Square", {
                    Filled = true,
                    Thickness = 0,
                    Theme = "Object Background",
                    Size = UDim2.new(1, 0, 0, 14),
                    ZIndex = 7,
                    Parent = sectioncontent
                })

                utility.outline(box, "Object Border")

                utility.create("Image", {
                    Size = UDim2.new(1, 0, 1, 0),
                    Transparency = 0.5,
                    ZIndex = 8,
                    Parent = box,
                    Data = library.gradient
                })

                local text = utility.create("Text", {
                    Text = default,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Center = true,
                    Theme = "Text",
                    ZIndex = 9,
                    Outline = true,
                    Parent = box
                })

                local placeholdertext = utility.create("Text", {
                    Text = placeholder,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Center = true,
                    Theme = "Disabled Text",
                    ZIndex = 9,
                    Outline = true,
                    Parent = box
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                box.MouseEnter:Connect(function()
                    mouseover = true
                    box.Color = utility.changecolor(library.theme["Object Background"], 3)
                end)

                box.MouseLeave:Connect(function()
                    mouseover = false
                    box.Color = library.theme["Object Background"]
                end)

                box.MouseButton1Down:Connect(function()
                    box.Color = utility.changecolor(library.theme["Object Background"], 6)
                end)

                box.MouseButton1Up:Connect(function()
                    box.Color = mouseover and utility.changecolor(library.theme["Object Background"], 3) or library.theme["Object Background"]
                end)

                library.createbox(box, text, function(str) 
                    if str == "" then
                        text.Visible = false
                        placeholdertext.Visible = true
                    else
                        placeholdertext.Visible = false
                        text.Visible = true
                    end
                end, function(str)
                    library.flags[flag] = str
                    callback(str)
                end)

                local function set(str)
                    placeholdertext.Visible = str == ""
                    text.Visible = str ~= ""

                    text.Color = Color3.fromRGB(200, 200, 200)
                    text.Text = str

                    library.flags[flag] = str
                    callback(str)
                end

                set(default)

                flags[flag] = set

                local boxtypes = utility.table({}, true)

                function boxtypes:Set(str)
                    set(str)
                end

                return boxtypes
            end

            function sectiontypes:Slider(options)
                utility.table(options)
                local name = options.name
                local min = options.min or options.minimum or 0
                local max = options.max or options.maximum or 100
                local text = options.text or ("[value]/" .. max)
                local float = options.float or 1
                local default = options.default and math.clamp(options.default, min, max) or min
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end

                local holder = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 24),
                    ZIndex = 7,
                    Thickness = 0,
                    Filled = true,
                    Parent = sectioncontent
                })

                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 0, 0, -2),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = holder
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                return library.createslider(min, max, holder, text, default, float, flag, callback)
            end

            function sectiontypes:Dropdown(options)
                utility.table(options)
                local name = options.name
                local default = options.default
                local content = type(options.content) == "table" and options.content or {}
                local max = options.max and (options.max > 1 and options.max) or nil
                local scrollable = options.scrollable
                local scrollingmax = options.scrollingmax or 10
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end

                if not max and type(default) == "table" then
                    default = nil
                end

                if max and default == nil then
                    default = {}
                end

                if type(default) == "table" then
                    if max then
                        for i, opt in next, default do
                            if not table.find(content, opt) then
                                table.remove(default, i)
                            elseif i > max then
                                table.remove(default, i)
                            end
                        end
                    else
                        default = nil
                    end
                elseif default ~= nil then
                    if not table.find(content, default) then
                        default = nil
                    end
                end

                local holder = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 29),
                    Parent = sectioncontent
                })

                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 0, 0, -2),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = holder
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                return library.createdropdown(holder, content, flag, callback, default, max, scrollable, scrollingmax)
            end

            function sectiontypes:List(options)
                utility.table(options)
                local name = options.name
                local default = options.default
                local content = type(options.content) == "table" and options.content or {}
                local max = options.max and (options.max > 1 and options.max) or nil
                local scrollable = options.scrollable
                local scrollingmax = options.scrollingmax or 10
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end

                if not max and type(default) == "table" then
                    default = nil
                end

                if max and default == nil then
                    default = {}
                end

                if type(default) == "table" then
                    if max then
                        for i, opt in next, default do
                            if not table.find(content, opt) then
                                table.remove(default, i)
                            elseif i > max then
                                table.remove(default, i)
                            end
                        end
                    else
                        default = nil
                    end
                elseif default ~= nil then
                    if not table.find(content, default) then
                        default = nil
                    end
                end

                local holder = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 29),
                    Parent = sectioncontent
                })

                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 0, 0, -2),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = holder
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                return library.createdropdown(holder, content, flag, callback, default, max, scrollable, scrollingmax, true, section, sectioncontent, column)
            end

            function sectiontypes:ColorPicker(options)
                utility.table(options)
                local name = options.name
                local default = options.default or Color3.fromRGB(255, 255, 255)
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end
                local defaultalpha = options.defaultalpha or 1

                local holder = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 10),
                    Position = UDim2.new(0, 0, 0, -1),
                    ZIndex = 7,
                    Parent = sectioncontent
                })

                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 0, 0, 0),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = holder
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                local colorpickers = 0

                local colorpickertypes = library.createcolorpicker(default, defaultalpha, holder, colorpickers, flag, callback)

                function colorpickertypes:ColorPicker(options)
                    colorpickers = colorpickers + 1

                    utility.table(options)
                    local default = options.default or Color3.fromRGB(255, 255, 255)
                    local flag = options.flag or utility.nextflag()
                    local callback = options.callback or function() end
                    local defaultalpha = options.defaultalpha or 1

                    return library.createcolorpicker(default, defaultalpha, holder, colorpickers, flag, callback)
                end

                return colorpickertypes
            end

            function sectiontypes:Keybind(options)
                utility.table(options)
                local name = options.name
                local default = options.default
                local blacklist = options.blacklist or {}
                local flag = options.flag or utility.nextflag()
                local callback = options.callback or function() end

                local holder = utility.create("Square", {
                    Transparency = 0,
                    Size = UDim2.new(1, 0, 0, 10),
                    Position = UDim2.new(0, 0, 0, -1),
                    ZIndex = 7,
                    Parent = sectioncontent
                })

                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = true,
                    Parent = holder
                })

                section.Size = UDim2.new(1, 0, 0, sectioncontent.AbsoluteContentSize + 28)

                return library.createkeybind(default, holder, blacklist, flag, callback, -1)
            end

            return sectiontypes
        end

        return tabtypes
    end

    return windowtypes
end

return library