-- Script Path: game:GetService("ReplicatedStorage").NewIcon
-- Took 0.87s to decompile.
-- Executor: Delta (1.0.714.1091)

local _ = game:GetService("LocalizationService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local l_TextService_0 = game:GetService("TextService");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_GuiService_0 = game:GetService("GuiService");
local _ = game:GetService("LocalizationService");
local _ = game:GetService("Players").LocalPlayer;
local l_script_0 = script;
local v12 = require(l_script_0.TopbarPlusReference);
local v13 = v12.getObject();
local v14 = v13 and v13.Value;
if v14 and v14 ~= l_script_0 then
    return require(v14);
else
    if not v13 then
        v12.addToReplicatedStorage();
    end;
    local v15 = {};
    v15.__index = v15;
    local v16 = require(l_script_0.IconController);
    local v17 = require(l_script_0.Signal);
    local v18 = require(l_script_0.Maid);
    local v19 = require(l_script_0.TopbarPlusGui);
    local v20 = require(l_script_0.Themes);
    local l_ActiveItems_0 = v19.ActiveItems;
    local l_TopbarContainer_0 = v19.TopbarContainer;
    local l_IconContainer_0 = l_TopbarContainer_0.IconContainer;
    local l_Default_0 = v20.Default;
    local v25 = {};
    v15.new = function() --[[ Line: 41 ]] --[[ Name: new ]]
        -- upvalues: v15 (copy), v18 (copy), l_IconContainer_0 (copy), l_TopbarContainer_0 (copy), v25 (copy), l_StarterGui_0 (copy), v16 (copy), l_TweenService_0 (copy), v17 (copy), l_HttpService_0 (copy), l_Default_0 (copy), l_UserInputService_0 (copy), l_RunService_0 (copy)
        local v26 = {};
        setmetatable(v26, v15);
        local v27 = v18.new();
        v26._maid = v27;
        v26._hoveringMaid = v27:give(v18.new());
        v26._dropdownClippingMaid = v27:give(v18.new());
        v26._menuClippingMaid = v27:give(v18.new());
        local v28 = {};
        v26.instances = v28;
        local v29 = v27:give(l_IconContainer_0:Clone());
        v29.Visible = true;
        v29.Parent = l_TopbarContainer_0;
        v28.iconContainer = v29;
        v28.iconButton = v29.IconButton;
        v28.iconImage = v28.iconButton.IconImage;
        v28.iconLabel = v28.iconButton.IconLabel;
        v28.fakeIconLabel = v28.iconButton.FakeIconLabel;
        v28.iconGradient = v28.iconButton.IconGradient;
        v28.iconCorner = v28.iconButton.IconCorner;
        v28.iconOverlay = v29.IconOverlay;
        v28.iconOverlayCorner = v28.iconOverlay.IconOverlayCorner;
        v28.noticeFrame = v28.iconButton.NoticeFrame;
        v28.noticeLabel = v28.noticeFrame.NoticeLabel;
        v28.captionContainer = v29.CaptionContainer;
        v28.captionFrame = v28.captionContainer.CaptionFrame;
        v28.captionLabel = v28.captionContainer.CaptionLabel;
        v28.captionCorner = v28.captionFrame.CaptionCorner;
        v28.captionOverlineContainer = v28.captionContainer.CaptionOverlineContainer;
        v28.captionOverline = v28.captionOverlineContainer.CaptionOverline;
        v28.captionOverlineCorner = v28.captionOverline.CaptionOverlineCorner;
        v28.captionVisibilityBlocker = v28.captionFrame.CaptionVisibilityBlocker;
        v28.captionVisibilityCorner = v28.captionVisibilityBlocker.CaptionVisibilityCorner;
        v28.tipFrame = v29.TipFrame;
        v28.tipLabel = v28.tipFrame.TipLabel;
        v28.tipCorner = v28.tipFrame.TipCorner;
        v28.dropdownContainer = v29.DropdownContainer;
        v28.dropdownFrame = v28.dropdownContainer.DropdownFrame;
        v28.dropdownList = v28.dropdownFrame.DropdownList;
        v28.menuContainer = v29.MenuContainer;
        v28.menuFrame = v28.menuContainer.MenuFrame;
        v28.menuList = v28.menuFrame.MenuList;
        v28.clickSound = v29.ClickSound;
        v26._settings = {
            action = {
                toggleTransitionInfo = {}, 
                resizeInfo = {}, 
                repositionInfo = {}, 
                captionFadeInfo = {}, 
                tipFadeInfo = {}, 
                dropdownSlideInfo = {}, 
                menuSlideInfo = {}
            }, 
            toggleable = {
                iconBackgroundColor = {
                    instanceNames = {
                        "iconButton"
                    }, 
                    propertyName = "BackgroundColor3"
                }, 
                iconBackgroundTransparency = {
                    instanceNames = {
                        "iconButton"
                    }, 
                    propertyName = "BackgroundTransparency"
                }, 
                iconCornerRadius = {
                    instanceNames = {
                        "iconCorner", 
                        "iconOverlayCorner"
                    }, 
                    propertyName = "CornerRadius"
                }, 
                iconGradientColor = {
                    instanceNames = {
                        "iconGradient"
                    }, 
                    propertyName = "Color"
                }, 
                iconGradientRotation = {
                    instanceNames = {
                        "iconGradient"
                    }, 
                    propertyName = "Rotation"
                }, 
                iconImage = {
                    callMethods = {
                        v26._updateIconSize
                    }, 
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "Image"
                }, 
                iconImageColor = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "ImageColor3"
                }, 
                iconImageTransparency = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "ImageTransparency"
                }, 
                iconScale = {
                    instanceNames = {
                        "iconButton"
                    }, 
                    propertyName = "Size"
                }, 
                forcedIconSizeX = {}, 
                forcedIconSizeY = {}, 
                iconSize = {
                    callSignals = {
                        v26.updated
                    }, 
                    callMethods = {
                        v26._updateIconSize
                    }, 
                    instanceNames = {
                        "iconContainer"
                    }, 
                    propertyName = "Size", 
                    tweenAction = "resizeInfo"
                }, 
                iconOffset = {
                    instanceNames = {
                        "iconButton"
                    }, 
                    propertyName = "Position"
                }, 
                iconText = {
                    callMethods = {
                        v26._updateIconSize
                    }, 
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "Text"
                }, 
                iconTextColor = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "TextColor3"
                }, 
                iconFont = {
                    callMethods = {
                        v26._updateIconSize
                    }, 
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "Font"
                }, 
                iconImageYScale = {
                    callMethods = {
                        v26._updateIconSize
                    }
                }, 
                iconImageRatio = {
                    callMethods = {
                        v26._updateIconSize
                    }
                }, 
                iconLabelYScale = {
                    callMethods = {
                        v26._updateIconSize
                    }
                }, 
                noticeCircleColor = {
                    instanceNames = {
                        "noticeFrame"
                    }, 
                    propertyName = "ImageColor3"
                }, 
                noticeCircleImage = {
                    instanceNames = {
                        "noticeFrame"
                    }, 
                    propertyName = "Image"
                }, 
                noticeTextColor = {
                    instanceNames = {
                        "noticeLabel"
                    }, 
                    propertyName = "TextColor3"
                }, 
                noticeImageTransparency = {
                    instanceNames = {
                        "noticeFrame"
                    }, 
                    propertyName = "ImageTransparency"
                }, 
                noticeTextTransparency = {
                    instanceNames = {
                        "noticeLabel"
                    }, 
                    propertyName = "TextTransparency"
                }, 
                baseZIndex = {
                    callMethods = {
                        v26._updateBaseZIndex
                    }
                }, 
                order = {
                    callSignals = {
                        v26.updated
                    }, 
                    instanceNames = {
                        "iconContainer"
                    }, 
                    propertyName = "LayoutOrder"
                }, 
                alignment = {
                    callSignals = {
                        v26.updated
                    }, 
                    callMethods = {
                        v26._updateDropdown
                    }
                }, 
                iconImageVisible = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "Visible"
                }, 
                iconImageAnchorPoint = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "AnchorPoint"
                }, 
                iconImagePosition = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "Position", 
                    tweenAction = "resizeInfo"
                }, 
                iconImageSize = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "Size", 
                    tweenAction = "resizeInfo"
                }, 
                iconImageTextXAlignment = {
                    instanceNames = {
                        "iconImage"
                    }, 
                    propertyName = "TextXAlignment"
                }, 
                iconLabelVisible = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "Visible"
                }, 
                iconLabelAnchorPoint = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "AnchorPoint"
                }, 
                iconLabelPosition = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "Position", 
                    tweenAction = "resizeInfo"
                }, 
                iconLabelSize = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "Size", 
                    tweenAction = "resizeInfo"
                }, 
                iconLabelTextXAlignment = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "TextXAlignment"
                }, 
                iconLabelTextSize = {
                    instanceNames = {
                        "iconLabel"
                    }, 
                    propertyName = "TextSize"
                }, 
                noticeFramePosition = {
                    instanceNames = {
                        "noticeFrame"
                    }, 
                    propertyName = "Position"
                }, 
                clickSoundId = {
                    instanceNames = {
                        "clickSound"
                    }, 
                    propertyName = "SoundId"
                }, 
                clickVolume = {
                    instanceNames = {
                        "clickSound"
                    }, 
                    propertyName = "Volume"
                }, 
                clickPlaybackSpeed = {
                    instanceNames = {
                        "clickSound"
                    }, 
                    propertyName = "PlaybackSpeed"
                }, 
                clickTimePosition = {
                    instanceNames = {
                        "clickSound"
                    }, 
                    propertyName = "TimePosition"
                }
            }, 
            other = {
                captionBackgroundColor = {
                    instanceNames = {
                        "captionFrame"
                    }, 
                    propertyName = "BackgroundColor3"
                }, 
                captionBackgroundTransparency = {
                    instanceNames = {
                        "captionFrame"
                    }, 
                    propertyName = "BackgroundTransparency", 
                    group = "caption"
                }, 
                captionBlockerTransparency = {
                    instanceNames = {
                        "captionVisibilityBlocker"
                    }, 
                    propertyName = "BackgroundTransparency", 
                    group = "caption"
                }, 
                captionOverlineColor = {
                    instanceNames = {
                        "captionOverline"
                    }, 
                    propertyName = "BackgroundColor3"
                }, 
                captionOverlineTransparency = {
                    instanceNames = {
                        "captionOverline"
                    }, 
                    propertyName = "BackgroundTransparency", 
                    group = "caption"
                }, 
                captionTextColor = {
                    instanceNames = {
                        "captionLabel"
                    }, 
                    propertyName = "TextColor3"
                }, 
                captionTextTransparency = {
                    instanceNames = {
                        "captionLabel"
                    }, 
                    propertyName = "TextTransparency", 
                    group = "caption"
                }, 
                captionFont = {
                    instanceNames = {
                        "captionLabel"
                    }, 
                    propertyName = "Font"
                }, 
                captionCornerRadius = {
                    instanceNames = {
                        "captionCorner", 
                        "captionOverlineCorner", 
                        "captionVisibilityCorner"
                    }, 
                    propertyName = "CornerRadius"
                }, 
                tipBackgroundColor = {
                    instanceNames = {
                        "tipFrame"
                    }, 
                    propertyName = "BackgroundColor3"
                }, 
                tipBackgroundTransparency = {
                    instanceNames = {
                        "tipFrame"
                    }, 
                    propertyName = "BackgroundTransparency", 
                    group = "tip"
                }, 
                tipTextColor = {
                    instanceNames = {
                        "tipLabel"
                    }, 
                    propertyName = "TextColor3"
                }, 
                tipTextTransparency = {
                    instanceNames = {
                        "tipLabel"
                    }, 
                    propertyName = "TextTransparency", 
                    group = "tip"
                }, 
                tipFont = {
                    instanceNames = {
                        "tipLabel"
                    }, 
                    propertyName = "Font"
                }, 
                tipCornerRadius = {
                    instanceNames = {
                        "tipCorner"
                    }, 
                    propertyName = "CornerRadius"
                }, 
                dropdownSize = {
                    instanceNames = {
                        "dropdownContainer"
                    }, 
                    propertyName = "Size", 
                    unique = "dropdown"
                }, 
                dropdownCanvasSize = {
                    instanceNames = {
                        "dropdownFrame"
                    }, 
                    propertyName = "CanvasSize"
                }, 
                dropdownMaxIconsBeforeScroll = {
                    callMethods = {
                        v26._updateDropdown
                    }
                }, 
                dropdownMinWidth = {
                    callMethods = {
                        v26._updateDropdown
                    }
                }, 
                dropdownSquareCorners = {
                    callMethods = {
                        v26._updateDropdown
                    }
                }, 
                dropdownBindToggleToIcon = {}, 
                dropdownToggleOnLongPress = {}, 
                dropdownToggleOnRightClick = {}, 
                dropdownCloseOnTapAway = {}, 
                dropdownHidePlayerlistOnOverlap = {}, 
                dropdownListPadding = {
                    callMethods = {
                        v26._updateDropdown
                    }, 
                    instanceNames = {
                        "dropdownList"
                    }, 
                    propertyName = "Padding"
                }, 
                dropdownAlignment = {
                    callMethods = {
                        v26._updateDropdown
                    }
                }, 
                dropdownScrollBarColor = {
                    instanceNames = {
                        "dropdownFrame"
                    }, 
                    propertyName = "ScrollBarImageColor3"
                }, 
                dropdownScrollBarTransparency = {
                    instanceNames = {
                        "dropdownFrame"
                    }, 
                    propertyName = "ScrollBarImageTransparency"
                }, 
                dropdownScrollBarThickness = {
                    instanceNames = {
                        "dropdownFrame"
                    }, 
                    propertyName = "ScrollBarThickness"
                }, 
                dropdownIgnoreClipping = {
                    callMethods = {
                        v26._dropdownIgnoreClipping
                    }
                }, 
                menuSize = {
                    instanceNames = {
                        "menuContainer"
                    }, 
                    propertyName = "Size", 
                    unique = "menu"
                }, 
                menuCanvasSize = {
                    instanceNames = {
                        "menuFrame"
                    }, 
                    propertyName = "CanvasSize"
                }, 
                menuMaxIconsBeforeScroll = {
                    callMethods = {
                        v26._updateMenu
                    }
                }, 
                menuBindToggleToIcon = {}, 
                menuToggleOnLongPress = {}, 
                menuToggleOnRightClick = {}, 
                menuCloseOnTapAway = {}, 
                menuListPadding = {
                    callMethods = {
                        v26._updateMenu
                    }, 
                    instanceNames = {
                        "menuList"
                    }, 
                    propertyName = "Padding"
                }, 
                menuDirection = {
                    callMethods = {
                        v26._updateMenu
                    }
                }, 
                menuScrollBarColor = {
                    instanceNames = {
                        "menuFrame"
                    }, 
                    propertyName = "ScrollBarImageColor3"
                }, 
                menuScrollBarTransparency = {
                    instanceNames = {
                        "menuFrame"
                    }, 
                    propertyName = "ScrollBarImageTransparency"
                }, 
                menuScrollBarThickness = {
                    instanceNames = {
                        "menuFrame"
                    }, 
                    propertyName = "ScrollBarThickness"
                }, 
                menuIgnoreClipping = {
                    callMethods = {
                        v26._menuIgnoreClipping
                    }
                }
            }
        };
        v26._groupSettings = {};
        for _, v31 in pairs(v26._settings) do
            for v32, v33 in pairs(v31) do
                local l_group_0 = v33.group;
                if l_group_0 then
                    local v35 = v26._groupSettings[l_group_0];
                    if not v35 then
                        v35 = {};
                        v26._groupSettings[l_group_0] = v35;
                    end;
                    table.insert(v35, v32);
                    v33.forcedGroupValue = v25[l_group_0];
                    v33.useForcedGroupValue = true;
                end;
            end;
        end;
        v26._settingsDictionary = {};
        v26._uniqueSettings = {};
        v26._uniqueSettingsDictionary = {};
        v26.uniqueValues = {};
        local v70 = {
            dropdown = function(_, v37, v38, v39) --[[ Line: 221 ]]
                -- upvalues: v26 (copy), l_StarterGui_0 (ref), v16 (ref), l_TweenService_0 (ref)
                local v40 = v26:get("dropdownSlideInfo");
                local v41 = v26:get("dropdownBindToggleToIcon");
                local v42 = false;
                if v26:get("dropdownHidePlayerlistOnOverlap") == true then
                    v42 = v26:get("alignment") == "right";
                end;
                local _ = v26.instances.dropdownContainer;
                local l_dropdownFrame_0 = v26.instances.dropdownFrame;
                local l_v39_0 = v39;
                local v46 = true;
                local v47 = not v26.isSelected;
                if v41 == false then
                    v47 = not v26.dropdownOpen;
                end;
                local v48 = v26._longPressing or v26._rightClicking;
                if v26._tappingAway or v47 and not v48 or v48 and v26.dropdownOpen then
                    local v49 = v26:get("dropdownSize");
                    local v50 = v49 and v49.X.Offset / 1 or 0;
                    l_v39_0 = UDim2.new(0, v50, 0, 0);
                    v46 = false;
                end;
                if #v26.dropdownIcons > 0 and v46 and v42 then
                    if l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
                        v16._bringBackPlayerlist = v16._bringBackPlayerlist and v16._bringBackPlayerlist + 1 or 1;
                        v26._bringBackPlayerlist = true;
                        l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
                    end;
                elseif v26._bringBackPlayerlist and not v46 and v16._bringBackPlayerlist then
                    local l_v16_0 = v16;
                    l_v16_0._bringBackPlayerlist = l_v16_0._bringBackPlayerlist - 1;
                    if v16._bringBackPlayerlist <= 0 then
                        v16._bringBackPlayerlist = nil;
                        l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
                    end;
                    v26._bringBackPlayerlist = nil;
                end;
                local v52 = l_TweenService_0:Create(v37, v40, {
                    [v38] = l_v39_0
                });
                local v53 = nil;
                v53 = v52.Completed:Connect(function() --[[ Line: 257 ]]
                    -- upvalues: v53 (ref)
                    v53:Disconnect();
                end);
                v52:Play();
                if not v46 then
                    v26._dropdownCanvasPos = l_dropdownFrame_0.CanvasPosition;
                end;
                l_dropdownFrame_0.ScrollingEnabled = v46;
                v26.dropdownOpen = v46;
                v26:_decideToCallSignal("dropdown");
            end, 
            menu = function(_, v55, v56, v57) --[[ Line: 271 ]]
                -- upvalues: v26 (copy), l_TweenService_0 (ref)
                local v58 = v26:get("menuSlideInfo");
                local v59 = v26:get("menuBindToggleToIcon");
                local _ = v26.instances.menuContainer;
                local l_menuFrame_0 = v26.instances.menuFrame;
                local l_v57_0 = v57;
                local v63 = true;
                local v64 = not v26.isSelected;
                if v59 == false then
                    v64 = not v26.menuOpen;
                end;
                local v65 = v26._longPressing or v26._rightClicking;
                if v26._tappingAway or v64 and not v65 or v65 and v26.menuOpen then
                    local v66 = v26:get("menuSize");
                    local v67 = v66 and v66.Y.Offset / 1 or 0;
                    l_v57_0 = UDim2.new(0, 0, 0, v67);
                    v63 = false;
                end;
                if v63 ~= v26.menuOpen then
                    v26.updated:Fire();
                end;
                if v63 and v58.EasingDirection == Enum.EasingDirection.Out then
                    v58 = TweenInfo.new(v58.Time, v58.EasingStyle, Enum.EasingDirection.In);
                end;
                local v68 = l_TweenService_0:Create(v55, v58, {
                    [v56] = l_v57_0
                });
                local v69 = nil;
                v69 = v68.Completed:Connect(function() --[[ Line: 297 ]]
                    -- upvalues: v69 (ref)
                    v69:Disconnect();
                end);
                v68:Play();
                if v63 then
                    if v26._menuCanvasPos then
                        l_menuFrame_0.CanvasPosition = v26._menuCanvasPos;
                    end;
                else
                    v26._menuCanvasPos = l_menuFrame_0.CanvasPosition;
                end;
                l_menuFrame_0.ScrollingEnabled = v63;
                v26.menuOpen = v63;
                v26:_decideToCallSignal("menu");
            end
        };
        for v71, v72 in pairs(v26._settings) do
            for v73, v74 in pairs(v72) do
                if v71 == "toggleable" then
                    v74.values = v74.values or {
                        deselected = nil, 
                        selected = nil
                    };
                else
                    v74.value = nil;
                end;
                v74.additionalValues = {};
                v74.type = v71;
                v26._settingsDictionary[v73] = v74;
                local l_unique_0 = v74.unique;
                if l_unique_0 then
                    local v76 = v26._uniqueSettings[l_unique_0] or {};
                    table.insert(v76, v73);
                    v26._uniqueSettings[l_unique_0] = v76;
                    v26._uniqueSettingsDictionary[v73] = v70[l_unique_0];
                end;
            end;
        end;
        v26.updated = v27:give(v17.new());
        v26.selected = v27:give(v17.new());
        v26.deselected = v27:give(v17.new());
        v26.toggled = v27:give(v17.new());
        v26.userSelected = v27:give(v17.new());
        v26.userDeselected = v27:give(v17.new());
        v26.userToggled = v27:give(v17.new());
        v26.hoverStarted = v27:give(v17.new());
        v26.hoverEnded = v27:give(v17.new());
        v26.dropdownOpened = v27:give(v17.new());
        v26.dropdownClosed = v27:give(v17.new());
        v26.menuOpened = v27:give(v17.new());
        v26.menuClosed = v27:give(v17.new());
        v26.notified = v27:give(v17.new());
        v26._endNotices = v27:give(v17.new());
        v26._ignoreClippingChanged = v27:give(v17.new());
        local function v85(v77, v78) --[[ Line: 359 ]] --[[ Name: setFeatureChange ]]
            -- upvalues: v26 (copy)
            local l__parentIcon_0 = v26._parentIcon;
            v26:set(v77 .. "IgnoreClipping", v78);
            if v78 == true and l__parentIcon_0 then
                local v82 = l__parentIcon_0._ignoreClippingChanged:Connect(function(_, v81) --[[ Line: 363 ]]
                    -- upvalues: v26 (ref), v77 (copy)
                    v26:set(v77 .. "IgnoreClipping", v81);
                end);
                local v83 = nil;
                do
                    local l_v83_0 = v83;
                    l_v83_0 = v26[v77 .. "Closed"]:Connect(function() --[[ Line: 367 ]]
                        -- upvalues: l_v83_0 (ref), v82 (copy)
                        l_v83_0:Disconnect();
                        v82:Disconnect();
                    end);
                end;
            end;
        end;
        v26.dropdownOpened:Connect(function() --[[ Line: 373 ]]
            -- upvalues: v85 (copy)
            v85("dropdown", true);
        end);
        v26.dropdownClosed:Connect(function() --[[ Line: 376 ]]
            -- upvalues: v26 (copy)
            local _ = v26._parentIcon;
            v26:set("dropdownIgnoreClipping", false);
        end);
        v26.menuOpened:Connect(function() --[[ Line: 379 ]]
            -- upvalues: v85 (copy)
            v85("menu", true);
        end);
        v26.menuClosed:Connect(function() --[[ Line: 382 ]]
            -- upvalues: v26 (copy)
            local _ = v26._parentIcon;
            v26:set("menuIgnoreClipping", false);
        end);
        v26.deselectWhenOtherIconSelected = true;
        v26.name = "";
        v26.isSelected = false;
        v26.presentOnTopbar = true;
        v26.accountForWhenDisabled = false;
        v26.enabled = true;
        v26.hovering = false;
        v26.tipText = nil;
        v26.captionText = nil;
        v26.totalNotices = 0;
        v26.notices = {};
        v26.dropdownIcons = {};
        v26.menuIcons = {};
        v26.dropdownOpen = false;
        v26.menuOpen = false;
        v26.locked = false;
        v26.topPadding = UDim.new(0, 4);
        v26.targetPosition = nil;
        v26.toggleItems = {};
        v26.lockedSettings = {};
        v26.UID = l_HttpService_0:GenerateGUID(true);
        v26.blockBackBehaviourChecks = {};
        v26._draggingFinger = false;
        v26._updatingIconSize = true;
        v26._previousDropdownOpen = false;
        v26._previousMenuOpen = false;
        v26._bindedToggleKeys = {};
        v26._bindedEvents = {};
        v26:setName("UnnamedIcon");
        v26:setTheme(l_Default_0, true);
        local function v88(...) --[[ Line: 436 ]]
            -- upvalues: v26 (copy)
            if v26.locked then
                return;
            elseif v26.isSelected then
                v26:deselect();
                v26.userDeselected:Fire();
                v26.userToggled:Fire(false);
                return true;
            else
                v26:select(...);
                v26.userSelected:Fire();
                v26.userToggled:Fire(true);
                return;
            end;
        end;
        v28.iconButton.MouseButton1Click:Connect(function() --[[ Line: 449 ]]
            -- upvalues: v88 (copy)
            v88();
        end);
        v28.iconButton.MouseButton2Click:Connect(function() --[[ Line: 453 ]]
            -- upvalues: v88 (copy)
            v88(nil, true);
        end);
        v28.iconButton.MouseButton1Down:Connect(function() --[[ Line: 466 ]]
            -- upvalues: v26 (copy)
            if v26.locked then
                return;
            else
                v26:_updateStateOverlay(0.7, Color3.new(0, 0, 0));
                return;
            end;
        end);
        v28.iconButton.MouseButton1Up:Connect(function() --[[ Line: 470 ]]
            -- upvalues: v26 (copy)
            if v26.overlayLocked then
                return;
            else
                v26:_updateStateOverlay(0.9, Color3.new(1, 1, 1));
                return;
            end;
        end);
        l_UserInputService_0.InputBegan:Connect(function(v89, v90) --[[ Line: 476 ]]
            -- upvalues: v26 (copy)
            local v91 = {
                [Enum.UserInputType.MouseButton1] = true, 
                [Enum.UserInputType.MouseButton2] = true, 
                [Enum.UserInputType.MouseButton3] = true, 
                [Enum.UserInputType.Touch] = true
            };
            if not v90 and v91[v89.UserInputType] then
                v26._tappingAway = true;
                if v26.dropdownOpen and v26:get("dropdownCloseOnTapAway") == true then
                    v26:_update("dropdownSize");
                end;
                if v26.menuOpen and v26:get("menuCloseOnTapAway") == true then
                    v26:_update("menuSize");
                end;
                v26._tappingAway = false;
            end;
            if v26._bindedToggleKeys[v89.KeyCode] and not v90 and not v26.locked then
                if v26.isSelected then
                    v26:deselect();
                    v26.userDeselected:Fire();
                    v26.userToggled:Fire(false);
                    return;
                else
                    v26:select();
                    v26.userSelected:Fire();
                    v26.userToggled:Fire(true);
                end;
            end;
        end);
        v26.hoverStarted:Connect(function(_, _) --[[ Line: 511 ]]
            -- upvalues: v26 (copy)
            v26.hovering = true;
            if not v26.locked then
                v26:_updateStateOverlay(0.9, Color3.fromRGB(255, 255, 255));
            end;
            v26:_updateHovering();
        end);
        v26.hoverEnded:Connect(function() --[[ Line: 518 ]]
            -- upvalues: v26 (copy)
            v26.hovering = false;
            v26:_updateStateOverlay(1);
            v26._hoveringMaid:clean();
            v26:_updateHovering();
        end);
        v28.iconButton.MouseEnter:Connect(function(v94, v95) --[[ Line: 524 ]]
            -- upvalues: v26 (copy)
            v26.hoverStarted:Fire(v94, v95);
        end);
        v28.iconButton.MouseLeave:Connect(function() --[[ Line: 527 ]]
            -- upvalues: v26 (copy)
            v26.hoverEnded:Fire();
        end);
        v28.iconButton.SelectionGained:Connect(function() --[[ Line: 530 ]]
            -- upvalues: v26 (copy)
            v26.hoverStarted:Fire();
        end);
        v28.iconButton.SelectionLost:Connect(function() --[[ Line: 533 ]]
            -- upvalues: v26 (copy)
            v26.hoverEnded:Fire();
        end);
        v28.iconButton.MouseButton1Down:Connect(function() --[[ Line: 536 ]]
            -- upvalues: v26 (copy), l_RunService_0 (ref), v28 (copy)
            if v26._draggingFinger then
                v26.hoverStarted:Fire();
            end;
            local v96 = nil;
            local v97 = nil;
            local v98 = tick() + 0.7;
            v96 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 545 ]]
                -- upvalues: v98 (copy), v97 (ref), v96 (ref), v26 (ref)
                if tick() >= v98 then
                    v97:Disconnect();
                    v96:Disconnect();
                    v26._longPressing = true;
                    if v26:get("dropdownToggleOnLongPress") == true then
                        v26:_update("dropdownSize");
                    end;
                    if v26:get("menuToggleOnLongPress") == true then
                        v26:_update("menuSize");
                    end;
                    v26._longPressing = false;
                end;
            end);
            v97 = v28.iconButton.MouseButton1Up:Connect(function() --[[ Line: 559 ]]
                -- upvalues: v97 (ref), v96 (ref)
                v97:Disconnect();
                v96:Disconnect();
            end);
        end);
        if l_UserInputService_0.TouchEnabled then
            v28.iconButton.MouseButton1Up:Connect(function() --[[ Line: 565 ]]
                -- upvalues: v26 (copy)
                if v26.hovering then
                    v26.hoverEnded:Fire();
                end;
            end);
            l_UserInputService_0.TouchMoved:Connect(function(_, v100) --[[ Line: 573 ]]
                -- upvalues: v26 (copy)
                if v100 then
                    return;
                else
                    v26._draggingFinger = true;
                    return;
                end;
            end);
            l_UserInputService_0.TouchEnded:Connect(function() --[[ Line: 579 ]]
                -- upvalues: v26 (copy)
                v26._draggingFinger = false;
            end);
        end;
        v26._updatingIconSize = false;
        v26:_updateIconSize();
        v16.iconAdded:Fire(v26);
        return v26;
    end;
    v15.mimic = function(v101) --[[ Line: 593 ]] --[[ Name: mimic ]]
        -- upvalues: v16 (copy), v15 (copy)
        local v102 = v101 .. "Mimic";
        local v103 = v16.getIcon(v102);
        if v103 then
            return v103;
        else
            v103 = v15.new();
            v103:setName(v102);
            if v101 == "Chat" then
                v103:setOrder(-1);
                v103:setImage("rbxasset://textures/ui/TopBar/chatOff.png", "deselected");
                v103:setImage("rbxasset://textures/ui/TopBar/chatOn.png", "selected");
                v103:setImageYScale(0.625);
            end;
            return v103;
        end;
    end;
    v15.set = function(v104, v105, v106, v107, v108) --[[ Line: 618 ]] --[[ Name: set ]]
        local v109 = v104._settingsDictionary[v105];
        assert(v109 ~= nil, ("setting '%s' does not exist"):format(v105));
        if type(v107) == "string" then
            v107 = v107:lower();
        end;
        local v110 = v104:get(v105, v107);
        if v107 == "hovering" then
            v109.hoveringValue = v106;
            if v108 ~= "_ignorePrevious" then
                v109.additionalValues["previous_" .. v107] = v110;
            end;
            if type(v108) == "string" then
                v109.additionalValues[v108 .. "_" .. v107] = v110;
            end;
            v104:_update(v105);
        else
            local l_v107_0 = v107;
            if v109.type == "toggleable" then
                local v112 = {};
                if l_v107_0 == "deselected" or l_v107_0 == "selected" then
                    table.insert(v112, l_v107_0);
                else
                    table.insert(v112, "deselected");
                    table.insert(v112, "selected");
                    l_v107_0 = nil;
                end;
                for _, v114 in pairs(v112) do
                    v109.values[v114] = v106;
                    if v108 ~= "_ignorePrevious" then
                        v109.additionalValues["previous_" .. v114] = v110;
                    end;
                    if type(v108) == "string" then
                        v109.additionalValues[v108 .. "_" .. v114] = v110;
                    end;
                end;
            else
                v109.value = v106;
                if type(v108) == "string" then
                    if v108 ~= "_ignorePrevious" then
                        v109.additionalValues.previous = v110;
                    end;
                    v109.additionalValues[v108] = v110;
                end;
            end;
            if v110 == v106 then
                return v104, "Value was already set";
            else
                local v115 = v104:getToggleState();
                if not v104._updateAfterSettingAll and v109.instanceNames and (v115 == l_v107_0 or l_v107_0 == nil) then
                    local v116 = false;
                    if v105 == "iconSize" then
                        v116 = v110 and v110.X.Scale == 1;
                    end;
                    v104:_update(v105, v115, not (not v109.tweenAction or v116) and v104:get(v109.tweenAction) or TweenInfo.new(0));
                end;
            end;
        end;
        if v109.callMethods then
            for _, v118 in pairs(v109.callMethods) do
                v118(v104, v106, v107);
            end;
        end;
        if v109.callSignals then
            for _, v120 in pairs(v109.callSignals) do
                v120:Fire();
            end;
        end;
        return v104;
    end;
    v15.setAdditionalValue = function(v121, v122, v123, v124, v125) --[[ Line: 699 ]] --[[ Name: setAdditionalValue ]]
        local v126 = v121._settingsDictionary[v122];
        assert(v126 ~= nil, ("setting '%s' does not exist"):format(v122));
        local v127 = v123 .. "_";
        if v125 then
            v127 = v127 .. v125;
        end;
        for v128, _ in pairs(v126.additionalValues) do
            if string.match(v128, v127) then
                v126.additionalValues[v128] = v124;
            end;
        end;
    end;
    v15.get = function(v130, v131, v132, v133) --[[ Line: 713 ]] --[[ Name: get ]]
        local v134 = v130._settingsDictionary[v131];
        assert(v134 ~= nil, ("setting '%s' does not exist"):format(v131));
        local v135 = nil;
        local v136 = nil;
        if typeof(v132) == "string" then
            v132 = v132:lower();
        end;
        if v132 == "hovering" and v133 == nil then
            v135 = v134.hoveringValue;
            local v137 = false;
            if type(v133) == "string" then
                v137 = v134.additionalValues[v133 .. "_" .. v132];
            end;
            v136 = v137;
        end;
        if v134.type == "toggleable" then
            local v138 = (not (v132 ~= "deselected") or v132 == "selected") and v132 or v130:getToggleState();
            if v136 == nil then
                local v139 = false;
                if type(v133) == "string" then
                    v139 = v134.additionalValues[v133 .. "_" .. v138];
                end;
                v136 = v139;
            end;
            if v135 == nil then
                return v134.values[v138], v136;
            end;
        else
            if v136 == nil then
                local v140 = false;
                if type(v133) == "string" then
                    v140 = v134.additionalValues[v133];
                end;
                v136 = v140;
            end;
            if v135 == nil then
                v135 = v134.value;
            end;
        end;
        return v135, v136;
    end;
    v15.getHovering = function(v141, v142) --[[ Line: 749 ]] --[[ Name: getHovering ]]
        local v143 = v141._settingsDictionary[v142];
        assert(v143 ~= nil, ("setting '%s' does not exist"):format(v142));
        return v143.hoveringValue;
    end;
    v15.getToggleState = function(v144, v145) --[[ Line: 755 ]] --[[ Name: getToggleState ]]
        if v145 or v144.isSelected then
            return "selected";
        else
            return "deselected";
        end;
    end;
    v15.getIconState = function(v146) --[[ Line: 760 ]] --[[ Name: getIconState ]]
        if v146.hovering then
            return "hovering";
        else
            return v146:getToggleState();
        end;
    end;
    v15._update = function(v147, v148, v149, v150) --[[ Line: 768 ]] --[[ Name: _update ]]
        -- upvalues: l_TweenService_0 (copy)
        local v151 = v147._settingsDictionary[v148];
        assert(v151 ~= nil, ("setting '%s' does not exist"):format(v148));
        v149 = v149 or v147:getToggleState();
        local v152 = v151.value or v151.values and v151.values[v149];
        if v147.hovering and v151.hoveringValue then
            v152 = v151.hoveringValue;
        end;
        if v152 == nil then
            return;
        else
            local v153 = v150 or v151.tweenAction and v151.tweenAction ~= "" and v147:get(v151.tweenAction) or v147:get("toggleTransitionInfo") or TweenInfo.new(0.15);
            local l_propertyName_0 = v151.propertyName;
            local v155 = {
                string = true, 
                NumberSequence = true, 
                Text = true, 
                EnumItem = true, 
                ColorSequence = true
            };
            local v156 = v147._uniqueSettingsDictionary[v148];
            local l_v152_0 = v152;
            if v151.useForcedGroupValue then
                l_v152_0 = v151.forcedGroupValue;
            end;
            if v151.instanceNames then
                for _, v159 in pairs(v151.instanceNames) do
                    local v160 = v147.instances[v159];
                    local v161 = v155[typeof(v160[l_propertyName_0])] or typeof(v160) == "table";
                    if v156 then
                        v156(v148, v160, l_propertyName_0, l_v152_0);
                    elseif v161 then
                        v160[l_propertyName_0] = v152;
                    else
                        l_TweenService_0:Create(v160, v153, {
                            [l_propertyName_0] = l_v152_0
                        }):Play();
                    end;
                    if v148 == "iconSize" and v160[l_propertyName_0] ~= l_v152_0 then
                        v147.updated:Fire();
                    end;
                end;
            end;
            return;
        end;
    end;
    v15._updateAll = function(v162, v163, v164) --[[ Line: 812 ]] --[[ Name: _updateAll ]]
        for v165, v166 in pairs(v162._settingsDictionary) do
            if v166.instanceNames then
                v162:_update(v165, v163, v164);
            end;
        end;
        v162:_updateIconSize();
        v162:_updateCaptionSize();
        v162:_updateTipSize();
    end;
    v15._updateHovering = function(v167, v168) --[[ Line: 825 ]] --[[ Name: _updateHovering ]]
        for v169, v170 in pairs(v167._settingsDictionary) do
            if v170.instanceNames and v170.hoveringValue ~= nil then
                v167:_update(v169, nil, v168);
            end;
        end;
    end;
    v15._updateStateOverlay = function(v171, v172, v173) --[[ Line: 833 ]] --[[ Name: _updateStateOverlay ]]
        local l_iconOverlay_0 = v171.instances.iconOverlay;
        l_iconOverlay_0.BackgroundTransparency = v172 or 1;
        l_iconOverlay_0.BackgroundColor3 = v173 or Color3.new(1, 1, 1);
    end;
    v15.setTheme = function(v175, v176, v177) --[[ Line: 839 ]] --[[ Name: setTheme ]]
        v175._updateAfterSettingAll = v177;
        for v178, v179 in pairs(v176) do
            if v178 == "toggleable" then
                for v180, v181 in pairs(v179.deselected) do
                    if not v175.lockedSettings[v180] then
                        v175:set(v180, v181, "both");
                    end;
                end;
                for v182, v183 in pairs(v179.selected) do
                    if not v175.lockedSettings[v182] then
                        v175:set(v182, v183, "selected");
                    end;
                end;
            else
                for v184, v185 in pairs(v179) do
                    if not v175.lockedSettings[v184] then
                        local v186 = v175._settingsDictionary[v184];
                        if v178 == "action" and v186 == nil then
                            v186 = {};
                            v175._settingsDictionary[v184] = {};
                        end;
                        v175:set(v184, v185);
                    end;
                end;
            end;
        end;
        v175._updateAfterSettingAll = nil;
        if v177 then
            v175:_updateAll();
        end;
        return v175;
    end;
    v15.getInstance = function(v187, v188) --[[ Line: 873 ]] --[[ Name: getInstance ]]
        return v187.instances[v188];
    end;
    v15.setInstance = function(v189, v190, v191) --[[ Line: 877 ]] --[[ Name: setInstance ]]
        local v192 = v189.instances[v190];
        v189.instances[v190] = v191;
        if v192 then
            v192:Destroy();
        end;
        return v189;
    end;
    v15.getSettingDetail = function(v193, v194) --[[ Line: 886 ]] --[[ Name: getSettingDetail ]]
        for _, v196 in pairs(v193._settings) do
            for v197, v198 in pairs(v196) do
                if v197 == v194 then
                    return v198;
                end;
            end;
        end;
        return false;
    end;
    v15.modifySetting = function(v199, v200, v201) --[[ Line: 897 ]] --[[ Name: modifySetting ]]
        local v202 = v199:getSettingDetail(v200);
        for v203, v204 in pairs(v201) do
            v202[v203] = v204;
        end;
        return v199;
    end;
    v15.convertLabelToNumberSpinner = function(v205, v206) --[[ Line: 905 ]] --[[ Name: convertLabelToNumberSpinner ]]
        v205:set("iconLabelSize", UDim2.new(1, 0, 1, 0));
        v206.Parent = v205:getInstance("iconButton");
        local v207 = {};
        setmetatable(v207, {
            __newindex = function(_, v209, v210) --[[ Line: 912 ]] --[[ Name: __newindex ]]
                -- upvalues: v206 (copy)
                for _, v212 in pairs(v206.Frame:GetDescendants()) do
                    if v212:IsA("TextLabel") then
                        v212[v209] = v210;
                    end;
                end;
            end
        });
        v205:getInstance("iconButton").ZIndex = 0;
        v205:setInstance("iconLabel", v207);
        v205:modifySetting("iconText", {
            instanceNames = {}
        });
        v205:setInstance("iconLabelSpinner", v206.Frame);
        for _, v214 in pairs({
            "iconLabelVisible", 
            "iconLabelAnchorPoint", 
            "iconLabelPosition", 
            "iconLabelSize"
        }) do
            v205:modifySetting(v214, {
                instanceNames = {
                    "iconLabelSpinner"
                }
            });
        end;
        v205:_updateAll();
        return v205;
    end;
    v15.setEnabled = function(v215, v216) --[[ Line: 936 ]] --[[ Name: setEnabled ]]
        v215.enabled = v216;
        v215.instances.iconContainer.Visible = v216;
        v215.updated:Fire();
        return v215;
    end;
    v15.setName = function(v217, v218) --[[ Line: 943 ]] --[[ Name: setName ]]
        v217.name = v218;
        v217.instances.iconContainer.Name = v218;
        return v217;
    end;
    v15.setProperty = function(v219, v220, v221) --[[ Line: 949 ]] --[[ Name: setProperty ]]
        v219[v220] = v221;
        return v219;
    end;
    v15._playClickSound = function(v222) --[[ Line: 954 ]] --[[ Name: _playClickSound ]]
        -- upvalues: l_Debris_0 (copy)
        local l_clickSound_0 = v222.instances.clickSound;
        if l_clickSound_0.SoundId ~= nil and #l_clickSound_0.SoundId > 0 and l_clickSound_0.Volume > 0 then
            local v224 = l_clickSound_0:Clone();
            v224.Parent = l_clickSound_0.Parent;
            v224:Play();
            l_Debris_0:AddItem(v224, l_clickSound_0.TimeLength);
        end;
    end;
    v15.select = function(v225, v226, ...) --[[ Line: 964 ]] --[[ Name: select ]]
        -- upvalues: v16 (copy), l_UserInputService_0 (copy), v18 (copy), l_GuiService_0 (copy)
        v225.isSelected = true;
        v225:_setToggleItemsVisible(true, v226);
        v225:_updateNotice();
        v225:_updateAll();
        v225:_playClickSound();
        if #v225.dropdownIcons > 0 or #v225.menuIcons > 0 then
            v16:_updateSelectionGroup();
        end;
        if l_UserInputService_0.GamepadEnabled then
            for _, v228 in pairs(v225.toggleItems) do
                if #v228 > 0 then
                    local v229 = v18.new();
                    l_GuiService_0:AddSelectionTuple(v225.UID, unpack(v228));
                    l_GuiService_0.SelectedObject = v228[1];
                    local l_v16_1 = v16;
                    l_v16_1.activeButtonBCallbacks = l_v16_1.activeButtonBCallbacks + 1;
                    v229:give(l_UserInputService_0.InputEnded:Connect(function(v231, _) --[[ Line: 985 ]]
                        -- upvalues: v225 (copy), l_GuiService_0 (ref)
                        local v233 = false;
                        for _, v235 in pairs(v225.blockBackBehaviourChecks) do
                            if v235() == true then
                                v233 = true;
                                break;
                            end;
                        end;
                        if v231.KeyCode == Enum.KeyCode.ButtonB and not v233 then
                            l_GuiService_0.SelectedObject = v225.instances.iconButton;
                            v225:deselect();
                        end;
                    end));
                    v229:give(v225.deselected:Connect(function() --[[ Line: 998 ]]
                        -- upvalues: v229 (copy)
                        v229:clean();
                    end));
                    v229:give(function() --[[ Line: 1001 ]]
                        -- upvalues: v16 (ref)
                        local l_v16_2 = v16;
                        l_v16_2.activeButtonBCallbacks = l_v16_2.activeButtonBCallbacks - 1;
                        if v16.activeButtonBCallbacks < 0 then
                            v16.activeButtonBCallbacks = 0;
                        end;
                    end);
                end;
            end;
        end;
        v225.selected:Fire(...);
        v225.toggled:Fire(v225.isSelected);
        return v225;
    end;
    v15.deselect = function(v237, v238) --[[ Line: 1016 ]] --[[ Name: deselect ]]
        -- upvalues: v16 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy)
        v237.isSelected = false;
        v237:_setToggleItemsVisible(false, v238);
        v237:_updateNotice();
        v237:_updateAll();
        v237:_playClickSound();
        if #v237.dropdownIcons > 0 or #v237.menuIcons > 0 then
            v16:_updateSelectionGroup();
        end;
        v237.deselected:Fire();
        v237.toggled:Fire(v237.isSelected);
        if l_UserInputService_0.GamepadEnabled then
            l_GuiService_0:RemoveSelectionGroup(v237.UID);
        end;
        return v237;
    end;
    v15.notify = function(v239, v240, v241) --[[ Line: 1034 ]] --[[ Name: notify ]]
        -- upvalues: v17 (copy), l_HttpService_0 (copy)
        coroutine.wrap(function() --[[ Line: 1035 ]]
            -- upvalues: v240 (ref), v239 (copy), v17 (ref), v241 (ref), l_HttpService_0 (ref)
            if not v240 then
                v240 = v239.deselected;
            end;
            if v239._parentIcon then
                v239._parentIcon:notify(v240);
            end;
            local v242 = v17.new();
            local v243 = v239._endNotices:Connect(function() --[[ Line: 1044 ]]
                -- upvalues: v242 (copy)
                v242:Fire();
            end);
            local v244 = v240:Connect(function() --[[ Line: 1047 ]]
                -- upvalues: v242 (copy)
                v242:Fire();
            end);
            v241 = v241 or l_HttpService_0:GenerateGUID(true);
            v239.notices[v241] = {
                completeSignal = v242, 
                clearNoticeEvent = v240
            };
            local l_v239_0 = v239;
            l_v239_0.totalNotices = l_v239_0.totalNotices + 1;
            v239:_updateNotice();
            v239.notified:Fire(v241);
            v242:Wait();
            v243:Disconnect();
            v244:Disconnect();
            v242:Disconnect();
            l_v239_0 = v239;
            l_v239_0.totalNotices = l_v239_0.totalNotices - 1;
            v239.notices[v241] = nil;
            v239:_updateNotice();
        end)();
        return v239;
    end;
    v15._updateNotice = function(v246) --[[ Line: 1073 ]] --[[ Name: _updateNotice ]]
        local v247 = true;
        if v246.totalNotices < 1 then
            v247 = false;
        end;
        if not v246.isSelected and (#v246.dropdownIcons > 0 or #v246.menuIcons > 0) and v246.totalNotices > 0 then
            v247 = true;
        end;
        if v246.isSelected and (#v246.dropdownIcons > 0 or #v246.menuIcons > 0) then
            v247 = false;
        end;
        local v248 = v247 and 0 or 1;
        v246:set("noticeImageTransparency", v248);
        v246:set("noticeTextTransparency", v248);
        v246.instances.noticeLabel.Text = v246.totalNotices < 100 and v246.totalNotices or "99+";
    end;
    v15.clearNotices = function(v249) --[[ Line: 1096 ]] --[[ Name: clearNotices ]]
        v249._endNotices:Fire();
        return v249;
    end;
    v15.disableStateOverlay = function(v250, v251) --[[ Line: 1101 ]] --[[ Name: disableStateOverlay ]]
        if v251 == nil then
            v251 = true;
        end;
        v250.instances.iconOverlay.Visible = not v251;
        return v250;
    end;
    v15.setLabel = function(v252, v253, v254) --[[ Line: 1113 ]] --[[ Name: setLabel ]]
        v252:set("iconText", v253 or "", v254);
        return v252;
    end;
    v15.setCornerRadius = function(v255, v256, v257, v258) --[[ Line: 1119 ]] --[[ Name: setCornerRadius ]]
        local l_CornerRadius_0 = v255.instances.iconCorner.CornerRadius;
        v255:set("iconCornerRadius", UDim.new(v256 or l_CornerRadius_0.Scale, v257 or l_CornerRadius_0.Offset), v258);
        return v255;
    end;
    v15.setImage = function(v260, v261, v262) --[[ Line: 1126 ]] --[[ Name: setImage ]]
        return v260:set("iconImage", tonumber(v261) and "http://www.roblox.com/asset/?id=" .. v261 or v261 or "", v262);
    end;
    v15.setOrder = function(v263, v264, v265) --[[ Line: 1131 ]] --[[ Name: setOrder ]]
        return v263:set("order", tonumber(v264) or 1, v265);
    end;
    v15.setLeft = function(v266, v267) --[[ Line: 1136 ]] --[[ Name: setLeft ]]
        return v266:set("alignment", "left", v267);
    end;
    v15.setMid = function(v268, v269) --[[ Line: 1140 ]] --[[ Name: setMid ]]
        return v268:set("alignment", "mid", v269);
    end;
    v15.setRight = function(v270, v271) --[[ Line: 1144 ]] --[[ Name: setRight ]]
        -- upvalues: v16 (copy)
        if not v270.internalIcon then
            v16.setupHealthbar();
        end;
        return v270:set("alignment", "right", v271);
    end;
    v15.setImageYScale = function(v272, v273, v274) --[[ Line: 1151 ]] --[[ Name: setImageYScale ]]
        return v272:set("iconImageYScale", tonumber(v273) or 0.63, v274);
    end;
    v15.setImageRatio = function(v275, v276, v277) --[[ Line: 1156 ]] --[[ Name: setImageRatio ]]
        return v275:set("iconImageRatio", tonumber(v276) or 1, v277);
    end;
    v15.setLabelYScale = function(v278, v279, v280) --[[ Line: 1161 ]] --[[ Name: setLabelYScale ]]
        return v278:set("iconLabelYScale", tonumber(v279) or 0.45, v280);
    end;
    v15.setBaseZIndex = function(v281, v282, v283) --[[ Line: 1166 ]] --[[ Name: setBaseZIndex ]]
        return v281:set("baseZIndex", tonumber(v282) or 1, v283);
    end;
    v15._updateBaseZIndex = function(v284, v285) --[[ Line: 1171 ]] --[[ Name: _updateBaseZIndex ]]
        local l_iconContainer_0 = v284.instances.iconContainer;
        local v287 = (tonumber(v285) or l_iconContainer_0.ZIndex) - l_iconContainer_0.ZIndex;
        if v287 == 0 then
            return "The baseValue is the same";
        else
            for _, v289 in pairs(v284.instances) do
                if v289:IsA("GuiObject") then
                    v289.ZIndex = v289.ZIndex + v287;
                end;
            end;
            return true;
        end;
    end;
    v15.setSize = function(v290, v291, v292, v293) --[[ Line: 1184 ]] --[[ Name: setSize ]]
        if tonumber(v291) then
            v290.forcefullyAppliedXSize = true;
            v290:set("forcedIconSizeX", tonumber(v291), v293);
        else
            v290.forcefullyAppliedXSize = false;
            v290:set("forcedIconSizeX", 32, v293);
        end;
        if tonumber(v292) then
            v290.forcefullyAppliedYSize = true;
            v290:set("forcedIconSizeY", tonumber(v292), v293);
        else
            v290.forcefullyAppliedYSize = false;
            v290:set("forcedIconSizeY", 32, v293);
        end;
        local v294 = tonumber(v291) or 32;
        local v295 = tonumber(v292) or v292 ~= "_NIL" and v294 or 32;
        v290:set("iconSize", UDim2.new(0, v294, 0, v295), v293);
        return v290;
    end;
    v15.setXSize = function(v296, v297, v298) --[[ Line: 1205 ]] --[[ Name: setXSize ]]
        v296:setSize(v297, "_NIL", v298);
        return v296;
    end;
    v15.setYSize = function(v299, v300, v301) --[[ Line: 1210 ]] --[[ Name: setYSize ]]
        v299:setSize("_NIL", v300, v301);
        return v299;
    end;
    v15._getContentText = function(v302, v303) --[[ Line: 1215 ]] --[[ Name: _getContentText ]]
        -- upvalues: v16 (copy)
        v302.instances.fakeIconLabel.Text = v303;
        local l_ContentText_0 = v302.instances.fakeIconLabel.ContentText;
        local v305 = false;
        if typeof(v302.instances.iconLabel) == "Instance" then
            v305 = v16.translator:Translate(v302.instances.iconLabel, l_ContentText_0);
        end;
        if typeof(v305) ~= "string" or v305 == "" then
            v305 = l_ContentText_0;
        end;
        v302.instances.fakeIconLabel.Text = "";
        return v305;
    end;
    v15._updateIconSize = function(v306, _, v308) --[[ Line: 1229 ]] --[[ Name: _updateIconSize ]]
        -- upvalues: l_TextService_0 (copy)
        if v306._destroyed then
            return;
        else
            local v309 = {
                iconImage = v306:get("iconImage", v308) or "_NIL", 
                iconText = v306:get("iconText", v308) or "_NIL", 
                iconFont = v306:get("iconFont", v308) or "_NIL", 
                iconSize = v306:get("iconSize", v308) or "_NIL", 
                forcedIconSizeX = v306:get("forcedIconSizeX", v308) or "_NIL", 
                iconImageYScale = v306:get("iconImageYScale", v308) or "_NIL", 
                iconImageRatio = v306:get("iconImageRatio", v308) or "_NIL", 
                iconLabelYScale = v306:get("iconLabelYScale", v308) or "_NIL"
            };
            for _, v311 in pairs(v309) do
                if v311 == "_NIL" then
                    return;
                end;
            end;
            local l_iconContainer_1 = v306.instances.iconContainer;
            if not l_iconContainer_1.Parent then
                return;
            else
                local l_Offset_0 = v309.iconSize.X.Offset;
                local l_Scale_0 = v309.iconSize.X.Scale;
                local v315 = l_Offset_0 + l_Scale_0 * l_iconContainer_1.Parent.AbsoluteSize.X;
                local l_forcedIconSizeX_0 = v309.forcedIconSizeX;
                local v317 = l_Scale_0 > 0 and v315 or v306.forcefullyAppliedXSize and l_forcedIconSizeX_0 or 9999;
                local v318 = v309.iconSize.Y.Offset + v309.iconSize.Y.Scale * l_iconContainer_1.Parent.AbsoluteSize.Y;
                local v319 = v318 * v309.iconLabelYScale;
                local v320 = v306:_getContentText(v309.iconText);
                local l_X_0 = l_TextService_0:GetTextSize(v320, v319, v309.iconFont, Vector2.new(10000, v319)).X;
                local v322 = v318 * v309.iconImageYScale * v309.iconImageRatio;
                local v323 = v309.iconImage ~= "";
                local v324 = v309.iconText ~= "";
                local v325 = 0.5;
                local v326 = nil;
                local v327 = v319 / 2;
                if v323 and not v324 then
                    v326 = 0;
                    v325 = 0.45;
                    v306:set("iconImageVisible", true, v308);
                    v306:set("iconImageAnchorPoint", Vector2.new(0.5, 0.5), v308);
                    v306:set("iconImagePosition", UDim2.new(0.5, 0, 0.5, 0), v308);
                    v306:set("iconImageSize", UDim2.new(v309.iconImageYScale * v309.iconImageRatio, 0, v309.iconImageYScale, 0), v308);
                    v306:set("iconLabelVisible", false, v308);
                elseif not v323 and v324 then
                    v326 = l_X_0 + 24;
                    v306:set("iconLabelVisible", true, v308);
                    v306:set("iconLabelAnchorPoint", Vector2.new(0, 0.5), v308);
                    v306:set("iconLabelPosition", UDim2.new(0, 12, 0.5, 0), v308);
                    v306:set("iconLabelSize", UDim2.new(1, -24, v309.iconLabelYScale, v327), v308);
                    v306:set("iconLabelTextXAlignment", Enum.TextXAlignment.Center, v308);
                    v306:set("iconImageVisible", false, v308);
                elseif v323 and v324 then
                    local v328 = 12 + v322 + 8;
                    v326 = v328 + l_X_0 + 12;
                    v306:set("iconImageVisible", true, v308);
                    v306:set("iconImageAnchorPoint", Vector2.new(0, 0.5), v308);
                    v306:set("iconImagePosition", UDim2.new(0, 12, 0.5, 0), v308);
                    v306:set("iconImageSize", UDim2.new(0, v322, v309.iconImageYScale, 0), v308);
                    v306:set("iconLabelVisible", true, v308);
                    v306:set("iconLabelAnchorPoint", Vector2.new(0, 0.5), v308);
                    v306:set("iconLabelPosition", UDim2.new(0, v328, 0.5, 0), v308);
                    v306:set("iconLabelSize", UDim2.new(1, -v328 - 12, v309.iconLabelYScale, v327), v308);
                    v306:set("iconLabelTextXAlignment", Enum.TextXAlignment.Left, v308);
                end;
                if v326 and not v306._updatingIconSize then
                    v306._updatingIconSize = true;
                    local v329 = l_Scale_0 > 0 and l_Scale_0 or 0;
                    local v330 = l_Scale_0 > 0 and 0 or math.clamp(v326, l_forcedIconSizeX_0, v317);
                    v306:set("iconSize", UDim2.new(v329, v330, v309.iconSize.Y.Scale, v309.iconSize.Y.Offset), v308, "_ignorePrevious");
                    local l__parentIcon_3 = v306._parentIcon;
                    if l__parentIcon_3 then
                        local v332 = UDim2.new(0, v326, 0, v309.iconSize.Y.Offset);
                        if #l__parentIcon_3.dropdownIcons > 0 then
                            v306:setAdditionalValue("iconSize", "beforeDropdown", v332, v308);
                            l__parentIcon_3:_updateDropdown();
                        end;
                        if #l__parentIcon_3.menuIcons > 0 then
                            v306:setAdditionalValue("iconSize", "beforeMenu", v332, v308);
                            l__parentIcon_3:_updateMenu();
                        end;
                    end;
                    v306._updatingIconSize = false;
                end;
                v306:set("iconLabelTextSize", v319, v308);
                v306:set("noticeFramePosition", UDim2.new(v325, 0, 0, -2), v308);
                v306._updatingIconSize = false;
                return;
            end;
        end;
    end;
    v15.bindEvent = function(v333, v334, v335) --[[ Line: 1340 ]] --[[ Name: bindEvent ]]
        local v336 = v333[v334];
        assert(v336 and typeof(v336) == "table" and v336.Connect, "argument[1] must be a valid topbarplus icon event name!");
        assert(typeof(v335) == "function", "argument[2] must be a function!");
        v333._bindedEvents[v334] = v336:Connect(function(...) --[[ Line: 1344 ]]
            -- upvalues: v335 (copy), v333 (copy)
            v335(v333, ...);
        end);
        return v333;
    end;
    v15.unbindEvent = function(v337, v338) --[[ Line: 1350 ]] --[[ Name: unbindEvent ]]
        local v339 = v337._bindedEvents[v338];
        if v339 then
            v339:Disconnect();
            v337._bindedEvents[v338] = nil;
        end;
        return v337;
    end;
    v15.bindToggleKey = function(v340, v341) --[[ Line: 1359 ]] --[[ Name: bindToggleKey ]]
        assert(typeof(v341) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
        v340._bindedToggleKeys[v341] = true;
        return v340;
    end;
    v15.unbindToggleKey = function(v342, v343) --[[ Line: 1365 ]] --[[ Name: unbindToggleKey ]]
        assert(typeof(v343) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
        v342._bindedToggleKeys[v343] = nil;
        return v342;
    end;
    v15.lock = function(v344) --[[ Line: 1371 ]] --[[ Name: lock ]]
        v344.instances.iconButton.Active = false;
        v344.locked = true;
        task.defer(function() --[[ Line: 1374 ]]
            -- upvalues: v344 (copy)
            if v344.locked then
                v344.overlayLocked = true;
            end;
        end);
        return v344;
    end;
    v15.unlock = function(v345) --[[ Line: 1383 ]] --[[ Name: unlock ]]
        v345.instances.iconButton.Active = true;
        v345.locked = false;
        v345.overlayLocked = false;
        return v345;
    end;
    v15.debounce = function(v346, v347) --[[ Line: 1390 ]] --[[ Name: debounce ]]
        v346:lock();
        task.wait(v347);
        v346:unlock();
        return v346;
    end;
    v15.autoDeselect = function(v348, v349) --[[ Line: 1397 ]] --[[ Name: autoDeselect ]]
        if v349 == nil then
            v349 = true;
        end;
        v348.deselectWhenOtherIconSelected = v349;
        return v348;
    end;
    v15.setTopPadding = function(v350, v351, v352) --[[ Line: 1405 ]] --[[ Name: setTopPadding ]]
        local v353 = v351 or 4;
        local v354 = v352 or 0;
        v350.topPadding = UDim.new(v354, v353);
        v350.updated:Fire();
        return v350;
    end;
    v15.bindToggleItem = function(v355, v356) --[[ Line: 1413 ]] --[[ Name: bindToggleItem ]]
        if not v356:IsA("GuiObject") and not v356:IsA("LayerCollector") then
            error("Toggle item must be a GuiObject or LayerCollector!");
        end;
        v355.toggleItems[v356] = true;
        v355:updateSelectionInstances();
        return v355;
    end;
    v15.updateSelectionInstances = function(v357) --[[ Line: 1422 ]] --[[ Name: updateSelectionInstances ]]
        for v358, _ in pairs(v357.toggleItems) do
            local v360 = {};
            for _, v362 in pairs(v358:GetDescendants()) do
                if (v362:IsA("TextButton") or v362:IsA("ImageButton")) and v362.Active then
                    table.insert(v360, v362);
                end;
            end;
            v357.toggleItems[v358] = v360;
        end;
    end;
    v15.addBackBlocker = function(v363, v364) --[[ Line: 1435 ]] --[[ Name: addBackBlocker ]]
        table.insert(v363.blockBackBehaviourChecks, v364);
        return v363;
    end;
    v15.unbindToggleItem = function(v365, v366) --[[ Line: 1444 ]] --[[ Name: unbindToggleItem ]]
        v365.toggleItems[v366] = nil;
        return v365;
    end;
    v15._setToggleItemsVisible = function(v367, v368, v369) --[[ Line: 1449 ]] --[[ Name: _setToggleItemsVisible ]]
        for v370, _ in pairs(v367.toggleItems) do
            if not v369 or v369.toggleItems[v370] == nil then
                local v372 = "Visible";
                if v370:IsA("LayerCollector") then
                    v372 = "Enabled";
                end;
                v370[v372] = v368;
            end;
        end;
    end;
    v15.call = function(v373, v374) --[[ Line: 1461 ]] --[[ Name: call ]]
        task.spawn(v374, v373);
        return v373;
    end;
    v15.give = function(v375, v376) --[[ Line: 1466 ]] --[[ Name: give ]]
        local l_v376_0 = v376;
        if typeof(v376) == "function" then
            local v378 = v376(v375);
            l_v376_0 = if typeof(v376) ~= "function" then v378 else nil;
        end;
        if l_v376_0 ~= nil then
            v375._maid:give(l_v376_0);
        end;
        return v375;
    end;
    v25.tip = 1;
    v15.setTip = function(v379, v380) --[[ Line: 1485 ]] --[[ Name: setTip ]]
        -- upvalues: l_ActiveItems_0 (copy), v18 (copy)
        local v381 = true;
        if typeof(v380) ~= "string" then
            v381 = v380 == nil;
        end;
        assert(v381, "Expected string, got " .. typeof(v380));
        local v382 = v380 or "";
        v381 = v382 ~= "";
        v379.tipText = v380;
        v379.instances.tipLabel.Text = v382;
        v379.instances.tipFrame.Parent = v381 and l_ActiveItems_0 or v379.instances.iconContainer;
        v379._maid.tipFrame = v379.instances.tipFrame;
        v379:_updateTipSize();
        local v383 = v18.new();
        v379._maid.tipMaid = v383;
        if v381 then
            v383:give(v379.hoverStarted:Connect(function() --[[ Line: 1498 ]]
                -- upvalues: v379 (copy)
                if not v379.isSelected then
                    v379:displayTip(true);
                end;
            end));
            v383:give(v379.hoverEnded:Connect(function() --[[ Line: 1503 ]]
                -- upvalues: v379 (copy)
                v379:displayTip(false);
            end));
            v383:give(v379.selected:Connect(function() --[[ Line: 1506 ]]
                -- upvalues: v379 (copy)
                if v379.hovering then
                    v379:displayTip(false);
                end;
            end));
        end;
        v379:displayTip(v379.hovering and v381);
        return v379;
    end;
    v15._updateTipSize = function(v384) --[[ Line: 1516 ]] --[[ Name: _updateTipSize ]]
        -- upvalues: l_TextService_0 (copy)
        local v385 = v384.tipText or "";
        local v386 = v385 ~= "";
        local v387 = v384:_getContentText(v385);
        local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v387, 12, Enum.Font.GothamSemibold, Vector2.new(1000, 14));
        v384.instances.tipFrame.Size = v386 and UDim2.new(0, l_l_TextService_0_TextSize_0.X + 6, 0, 20) or UDim2.new(0, 0, 0, 0);
    end;
    v15.displayTip = function(v389, v390) --[[ Line: 1524 ]] --[[ Name: displayTip ]]
        -- upvalues: l_UserInputService_0 (copy), v16 (copy), v19 (copy)
        if l_UserInputService_0.TouchEnabled and not v389._draggingFinger then
            return;
        else
            local v391 = v389.tipVisible or false;
            if typeof(v390) == "boolean" then
                v391 = v390;
            end;
            v389.tipVisible = v391;
            local l_tipFrame_0 = v389.instances.tipFrame;
            if v391 then
                local function v411(v393, v394) --[[ Line: 1538 ]] --[[ Name: updateTipPositon ]]
                    -- upvalues: l_UserInputService_0 (ref), l_tipFrame_0 (copy), v16 (ref), v19 (ref)
                    local l_v393_0 = v393;
                    local l_v394_0 = v394;
                    local l_CurrentCamera_0 = workspace.CurrentCamera;
                    local v398 = l_CurrentCamera_0 and l_CurrentCamera_0.ViewportSize;
                    if l_UserInputService_0.TouchEnabled then
                        local v399 = l_v393_0 - l_tipFrame_0.Size.X.Offset / 2;
                        local v400 = v398.X - l_tipFrame_0.Size.X.Offset;
                        local v401 = l_v394_0 + 55 + 60;
                        local v402 = l_tipFrame_0.AbsoluteSize.Y + 55 + 64 + 3;
                        local v403 = v398.Y - l_tipFrame_0.Size.Y.Offset;
                        l_v393_0 = math.clamp(v399, 0, v400);
                        l_v394_0 = math.clamp(v401, v402, v403);
                    elseif v16.controllerModeEnabled then
                        local l_Indicator_0 = v19.Indicator;
                        local l_AbsolutePosition_0 = l_Indicator_0.AbsolutePosition;
                        l_v393_0 = l_AbsolutePosition_0.X - l_tipFrame_0.Size.X.Offset / 2 + l_Indicator_0.AbsoluteSize.X / 2;
                        l_v394_0 = l_AbsolutePosition_0.Y + 90;
                    else
                        local l_l_v393_0_0 = l_v393_0;
                        local v407 = v398.X - l_tipFrame_0.Size.X.Offset - 48;
                        local l_l_v394_0_0 = l_v394_0;
                        local v409 = l_tipFrame_0.Size.Y.Offset + 3;
                        local l_Y_0 = v398.Y;
                        l_v393_0 = math.clamp(l_l_v393_0_0, 0, v407);
                        l_v394_0 = math.clamp(l_l_v394_0_0, v409, l_Y_0);
                    end;
                    l_tipFrame_0.Position = UDim2.new(0, l_v393_0, 0, l_v394_0 - 20);
                end;
                local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
                if l_l_UserInputService_0_MouseLocation_0 then
                    v411(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
                end;
                v389._hoveringMaid:give(v389.instances.iconButton.MouseMoved:Connect(v411));
            end;
            for _, v414 in pairs(v389._groupSettings.tip) do
                v389._settingsDictionary[v414].useForcedGroupValue = not v391;
                v389:_update(v414);
            end;
            return;
        end;
    end;
    v25.caption = 1;
    v15.setCaption = function(v415, v416) --[[ Line: 1593 ]] --[[ Name: setCaption ]]
        -- upvalues: l_ActiveItems_0 (copy), v18 (copy)
        local v417 = true;
        if typeof(v416) ~= "string" then
            v417 = v416 == nil;
        end;
        assert(v417, "Expected string, got " .. typeof(v416));
        local v418 = v416 or "";
        v417 = v418 ~= "";
        v415.captionText = v416;
        v415.instances.captionLabel.Text = v418;
        v415.instances.captionContainer.Parent = v417 and l_ActiveItems_0 or v415.instances.iconContainer;
        v415._maid.captionContainer = v415.instances.captionContainer;
        v415:_updateIconSize(nil, v415:getIconState());
        local v419 = v18.new();
        v415._maid.captionMaid = v419;
        if v417 then
            v419:give(v415.hoverStarted:Connect(function() --[[ Line: 1605 ]]
                -- upvalues: v415 (copy)
                if not v415.isSelected then
                    v415:displayCaption(true);
                end;
            end));
            v419:give(v415.hoverEnded:Connect(function() --[[ Line: 1610 ]]
                -- upvalues: v415 (copy)
                v415:displayCaption(false);
            end));
            v419:give(v415.selected:Connect(function() --[[ Line: 1613 ]]
                -- upvalues: v415 (copy)
                if v415.hovering then
                    v415:displayCaption(false);
                end;
            end));
            local l_iconContainer_2 = v415.instances.iconContainer;
            v419:give(l_iconContainer_2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 1619 ]]
                -- upvalues: v415 (copy)
                if v415.hovering then
                    v415:displayCaption();
                end;
            end));
            v419:give(l_iconContainer_2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 1624 ]]
                -- upvalues: v415 (copy)
                if v415.hovering then
                    v415:displayCaption();
                end;
            end));
        end;
        v415:_updateCaptionSize();
        v415:displayCaption(v415.hovering and v417);
        return v415;
    end;
    v15._updateCaptionSize = function(v421) --[[ Line: 1635 ]] --[[ Name: _updateCaptionSize ]]
        -- upvalues: l_TextService_0 (copy)
        local v422 = v421:get("iconSize");
        local v423 = v421:get("captionFont");
        if v422 and v423 then
            local l_Offset_1 = v422.Y.Offset;
            local l_Scale_1 = v422.Y.Scale;
            local l_iconContainer_3 = v421.instances.iconContainer;
            local l_captionContainer_0 = v421.instances.captionContainer;
            if (v421.captionText or "") ~= "" then
                local v428 = l_Offset_1 + l_Scale_1 * l_iconContainer_3.Parent.AbsoluteSize.Y;
                local l_captionLabel_0 = v421.instances.captionLabel;
                local v430 = v428 * 0.8 * 0.58;
                local v431 = v421:_getContentText(v421.captionText);
                local l_X_1 = l_TextService_0:GetTextSize(v431, v430, v423, Vector2.new(10000, v430)).X;
                l_captionLabel_0.TextSize = v430;
                l_captionLabel_0.Size = UDim2.new(0, l_X_1, 0.58, 0);
                l_captionContainer_0.Size = UDim2.new(0, l_X_1 + 12, 0, v428 * 0.8);
                return;
            else
                l_captionContainer_0.Size = UDim2.new(0, 0, 0, 0);
            end;
        end;
    end;
    v15.displayCaption = function(v433, v434) --[[ Line: 1665 ]] --[[ Name: displayCaption ]]
        -- upvalues: l_UserInputService_0 (copy)
        if l_UserInputService_0.TouchEnabled and not v433._draggingFinger then
            return;
        else
            local v435 = 8;
            if v433._draggingFinger then
                v435 = v435 + 55;
            end;
            local l_iconContainer_4 = v433.instances.iconContainer;
            local l_captionContainer_1 = v433.instances.captionContainer;
            l_captionContainer_1.Position = UDim2.new(0, l_iconContainer_4.AbsolutePosition.X + l_iconContainer_4.AbsoluteSize.X / 2 - l_captionContainer_1.AbsoluteSize.X / 2, 0, l_iconContainer_4.AbsolutePosition.Y + l_iconContainer_4.AbsoluteSize.Y * 2 + v435);
            local v438 = v433.captionVisible or false;
            if typeof(v434) == "boolean" then
                v438 = v434;
            end;
            v433.captionVisible = v438;
            local _ = v433:get("captionFadeInfo");
            for _, v441 in pairs(v433._groupSettings.caption) do
                v433._settingsDictionary[v441].useForcedGroupValue = not v438;
                v433:_update(v441);
            end;
            return;
        end;
    end;
    v15.join = function(v442, v443, v444, v445) --[[ Line: 1695 ]] --[[ Name: join ]]
        -- upvalues: v16 (copy)
        if v442._parentIcon then
            v442:leave();
        end;
        local v446 = v444 and v444:lower() or "dropdown";
        local v447 = "before" .. v444:sub(1, 1):upper() .. v444:sub(2);
        local v448 = v443.instances[v444 .. "Frame"];
        v442.presentOnTopbar = false;
        v442.joinedFeatureName = v444;
        v442._parentIcon = v443;
        v442.instances.iconContainer.Parent = v448;
        for v449, v450 in pairs(v442.notices) do
            v443:notify(v450.clearNoticeEvent, v449);
        end;
        if v444 == "dropdown" then
            local v451 = v443:get("dropdownSquareCorners");
            v442:set("iconSize", UDim2.new(1, 0, 0, v442:get("iconSize", "deselected").Y.Offset), "deselected", v447);
            v442:set("iconSize", UDim2.new(1, 0, 0, v442:get("iconSize", "selected").Y.Offset), "selected", v447);
            if v451 then
                v442:set("iconCornerRadius", UDim.new(0, 0), "deselected", v447);
                v442:set("iconCornerRadius", UDim.new(0, 0), "selected", v447);
            end;
            v442:set("captionBlockerTransparency", 0.4, nil, v447);
        end;
        table.insert(v443[v446 .. "Icons"], v442);
        if not v445 then
            if v444 == "dropdown" then
                v443:_updateDropdown();
            elseif v444 == "menu" then
                v443:_updateMenu();
            end;
        end;
        v443.deselectWhenOtherIconSelected = false;
        v16:_updateSelectionGroup();
        v442:_decideToCallSignal("dropdown");
        v442:_decideToCallSignal("menu");
        return v442;
    end;
    v15.leave = function(v452) --[[ Line: 1739 ]] --[[ Name: leave ]]
        -- upvalues: l_TopbarContainer_0 (copy), v16 (copy)
        if v452._destroyed or v452.instances.iconContainer.Parent == nil then
            return;
        else
            local v453 = {
                "iconSize", 
                "captionBlockerTransparency", 
                "iconCornerRadius"
            };
            local l__parentIcon_4 = v452._parentIcon;
            v452.instances.iconContainer.Parent = l_TopbarContainer_0;
            v452.presentOnTopbar = true;
            v452.joinedFeatureName = nil;
            local function v466(v455, v456, v457) --[[ Line: 1748 ]] --[[ Name: scanFeature ]]
                -- upvalues: v452 (copy), v453 (copy), l__parentIcon_4 (copy)
                for v458, v459 in pairs(v455) do
                    if v459 == v452 then
                        for _, v461 in pairs(v453) do
                            for _, v463 in pairs({
                                "deselected", 
                                "selected"
                            }) do
                                local _, v465 = v452:get(v461, v463, v456);
                                if v465 then
                                    v452:set(v461, v465, v463);
                                end;
                            end;
                        end;
                        table.remove(v455, v458);
                        v457(l__parentIcon_4);
                        if #v455 == 0 then
                            v452._parentIcon.deselectWhenOtherIconSelected = true;
                            return;
                        else
                            break;
                        end;
                    end;
                end;
            end;
            v466(l__parentIcon_4.dropdownIcons, "beforeDropdown", l__parentIcon_4._updateDropdown);
            v466(l__parentIcon_4.menuIcons, "beforeMenu", l__parentIcon_4._updateMenu);
            for v467, _ in pairs(v452.notices) do
                local v469 = l__parentIcon_4.notices[v467];
                if v469 then
                    v469.completeSignal:Fire();
                end;
            end;
            v452._parentIcon = nil;
            v16:_updateSelectionGroup();
            v452:_decideToCallSignal("dropdown");
            v452:_decideToCallSignal("menu");
            return v452;
        end;
    end;
    v15._decideToCallSignal = function(v470, v471) --[[ Line: 1788 ]] --[[ Name: _decideToCallSignal ]]
        local v472 = v470[v471 .. "Open"];
        local v473 = "_previous" .. string.sub(v471, 1, 1):upper() .. v471:sub(2) .. "Open";
        local v474 = v470[v473];
        local v475 = #v470[v471 .. "Icons"];
        if v472 and v475 > 0 and v474 == false then
            v470[v473] = true;
            v470[v471 .. "Opened"]:Fire();
            return;
        else
            if (not v472 or v475 == 0) and v474 == true then
                v470[v473] = false;
                v470[v471 .. "Closed"]:Fire();
            end;
            return;
        end;
    end;
    v15._ignoreClipping = function(v476, v477) --[[ Line: 1802 ]] --[[ Name: _ignoreClipping ]]
        -- upvalues: l_ActiveItems_0 (copy)
        local v478 = v476:get(v477 .. "IgnoreClipping");
        if v476._parentIcon then
            local v479 = v476["_" .. v477 .. "ClippingMaid"];
            local v480 = v476.instances[v477 .. "Container"];
            v479:clean();
            if v478 then
                local l_Frame_0 = Instance.new("Frame");
                l_Frame_0.Name = v480.Name .. "FakeFrame";
                l_Frame_0.ClipsDescendants = true;
                l_Frame_0.BackgroundTransparency = 1;
                l_Frame_0.Size = v480.Size;
                l_Frame_0.Position = v480.Position;
                l_Frame_0.Parent = l_ActiveItems_0;
                for _, v483 in pairs(v480:GetChildren()) do
                    v483.Parent = l_Frame_0;
                end;
                local function _() --[[ Line: 1821 ]] --[[ Name: updateSize ]]
                    -- upvalues: v480 (copy), l_Frame_0 (copy)
                    local l_AbsoluteSize_0 = v480.AbsoluteSize;
                    l_Frame_0.Size = UDim2.new(0, l_AbsoluteSize_0.X, 0, l_AbsoluteSize_0.Y);
                end;
                v479:give(v480:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 1825 ]]
                    -- upvalues: v480 (copy), l_Frame_0 (copy)
                    local l_AbsoluteSize_1 = v480.AbsoluteSize;
                    l_Frame_0.Size = UDim2.new(0, l_AbsoluteSize_1.X, 0, l_AbsoluteSize_1.Y);
                end));
                local l_AbsoluteSize_2 = v480.AbsoluteSize;
                l_Frame_0.Size = UDim2.new(0, l_AbsoluteSize_2.X, 0, l_AbsoluteSize_2.Y);
                l_AbsoluteSize_2 = function() --[[ Line: 1829 ]] --[[ Name: updatePos ]]
                    -- upvalues: v480 (copy), l_Frame_0 (copy)
                    local l_absolutePosition_0 = v480.absolutePosition;
                    l_Frame_0.Position = UDim2.new(0, l_absolutePosition_0.X, 0, l_absolutePosition_0.Y + 36);
                end;
                v479:give(v480:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 1833 ]]
                    -- upvalues: v480 (copy), l_Frame_0 (copy)
                    local l_absolutePosition_1 = v480.absolutePosition;
                    l_Frame_0.Position = UDim2.new(0, l_absolutePosition_1.X, 0, l_absolutePosition_1.Y + 36);
                end));
                local l_absolutePosition_2 = v480.absolutePosition;
                l_Frame_0.Position = UDim2.new(0, l_absolutePosition_2.X, 0, l_absolutePosition_2.Y + 36);
                v479:give(function() --[[ Line: 1837 ]]
                    -- upvalues: l_Frame_0 (copy), v480 (copy)
                    for _, v492 in pairs(l_Frame_0:GetChildren()) do
                        v492.Parent = v480;
                    end;
                    l_Frame_0.Name = "Destroying...";
                    l_Frame_0:Destroy();
                end);
            end;
        end;
        v476._ignoreClippingChanged:Fire(v477, v478);
    end;
    v15.setDropdown = function(v493, v494) --[[ Line: 1850 ]] --[[ Name: setDropdown ]]
        for _, v496 in pairs(v493.dropdownIcons) do
            v496:leave();
        end;
        if type(v494) == "table" then
            for _, v498 in pairs(v494) do
                v498:join(v493, "dropdown", true);
            end;
        end;
        v493:_updateDropdown();
        return v493;
    end;
    v15._updateDropdown = function(v499) --[[ Line: 1866 ]] --[[ Name: _updateDropdown ]]
        local v500 = {
            maxIconsBeforeScroll = v499:get("dropdownMaxIconsBeforeScroll") or "_NIL", 
            minWidth = v499:get("dropdownMinWidth") or "_NIL", 
            padding = v499:get("dropdownListPadding") or "_NIL", 
            dropdownAlignment = v499:get("dropdownAlignment") or "_NIL", 
            iconAlignment = v499:get("alignment") or "_NIL", 
            scrollBarThickness = v499:get("dropdownScrollBarThickness") or "_NIL"
        };
        for _, v502 in pairs(v500) do
            if v502 == "_NIL" then
                return;
            end;
        end;
        local l_Offset_2 = v500.padding.Offset;
        local l_dropdownContainer_1 = v499.instances.dropdownContainer;
        local l_dropdownFrame_1 = v499.instances.dropdownFrame;
        local _ = v499.instances.dropdownList;
        local v507 = #v499.dropdownIcons;
        local v508 = v500.maxIconsBeforeScroll < v507 and v500.maxIconsBeforeScroll or v507;
        local v509 = -l_Offset_2;
        local v510 = 0;
        local l_minWidth_0 = v500.minWidth;
        table.sort(v499.dropdownIcons, function(v512, v513) --[[ Line: 1887 ]]
            return v512:get("order") < v513:get("order");
        end);
        for v514 = 1, v507 do
            local v515 = v499.dropdownIcons[v514];
            local _, v517 = v515:get("iconSize", nil, "beforeDropdown");
            local v518 = v517.Y.Offset + l_Offset_2;
            if v514 <= v508 then
                v510 = v510 + v518;
            end;
            if v514 == v507 then
                v510 = v510 + v518 / 4;
            end;
            v509 = v509 + v518;
            local l_Offset_3 = v517.X.Offset;
            if l_minWidth_0 < l_Offset_3 then
                l_minWidth_0 = l_Offset_3;
            end;
            local v520 = v514 == 1 and v499 or v499.dropdownIcons[v514 - 1];
            local v521 = v499.dropdownIcons[v514 + 1];
            v515.instances.iconButton.NextSelectionUp = v520 and v520.instances.iconButton;
            v515.instances.iconButton.NextSelectionDown = v521 and v521.instances.iconButton;
        end;
        local v522 = v508 == v507 and 0 or v509;
        v499:set("dropdownCanvasSize", UDim2.new(0, 0, 0, v522));
        v499:set("dropdownSize", UDim2.new(0, (l_minWidth_0 + 4) * 2, 0, v510));
        local v523 = v500.dropdownAlignment:lower();
        local v524 = {
            left = {
                AnchorPoint = Vector2.new(0, 0), 
                PositionXScale = 0, 
                ThicknessMultiplier = 0
            }, 
            mid = {
                AnchorPoint = Vector2.new(0.5, 0), 
                PositionXScale = 0.5, 
                ThicknessMultiplier = 0.5
            }, 
            right = {
                AnchorPoint = Vector2.new(0.5, 0), 
                PositionXScale = 1, 
                FrameAnchorPoint = Vector2.new(0, 0), 
                FramePositionXScale = 0, 
                ThicknessMultiplier = 1
            }
        };
        local v525 = v524[v523] or v524[v500.iconAlignment:lower()];
        l_dropdownContainer_1.AnchorPoint = v525.AnchorPoint;
        l_dropdownContainer_1.Position = UDim2.new(v525.PositionXScale, 0, 1, l_Offset_2 + 0);
        local v526 = v500.scrollBarThickness * v525.ThicknessMultiplier;
        local v527 = l_dropdownFrame_1.VerticalScrollBarPosition == Enum.VerticalScrollBarPosition.Right and v526 or -v526;
        l_dropdownFrame_1.AnchorPoint = v525.FrameAnchorPoint or v525.AnchorPoint;
        l_dropdownFrame_1.Position = UDim2.new(v525.FramePositionXScale or v525.PositionXScale, v527, 0, 0);
        v499._dropdownCanvasPos = Vector2.new(0, 0);
    end;
    v15._dropdownIgnoreClipping = function(v528) --[[ Line: 1949 ]] --[[ Name: _dropdownIgnoreClipping ]]
        v528:_ignoreClipping("dropdown");
    end;
    v15.setMenu = function(v529, v530) --[[ Line: 1955 ]] --[[ Name: setMenu ]]
        for _, v532 in pairs(v529.menuIcons) do
            v532:leave();
        end;
        if type(v530) == "table" then
            for _, v534 in pairs(v530) do
                v534:join(v529, "menu", true);
            end;
        end;
        v529:_updateMenu();
        return v529;
    end;
    v15._getMenuDirection = function(v535) --[[ Line: 1971 ]] --[[ Name: _getMenuDirection ]]
        local v536 = (v535:get("menuDirection") or "_NIL"):lower();
        local v537 = (v535:get("alignment") or "_NIL"):lower();
        if v536 ~= "left" and v536 ~= "right" then
            v536 = v537 == "left" and "right" or "left";
        end;
        return v536;
    end;
    v15._updateMenu = function(v538) --[[ Line: 1980 ]] --[[ Name: _updateMenu ]]
        -- upvalues: v16 (copy)
        local v539 = {
            maxIconsBeforeScroll = v538:get("menuMaxIconsBeforeScroll") or "_NIL", 
            direction = v538:get("menuDirection") or "_NIL", 
            iconAlignment = v538:get("alignment") or "_NIL", 
            scrollBarThickness = v538:get("menuScrollBarThickness") or "_NIL"
        };
        for _, v541 in pairs(v539) do
            if v541 == "_NIL" then
                return;
            end;
        end;
        local v542 = v16[v539.iconAlignment .. "Gap"];
        local l_menuContainer_1 = v538.instances.menuContainer;
        local l_menuFrame_1 = v538.instances.menuFrame;
        local l_menuList_0 = v538.instances.menuList;
        local v546 = #v538.menuIcons;
        local v547 = v538:_getMenuDirection();
        local v548 = v539.maxIconsBeforeScroll < v546 and v539.maxIconsBeforeScroll or v546;
        local v549 = -v542;
        local v550 = 0;
        local v551 = 0;
        local v556 = v547 == "right" and function(v552, v553) --[[ Line: 2000 ]]
            return v552:get("order") < v553:get("order");
        end or function(v554, v555) --[[ Line: 2000 ]]
            return v554:get("order") > v555:get("order");
        end;
        table.sort(v538.menuIcons, v556);
        for v557 = 1, v546 do
            local v558 = v538.menuIcons[v557];
            local v559 = v558:get("iconSize");
            local v560 = v559.X.Offset + v542;
            if v557 <= v548 then
                v550 = v550 + v560;
            end;
            if v557 == v548 and v557 ~= v546 then
                v550 = v550 - 2;
            end;
            v549 = v549 + v560;
            local l_Offset_4 = v559.Y.Offset;
            if v551 < l_Offset_4 then
                v551 = l_Offset_4;
            end;
            local v562 = v538.menuIcons[v557 - 1];
            local v563 = v538.menuIcons[v557 + 1];
            v558.instances.iconButton.NextSelectionRight = v562 and v562.instances.iconButton;
            v558.instances.iconButton.NextSelectionLeft = v563 and v563.instances.iconButton;
        end;
        local v564 = v548 == v546 and 0 or v549 + v542;
        v538:set("menuCanvasSize", UDim2.new(0, v564, 0, 0));
        v538:set("menuSize", UDim2.new(0, v550, 0, v551 + v539.scrollBarThickness + 3));
        local v565 = ({
            left = {
                containerAnchorPoint = Vector2.new(1, 0), 
                containerPosition = UDim2.new(0, -4, 0, 0), 
                canvasPosition = Vector2.new(v564, 0)
            }, 
            right = {
                containerAnchorPoint = Vector2.new(0, 0), 
                containerPosition = UDim2.new(1, v542 - 2, 0, 0), 
                canvasPosition = Vector2.new(0, 0)
            }
        })[v547];
        l_menuContainer_1.AnchorPoint = v565.containerAnchorPoint;
        l_menuContainer_1.Position = v565.containerPosition;
        l_menuFrame_1.CanvasPosition = v565.canvasPosition;
        v538._menuCanvasPos = v565.canvasPosition;
        l_menuList_0.Padding = UDim.new(0, v542);
    end;
    v15._menuIgnoreClipping = function(v566) --[[ Line: 2050 ]] --[[ Name: _menuIgnoreClipping ]]
        v566:_ignoreClipping("menu");
    end;
    v15.destroy = function(v567) --[[ Line: 2057 ]] --[[ Name: destroy ]]
        -- upvalues: v16 (copy)
        if v567._destroyed then
            return;
        else
            v16.iconRemoved:Fire(v567);
            v567:clearNotices();
            if v567._parentIcon then
                v567:leave();
            end;
            v567:setDropdown();
            v567:setMenu();
            v567._destroyed = true;
            v567._maid:clean();
            return;
        end;
    end;
    v15.Destroy = v15.destroy;
    return v15;
end;
