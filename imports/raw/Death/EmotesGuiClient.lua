-- Script Path: game:GetService("Players").real_hiklo0.PlayerGui.Emotes.LocalScript
-- Took 2.08s to decompile.
-- Executor: Delta (1.0.714.1091)

repeat
    task.wait();
until game.IsLoaded;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_ImageLabel_0 = script.Parent.ImageLabel;
local _ = require(game.ReplicatedStorage.Emotes);
local l_Table_0 = require(game.ReplicatedStorage.Emotes):GetTable();
local l_Table_1 = require(game.ReplicatedStorage.Emotes):GetTable(true);
local v5 = nil;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GamepadEnabled_0 = l_UserInputService_0.GamepadEnabled;
local l_TouchEnabled_0 = l_UserInputService_0.TouchEnabled;
local v9 = require(game.ReplicatedStorage.ActionCheck);
local v10 = require(game.ReplicatedStorage.Info);
local v11 = {};
local _ = {};
local _ = {};
local v14 = Color3.fromRGB(255, 255, 255);
local v15 = Color3.fromRGB(171, 66, 66);
local v16 = Color3.fromRGB(255, 194, 38);
local l_ScrollingFrame_0 = script.ScrollingFrame;
local v18 = {};
local v19 = {};
local v20 = {};
local v21 = {
    "Boundless Rage", 
    "Final Stand", 
    "Divine Form", 
    "Inner Rage", 
    "Shadow Eruption", 
    "True Aura"
};
local v22 = {
    KillEmote = {
        Text = "Kill Emote", 
        AttributeName = "KillEmote", 
        Table = v20, 
        ImageColor3 = v15
    }, 
    MeleeEffects = {
        Text = "Melee Effect", 
        AttributeName = "MeleeEffect", 
        Table = v19, 
        ImageColor3 = v14
    }, 
    AuraEffect = {
        Text = "Aura Effect", 
        AttributeName = "AuraEffect", 
        Table = v21, 
        ImageColor3 = v16
    }
};
local l_ColorFrame_0 = script.ColorFrame;
l_ScrollingFrame_0:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 58 ]]
    -- upvalues: l_ScrollingFrame_0 (copy), l_ImageLabel_0 (copy), l_Table_1 (copy), l_ColorFrame_0 (copy)
    local v24 = l_ScrollingFrame_0.Parent == script;
    l_ImageLabel_0.Spin.Visible = v24;
    l_ImageLabel_0.Bulk.Visible = v24;
    l_ImageLabel_0.Limited.Visible = v24;
    if not v24 then
        local v25 = l_Table_1[l_ScrollingFrame_0.Parent:GetAttribute("Emote")];
        if v25 and v25.CanColor then
            l_ColorFrame_0.Parent = l_ScrollingFrame_0.Parent;
            return;
        end;
    else
        l_ColorFrame_0.Parent = script;
    end;
