-- rActionButtonStyler by Roth, modified.

local F, C = unpack(select(2, ...))

if not C.actionbars.enableStyle then return end

local r, g, b = unpack(C.class)

local _G = _G
local gsub = gsub

local showHotKey = C.actionbars.hotkey

F.AddOptionsCallback("actionbars", "hotkey", function()
	showHotKey = C.actionbars.hotkey

	for k, frame in pairs(ActionBarButtonEventsFrame.frames) do
		ActionButton_UpdateHotkeys(frame, frame.buttonType)
	end

	for i = 1, NUM_PET_ACTION_SLOTS do
		PetActionButton_SetHotkeys(_G["PetActionButton"..i])
	end
end)

local function updateHotkey(self)
	local ho = _G[self:GetName().."HotKey"]

	if showHotKey then
		if not self.styledHotkey then
			ho:ClearAllPoints()
			ho:SetWidth(0)

			ho:SetPoint("BOTTOM", 1, 0)
			F.SetFS(ho)
			ho:SetJustifyH("RIGHT")
			ho:SetDrawLayer("OVERLAY", 1)
			ho:SetFont(C.media.font, 8, "OUTLINE")
			self.styledHotkey = true
		end

		local text = ho:GetText()

		if text then
			text = text:gsub("(s%-)", "S")
			text = text:gsub("(a%-)", "A")
			text = text:gsub("(c%-)", "C")
			text = text:gsub("Mouse Button", "M")
			text = text:gsub("Middle Mouse", "M3")
			text = text:gsub("Mouse Wheel Up", "MU")
			text = text:gsub("Mouse Wheel Down", "MD")
			text = text:gsub("Delete", "Del")
			text = text:gsub("Num Pad", "N")
			text = text:gsub("Page Up", "PU")
			text = text:gsub("Page Down", "PD")
			text = text:gsub("Spacebar", "SpB")
			text = text:gsub("Insert", "Ins")
			text = text:gsub("Num Lock", "NL")
			text = text:gsub("Home", "Hm")
			text = text:gsub("Left Arrow", "LA")
			text = text:gsub("Right Arrow", "RA")
			text = text:gsub("Down Arrow", "DA")
			text = text:gsub("Up Arrow", "UA")

			ho:SetText("|cffffffff"..text)
		end

		ho:Show()
	else
		ho:Hide()
	end
end

local function applyBackground(bu)
	bu:SetBackdrop({
		edgeFile = C.media.backdrop,
		edgeSize = 1,
	})
	bu:SetBackdropBorderColor(0, 0, 0)

	bu.bg = true
end

local function styleExtraActionButton(bu)
	if not bu or (bu and bu.styled) then return end

	bu.style:SetTexture(nil)

	hooksecurefunc(bu.style, "SetTexture", function(self, texture)
		if texture then
			self:SetTexture(nil)
		end
	end)

	bu:SetNormalTexture("")
	bu:SetPushedTexture("")
	bu:SetHighlightTexture("")
	bu:SetCheckedTexture(C.media.backdrop)

	local ch = bu:GetCheckedTexture()
	ch:SetVertexColor(r, g, b)
	ch:SetDrawLayer("ARTWORK")
	ch:SetAllPoints(bu)

	_G[bu:GetName().."HotKey"]:Hide()

	bu.icon:SetDrawLayer("OVERLAY")
	bu.icon:SetTexCoord(.08, .92, .08, .92)
	bu.icon:SetPoint("TOPLEFT", bu, "TOPLEFT", 1, -1)
	bu.icon:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -1, 1)

	bu.cooldown:SetAllPoints()

	if not bu.bg then applyBackground(bu) end

	bu.styled = true
end

local function styleActionButton(bu)
	if not bu or (bu and bu.styled) then return end

	local name = bu:GetName()
	local ic  = bu.icon
	local co  = _G[name.."Count"]
	local fl  = _G[name.."FloatingBG"]

	_G[name.."Name"]:Hide()
	_G[name.."Border"]:SetTexture("")
	bu.NewActionTexture:SetTexture("")

	F.SetFS(co)
	co:ClearAllPoints()
	co:SetPoint("TOP", 1, -2)
	co:SetDrawLayer("OVERLAY")

	bu:SetNormalTexture("")
	bu:SetPushedTexture("")
	bu:SetHighlightTexture("")
	bu:SetCheckedTexture(C.media.backdrop)

	local ch = bu:GetCheckedTexture()
	ch:SetVertexColor(r, g, b)
	ch:SetDrawLayer("ARTWORK")
	ch:SetAllPoints(bu)

	ic:SetTexCoord(.08, .92, .08, .92)
	ic:SetDrawLayer("OVERLAY")
	ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 1, -1)
	ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -1, 1)

	if fl then
		fl:Hide()
	end

	updateHotkey(bu)
	if not bu.bg then applyBackground(bu) end

	bu.styled = true
