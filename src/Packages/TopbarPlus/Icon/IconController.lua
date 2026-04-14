-- Script Path: game:GetService("ReplicatedStorage").Icon.IconController
-- Took 0.7s to decompile.
-- Executor: Delta (1.0.714.1091)

local l_StarterGui_0 = game:GetService("StarterGui");
local l_GuiService_0 = game:GetService("GuiService");
local l_HapticService_0 = game:GetService("HapticService");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_VRService_0 = game:GetService("VRService");
local l_VoiceChatService_0 = game:GetService("VoiceChatService");
local l_LocalizationService_0 = game:GetService("LocalizationService");
local l_Parent_0 = script.Parent;
local v11 = require(l_Parent_0.TopbarPlusReference);
local v12 = v11.getObject();
local v13 = v12 and v12.Value;
if v13 and v13.IconController ~= script then
    return require(v13.IconController);
else
    if not v12 then
        v11.addToReplicatedStorage();
    end;
    local v14 = {};
    local v15 = require(l_Parent_0.Signal);
    local v16 = require(l_Parent_0.TopbarPlusGui);
    local v17 = {};
    local v18 = false;
    local v19 = nil;
    local v20 = false;
    local v21 = nil;
    local v22 = nil;
    local v23 = l_RunService_0:IsStudio();
    local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    local v25 = false;
    local v26 = false;
    local _ = function() --[[ Line: 40 ]] --[[ Name: checkTopbarEnabled ]]
        -- upvalues: l_StarterGui_0 (copy)
        local v28, v29 = xpcall(function() --[[ Line: 41 ]]
            -- upvalues: l_StarterGui_0 (ref)
            return l_StarterGui_0:GetCore("TopbarEnabled");
        end, function(_) --[[ Line: 43 ]]
            return true;
        end);
        return v28 and v29;
    end;
    local _ = function() --[[ Line: 50 ]] --[[ Name: checkTopbarEnabledAccountingForMimic ]]
        -- upvalues: l_StarterGui_0 (copy), v14 (copy)
        local v32, v33 = xpcall(function() --[[ Line: 41 ]]
            -- upvalues: l_StarterGui_0 (ref)
            return l_StarterGui_0:GetCore("TopbarEnabled");
        end, function(_) --[[ Line: 43 ]]
            return true;
        end);
        return v32 and v33 or not v14.mimicCoreGui;
    end;
    local function v35() --[[ Line: 56 ]] --[[ Name: bindCamera ]]
        -- upvalues: v21 (ref), v14 (copy)
        if not workspace.CurrentCamera then
            return;
        else
            if v21 and v21.Connected then
                v21:Disconnect();
            end;
            v21 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(v14.updateTopbar);
            return;
        end;
    end;
    local v36 = {};
    v36.left = {
        startScale = 0, 
        getOffset = function() --[[ Line: 68 ]] --[[ Name: getOffset ]]
            -- upvalues: v14 (copy), l_StarterGui_0 (copy), v25 (ref), v23 (copy)
            local v37 = 48 + v14.leftOffset;
            local v39, v40 = xpcall(function() --[[ Line: 41 ]]
                -- upvalues: l_StarterGui_0 (ref)
                return l_StarterGui_0:GetCore("TopbarEnabled");
            end, function(_) --[[ Line: 43 ]]
                return true;
            end);
            if v39 and v40 then
                local l_l_StarterGui_0_CoreGuiEnabled_0 = l_StarterGui_0:GetCoreGuiEnabled("Chat");
                if l_l_StarterGui_0_CoreGuiEnabled_0 then
                    v37 = v37 + 44;
                end;
                if v25 and not v23 then
                    if l_l_StarterGui_0_CoreGuiEnabled_0 then
                        return v37 + 67;
                    else
                        v37 = v37 + 43;
                    end;
                end;
            end;
            return v37;
        end, 
        getStartOffset = function() --[[ Line: 85 ]] --[[ Name: getStartOffset ]]
            -- upvalues: v14 (copy), v36 (copy)
            local l_leftGap_0 = v14.leftGap;
            return v36.left.getOffset() + l_leftGap_0;
        end, 
        records = {}
    };
    v36.mid = {
        startScale = 0.5, 
        getOffset = function() --[[ Line: 94 ]] --[[ Name: getOffset ]]
            return 0;
        end, 
        getStartOffset = function(v43) --[[ Line: 97 ]] --[[ Name: getStartOffset ]]
            -- upvalues: v14 (copy)
            local l_midGap_0 = v14.midGap;
            return -v43 / 2 + l_midGap_0 / 2;
        end, 
        records = {}
    };
    v36.right = {
        startScale = 1, 
        getOffset = function() --[[ Line: 105 ]] --[[ Name: getOffset ]]
            -- upvalues: v14 (copy), l_LocalPlayer_0 (copy), l_StarterGui_0 (copy), l_VRService_0 (copy)
            local l_rightOffset_0 = v14.rightOffset;
            local l_Character_0 = l_LocalPlayer_0.Character;
            local v47 = l_Character_0 and l_Character_0:FindFirstChild("Humanoid");
            local v48 = if v47 then v47.RigType == Enum.HumanoidRigType.R6 else false;
            local v50, v51 = xpcall(function() --[[ Line: 41 ]]
                -- upvalues: l_StarterGui_0 (ref)
                return l_StarterGui_0:GetCore("TopbarEnabled");
            end, function(_) --[[ Line: 43 ]]
                return true;
            end);
            if (v50 and v51 or l_VRService_0.VREnabled) and (l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) or l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) or not v48 and l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)) then
                l_rightOffset_0 = l_rightOffset_0 + 48;
            end;
            return l_rightOffset_0;
        end, 
        getStartOffset = function(v52) --[[ Line: 115 ]] --[[ Name: getStartOffset ]]
            -- upvalues: v36 (copy)
            return -v52 - v36.right.getOffset();
        end, 
        records = {}
    };
    v14.topbarEnabled = true;
    v14.controllerModeEnabled = false;
    local v54, v55 = xpcall(function() --[[ Line: 41 ]]
        -- upvalues: l_StarterGui_0 (copy)
        return l_StarterGui_0:GetCore("TopbarEnabled");
    end, function(_) --[[ Line: 43 ]]
        return true;
    end);
    v14.previousTopbarEnabled = v54 and v55;
    v14.leftGap = 12;
    v14.midGap = 12;
    v14.rightGap = 12;
    v14.leftOffset = 0;
    v14.rightOffset = 0;
    v14.voiceChatEnabled = true;
    v14.mimicCoreGui = true;
    v14.healthbarDisabled = false;
    v14.activeButtonBCallbacks = 0;
    v14.disableButtonB = false;
    v14.translator = l_LocalizationService_0:GetTranslatorForPlayer(l_LocalPlayer_0);
    v14.iconAdded = v15.new();
    v14.iconRemoved = v15.new();
    v14.controllerModeStarted = v15.new();
    v14.controllerModeEnded = v15.new();
    v14.healthbarDisabledSignal = v15.new();
    local v56 = 0;
    v14.iconAdded:Connect(function(v57) --[[ Line: 154 ]]
        -- upvalues: v17 (copy), v14 (copy), v56 (ref)
        v17[v57] = true;
        if v14.gameTheme then
            v57:setTheme(v14.gameTheme);
        end;
        v57.updated:Connect(function() --[[ Line: 159 ]]
            -- upvalues: v14 (ref)
            v14.updateTopbar();
        end);
        v57.selected:Connect(function() --[[ Line: 163 ]]
            -- upvalues: v14 (ref), v57 (copy)
            local v58 = v14.getIcons();
            for _, v60 in pairs(v58) do
                if v57.deselectWhenOtherIconSelected and v60 ~= v57 and v60.deselectWhenOtherIconSelected and v60:getToggleState() == "selected" then
                    v60:deselect(v57);
                end;
            end;
        end);
        v56 = v56 + 1;
        v57:setOrder(v56);
        if v14.controllerModeEnabled then
            v14._enableControllerModeForIcon(v57, true);
        end;
        v14:_updateSelectionGroup();
        v14.updateTopbar();
    end);
    v14.iconRemoved:Connect(function(v61) --[[ Line: 182 ]]
        -- upvalues: v17 (copy), v14 (copy)
        v17[v61] = nil;
        v61:setEnabled(false);
        v61:deselect();
        v61.updated:Fire();
        v14:_updateSelectionGroup();
    end);
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v35);
    v14.setGameTheme = function(v62) --[[ Line: 194 ]] --[[ Name: setGameTheme ]]
        -- upvalues: v14 (copy)
        v14.gameTheme = v62;
        local v63 = v14.getIcons();
        for _, v65 in pairs(v63) do
            v65:setTheme(v62);
        end;
    end;
    v14.setDisplayOrder = function(v66) --[[ Line: 202 ]] --[[ Name: setDisplayOrder ]]
        -- upvalues: v16 (copy)
        v16.DisplayOrder = tonumber(v66) or v16.DisplayOrder;
    end;
    v14.setDisplayOrder(10);
    v14.getIcons = function() --[[ Line: 208 ]] --[[ Name: getIcons ]]
        -- upvalues: v17 (copy)
        local v67 = {};
        for v68, _ in pairs(v17) do
            table.insert(v67, v68);
        end;
        return v67;
    end;
    v14.getIcon = function(v70) --[[ Line: 216 ]] --[[ Name: getIcon ]]
        -- upvalues: v17 (copy)
        for v71, _ in pairs(v17) do
            if v71.name == v70 then
                return v71;
            end;
        end;
        return false;
    end;
    v14.disableHealthbar = function(v73) --[[ Line: 225 ]] --[[ Name: disableHealthbar ]]
        -- upvalues: v14 (copy)
        local v74 = true;
        if v73 ~= nil then
            v74 = v73;
        end;
        v14.healthbarDisabled = v74;
        v14.healthbarDisabledSignal:Fire(v74);
    end;
    v14.disableControllerOption = function(v75) --[[ Line: 231 ]] --[[ Name: disableControllerOption ]]
        -- upvalues: v26 (ref), v14 (copy)
        local v76 = true;
        if v75 ~= nil then
            v76 = v75;
        end;
        v26 = v76;
        if v14.getIcon("_TopbarControllerOption") then
            v14._determineControllerDisplay();
        end;
    end;
    v14.canShowIconOnTopbar = function(v77) --[[ Line: 239 ]] --[[ Name: canShowIconOnTopbar ]]
        if (v77.enabled == true or v77.accountForWhenDisabled) and v77.presentOnTopbar then
            return true;
        else
            return false;
        end;
    end;
    v14.getMenuOffset = function(v78) --[[ Line: 246 ]] --[[ Name: getMenuOffset ]]
        -- upvalues: v14 (copy)
        local v79 = v14[v78:get("alignment") .. "Gap"];
        local v80 = 0;
        local v81 = 0;
        local v82 = 0;
        if v78.menuOpen then
            local l_Offset_0 = v78:get("menuSize").X.Offset;
            local v84 = v78:_getMenuDirection();
            if v84 == "right" then
                return v80, v81 + (l_Offset_0 + v79 / 6), v82;
            elseif v84 == "left" then
                v80 = l_Offset_0 + 4;
                v81 = v81 + v79 / 3;
                v82 = l_Offset_0;
            end;
        end;
        return v80, v81, v82;
    end;
    v54 = false;
    v14.updateTopbar = function() --[[ Line: 269 ]] --[[ Name: updateTopbar ]]
        -- upvalues: v14 (copy), v20 (ref), v54 (ref), l_RunService_0 (copy), v36 (copy), v17 (copy), v16 (copy), l_TweenService_0 (copy)
        local function v92(v85, v86) --[[ Line: 270 ]] --[[ Name: getIncrement ]]
            -- upvalues: v14 (ref)
            local v87 = (v85:get("iconSize", v85:getIconState()) or UDim2.new(0, 32, 0, 32)).X.Offset + v14[v86 .. "Gap"];
            local v88 = 0;
            if v85._parentIcon == nil then
                local v89, v90, v91 = v14.getMenuOffset(v85);
                v88 = v88 + v89;
                v87 = v87 + (v90 + v91);
            end;
            return v87, v88;
        end;
        if v20 then
            v54 = true;
            return false;
        else
            task.defer(function() --[[ Line: 290 ]]
                -- upvalues: v20 (ref), l_RunService_0 (ref), v36 (ref), v17 (ref), v14 (ref), v92 (copy), v16 (ref), l_TweenService_0 (ref), v54 (ref)
                v20 = true;
                l_RunService_0.Heartbeat:Wait();
                v20 = false;
                for _, v94 in pairs(v36) do
                    v94.records = {};
                end;
                for v95, _ in pairs(v17) do
                    if v14.canShowIconOnTopbar(v95) then
                        table.insert(v36[v95:get("alignment")].records, v95);
                    end;
                end;
                local l_ViewportSize_0 = workspace.CurrentCamera.ViewportSize;
                for v98, v99 in pairs(v36) do
                    local l_records_0 = v99.records;
                    if #l_records_0 > 1 then
                        if v99.reverseSort then
                            table.sort(l_records_0, function(v101, v102) --[[ Line: 310 ]]
                                return v101:get("order") > v102:get("order");
                            end);
                        else
                            table.sort(l_records_0, function(v103, v104) --[[ Line: 312 ]]
                                return v103:get("order") < v104:get("order");
                            end);
                        end;
                    end;
                    local v105 = 0;
                    for _, v107 in pairs(l_records_0) do
                        v105 = v105 + v92(v107, v98);
                    end;
                    local v108 = v99.getStartOffset(v105, v98);
                    local l_v108_0 = v108;
                    local l_X_0 = v16.TopbarContainer.AbsoluteSize.X;
                    for _, v112 in pairs(l_records_0) do
                        local v113, v114 = v92(v112, v98);
                        local _ = v99.startScale * l_X_0 + l_v108_0 + v114;
                        l_v108_0 = l_v108_0 + v113;
                    end;
                    for _, v117 in pairs(l_records_0) do
                        local l_iconContainer_0 = v117.instances.iconContainer;
                        local v119, v120 = v92(v117, v98);
                        local l_topPadding_0 = v117.topPadding;
                        local v122 = UDim2.new(v99.startScale, v108 + v120, l_topPadding_0.Scale, l_topPadding_0.Offset);
                        local _ = string.match(v117.name, "_overflowIcon-");
                        local v124 = v117:get("repositionInfo");
                        if v124 then
                            l_TweenService_0:Create(l_iconContainer_0, v124, {
                                Position = v122
                            }):Play();
                        else
                            l_iconContainer_0.Position = v122;
                        end;
                        v108 = v108 + v119;
                        v117.targetPosition = UDim2.new(0, v122.X.Scale * l_ViewportSize_0.X + v122.X.Offset, 0, v122.Y.Scale * l_ViewportSize_0.Y + v122.Y.Offset);
                    end;
                end;
                local function v133(v125, v126, v127) --[[ Line: 348 ]] --[[ Name: getBoundaryX ]]
                    -- upvalues: v14 (ref)
                    local v128 = v127 or 0;
                    local l_Offset_1 = v125:get("iconSize", v125:getIconState()).X.Offset;
                    local v130, v131 = v14.getMenuOffset(v125);
                    local v132 = v126 == "left" and -v128 - v130 or v126 == "right" and l_Offset_1 + v128 + v131;
                    return v125.targetPosition.X.Offset + v132;
                end;
                local function v142(v134, v135) --[[ Line: 357 ]] --[[ Name: getSizeX ]]
                    -- upvalues: v14 (ref)
                    local v136, v137 = v134:get("iconSize", v134:getIconState(), "beforeDropdown");
                    local v138 = v134:get("iconSize", "hovering");
                    if v134.wasHoveringBeforeOverflow and v137 and v138 and v138.X.Offset > v137.X.Offset then
                        v137 = v138;
                    end;
                    local v139 = v135 and v137 or v136;
                    local v140, v141 = v14.getMenuOffset(v134);
                    return v139.X.Offset + v140 + v141;
                end;
                for v143, v144 in pairs(v36) do
                    local l_overflowIcon_0 = v144.overflowIcon;
                    if l_overflowIcon_0 then
                        local v146 = v14[v143 .. "Gap"];
                        local v147 = v143 == "left" and "right" or "left";
                        local v148 = v36[v147];
                        local v149 = v14.getIcon("_overflowIcon-" .. v147);
                        local l_Offset_2 = l_overflowIcon_0:get("iconSize", l_overflowIcon_0:getIconState()).X.Offset;
                        local v151, v152 = v14.getMenuOffset(l_overflowIcon_0);
                        local v153 = v143 == "left" and -0 - v151 or v143 == "right" and l_Offset_2 + 0 + v152;
                        local v154 = l_overflowIcon_0.targetPosition.X.Offset + v153;
                        if l_overflowIcon_0.enabled then
                            v154 = v133(l_overflowIcon_0, v147, v146);
                        end;
                        do
                            local l_v154_0, l_v152_0, l_v153_0 = v154, v152, v153;
                            local function _(v158) --[[ Line: 383 ]] --[[ Name: doesExceed ]]
                                -- upvalues: v143 (copy), l_v154_0 (ref)
                                return v143 == "left" and v158 < l_v154_0 or v143 == "right" and l_v154_0 < v158;
                            end;
                            l_Offset_2 = v148.getOffset();
                            if not l_overflowIcon_0.enabled then
                                l_Offset_2 = l_Offset_2 + 10;
                            end;
                            l_v152_0 = v143 == "left" and l_ViewportSize_0.X - l_Offset_2 or v143 == "right" and l_Offset_2;
                            local l_l_v152_0_0 = l_v152_0;
                            l_v153_0 = v143 == "left" and l_l_v152_0_0 < l_v154_0 or v143 == "right" and l_v154_0 < l_l_v152_0_0;
                            l_l_v152_0_0 = function(v161) --[[ Line: 394 ]] --[[ Name: checkBoundaryExceeded ]]
                                -- upvalues: v14 (ref), l_overflowIcon_0 (copy), v133 (copy), v143 (copy), l_v152_0 (ref), l_v154_0 (ref), l_v153_0 (ref)
                                local v162 = #v161;
                                for v163 = 1, v162 do
                                    local v164 = v161[v162 + 1 - v163];
                                    if v14.canShowIconOnTopbar(v164) then
                                        local v165 = string.match(v164.name, "_overflowIcon-");
                                        if v165 and v162 ~= 1 then
                                            return;
                                        elseif not v165 or v164.enabled then
                                            local v166 = 0;
                                            if not l_overflowIcon_0.enabled then
                                                v166 = 10;
                                            end;
                                            local v167 = v133(v164, v143, v166);
                                            if v143 == "left" and v167 < l_v152_0 or v143 == "right" and l_v152_0 < v167 then
                                                l_v152_0 = v167;
                                                if v143 == "left" and v167 < l_v154_0 or v143 == "right" and l_v154_0 < v167 then
                                                    l_v153_0 = true;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                            l_l_v152_0_0(v36[v147].records);
                            l_l_v152_0_0(v36.mid.records);
                            if l_v153_0 then
                                local l_records_1 = v144.records;
                                local v169 = #l_records_1;
                                for v170 = 1, v169 do
                                    local v171 = v143 == "left" and l_records_1[v169 + 1 - v170] or v143 == "right" and l_records_1[v170];
                                    if v171 ~= l_overflowIcon_0 and v14.canShowIconOnTopbar(v171) then
                                        local l_v146_0 = v146;
                                        local l_Offset_3 = l_overflowIcon_0:get("iconSize", l_overflowIcon_0:getIconState()).X.Offset;
                                        if l_overflowIcon_0.enabled then
                                            l_v146_0 = l_v146_0 + (v146 + l_Offset_3);
                                        end;
                                        local v174 = v133(v171, v147, l_v146_0);
                                        if v143 == "left" and l_v152_0 <= v174 or v143 == "right" and v174 <= l_v152_0 then
                                            if not l_overflowIcon_0.enabled then
                                                local l_iconContainer_1 = l_overflowIcon_0.instances.iconContainer;
                                                local l_Y_0 = l_iconContainer_1.Position.Y;
                                                local v177 = v133(v171, v147, v143 == "left" and -l_iconContainer_1.Size.X.Offset or 0);
                                                l_iconContainer_1.Position = UDim2.new(0, v177, l_Y_0.Scale, l_Y_0.Offset);
                                                l_overflowIcon_0:setEnabled(true);
                                            end;
                                            if #v171.dropdownIcons > 0 then
                                                v171._overflowConvertedToMenu = true;
                                                local l_isSelected_0 = v171.isSelected;
                                                v171:deselect();
                                                local v179 = {};
                                                for _, v181 in pairs(v171.dropdownIcons) do
                                                    table.insert(v179, v181);
                                                end;
                                                for _, v183 in pairs(v171.dropdownIcons) do
                                                    v183:leave();
                                                end;
                                                v171:setMenu(v179);
                                                if l_isSelected_0 and l_overflowIcon_0.isSelected then
                                                    v171:select();
                                                end;
                                            end;
                                            if v171.hovering then
                                                v171.wasHoveringBeforeOverflow = true;
                                            end;
                                            v171:join(l_overflowIcon_0, "dropdown");
                                            if #v171.menuIcons > 0 and v171.menuOpen then
                                                v171:deselect();
                                                v171:select();
                                                l_overflowIcon_0:select();
                                                break;
                                            else
                                                break;
                                            end;
                                        else
                                            break;
                                        end;
                                    end;
                                end;
                            else
                                local v184 = nil;
                                local v185 = nil;
                                local v186 = #l_overflowIcon_0.dropdownIcons;
                                if not v149 or not v149.enabled or #v144.records ~= 1 or #v148.records == 1 then
                                    for _, v188 in pairs(l_overflowIcon_0.dropdownIcons) do
                                        local v189 = v188:get("order");
                                        if v185 == nil or v143 == "left" and v189 < v184 or v143 == "right" and v184 < v189 then
                                            v184 = v189;
                                            v185 = v188;
                                        end;
                                    end;
                                end;
                                if v185 then
                                    local v190 = v142(v185, true);
                                    local l_Offset_4 = l_overflowIcon_0:get("iconSize", l_overflowIcon_0:getIconState()).X.Offset;
                                    local v192, v193 = v14.getMenuOffset(l_overflowIcon_0);
                                    local v194 = v147 == "left" and -0 - v192 or v147 == "right" and l_Offset_4 + 0 + v193;
                                    local v195 = l_overflowIcon_0.targetPosition.X.Offset + v194;
                                    if v186 == 1 then
                                        v195 = v133(l_overflowIcon_0, v143, v146 - 10);
                                    end;
                                    if v190 < math.abs(l_v152_0 - v195) - v146 * 2 then
                                        if #l_overflowIcon_0.dropdownIcons == 1 then
                                            l_overflowIcon_0:setEnabled(false);
                                        end;
                                        v192 = l_overflowIcon_0.instances.iconContainer;
                                        v193 = v192.Position.Y;
                                        v192.Position = UDim2.new(0, v195, v193.Scale, v193.Offset);
                                        v185:leave();
                                        v185.wasHoveringBeforeOverflow = nil;
                                        if v185._overflowConvertedToMenu then
                                            v185._overflowConvertedToMenu = nil;
                                            v194 = {};
                                            for _, v197 in pairs(v185.menuIcons) do
                                                table.insert(v194, v197);
                                            end;
                                            for _, v199 in pairs(v185.menuIcons) do
                                                v199:leave();
                                            end;
                                            v185:setDropdown(v194);
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                if v54 then
                    v54 = false;
                    v14.updateTopbar();
                end;
                return true;
            end);
            return;
        end;
    end;
    v14.setTopbarEnabled = function(v200, v201) --[[ Line: 535 ]] --[[ Name: setTopbarEnabled ]]
        -- upvalues: v16 (copy), v18 (ref), l_StarterGui_0 (copy), v14 (copy), v19 (ref), v22 (ref), l_HapticService_0 (copy), l_RunService_0 (copy), v17 (copy), l_GuiService_0 (copy)
        if v201 == nil then
            v201 = true;
        end;
        local l_Indicator_0 = v16.Indicator;
        if v201 and not v200 then
            v18 = true;
        elseif v201 and v200 then
            v18 = false;
        end;
        local v204, v205 = xpcall(function() --[[ Line: 41 ]]
            -- upvalues: l_StarterGui_0 (ref)
            return l_StarterGui_0:GetCore("TopbarEnabled");
        end, function(_) --[[ Line: 43 ]]
            return true;
        end);
        local v206 = v204 and v205 or not v14.mimicCoreGui;
        if v14.controllerModeEnabled then
            if v200 then
                if v16.TopbarContainer.Visible or v18 or v19 or not v206 then
                    return;
                elseif v201 then
                    l_Indicator_0.Visible = v206;
                    return;
                else
                    l_Indicator_0.Active = false;
                    if v22 and v22.Connected then
                        v22:Disconnect();
                    end;
                    if l_HapticService_0:IsVibrationSupported(Enum.UserInputType.Gamepad1) and l_HapticService_0:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small) then
                        l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 1);
                        delay(0.2, function() --[[ Line: 559 ]]
                            -- upvalues: l_HapticService_0 (ref)
                            pcall(function() --[[ Line: 560 ]]
                                -- upvalues: l_HapticService_0 (ref)
                                l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
                            end);
                        end);
                    end;
                    v16.TopbarContainer.Visible = true;
                    v16.TopbarContainer:TweenPosition(UDim2.new(0, 0, 0, 37), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
                    local v207 = nil;
                    v204 = 0;
                    v14:_updateSelectionGroup();
                    l_RunService_0.Heartbeat:Wait();
                    for v208, _ in pairs(v17) do
                        if v14.canShowIconOnTopbar(v208) and (v207 == nil or v208:get("order") < v207:get("order")) and v208.enabled then
                            v207 = v208;
                        end;
                        local v210 = -27 + v208.instances.iconContainer.AbsoluteSize.Y + 50;
                        if v204 < v210 then
                            v204 = v210;
                        end;
                    end;
                    if l_GuiService_0:GetEmotesMenuOpen() then
                        l_GuiService_0:SetEmotesMenuOpen(false);
                    end;
                    if l_GuiService_0:GetInspectMenuEnabled() then
                        l_GuiService_0:CloseInspectMenu();
                    end;
                    v205 = v14._previousSelectedObject or v207 and v207.instances.iconButton;
                    local v211 = {
                        ButtonB = "rbxassetid://5278151071", 
                        ButtonCircle = "rbxassetid://15030650284"
                    };
                    v14._setControllerSelectedObject(v205);
                    l_Indicator_0.Image = v211[game:GetService("UserInputService"):GetStringForKeyCode(Enum.KeyCode.ButtonB)];
                    l_Indicator_0:TweenPosition(UDim2.new(0.5, 0, 0, v204 + 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
                    return;
                end;
            else
                if v201 then
                    l_Indicator_0.Visible = false;
                elseif v206 then
                    l_Indicator_0.Visible = true;
                    l_Indicator_0.Active = true;
                    v22 = l_Indicator_0.InputBegan:Connect(function(v212) --[[ Line: 618 ]]
                        -- upvalues: v14 (ref)
                        if v212.UserInputType == Enum.UserInputType.MouseButton1 then
                            v14.setTopbarEnabled(true, false);
                        end;
                    end);
                else
                    l_Indicator_0.Visible = false;
                end;
                if not v16.TopbarContainer.Visible then
                    return;
                else
                    l_GuiService_0.AutoSelectGuiEnabled = true;
                    v14:_updateSelectionGroup(true);
                    v16.TopbarContainer:TweenPosition(UDim2.new(0, 0, 0, -v16.TopbarContainer.Size.Y.Offset + 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 635 ]]
                        -- upvalues: v16 (ref)
                        v16.TopbarContainer.Visible = false;
                    end);
                    l_Indicator_0.Image = "rbxassetid://5278151556";
                    l_Indicator_0:TweenPosition(UDim2.new(0.5, 0, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
                    return;
                end;
            end;
        else
            local l_TopbarContainer_0 = v16.TopbarContainer;
            if v206 then
                l_TopbarContainer_0.Visible = v200;
                return;
            else
                l_TopbarContainer_0.Visible = false;
                return;
            end;
        end;
    end;
    v14.setGap = function(v214, v215) --[[ Line: 658 ]] --[[ Name: setGap ]]
        -- upvalues: v14 (copy)
        local v216 = tonumber(v214) or 12;
        local v217 = tostring(v215):lower();
        if v217 == "left" or v217 == "mid" or v217 == "right" then
            v14[v217 .. "Gap"] = v216;
            v14.updateTopbar();
            return;
        else
            v14.leftGap = v216;
            v14.midGap = v216;
            v14.rightGap = v216;
            v14.updateTopbar();
            return;
        end;
    end;
    v14.setLeftOffset = function(v218) --[[ Line: 672 ]] --[[ Name: setLeftOffset ]]
        -- upvalues: v14 (copy)
        v14.leftOffset = tonumber(v218) or 0;
        v14.updateTopbar();
    end;
    v14.setRightOffset = function(v219) --[[ Line: 677 ]] --[[ Name: setRightOffset ]]
        -- upvalues: v14 (copy)
        v14.rightOffset = tonumber(v219) or 0;
        v14.updateTopbar();
    end;
    v55 = l_Players_0.LocalPlayer;
    local v220 = {};
    v55.CharacterAdded:Connect(function() --[[ Line: 684 ]]
        -- upvalues: v220 (ref)
        for _, v222 in pairs(v220) do
            v222:destroy();
        end;
        v220 = {};
    end);
    v14.clearIconOnSpawn = function(v223) --[[ Line: 690 ]] --[[ Name: clearIconOnSpawn ]]
        -- upvalues: v55 (copy), v220 (ref)
        coroutine.wrap(function() --[[ Line: 691 ]]
            -- upvalues: v55 (ref), v220 (ref), v223 (copy)
            if not v55.Character then
                local _ = v55.CharacterAdded:Wait();
            end;
            table.insert(v220, v223);
        end)();
    end;
    v14._updateSelectionGroup = function(_, v226) --[[ Line: 700 ]] --[[ Name: _updateSelectionGroup ]]
        -- upvalues: v14 (copy), l_GuiService_0 (copy)
        if v14._navigationEnabled then
            l_GuiService_0:RemoveSelectionGroup("TopbarPlusIcons");
        end;
        if v226 then
            l_GuiService_0.CoreGuiNavigationEnabled = v14._originalCoreGuiNavigationEnabled;
            l_GuiService_0.GuiNavigationEnabled = v14._originalGuiNavigationEnabled;
            v14._navigationEnabled = nil;
            return;
        else
            if v14.controllerModeEnabled then
                local v227 = v14.getIcons();
                local v228 = {};
                for _, v230 in pairs(v227) do
                    if not v230.joinedFeatureName or v230._parentIcon[v230.joinedFeatureName .. "Open"] == true then
                        table.insert(v228, v230.instances.iconButton);
                    end;
                end;
                l_GuiService_0:AddSelectionTuple("TopbarPlusIcons", table.unpack(v228));
                if not v14._navigationEnabled then
                    v14._originalCoreGuiNavigationEnabled = l_GuiService_0.CoreGuiNavigationEnabled;
                    v14._originalGuiNavigationEnabled = l_GuiService_0.GuiNavigationEnabled;
                    l_GuiService_0.CoreGuiNavigationEnabled = false;
                    l_GuiService_0.GuiNavigationEnabled = true;
                    v14._navigationEnabled = true;
                end;
            end;
            return;
        end;
    end;
    local function _() --[[ Line: 728 ]] --[[ Name: getScaleMultiplier ]]
        -- upvalues: l_GuiService_0 (copy)
        if l_GuiService_0:IsTenFootInterface() then
            return 3;
        else
            return 1.3;
        end;
    end;
    v14._setControllerSelectedObject = function(v232) --[[ Line: 736 ]] --[[ Name: _setControllerSelectedObject ]]
        -- upvalues: v14 (copy), l_GuiService_0 (copy)
        local v233 = v14._controllerSetCount and v14._controllerSetCount + 1 or 0;
        v14._controllerSetCount = v233;
        l_GuiService_0.SelectedObject = v232;
        task.delay(0.1, function() --[[ Line: 740 ]]
            -- upvalues: v14 (ref), v233 (copy), l_GuiService_0 (ref), v232 (copy)
            if v14._controllerSetCountS == v233 then
                l_GuiService_0.SelectedObject = v232;
            end;
        end);
    end;
    v14._enableControllerMode = function(v234) --[[ Line: 748 ]] --[[ Name: _enableControllerMode ]]
        -- upvalues: v16 (copy), v14 (copy), l_GuiService_0 (copy), l_StarterGui_0 (copy), v22 (ref), v17 (copy)
        local l_Indicator_1 = v16.Indicator;
        local _ = v14.getIcon("_TopbarControllerOption");
        if v14.controllerModeEnabled == v234 then
            return;
        else
            v14.controllerModeEnabled = v234;
            if v234 then
                v16.TopbarContainer.Position = UDim2.new(0, 0, 0, 5);
                v16.TopbarContainer.Visible = false;
                local v237 = l_GuiService_0:IsTenFootInterface() and 3 or 1.3;
                l_Indicator_1.Position = UDim2.new(0.5, 0, 0, 5);
                l_Indicator_1.Size = UDim2.new(0, 18 * v237, 0, 18 * v237);
                l_Indicator_1.Image = "rbxassetid://5278151556";
                local v239, v240 = xpcall(function() --[[ Line: 41 ]]
                    -- upvalues: l_StarterGui_0 (ref)
                    return l_StarterGui_0:GetCore("TopbarEnabled");
                end, function(_) --[[ Line: 43 ]]
                    return true;
                end);
                l_Indicator_1.Visible = v239 and v240 or not v14.mimicCoreGui;
                l_Indicator_1.Position = UDim2.new(0.5, 0, 0, 5);
                l_Indicator_1.Active = true;
                v22 = l_Indicator_1.InputBegan:Connect(function(v241) --[[ Line: 765 ]]
                    -- upvalues: v14 (ref)
                    if v241.UserInputType == Enum.UserInputType.MouseButton1 then
                        v14.setTopbarEnabled(true, false);
                    end;
                end);
            else
                v16.TopbarContainer.Position = UDim2.new(0, 0, 0, 0);
                local l_TopbarContainer_1 = v16.TopbarContainer;
                local v244, v245 = xpcall(function() --[[ Line: 41 ]]
                    -- upvalues: l_StarterGui_0 (ref)
                    return l_StarterGui_0:GetCore("TopbarEnabled");
                end, function(_) --[[ Line: 43 ]]
                    return true;
                end);
                l_TopbarContainer_1.Visible = v244 and v245 or not v14.mimicCoreGui;
                l_Indicator_1.Visible = false;
                v14._setControllerSelectedObject(nil);
            end;
            for v246, _ in pairs(v17) do
                v14._enableControllerModeForIcon(v246, v234);
            end;
            return;
        end;
    end;
    v14._enableControllerModeForIcon = function(v248, v249) --[[ Line: 781 ]] --[[ Name: _enableControllerModeForIcon ]]
        -- upvalues: l_GuiService_0 (copy)
        local l__parentIcon_0 = v248._parentIcon;
        local l_joinedFeatureName_0 = v248.joinedFeatureName;
        if l__parentIcon_0 then
            v248:leave();
        end;
        if v249 then
            local v252 = l_GuiService_0:IsTenFootInterface() and 3 or 1.3;
            local v253 = v248:get("iconSize", "deselected");
            local v254 = v248:get("iconSize", "selected");
            local v255 = v248:getHovering("iconSize");
            v248:set("iconSize", UDim2.new(0, v253.X.Offset * v252, 0, v253.Y.Offset * v252), "deselected", "controllerMode");
            v248:set("iconSize", UDim2.new(0, v254.X.Offset * v252, 0, v254.Y.Offset * v252), "selected", "controllerMode");
            if v255 then
                v248:set("iconSize", UDim2.new(0, v254.X.Offset * v252, 0, v254.Y.Offset * v252), "hovering", "controllerMode");
            end;
            v248:set("alignment", "mid", "deselected", "controllerMode");
            v248:set("alignment", "mid", "selected", "controllerMode");
        else
            for _, v257 in pairs({
                "deselected", 
                "selected", 
                "hovering"
            }) do
                local _, v259 = v248:get("alignment", v257, "controllerMode");
                if v259 then
                    v248:set("alignment", v259, v257);
                end;
                local _, v261 = v248:get("iconSize", v257, "controllerMode");
                if v261 then
                    v248:set("iconSize", v261, v257);
                end;
            end;
        end;
        if l__parentIcon_0 then
            v248:join(l__parentIcon_0, l_joinedFeatureName_0);
        end;
    end;
    local v262 = false;
    v14.setupHealthbar = function() --[[ Line: 818 ]] --[[ Name: setupHealthbar ]]
        -- upvalues: v262 (ref), l_RunService_0 (copy), l_Parent_0 (copy), l_StarterGui_0 (copy), v14 (copy), v55 (copy)
        if v262 then
            return;
        else
            v262 = true;
            task.defer(function() --[[ Line: 826 ]]
                -- upvalues: l_RunService_0 (ref), l_Parent_0 (ref), l_StarterGui_0 (ref), v14 (ref), v55 (ref)
                l_RunService_0.Heartbeat:Wait();
                require(l_Parent_0).new():setProperty("internalIcon", true):setName("_FakeHealthbar"):setRight():setOrder(-420):setSize(80, 32):lock():set("iconBackgroundTransparency", 1):give(function(v263) --[[ Line: 838 ]]
                    -- upvalues: l_StarterGui_0 (ref), v14 (ref), v55 (ref)
                    local l_Frame_0 = Instance.new("Frame");
                    l_Frame_0.Name = "HealthContainer";
                    l_Frame_0.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                    l_Frame_0.BorderSizePixel = 0;
                    l_Frame_0.AnchorPoint = Vector2.new(0, 0.5);
                    l_Frame_0.Position = UDim2.new(0, 0, 0.5, 0);
                    l_Frame_0.Size = UDim2.new(1, 0, 0.2, 0);
                    l_Frame_0.Visible = true;
                    l_Frame_0.ZIndex = 11;
                    l_Frame_0.Parent = v263.instances.iconButton;
                    local l_UICorner_0 = Instance.new("UICorner");
                    l_UICorner_0.CornerRadius = UDim.new(1, 0);
                    l_UICorner_0.Parent = l_Frame_0;
                    local v266 = l_Frame_0:Clone();
                    v266.Name = "HealthFrame";
                    v266.BackgroundColor3 = Color3.fromRGB(167, 167, 167);
                    v266.BorderSizePixel = 0;
                    v266.AnchorPoint = Vector2.new(0.5, 0.5);
                    v266.Position = UDim2.new(0.5, 0, 0.5, 0);
                    v266.Size = UDim2.new(1, -2, 1, -2);
                    v266.Visible = true;
                    v266.ZIndex = 12;
                    v266.Parent = l_Frame_0;
                    local v267 = v266:Clone();
                    v267.Name = "HealthBar";
                    v267.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    v267.BorderSizePixel = 0;
                    v267.AnchorPoint = Vector2.new(0, 0.5);
                    v267.Position = UDim2.new(0, 0, 0.5, 0);
                    v267.Size = UDim2.new(0.5, 0, 1, 0);
                    v267.Visible = true;
                    v267.ZIndex = 13;
                    v267.Parent = v266;
                    local v268 = Color3.fromRGB(27, 252, 107);
                    local v269 = Color3.fromRGB(250, 235, 0);
                    local v270 = Color3.fromRGB(255, 28, 0);
                    local function v273(v271, v272) --[[ Line: 881 ]] --[[ Name: powColor3 ]]
                        return Color3.new(math.pow(v271.R, v272), math.pow(v271.G, v272), (math.pow(v271.B, v272)));
                    end;
                    local function _(v274, v275, v276, v277) --[[ Line: 889 ]] --[[ Name: lerpColor ]]
                        -- upvalues: v273 (copy)
                        v277 = v277 or 2;
                        local l_v277_0 = v277;
                        local v279 = Color3.new(math.pow(v274.R, l_v277_0), math.pow(v274.G, l_v277_0), (math.pow(v274.B, l_v277_0)));
                        local l_v277_1 = v277;
                        l_v277_0 = Color3.new(math.pow(v275.R, l_v277_1), math.pow(v275.G, l_v277_1), (math.pow(v275.B, l_v277_1)));
                        return v273(v279:Lerp(l_v277_0, v276), 1 / v277);
                    end;
                    local v282 = true;
                    local function v300(v283) --[[ Line: 897 ]] --[[ Name: listenToHealth ]]
                        -- upvalues: l_StarterGui_0 (ref), v14 (ref), v282 (ref), v263 (copy), v268 (copy), v269 (copy), v270 (copy), v267 (copy)
                        if not v283 then
                            return;
                        else
                            local v284 = v283:WaitForChild("Humanoid", 10);
                            if not v284 then
                                return;
                            else
                                local function v299() --[[ Line: 906 ]] --[[ Name: updateHealthBar ]]
                                    -- upvalues: l_StarterGui_0 (ref), v284 (copy), v14 (ref), v282 (ref), v263 (ref), v268 (ref), v269 (ref), v270 (ref), v267 (ref)
                                    local l_l_StarterGui_0_CoreGuiEnabled_1 = l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.Health);
                                    local v286 = v284.Health / v284.MaxHealth;
                                    if v286 == 1 or v14.healthbarDisabled or v282 and l_l_StarterGui_0_CoreGuiEnabled_1 == false then
                                        if v263.enabled then
                                            v263:setEnabled(false);
                                        end;
                                        return;
                                    else
                                        if v286 < 1 then
                                            if not v263.enabled then
                                                v263:setEnabled(true);
                                            end;
                                            v282 = false;
                                            if l_l_StarterGui_0_CoreGuiEnabled_1 then
                                                l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
                                            end;
                                        end;
                                        local v287 = 1.25 * v286 + -0.125;
                                        local v288 = v287 > 1 and 1 or v287 < 0 and 0 or v287;
                                        local v289 = v286 > 0.5 and v268 or v269;
                                        local v290 = v286 > 0.5 and v269 or v270;
                                        local v291 = (1 - v288) * 2;
                                        local v292 = v286 > 0.5 and 1 - v291 or 2 - v291;
                                        local v293 = nil or 2;
                                        local l_v293_0 = v293;
                                        local v295 = Color3.new(math.pow(v290.R, l_v293_0), math.pow(v290.G, l_v293_0), (math.pow(v290.B, l_v293_0)));
                                        local l_v293_1 = v293;
                                        l_v293_1 = v295:Lerp(Color3.new(math.pow(v289.R, l_v293_1), math.pow(v289.G, l_v293_1), (math.pow(v289.B, l_v293_1))), v292);
                                        local v297 = 1 / v293;
                                        local v298 = Color3.new(math.pow(l_v293_1.R, v297), math.pow(l_v293_1.G, v297), (math.pow(l_v293_1.B, v297)));
                                        v293 = UDim2.new(v286, 0, 1, 0);
                                        v267.BackgroundColor3 = v298;
                                        v267.Size = v293;
                                        return;
                                    end;
                                end;
                                v284.HealthChanged:Connect(v299);
                                v14.healthbarDisabledSignal:Connect(v299);
                                v299();
                                return;
                            end;
                        end;
                    end;
                    v55.CharacterAdded:Connect(function(v301) --[[ Line: 943 ]]
                        -- upvalues: v300 (copy)
                        v300(v301);
                    end);
                    task.spawn(v300, v55.Character);
                end);
            end);
            return;
        end;
    end;
    v14._determineControllerDisplay = function() --[[ Line: 951 ]] --[[ Name: _determineControllerDisplay ]]
        -- upvalues: l_UserInputService_0 (copy), v14 (copy), v26 (ref)
        local l_MouseEnabled_0 = l_UserInputService_0.MouseEnabled;
        local l_GamepadEnabled_0 = l_UserInputService_0.GamepadEnabled;
        local v304 = v14.getIcon("_TopbarControllerOption");
        if l_MouseEnabled_0 and l_GamepadEnabled_0 then
            if not v26 then
                v304:setEnabled(true);
                return;
            else
                v304:setEnabled(false);
                return;
            end;
        elseif l_MouseEnabled_0 and not l_GamepadEnabled_0 then
            v304:setEnabled(false);
            v14._enableControllerMode(false);
            v304:deselect();
            return;
        else
            if not l_MouseEnabled_0 and l_GamepadEnabled_0 then
                v304:setEnabled(false);
                v14._enableControllerMode(true);
            end;
            return;
        end;
    end;
    coroutine.wrap(function() --[[ Line: 978 ]]
        -- upvalues: l_RunService_0 (copy), l_Parent_0 (copy), l_UserInputService_0 (copy), v14 (copy), l_GuiService_0 (copy), l_StarterGui_0 (copy), v16 (copy), v36 (copy), l_VoiceChatService_0 (copy), v55 (copy), v25 (ref), v23 (copy)
        l_RunService_0.Heartbeat:Wait();
        local v305 = require(l_Parent_0);
        local v306 = v305.new():setProperty("internalIcon", true):setName("_TopbarControllerOption"):setOrder(100):setImage(11162828670):setRight():setEnabled(false):setTip("Controller mode"):setProperty("deselectWhenOtherIconSelected", false);
        l_UserInputService_0:GetPropertyChangedSignal("MouseEnabled"):Connect(v14._determineControllerDisplay);
        l_UserInputService_0.GamepadConnected:Connect(v14._determineControllerDisplay);
        l_UserInputService_0.GamepadDisconnected:Connect(v14._determineControllerDisplay);
        v14._determineControllerDisplay();
        local function v309() --[[ Line: 1002 ]] --[[ Name: iconClicked ]]
            -- upvalues: v306 (copy), v14 (ref)
            local l_isSelected_1 = v306.isSelected;
            local v308 = l_isSelected_1 and "Normal mode" or "Controller mode";
            v306:setTip(v308);
            v14._enableControllerMode(l_isSelected_1);
        end;
        v306.selected:Connect(v309);
        v306.deselected:Connect(v309);
        l_UserInputService_0.InputBegan:Connect(function(v310, _) --[[ Line: 1012 ]]
            -- upvalues: v14 (ref), l_GuiService_0 (ref), l_StarterGui_0 (ref), v16 (ref)
            if not v14.controllerModeEnabled then
                return;
            else
                if v310.KeyCode == Enum.KeyCode.DPadDown then
                    if not l_GuiService_0.SelectedObject then
                        local v313, v314 = xpcall(function() --[[ Line: 41 ]]
                            -- upvalues: l_StarterGui_0 (ref)
                            return l_StarterGui_0:GetCore("TopbarEnabled");
                        end, function(_) --[[ Line: 43 ]]
                            return true;
                        end);
                        if v313 and v314 or not v14.mimicCoreGui then
                            v14.setTopbarEnabled(true, false);
                        end;
                    end;
                elseif v310.KeyCode == Enum.KeyCode.ButtonB and not v14.disableButtonB then
                    if v14.activeButtonBCallbacks == 1 and v16.Indicator.Image == "rbxassetid://5278151556" then
                        v14.activeButtonBCallbacks = 0;
                        l_GuiService_0.SelectedObject = nil;
                    end;
                    if v14.activeButtonBCallbacks == 0 then
                        v14._previousSelectedObject = l_GuiService_0.SelectedObject;
                        v14._setControllerSelectedObject(nil);
                        v14.setTopbarEnabled(false, false);
                    end;
                end;
                v310:Destroy();
                return;
            end;
        end);
        for v315, v316 in pairs(v36) do
            if v315 ~= "mid" then
                local v317 = "_overflowIcon-" .. v315;
                local v318 = v305.new():setProperty("internalIcon", true):setImage(6069276526):setName(v317):setEnabled(false);
                v316.overflowIcon = v318;
                v318.accountForWhenDisabled = true;
                if v315 == "left" then
                    v318:setOrder(1e999);
                    v318:setLeft();
                    v318:set("dropdownAlignment", "right");
                elseif v315 == "right" then
                    v318:setOrder(-1e999);
                    v318:setRight();
                    v318:set("dropdownAlignment", "left");
                end;
                v318.lockedSettings = {
                    iconImage = true, 
                    order = true, 
                    alignment = true
                };
            end;
        end;
        task.defer(function() --[[ Line: 1065 ]]
            -- upvalues: l_VoiceChatService_0 (ref), v55 (ref), v14 (ref), v25 (ref), v23 (ref)
            local v319 = nil;
            local v320 = nil;
            while true do
                local l_status_0, l_result_0 = pcall(function() --[[ Line: 1068 ]]
                    -- upvalues: l_VoiceChatService_0 (ref), v55 (ref)
                    return l_VoiceChatService_0:IsVoiceEnabledForUserIdAsync(v55.UserId);
                end);
                v319 = l_status_0;
                v320 = l_result_0;
                if not v319 then
                    task.wait(1);
                else
                    break;
                end;
            end;
            local function _() --[[ Line: 1074 ]] --[[ Name: checkVoiceChatManuallyEnabled ]]
                -- upvalues: v14 (ref), v319 (ref), v320 (ref), v25 (ref)
                if v14.voiceChatEnabled and v319 and v320 then
                    v25 = true;
                    v14.updateTopbar();
                end;
            end;
            if v14.voiceChatEnabled and v319 and v320 then
                v25 = true;
                v14.updateTopbar();
            end;
            v55.PlayerGui:WaitForChild("TopbarPlus", 999);
            task.delay(10, function() --[[ Line: 1086 ]]
                -- upvalues: v14 (ref), v319 (ref), v320 (ref), v25 (ref), v23 (ref)
                if v14.voiceChatEnabled and v319 and v320 then
                    v25 = true;
                    v14.updateTopbar();
                end;
                if v14.voiceChatEnabled == nil and v319 and v320 and v23 then
                    warn("\226\154\160\239\184\143TopbarPlus Action Required\226\154\160\239\184\143 If VoiceChat is enabled within your experience it's vital you set IconController.voiceChatEnabled to true ``require(game.ReplicatedStorage.Icon.IconController).voiceChatEnabled = true`` otherwise the BETA label will not be accounted for within your live servers. This warning will disappear after doing so. Feel free to delete this warning or to set to false if you don't have VoiceChat enabled within your experience.");
                end;
            end);
        end);
        if not v23 then
            local l_CreatorId_0 = game.CreatorId;
            local l_GroupService_0 = game:GetService("GroupService");
            if game.CreatorType == Enum.CreatorType.Group then
                local l_status_1, l_result_1 = pcall(function() --[[ Line: 1104 ]]
                    -- upvalues: l_GroupService_0 (copy)
                    return l_GroupService_0:GetGroupInfoAsync(game.CreatorId).Owner;
                end);
                if l_status_1 then
                    l_CreatorId_0 = l_result_1.Id;
                end;
            end;
            local v328 = require(l_Parent_0.VERSION);
            if v55.UserId ~= l_CreatorId_0 then
                local l_MarketplaceService_0 = game:GetService("MarketplaceService");
                local l_status_2, l_result_2 = pcall(function() --[[ Line: 1112 ]]
                    -- upvalues: l_MarketplaceService_0 (copy)
                    return l_MarketplaceService_0:GetProductInfo(game.PlaceId);
                end);
                if l_status_2 and l_result_2 then
                    local l_Name_0 = l_result_2.Name;
                    print(("\n\n\n\226\154\189 %s uses TopbarPlus %s\n\240\159\141\141 TopbarPlus was developed by ForeverHD and the Nanoblox Team\n\240\159\154\128 You can learn more and take a free copy by searching for 'TopbarPlus' on the DevForum\n\n"):format(l_Name_0, v328));
                end;
            end;
        end;
    end)();
    l_GuiService_0.MenuClosed:Connect(function() --[[ Line: 1125 ]]
        -- upvalues: l_VRService_0 (copy), v19 (ref), v14 (copy)
        if l_VRService_0.VREnabled then
            return;
        else
            v19 = false;
            if not v14.controllerModeEnabled then
                v14.setTopbarEnabled(v14.topbarEnabled, false);
            end;
            return;
        end;
    end);
    l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 1134 ]]
        -- upvalues: l_VRService_0 (copy), v19 (ref), v14 (copy)
        if l_VRService_0.VREnabled then
            return;
        else
            v19 = true;
            v14.setTopbarEnabled(false, false);
            return;
        end;
    end);
    if workspace.CurrentCamera then
        if v21 and v21.Connected then
            v21:Disconnect();
        end;
        v21 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(v14.updateTopbar);
    end;
    task.spawn(function() --[[ Line: 1145 ]]
        -- upvalues: l_LocalizationService_0 (copy), v55 (copy), v14 (copy)
        local l_status_3, l_result_3 = pcall(function() --[[ Line: 1146 ]]
            -- upvalues: l_LocalizationService_0 (ref), v55 (ref)
            return l_LocalizationService_0:GetTranslatorForPlayerAsync(v55);
        end);
        local function v338() --[[ Line: 1147 ]] --[[ Name: updateAllIcons ]]
            -- upvalues: v14 (ref)
            local v335 = v14.getIcons();
            for _, v337 in pairs(v335) do
                v337:_updateAll();
            end;
        end;
        if l_status_3 then
            v14.translator = l_result_3;
            l_result_3:GetPropertyChangedSignal("LocaleId"):Connect(v338);
            task.spawn(v338);
            task.delay(1, v338);
            task.delay(10, v338);
        end;
    end);
    return v14;
end;