end);
local v26 = string.format("<font size=\"30\">CLAIM NEW EMOTE</font>\n<font size=\"18\">%s ME!</font>", l_TouchEnabled_0 and "PRESS" or "CLICK");
local v27 = {};
local v28 = {};
local v29 = {};
local function v40() --[[ Line: 86 ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v30 = {};
    for _, v32 in pairs(workspace.Live:GetChildren()) do
        if tostring(v32) ~= tostring(l_LocalPlayer_0) and v32:FindFirstChild("Humanoid") and v32:FindFirstChild("HumanoidRootPart") then
            local l_Humanoid_0 = v32:FindFirstChild("Humanoid");
            local l_HumanoidRootPart_0 = v32:FindFirstChild("HumanoidRootPart");
            if l_Humanoid_0.Health <= 0 and (l_HumanoidRootPart_0.Position - l_LocalPlayer_0.Character.PrimaryPart.Position).Magnitude <= 10 and not v32:FindFirstChild("KillEmoteFinished") and v32:FindFirstChild("Torso") and v32:FindFirstChild("Torso").Transparency ~= 1 and not v32:GetAttribute("KillEmoteBegan") then
                table.insert(v30, v32);
            end;
        end;
    end;
    local v35 = nil;
    local v36 = 20;
    for _, v38 in pairs(v30) do
        local l_Magnitude_0 = (v38:FindFirstChild("HumanoidRootPart").Position - l_LocalPlayer_0.Character.PrimaryPart.Position).Magnitude;
        if l_Magnitude_0 < v36 then
            v36 = l_Magnitude_0;
            v35 = v38;
        end;
    end;
    if workspace:GetAttribute("RoyaleCustom") then
        return nil;
    elseif v35 then
        return v35;
    else
        return;
    end;
end;
local function v59(v41, v42, v43) --[[ Line: 121 ]]
    -- upvalues: v18 (copy)
    local l_Radial_0 = v41.Radial;
    local v45 = (v42 or 16) / 160;
    l_Radial_0.Visible = true;
    local v46 = {
        "rbxassetid://95007903269647", 
        "rbxassetid://71926048514582", 
        "rbxassetid://111515469080408", 
        "rbxassetid://99378878471592", 
        "rbxassetid://124125109911613", 
        "rbxassetid://112905073377905", 
        "rbxassetid://94584979745998", 
        "rbxassetid://123498196278321", 
        "rbxassetid://98495583544127", 
        "rbxassetid://108071026812990"
    };
    local v47 = {};
    for v48, v49 in pairs(v46) do
        if v48 > 2 then
            local l_ImageLabel_1 = Instance.new("ImageLabel");
            l_ImageLabel_1.Size = UDim2.new(0.001, 0, 0.001, 0);
            l_ImageLabel_1.ImageTransparency = 0.99;
            l_ImageLabel_1.Image = v49;
            l_ImageLabel_1.BackgroundTransparency = 1;
            l_ImageLabel_1.Parent = l_Radial_0;
            table.insert(v47, l_ImageLabel_1);
        end;
    end;
    for _, v52 in pairs(v46) do
        l_Radial_0.Image = v52;
        for v53 = 3, 0, -1 do
            for v54 = 3, 0, -1 do
                local v55 = v54 * 225;
                local v56 = v53 * 225;
                l_Radial_0.ImageRectOffset = Vector2.new(v55, v56);
                task.wait(v45);
            end;
        end;
    end;
    v18[v43] = nil;
    l_Radial_0.Visible = false;
    for _, v58 in pairs(v47) do
        v58:Destroy();
    end;
end;
local function v109(v60, v61) --[[ Line: 169 ]]
    -- upvalues: l_ImageLabel_0 (copy), v29 (copy), v28 (copy), v27 (copy), l_Table_1 (copy), v21 (copy), v22 (copy), v20 (copy), v19 (copy), l_ScrollingFrame_0 (copy), l_LocalPlayer_0 (copy), v9 (copy), v40 (copy), v18 (copy), v59 (copy)
    local v62 = script.Frame:Clone();
    local l_Button_0 = v62.Button;
    local l_WorldModel_0 = v62.ViewportFrame.WorldModel;
    v62.Parent = l_ImageLabel_0;
    v62.Name = v61;
    v62.Position = v60;
    v29[v61] = v62;
    local l_Preview_0 = l_WorldModel_0.Preview;
    local l_Animation_0 = Instance.new("Animation");
    l_Animation_0.AnimationId = "rbxassetid://13716964686";
    l_Animation_0.Parent = l_Preview_0;
    local l_Camera_0 = Instance.new("Camera");
    l_Camera_0.CFrame = l_Preview_0.PrimaryPart.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0.3490658503988659, 3.141592653589793, 0);
    l_Camera_0.Parent = v62;
    v62.ViewportFrame.CurrentCamera = l_Camera_0;
    local v68 = l_Preview_0.Humanoid.Animator:LoadAnimation(l_Animation_0);
    v68.Looped = true;
    if l_ImageLabel_0.Visible then
        v68:Play();
    end;
    v28[l_Preview_0] = v68;
    table.insert(v27, l_Preview_0);
    local function v85() --[[ Line: 201 ]]
        -- upvalues: v62 (copy), l_Table_1 (ref), v21 (ref), v22 (ref), v20 (ref), v19 (ref)
        local v69 = string.byte((string.sub(v62.EmoteName.Text, 1, 1)));
        if tonumber((string.sub(v62.EmoteName.Text, 1, 1))) then
            v69 = 150;
        end;
        local v70 = v62:GetAttribute("Emote") or "Crush";
        for _, v72 in pairs(v62:GetChildren()) do
            if v72:IsA("TextLabel") and tostring(v72) == "Clone" then
                v72:Destroy();
            end;
        end;
        v62.EmoteName.Visible = true;
        v62.EmoteName.Text = v70;
        v62.EmoteProperty.Text = "2 Player";
        v62.EmoteProperty.Visible = v62:GetAttribute("Dual");
        v62.EmoteProperty.ZIndex = 3;
        v62.LayoutOrder = v69;
        local l_Fade_0 = v62.Fade;
        local v74 = l_Table_1[tostring(v70)];
        local l_v21_0 = v21;
        local v76 = false;
        for _, v78 in pairs(l_v21_0) do
            if tostring(v62:GetAttribute("Emote")) == v78 then
                v76 = true;
            end;
        end;
        if v74 and (v74.KillEmote or v74.MeleeEffects) or v76 then
            for _, v80 in pairs({
                "KillEmote", 
                "MeleeEffect", 
                "AuraEffect"
            }) do
                v62:SetAttribute(v80, false);
            end;
            local l_v22_0 = v22;
            if v76 then
                l_v22_0 = v22.AuraEffect;
            elseif v74.KillEmote then
                l_v22_0 = v22.KillEmote;
            elseif v22.MeleeEffects then
                l_v22_0 = v22.MeleeEffects;
            end;
            local l_EmoteProperty_0 = v62.EmoteProperty;
            l_EmoteProperty_0.Text = l_v22_0.Text;
            l_EmoteProperty_0.Visible = true;
            l_EmoteProperty_0.ZIndex = 30;
            l_Fade_0.ImageColor3 = l_v22_0.ImageColor3;
            v62:SetAttribute(l_v22_0.AttributeName, true);
            for _, v84 in pairs({
                v20, 
                v19
            }) do
                if table.find(v84, v62) then
                    table.remove(v84, table.find(v84, v62));
                end;
            end;
            if l_v22_0.Table and not table.find(l_v22_0.Table, v62) then
                table.insert(l_v22_0.Table, v62);
                return;
            end;
        else
            l_Fade_0.ImageColor3 = Color3.fromRGB(0, 0, 0);
            if table.find(v20, v62) then
                table.remove(v20, table.find(v20, v62));
                v62:SetAttribute("KillEmote", false);
            end;
        end;
    end;
    v62:GetAttributeChangedSignal("Emote"):Connect(v85);
    v85();
    v62:GetAttributeChangedSignal("Animation"):Connect(function() --[[ Line: 287 ]]
        -- upvalues: v68 (ref), v62 (copy), l_Preview_0 (copy), l_ImageLabel_0 (ref), v28 (ref)
        v68:Stop();
        local l_Animation_1 = Instance.new("Animation");
        l_Animation_1.AnimationId = v62:GetAttribute("Animation");
        l_Animation_1.Parent = l_Preview_0;
        v68 = l_Preview_0.Humanoid.Animator:LoadAnimation(l_Animation_1);
        v68.Looped = true;
        if l_ImageLabel_0.Visible then
            v68:Play();
        end;
        v28[l_Preview_0] = v68;
    end);
    local v87 = nil;
    l_Button_0.InputBegan:Connect(function(v88, v89) --[[ Line: 304 ]]
        -- upvalues: l_ImageLabel_0 (ref), v87 (ref), l_ScrollingFrame_0 (ref), v62 (copy), v61 (copy), v29 (ref), l_LocalPlayer_0 (ref), v9 (ref), v40 (ref), l_Table_1 (ref), v18 (ref), v59 (ref)
        if v89 then
            return;
        else
            if v88.UserInputType == Enum.UserInputType.MouseButton1 or v88.UserInputType == Enum.UserInputType.Touch then
                if not l_ImageLabel_0.Visible then
                    return;
                else
                    v87 = function() --[[ Line: 310 ]]
                        -- upvalues: v87 (ref)
                        v87 = nil;
                    end;
                    local v90 = tick();
                    repeat
                        if v87 then
                            task.wait();
                        end;
                    until not v87 or tick() - v90 > 0.5;
                    if tick() - v90 > 0.5 and v87 then
                        local v91 = l_ScrollingFrame_0.Parent == v62;
                        l_ScrollingFrame_0:SetAttribute("Number", v61);
                        l_ScrollingFrame_0.Parent = v91 and script or v62;
                        shared.sfx({
                            SoundId = "rbxassetid://5797580410", 
                            Parent = workspace, 
                            Volume = 0.75
                        }):Play();
                        for _, v93 in pairs(v29) do
                            if v93 ~= v62 then
                                v93.Visible = v91 and true or false;
                            end;
                        end;
                        return;
                    else
                        l_ScrollingFrame_0.Parent = script;
                        for _, v95 in pairs(v29) do
                            v95.Visible = true;
                        end;
                        l_ImageLabel_0.Visible = false;
                        local l_Character_0 = l_LocalPlayer_0.Character;
                        if l_Character_0 then
                            if l_Character_0:FindFirstChild("NoRotate") then
                                return;
                            elseif not l_Character_0:FindFirstChild("DoingEmote") and not v9:Check(l_Character_0, {
                                "Emote"
                            }) then
                                return;
                            elseif tick() - (l_Character_0:GetAttribute("_JustDashed") or 0) < 0.4 then
                                return;
                            else
                                if v62:GetAttribute("KillEmote") then
                                    local v97 = "YOU MUST BE NEXT TO A DEAD PLAYER TO USE THIS EMOTE!";
                                    local v98 = true;
                                    local v99 = v40();
                                    if not v99 then
                                        v98 = false;
                                    end;
                                    if v99 and v99:FindFirstChild("KillEmoteFinished") then
                                        v98 = false;
                                        v97 = "THIS PLAYER HAS ALREADY BEEN EMOTED ON!";
                                    end;
                                    if not v98 then
                                        shared.repfire({
                                            Effect = "Notification", 
                                            Message = v97
                                        });
                                        return;
                                    end;
                                end;
                                local v100 = v62:GetAttribute("Emote") or "Crush";
                                local l_Cooldown_0 = l_Table_1[v100].Cooldown;
                                if l_Cooldown_0 then
                                    if v18[v100] then
                                        return;
                                    elseif not v62.Radial.Visible then
                                        v62.Radial.Visible = true;
                                        v62.Radial.Image = "rbxassetid://95007903269647";
                                        v62.Radial.ImageRectOffset = Vector2.new(675, 675);
                                        v18[v100] = 1e999;
                                        task.spawn(function() --[[ Line: 394 ]]
                                            -- upvalues: l_Character_0 (copy), v100 (copy), v62 (ref), v18 (ref), l_Cooldown_0 (copy), v59 (ref)
                                            local v102 = nil;
                                            local v103 = tick();
                                            local v104 = nil;
                                            v104 = l_Character_0.ChildAdded:Connect(function(v105) --[[ Line: 397 ]]
                                                -- upvalues: v100 (ref), v102 (ref), v104 (ref)
                                                if v105.Name == "DoingEmote" and v105:GetAttribute("Name") == v100 then
                                                    v102 = v105;
                                                    return v104:Disconnect();
                                                else
                                                    return;
                                                end;
                                            end);
                                            repeat
                                                task.wait();
                                            until v102 or tick() - v103 > 1;
                                            v104:Disconnect();
                                            if tick() - v103 > 1 then
                                                v62.Radial.Visible = false;
                                                v18[v100] = nil;
                                                return;
                                            else
                                                if v102 and v102:GetAttribute("Name") == v100 then
                                                    local v106 = tick();
                                                    repeat
                                                        task.wait();
                                                    until not v102 or not v102.Parent or tick() - v106 > 13 or not l_Character_0.Parent;
                                                    if tick() - v106 > 13 then
                                                        v62.Radial.Visible = false;
                                                        v18[v100] = nil;
                                                        return;
                                                    else
                                                        v18[v100] = tick() + l_Cooldown_0;
                                                        task.spawn(v59, v62, l_Cooldown_0, v100);
                                                    end;
                                                else
                                                    v18[v100] = nil;
                                                end;
                                                return;
                                            end;
                                        end);
                                    else
                                        return;
                                    end;
                                end;
                                l_Character_0:SetAttribute("EmoteStarted", tick());
                                l_Character_0:SetAttribute("SideDashDisable", tick());
                                l_Character_0.Communicate:FireServer({
                                    Goal = "Emote", 
                                    Emote = v100
                                });
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end);
    l_Button_0.InputEnded:Connect(function(v107, v108) --[[ Line: 446 ]]
        -- upvalues: v87 (ref)
        if v108 then
            return;
        else
            if (v107.UserInputType == Enum.UserInputType.MouseButton1 or v107.UserInputType == Enum.UserInputType.Touch) and v87 then
                v87();
            end;
            return;
        end;
    end);
    return v62;
end;
local _ = tick();
local v111 = -100;
local v112 = {};
local function v134() --[[ Line: 462 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_ScrollingFrame_0 (copy), l_Table_1 (copy), v22 (copy), v111 (ref), v112 (copy), l_GamepadEnabled_0 (copy), v29 (copy)
    local v113 = l_LocalPlayer_0:GetAttribute("Emotes") or "[]";
    v113 = game:GetService("HttpService"):JSONDecode(v113);
    for v114 = 1, math.floor(#v113 / 2) do
        local v115 = #v113 - v114 + 1;
        local v116 = v113[v115];
        local v117 = v113[v114];
        v113[v114] = v116;
        v113[v115] = v117;
    end;
    for _, v119 in pairs(v113) do
        if not l_ScrollingFrame_0.ScrollingFrame:FindFirstChild(v119 .. "em") and l_Table_1[v119] then
            local v120 = script.TextButton:Clone();
            v120.Text = v119;
            v120.Name = v119 .. "em";
            local v121 = l_Table_1[tostring(v119)];
            local v122 = nil;
            local v123 = {};
            for v124, v125 in pairs(v22) do
                table.insert(v123, {
                    v124, 
                    v125.ImageColor3
                });
            end;
            for _, v127 in pairs(v123) do
                if v121 and v121[v127[1]] then
                    v122 = v127[2];
                end;
            end;
            if v122 then
                local v128 = script.EmoteGlow:Clone();
                v128.ImageColor3 = v122;
                v128.Parent = v120;
            end;
            if tonumber((string.sub(v120.Name:lower(), 1, 1))) then

            end;
            v120.Parent = l_ScrollingFrame_0.ScrollingFrame;
            local v129 = nil;
            if l_LocalPlayer_0 and l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("NewEmotes") then
                v129 = script.Glow:Clone();
                v129.Parent = v120;
                v120.LayoutOrder = v111;
                v111 = v111 - 1;
                l_ScrollingFrame_0.ScrollingFrame.CanvasPosition = Vector2.new(0, 0, 0, 0);
            end;
            v112[v120] = v129 or true;
            do
                local l_v129_0 = v129;
                if l_GamepadEnabled_0 then
                    v120.MouseButton1Click:Connect(function() --[[ Line: 515 ]]
                        -- upvalues: l_ScrollingFrame_0 (ref), v29 (ref), l_v129_0 (ref), l_LocalPlayer_0 (ref), v119 (copy)
                        l_ScrollingFrame_0.Parent = script;
                        for _, v132 in pairs(v29) do
                            v132.Visible = true;
                        end;
                        if l_v129_0 then
                            l_v129_0:Destroy();
                        end;
                        local l_Character_1 = l_LocalPlayer_0.Character;
                        if l_Character_1 then
                            shared.sfx({
                                SoundId = "rbxassetid://6493287948", 
                                Parent = workspace, 
                                Volume = 0.65
                            }):Play();
                            l_Character_1.Communicate:FireServer({
                                Goal = "EmoteLoadout", 
                                Emote = v119, 
                                Loadout = tonumber(l_ScrollingFrame_0:GetAttribute("Number") or 1)
                            });
                        end;
                    end);
                end;
            end;
        end;
    end;
end;
game:GetService("UserInputService").InputBegan:Connect(function(v135, _) --[[ Line: 543 ]]
    -- upvalues: l_LocalPlayer_0 (copy), v112 (copy), l_ScrollingFrame_0 (copy), v29 (copy)
    if v135.UserInputType == Enum.UserInputType.MouseButton1 or v135.UserInputType == Enum.UserInputType.Touch then
        local l_Position_0 = v135.Position;
        local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_Position_0.X, l_Position_0.Y);
        for _, v140 in pairs(l_GuiObjectsAtPosition_0) do
            if string.sub(v140.Name, #v140.Name - 1, #v140.Name) == "em" and v112[v140] then
                local v141 = v112[v140];
                l_ScrollingFrame_0.Parent = script;
                for _, v143 in pairs(v29) do
                    v143.Visible = true;
                end;
                if v141 and typeof(v141) == "Instance" then
                    v141:Destroy();
                end;
                local l_Character_2 = l_LocalPlayer_0.Character;
                if l_Character_2 then
                    shared.sfx({
                        SoundId = "rbxassetid://6493287948", 
                        Parent = workspace, 
                        Volume = 0.65
                    }):Play();
                    l_Character_2.Communicate:FireServer({
                        Goal = "EmoteLoadout", 
                        Emote = string.sub(v140.Name, 0, #v140.Name - 2), 
                        Loadout = tonumber(l_ScrollingFrame_0:GetAttribute("Number") or 1)
                    });
                    return;
                else
                    break;
                end;
            end;
        end;
    end;
end);
pcall(v134);
l_LocalPlayer_0:GetAttributeChangedSignal("Emotes"):Connect(function() --[[ Line: 580 ]]
    -- upvalues: v134 (copy)
    v134(true);
end);
local v145 = 0;
local function _(v146, v147) --[[ Line: 585 ]]
    return string.sub(string.lower(v146), 1, (string.len(v147))) == string.lower(v147);
end;
l_ScrollingFrame_0.Framechh.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 589 ]]
    -- upvalues: v145 (ref), l_ScrollingFrame_0 (copy)
    v145 = tick();
    task.delay(0.3, function() --[[ Line: 592 ]]
        -- upvalues: v145 (ref), l_ScrollingFrame_0 (ref)
        if tick() - v145 > 0.3 then
            local l_Text_0 = l_ScrollingFrame_0.Framechh.TextBox.Text;
            for _, v151 in pairs(l_ScrollingFrame_0.ScrollingFrame:GetChildren()) do
                if v151:IsA("TextButton") then
                    local v152 = false;
                    local l_Name_0 = v151.Name;
                    if string.sub(string.lower(l_Name_0), 1, (string.len(l_Text_0))) == string.lower(l_Text_0) then
                        v152 = true;
                    else
                        local v154 = v151.Name:split(" ");
                        if #v154 > 1 then
                            for _, v156 in pairs(v154) do
                                if string.sub(string.lower(v156), 1, (string.len(l_Text_0))) == string.lower(l_Text_0) then
                                    v152 = true;
                                    break;
                                end;
                            end;
                        end;
                    end;
                    if v152 then
                        v151.Visible = true;
                    else
                        v151.Visible = false;
                    end;
                end;
            end;
        end;
    end);
end);
local l_ScrollingFrame_1 = l_ScrollingFrame_0.ScrollingFrame;
local function v158() --[[ Line: 625 ]]
    -- upvalues: l_ScrollingFrame_1 (copy)
    l_ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, l_ScrollingFrame_1.UIListLayout.AbsoluteContentSize.Y);
end;
l_ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, l_ScrollingFrame_1.UIListLayout.AbsoluteContentSize.Y);
l_ScrollingFrame_1.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v158);
local function v166() --[[ Line: 632 ]]
    -- upvalues: l_LocalPlayer_0 (copy), v29 (copy), l_Table_1 (copy)
    local v159 = l_LocalPlayer_0:GetAttribute("EmoteLoadout") or "[]";
    v159 = game:GetService("HttpService"):JSONDecode(v159);
    for v160, v161 in pairs(v159) do
        local v162 = rawget(v29, (tonumber(v160)));
        if v162 then
            local v163 = false;
            if l_Table_1[v161] and l_Table_1[v161].Dual then
                v163 = true;
            end;
            v162:SetAttribute("Dual", v163);
            v162:SetAttribute("Emote", v161);
            local v164 = l_Table_1[v161] and l_Table_1[v161].Animation or l_Table_1.Crush.Animation;
            local _ = nil;
            v162:SetAttribute("Animation", if typeof(v164) == "Instance" then if game:GetService("RunService"):IsStudio() then game:GetService("KeyframeSequenceProvider"):RegisterKeyframeSequence(v164) else "rbxassetid://0" else "rbxassetid://" .. v164);
        end;
    end;