end

local function stylePetButton(bu)
	if not bu or (bu and bu.styled) then return end

	local name = bu:GetName()
	local ic  = _G[name.."Icon"]

	_G[name.."NormalTexture2"]:SetAllPoints(bu)
	_G[name.."AutoCastable"]:SetAlpha(0)

	bu:SetNormalTexture("")
	bu:SetCheckedTexture(C.media.checked)
	bu:SetPushedTexture("")

	hooksecurefunc(bu, "SetNormalTexture", function(self, texture)
		if texture and texture ~= "" then
			self:SetNormalTexture("")
		end
	end)

	ic:SetTexCoord(.08, .92, .08, .92)
	ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 1, -1)
	ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -1, 1)
	ic:SetDrawLayer("OVERLAY")

	updateHotkey(bu)
	if not bu.bg then applyBackground(bu) end

	bu.styled = true
end

local function styleStanceButton(bu)
	local ic  = bu.icon

	bu:SetNormalTexture("")
	bu:SetPushedTexture("")
	bu:SetCheckedTexture(C.media.backdrop)

	local ch = bu:GetCheckedTexture()
	ch:SetVertexColor(r/2, g/2, b/2)
	-- ch:SetDrawLayer("ARTWORK")
	ch:SetAllPoints(bu)
	ch:SetPoint("TOPLEFT", bu, 1, -1)
	ch:SetPoint("BOTTOMRIGHT", bu, -1, 1)

	ic:SetTexCoord(.08, .92, .08, .92)
	-- ic:SetDrawLayer("OVERLAY")
	ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 1, -1)
	ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -1, 1)

	applyBackground(bu)
end

local numFlyoutButtons = 0
local function flyoutbutton()
	for i = 1, numFlyoutButtons do
		local bu = _G["SpellFlyoutButton"..i]
		if bu and not bu.styled then
			styleActionButton(bu)

			if bu:GetChecked() then
				bu:SetChecked(nil)
			end
			bu.styled = true
		end
	end
end

SpellFlyout:HookScript("OnShow", flyoutbutton)

local function styleflyout(self)
	if not self.reskinned then
		if not self.FlyoutArrow then return end
		self.FlyoutBorder:SetAlpha(0)
		self.FlyoutBorderShadow:SetAlpha(0)

		SpellFlyoutHorizontalBackground:SetAlpha(0)
		SpellFlyoutVerticalBackground:SetAlpha(0)
		SpellFlyoutBackgroundEnd:SetAlpha(0)

		self.reskinned = true
	end

	for i=1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			numFlyoutButtons = numSlots
			break
		end
	end
end

local function init()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		styleActionButton(_G["ActionButton"..i])
		styleActionButton(_G["VehicleMenuBarActionButton"..i])
		styleActionButton(_G["BonusActionButton"..i])
		styleActionButton(_G["MultiBarBottomLeftButton"..i])
		styleActionButton(_G["MultiBarBottomRightButton"..i])
		styleActionButton(_G["MultiBarRightButton"..i])
		styleActionButton(_G["MultiBarLeftButton"..i])
	end

	for i = 1, 6 do
		styleActionButton(OverrideActionBar["SpellButton"..i])
	end

	applyBackground(OverrideActionBarLeaveFrameLeaveButton)
	OverrideActionBarLeaveFrameLeaveButton:SetHighlightTexture("")
	local nt = OverrideActionBarLeaveFrameLeaveButton:GetNormalTexture()
	nt:SetPoint("TOPLEFT", 1, -1)
	nt:SetPoint("BOTTOMRIGHT", -1, 1)
	nt:SetTexCoord(0.0959375, 0.1579688, 0.369375, 0.4314063)

	for i = 1, NUM_PET_ACTION_SLOTS do
		stylePetButton(_G["PetActionButton"..i])
	end

	for i = 1, NUM_STANCE_SLOTS do
		styleStanceButton(_G["StanceButton"..i])
	end
	for i = 1, NUM_POSSESS_SLOTS do
		styleStanceButton(_G["PossessButton"..i])
	end

	styleExtraActionButton(ExtraActionButton1)

	hooksecurefunc("ActionButton_UpdateHotkeys", updateHotkey)
	hooksecurefunc("PetActionButton_SetHotkeys", updateHotkey)
	hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", init)
