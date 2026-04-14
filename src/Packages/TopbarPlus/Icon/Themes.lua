-- Script Path: game:GetService("ReplicatedStorage").Icon.Themes
-- Took 0.2s to decompile.
-- Executor: Delta (1.0.714.1091)

local v0 = {};
for _, v2 in pairs(script:GetChildren()) do
    if v2:IsA("ModuleScript") then
        v0[v2.Name] = require(v2);
    end;
end;
return v0;
