-- Script Path: game:GetService("ReplicatedStorage").NewIcon.TopbarPlusReference
-- Took 0.2s to decompile.
-- Executor: Delta (1.0.714.1091)

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
return {
    addToReplicatedStorage = function() --[[ Line: 9 ]] --[[ Name: addToReplicatedStorage ]]
        -- upvalues: l_ReplicatedStorage_0 (copy)
        if l_ReplicatedStorage_0:FindFirstChild(script.Name) then
            return false;
        else
            local l_ObjectValue_0 = Instance.new("ObjectValue");
            l_ObjectValue_0.Name = script.Name;
            l_ObjectValue_0.Value = script.Parent;
            l_ObjectValue_0.Parent = l_ReplicatedStorage_0;
            return l_ObjectValue_0;
        end;
    end, 
    getObject = function() --[[ Line: 21 ]] --[[ Name: getObject ]]
        -- upvalues: l_ReplicatedStorage_0 (copy)
        local l_l_ReplicatedStorage_0_FirstChild_0 = l_ReplicatedStorage_0:FindFirstChild(script.Name);
        if l_l_ReplicatedStorage_0_FirstChild_0 then
            return l_l_ReplicatedStorage_0_FirstChild_0;
        else
            return false;
        end;
    end
};