end;
local v167 = {
    UDim2.new(0.5, 0, 0.115, 0), 
    UDim2.new(0.095, 0, 0.5, 0), 
    UDim2.new(0.5, 0, 0.9, 0), 
    UDim2.new(0.903, 0, 0.498, 0)
};
local l_GamepadEnabled_1 = l_UserInputService_0.GamepadEnabled;
local v169 = {};
local v170 = false;
local v171 = false;
local function v187(v172) --[[ Line: 674 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_GamepadEnabled_1 (copy), l_ScrollingFrame_0 (copy), l_ImageLabel_0 (copy), v170 (ref), v171 (ref), v29 (copy), v27 (copy), v167 (copy), v109 (copy), v169 (copy)
    local l_Gamepass_0 = script.Parent.ImageLabel.Gamepass;
    l_Gamepass_0.Visible = not l_LocalPlayer_0:GetAttribute("ExtraSlots");
    if l_GamepadEnabled_1 then
        l_Gamepass_0.Visible = false;
    elseif not l_Gamepass_0.Visible then
        local l_GamepassTwo_0 = script.Parent.ImageLabel.GamepassTwo;
        l_GamepassTwo_0.Visible = not l_LocalPlayer_0:GetAttribute("EmoteSearchBar");
        if not l_GamepassTwo_0:GetAttribute("coddn") then
            l_GamepassTwo_0:SetAttribute("coddn", true);
            local function v175() --[[ Line: 686 ]]
                -- upvalues: l_LocalPlayer_0 (ref)
                game:GetService("MarketplaceService"):PromptGamePassPurchase(l_LocalPlayer_0, 793925178);
            end;
            l_GamepassTwo_0.Spin.MouseButton1Click:Connect(v175);
            l_GamepassTwo_0.MouseButton1Click:Connect(v175);
        end;
    end;
    local function v176() --[[ Line: 695 ]]
        -- upvalues: l_LocalPlayer_0 (ref)
        l_LocalPlayer_0.Character.Communicate:FireServer({
            Goal = "Prompt Emote Purchase"
        });
    end;
    if not l_Gamepass_0:GetAttribute("con") then
        l_Gamepass_0:SetAttribute("con", true);
        l_Gamepass_0.Spin.MouseButton1Click:Connect(v176);
        l_Gamepass_0.MouseButton1Click:Connect(v176);
        task.spawn(function() --[[ Line: 705 ]]
            -- upvalues: l_Gamepass_0 (copy)
            local l_ProductInfo_0 = game:GetService("MarketplaceService"):GetProductInfo(229966673, Enum.InfoType.GamePass);
            l_Gamepass_0.Spin.Text = string.gsub(l_Gamepass_0.Spin.Text, "99 ROBUX", l_ProductInfo_0.PriceInRobux .. " ROBUX");
        end);
    end;
    l_ScrollingFrame_0.Gamepass.Visible = false;
    if not l_LocalPlayer_0:GetAttribute("EmoteSearchBar") then

    end;
    l_ScrollingFrame_0.Framechh.Visible = true;
    if l_LocalPlayer_0:GetAttribute("EmoteSearchBar") then
        l_ImageLabel_0.Switch.Visible = true;
        if l_LocalPlayer_0:GetAttribute("ExtraSlots") then
            l_ImageLabel_0.Switch.Position = UDim2.new(0.5, 0, 0.5, 0);
        end;
    end;
    if l_LocalPlayer_0:GetAttribute("ExtraSlots") and not v170 then
        v170 = true;
        if v172 then
            l_ScrollingFrame_0.Parent = script;
            v171 = false;
            for _, v179 in pairs(v29) do
                v179:Destroy();
            end;
            table.clear(v27);
            table.clear(v29);
        end;
        script.Frame.Size = UDim2.new(0.285, 0, 0.285, 0);
        for _, v181 in pairs({
            UDim2.new(0.215, 0, 0.24, 0), 
            UDim2.new(0.785, 0, 0.24, 0), 
            UDim2.new(0.215, 0, 0.76, 0), 
            UDim2.new(0.785, 0, 0.76, 0)
        }) do
            table.insert(v167, v181);
        end;
        if v172 then
            for v182, v183 in pairs(v167) do
                v109(v183, v182);
            end;
        end;
    end;
    if not v171 then
        v171 = true;
        for v184, v185 in pairs(v167) do
            local v186 = v109(v185, #v167 + v184);
            v186.Button.Visible = false;
            v186.UIAspectRatioConstraint.AspectRatio = 1.0E-4;
            v186.Active = false;
            v169[v186] = true;
        end;
    end;
end;
v187();
for v188, v189 in pairs(v167) do
    v109(v189, v188);
end;
local v190 = false;
l_ImageLabel_0.Switch.MouseButton1Click:Connect(function() --[[ Line: 789 ]]
    -- upvalues: v29 (copy), v169 (copy), v190 (ref)
    shared.sfx({
        SoundId = "rbxassetid://5797580410", 
        Parent = workspace, 
        Volume = 0.75
    }):Play();
    for _, v192 in pairs(v29) do
        if not not v169[v192] == not v190 then
            v192.Button.Visible = true;
            v192.UIAspectRatioConstraint.AspectRatio = 1;
            v192.Active = true;
        else
            v192.UIAspectRatioConstraint.AspectRatio = 1.0E-4;
            v192.Button.Visible = false;
            v192.Active = false;
        end;
    end;
    v190 = not v190;
end);
l_ImageLabel_0:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 810 ]]
    -- upvalues: l_ImageLabel_0 (copy), v27 (copy), v28 (copy)
    if not l_ImageLabel_0.Visible then
        for _, v194 in pairs(v27) do
            for _, v196 in pairs(v194.Humanoid.Animator:GetPlayingAnimationTracks()) do
                v196:Stop();
            end;
        end;
        return;
    else
        for _, v198 in pairs(v27) do
            if v28[v198] then
                v28[v198]:Play(0);
            end;
        end;
        return;
    end;
end);
local l_CollectionService_0 = game:GetService("CollectionService");
l_ImageLabel_0.Visible = false;
local function v203(v200) --[[ Line: 829 ]]
    -- upvalues: v20 (copy)
    for _, v202 in pairs(v20) do
        if v202 and v202:FindFirstChild("EmoteProperty") then
            v202.EmoteProperty.Text = v200;
        end;
    end;
