-- Script Path: game:GetService("ReplicatedStorage").NewIcon.Signal
-- Took 0.21s to decompile.
-- Executor: Delta (1.0.714.1091)

local v0 = {};
v0.__index = v0;
local v1 = {};
v1.__index = v1;
local v2 = nil;
local function v5(v3, ...) --[[ Line: 50 ]] --[[ Name: RunHandlerInFreeThread ]]
    -- upvalues: v2 (ref)
    local l_v2_0 = v2;
    v2 = nil;
    v3(...);
    v2 = l_v2_0;
end;
local function v6() --[[ Line: 59 ]] --[[ Name: CreateFreeThread ]]
    -- upvalues: v2 (ref), v5 (copy)
    v2 = coroutine.running();
    while true do
        v5(coroutine.yield());
    end;
end;
v0.new = function() --[[ Line: 73 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    return (setmetatable({
        _active = true, 
        _head = nil
    }, v0));
end;
v0.Is = function(v7) --[[ Line: 95 ]] --[[ Name: Is ]]
    -- upvalues: v0 (copy)
    local v8 = false;
    if typeof(v7) == "table" then
        v8 = getmetatable(v7) == v0;
    end;
    return v8;
end;
v0.IsActive = function(v9) --[[ Line: 112 ]] --[[ Name: IsActive ]]
    return v9._active == true;
end;
v0.Connect = function(v10, v11) --[[ Line: 134 ]] --[[ Name: Connect ]]
    -- upvalues: v1 (copy)
    assert(typeof(v11) == "function", "Must be function");
    if v10._active ~= true then
        return (setmetatable({
            Connected = false, 
            _node = nil
        }, v1));
    else
        local l__head_0 = v10._head;
        local v13 = {
            _signal = v10, 
            _connection = nil, 
            _handler = v11, 
            _next = l__head_0, 
            _prev = nil
        };
        if l__head_0 ~= nil then
            l__head_0._prev = v13;
        end;
        v10._head = v13;
        local v14 = setmetatable({
            Connected = true, 
            _node = v13
        }, v1);
        v13._connection = v14;
        return v14;
    end;
end;
v0.ConnectOnce = function(v15, v16) --[[ Line: 195 ]] --[[ Name: ConnectOnce ]]
    assert(typeof(v16) == "function", "Must be function");
    local v17 = nil;
    v17 = v15:Connect(function(...) --[[ Line: 204 ]]
        -- upvalues: v17 (ref), v16 (copy)
        v17:Disconnect();
        v16(...);
    end);
end;
v0.Wait = function(v18) --[[ Line: 228 ]] --[[ Name: Wait ]]
    local v19 = nil;
    v19 = coroutine.running();
    local v20 = nil;
    do
        local l_v20_0 = v20;
        l_v20_0 = v18:Connect(function(...) --[[ Line: 233 ]]
            -- upvalues: l_v20_0 (ref), v19 (ref)
            l_v20_0:Disconnect();
            task.spawn(v19, ...);
        end);
    end;
    return coroutine.yield();
end;
v0.Fire = function(v22, ...) --[[ Line: 258 ]] --[[ Name: Fire ]]
    -- upvalues: v2 (ref), v6 (copy)
    local l__head_1 = v22._head;
    while l__head_1 ~= nil do
        if l__head_1._connection ~= nil then
            if v2 == nil then
                task.spawn(v6);
            end;
            task.spawn(v2, l__head_1._handler, ...);
        end;
        l__head_1 = l__head_1._next;
    end;
end;
v0.DisconnectAll = function(v24) --[[ Line: 289 ]] --[[ Name: DisconnectAll ]]
    local l__head_2 = v24._head;
    while l__head_2 ~= nil do
        local l__connection_0 = l__head_2._connection;
        if l__connection_0 ~= nil then
            l__connection_0.Connected = false;
            l__connection_0._node = nil;
            l__head_2._connection = nil;
        end;
        l__head_2 = l__head_2._next;
    end;
    v24._head = nil;
end;
v0.Destroy = function(v27) --[[ Line: 318 ]] --[[ Name: Destroy ]]
    if v27._active ~= true then
        return;
    else
        v27:DisconnectAll();
        v27._active = false;
        return;
    end;
end;
v1.Disconnect = function(v28) --[[ Line: 341 ]] --[[ Name: Disconnect ]]
    if v28.Connected ~= true then
        return;
    else
        v28.Connected = false;
        local l__node_0 = v28._node;
        local l__prev_0 = l__node_0._prev;
        local l__next_0 = l__node_0._next;
        if l__next_0 ~= nil then
            l__next_0._prev = l__prev_0;
        end;
        if l__prev_0 ~= nil then
            l__prev_0._next = l__next_0;
        else
            l__node_0._signal._head = l__next_0;
        end;
        l__node_0._connection = nil;
        v28._node = nil;
        return;
    end;
end;
v1.destroy = v1.Disconnect;
v1.Destroy = v1.Disconnect;
v1.disconnect = v1.Disconnect;
v0.destroy = v0.Destroy;
v0.Disconnect = v0.Destroy;
v0.disconnect = v0.Destroy;
v0.connect = v0.Connect;
v0.wait = v0.Wait;
v0.fire = v0.Fire;
return v0;