end;
local v204 = nil;
local v205 = nil;
local v206 = nil;
local function v214() --[[ Line: 838 ]] --[[ Name: timeUntilNextWeek ]]
    -- upvalues: v206 (ref), v204 (ref), v205 (ref)
    if not v206 then
        return "???";
    else
        local v207 = v204 + v205 * v206;
        local v208 = os.difftime(v207, os.time());
        local v209 = math.floor(v208 / 86400);
        v208 = v208 % 86400;
        local v210 = math.floor(v208 / 3600);
        v208 = v208 % 3600;
        local v211 = math.floor(v208 / 60);
        local v212 = v208 % 60;
        local v213 = {};
        if v209 > 0 then
            table.insert(v213, v209 .. "d");
        end;
        if v210 > 0 then
            table.insert(v213, v210 .. "h");
        end;
        if v211 > 0 then
            table.insert(v213, v211 .. "m");
        end;
        table.insert(v213, math.clamp(v212, 1, 60) .. "s");
        return table.concat(v213, " ");
    end;
end;
shared.emotegui = function(v215, v216) --[[ Line: 874 ]]
    -- upvalues: l_ImageLabel_0 (copy), l_LocalPlayer_0 (copy), l_ScrollingFrame_0 (copy), v29 (copy), v214 (copy), v40 (copy), v203 (copy), l_CollectionService_0 (copy)
    if v216 then
        return l_ImageLabel_0.Visible;
    else
        if not l_ImageLabel_0.Visible then
            local l_Children_0 = l_LocalPlayer_0.PlayerGui:GetChildren();
            l_LocalPlayer_0.Character.Communicate:FireServer({
                Goal = "Delete Guis", 
                guis = l_Children_0, 
                caller = script.Parent
            });
            for _, v219 in pairs(l_Children_0) do
                if v219.Name == "Cape Customization" or v219.Name == "Awakening Outfit" or v219.Name == "Kill Sound" then
                    game:GetService("Debris"):AddItem(v219, 0);
                elseif (v219.Name == "Emotes" or v219.Name == "Gifting" or v219.Name == "Cosmetics") and v219 ~= script.Parent.Parent then
                    if v219.Name == "Cosmetics" then
                        v219.Enabled = true;
                        v219.Enabled = false;
                    else
                        local v220 = v219:FindFirstChild("ImageLabel") or v219:FindFirstChild("Frame");
                        if v220 then
                            v220.Visible = true;
                            v220.Visible = false;
                        end;
                    end;
                end;
            end;
        end;
        if v215 ~= nil then
            l_ImageLabel_0.Visible = v215;
        else
            l_ImageLabel_0.Visible = v215 or not l_ImageLabel_0.Visible;
        end;
        if not l_ImageLabel_0.Visible then
            l_ScrollingFrame_0.Parent = script;
            for _, v222 in pairs(v29) do
                v222.Visible = true;
            end;
            for _ = 1, 10 do
                local l_Preview_1 = l_ImageLabel_0:FindFirstChild("Preview");
                if l_Preview_1 then
                    l_Preview_1:Destroy();
                else
                    break;
                end;
            end;
        else
            task.spawn(function() --[[ Line: 929 ]]
                -- upvalues: l_ImageLabel_0 (ref), v214 (ref), v40 (ref), v203 (ref)
                while l_ImageLabel_0.Visible do
                    l_ImageLabel_0.Limited.Timer.Timer.Text = "Leaving in " .. v214();
                    local v225 = v40();
                    if v225 and not v225:FindFirstChild("KillEmoteFinished") then
                        v203("USE!");
                    else
                        v203("Kill Emote");
                    end;
                    task.wait(0.1);
                end;
            end);
        end;
        for _, v227 in pairs(l_CollectionService_0:GetTagged("gamewins")) do
            v227.Visible = not l_ImageLabel_0.Visible;
        end;
        return;
    end;
end;
pcall(v166);
l_LocalPlayer_0:GetAttributeChangedSignal("EmoteLoadout"):Connect(v166);
l_LocalPlayer_0:GetAttributeChangedSignal("ExtraSlots"):Connect(function() --[[ Line: 955 ]]
    -- upvalues: v187 (copy), v166 (copy)
    v187(true);
    v166();
end);
l_LocalPlayer_0:GetAttributeChangedSignal("EmoteSearchBar"):Connect(function() --[[ Line: 959 ]]
    -- upvalues: v187 (copy)
    v187(true);
end);
local l_EmoteProducts_0 = v10.EmoteProducts;
local function v241() --[[ Line: 966 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Table_0 (copy), v11 (copy), l_EmoteProducts_0 (copy), l_ImageLabel_0 (copy), v26 (ref)
    local v229 = l_LocalPlayer_0:GetAttribute("LastEmoteSpin") or -100;
    local v230 = (l_LocalPlayer_0:GetAttribute("TotalKillsFrb") or 0) - v229;
    local v231 = true;
    local v232 = 0;
    local v233 = game:GetService("HttpService"):JSONDecode(l_LocalPlayer_0:GetAttribute("Emotes") or "[]");
    for v234, _ in pairs(l_Table_0) do
        if not table.find(v233, v234) then
            v231 = false;
            v232 = v232 + 1;
        end;
    end;
    for v236, v237 in pairs(v11) do
        if table.find(v233, v236) then
            v237.Spin.Text = ("<font size=\"45\">%s</font>\n<font color=\"rgb(158, 255, 174)\" transparency=\"1\"><stroke transparency=\"1\" color=\"#00A2FF\" thickness=\"0\">188 ROBUX</stroke></font>"):format(v236);
            v237.Spin.Check.Visible = true;
        end;
    end;
    for _, v239 in pairs(l_EmoteProducts_0) do
        if v239.button then
            if v231 or v232 < v239.count then
                v239.button.Visible = false;
            else
                v239.button.Visible = true;
            end;
        end;
    end;
    if workspace:FindFirstChild("Duel Choice") or workspace:GetAttribute("RankedOnes") then
        l_ImageLabel_0.Spin.Text = "";
        l_ImageLabel_0.Spin.Position = UDim2.new(5, 0, 5, 0);
        return;
    elseif v231 then
        l_ImageLabel_0.Spin.Text = "";
        return;
    elseif v230 < 50 then
        v230 = 50 - v230;
        l_ImageLabel_0.Spin.Text = string.format("NEW EMOTE: <font color=\"rgb(255, 85, 85)\">%s KILLS</font>\n<font size=\"16\">HOLD EMOTE DOWN TO CHANGE</font>", v230);
        return;
    else
        if l_ImageLabel_0.Spin.Text ~= v26 and l_LocalPlayer_0:GetAttribute("HandlerLoaded") then
            if shared.notifyemote then
                shared.notifyemote();
            else
                local v240 = tick();
                task.spawn(function() --[[ Line: 1020 ]]
                    -- upvalues: v240 (copy)
                    repeat
                        task.wait();
                    until tick() - v240 > 5 or shared.notifyemote;
                    if shared.notifyemote then
                        shared.notifyemote();
                    end;
                end);
            end;
        end;
        l_ImageLabel_0.Spin.Text = v26;
        return;
    end;
end;
l_ImageLabel_0.Spin.MouseButton1Click:Connect(function() --[[ Line: 1034 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_ImageLabel_0 (copy), v26 (ref)
    local l_Character_3 = l_LocalPlayer_0.Character;
    if l_Character_3 then
        if l_ImageLabel_0.Spin.Text == "" then
            return;
        elseif workspace:GetAttribute("RankedOnes") then
            l_ImageLabel_0.Spin.Visible = false;
            l_ImageLabel_0.Spin.Position = UDim2.new(3, 0, 3, 0);
            return;
        elseif l_ImageLabel_0.Spin.Text == v26 then
            shared.sfx({
                SoundId = "rbxassetid://4612384643", 
                Parent = workspace, 
                Volume = 0.6
            }):Play();
            l_Character_3.Communicate:FireServer({
                Goal = "Emote Spin"
            });
        end;
    end;
end);
for _, v244 in pairs({
    "TotalKillsFrb", 
    "LastEmoteSpin", 
    "Emotes", 
    "HandlerLoaded", 
    "CanBuyRandom"
}) do
    l_LocalPlayer_0:GetAttributeChangedSignal(v244):Connect(v241);
end;
v241();
v5 = v241;
local l_Bulk_0 = l_ImageLabel_0.Bulk;
local l_ImageButton_0 = l_Bulk_0.ImageButton;
l_ImageButton_0.Name = "GP";
l_ImageButton_0.Parent = script;
for _, v248 in pairs(l_EmoteProducts_0) do
    local l_id_0 = v248.id;
    local l_ProductInfo_1 = game:GetService("MarketplaceService"):GetProductInfo(l_id_0, Enum.InfoType.Product);
    local v251 = l_ImageButton_0:Clone();
    v251.Visible = false;
    v251.Parent = l_Bulk_0;
    v251.Spin.Text = string.format("<font size=\"45\">%s</font>\n<font size=\"35\" color=\"rgb(158, 255, 174)\">%s ROBUX</font>", v248.count .. " " .. (v248.count > 1 and "EMOTES" or "EMOTE"), l_ProductInfo_1.PriceInRobux);
    v251.Image = "rbxassetid://" .. 15079675105;
    v251.MouseButton1Click:Connect(function() --[[ Line: 1090 ]]
        -- upvalues: l_LocalPlayer_0 (copy), v248 (copy)
        if not l_LocalPlayer_0:GetAttribute("CanBuyRandom") then
            return;
        else
            game:GetService("MarketplaceService"):PromptProductPurchase(l_LocalPlayer_0, v248.id);
            return;
        end;
    end);
    v248.button = v251;
end;
v241();
getRarityColor = function(v252) --[[ Line: 1105 ]] --[[ Name: getRarityColor ]]
    v252 = math.clamp(v252, 100, 799);
    local v253 = {
        {
            threshold = 250, 
            color = Color3.fromRGB(255, 255, 255)
        }, 
        {
            threshold = 400, 
            color = Color3.fromRGB(130, 255, 128)
        }, 
        {
            threshold = 550, 
            color = Color3.fromRGB(92, 135, 255)
        }, 
        {
            threshold = 700, 
            color = Color3.fromRGB(255, 165, 0)
        }, 
        {
            threshold = 799, 
            color = Color3.fromRGB(255, 79, 79)
        }
    };
    for _, v255 in ipairs(v253) do
        if v252 <= v255.threshold then
            return v255.color;
        end;
    end;
    return v253[#v253].color;
end;
l_Bulk_0 = l_ImageLabel_0.Limited;
l_ImageButton_0 = l_Bulk_0.List.ImageButton;
l_ImageButton_0.Parent = script;
local function v261() --[[ Line: 1128 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Bulk_0 (copy)
    local v256 = game:GetService("HttpService"):JSONDecode(l_LocalPlayer_0:GetAttribute("LimitedPreview") or "[]");
    for _, v258 in pairs(l_Bulk_0.List:GetChildren()) do
        local l_v258_Attribute_0 = v258:GetAttribute("ID");
        if v258:IsA("ImageButton") and l_v258_Attribute_0 then
            l_v258_Attribute_0 = tostring(l_v258_Attribute_0);
            local l_New_0 = v258:FindFirstChild("New");
            if l_New_0 then
                l_New_0.Visible = not v256[l_v258_Attribute_0];
            end;
        end;
    end;
end;
local function v279() --[[ Line: 1143 ]]
    -- upvalues: l_Bulk_0 (copy), v11 (copy), l_ImageButton_0 (copy), l_Table_1 (copy), v22 (copy), l_ImageLabel_0 (copy), l_LocalPlayer_0 (copy), v204 (ref), v205 (ref), v206 (ref), v261 (copy), v241 (copy)
    local l_workspace_Attribute_0 = workspace:GetAttribute("Limited");
    if not l_workspace_Attribute_0 then
        return;
    else
        l_workspace_Attribute_0 = game:GetService("HttpService"):JSONDecode(l_workspace_Attribute_0);
        for _, v264 in pairs(l_Bulk_0.List:GetChildren()) do
            if v264:IsA("ImageButton") then
                v264:Destroy();
            end;
        end;
        table.clear(v11);
        local v265 = 0;
        for _, v267 in pairs(l_workspace_Attribute_0.items) do
            v265 = v265 + 1;
            local v268 = l_ImageButton_0:Clone();
            v268:SetAttribute("ID", v267.ID);
            v268.Spin.Text = ("<font size=\"45\">%s</font>\n<font color=\"rgb(158, 255, 174)\">%s ROBUX</font>"):format(v267.Name, v267.Price);
            v268.Image = "rbxassetid://" .. v267.Image;
            local v269 = l_Table_1[tostring(v267.Name)];
            local v270 = nil;
            local v271 = {};
            for v272, v273 in pairs(v22) do
                table.insert(v271, {
                    v272, 
                    v273.ImageColor3
                });
            end;
            for _, v275 in pairs(v271) do
                if v269 and v269[v275[1]] then
                    v270 = v275[2];
                end;
            end;
            if v270 then
                v268.Glow.ImageColor3 = v270;
            end;
            v268.Parent = l_Bulk_0.List;
            v268.Visible = true;
            if v269 and v269.Preview then
                v268.Preview.Visible = true;
                v268.Preview.MouseButton1Click:Connect(function() --[[ Line: 1183 ]]
                    -- upvalues: l_ImageLabel_0 (ref), v268 (copy), v269 (copy), l_LocalPlayer_0 (ref), v267 (copy)
                    if l_ImageLabel_0:FindFirstChild("Preview") then
                        return;
                    else
                        shared.sfx({
                            SoundId = "rbxassetid://10066921516", 
                            Parent = workspace, 
                            Volume = 0.25
                        }):Play();
                        local v276 = script.Preview:Clone();
                        v276.Loading.LocalScript.Enabled = true;
                        v276.Origin.Value = v268.Preview;
                        v276:SetAttribute("ID", v269.Preview);
                        v276.Parent = l_ImageLabel_0;
                        l_LocalPlayer_0.Character.Communicate:FireServer({
                            Goal = "Limited Preview", 
                            Limited = v267.ID
                        });
                        return;
                    end;
                end);
            else
                v268.Preview.Visible = false;
            end;
            v268.MouseButton1Click:Connect(function() --[[ Line: 1228 ]]
                -- upvalues: l_LocalPlayer_0 (ref), v267 (copy)
                l_LocalPlayer_0.Character.Communicate:FireServer({
                    Goal = "Prompt Limited Purchase", 
                    Limited = v267.Number
                });
            end);
            v11[v267.Name] = v268;
        end;
        local v277 = ({
            [1] = 0.317, 
            [2] = 0.151, 
            [3] = -0.01
        })[v265] or -0.01;
        local l_Timer_0 = l_ImageLabel_0.Limited.Timer;
        l_Timer_0.Position = UDim2.new(l_Timer_0.Position.X.Scale, l_Timer_0.Position.X.Offset, v277, l_Timer_0.Position.Y.Offset);
        v204 = l_workspace_Attribute_0.info.startOfYear;
        v205 = l_workspace_Attribute_0.info.currentWeek;
        v206 = l_workspace_Attribute_0.info.secondsInWeek;
        v261();
        v241();
        return;
    end;
end;
workspace:GetAttributeChangedSignal("Limited"):Connect(v279);
pcall(v279);
l_LocalPlayer_0:GetAttributeChangedSignal("LimitedPreview"):Connect(v261);
