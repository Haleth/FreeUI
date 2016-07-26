local F, C = unpack(select(2, ...))

-- [[ Constants ]]

C.media = {
	["arrowUp"] = "Interface\\AddOns\\FreeUI\\media\\arrow-up-active",
	["arrowDown"] = "Interface\\AddOns\\FreeUI\\media\\arrow-down-active",
	["arrowLeft"] = "Interface\\AddOns\\FreeUI\\media\\arrow-left-active",
	["arrowRight"] = "Interface\\AddOns\\FreeUI\\media\\arrow-right-active",
	["backdrop"] = "Interface\\AddOns\\FreeUI\\media\\blank", 					-- default backdrop
	["checked"] = "Interface\\AddOns\\FreeUI\\media\\CheckButtonHilight", 		-- replace default checked texture
	["font"] = "Interface\\AddOns\\FreeUI\\media\\pixel.ttf", 					-- default pixel font
	["font2"] = "Fonts\\FRIZQT__.ttf", 					-- default font
	["glow"] = "Interface\\AddOns\\FreeUI\\media\\glowTex", 					-- glow/shadow texture
	["gradient"] = "Interface\\AddOns\\FreeUI\\media\\gradient",
	["roleIcons"] = "Interface\\Addons\\FreeUI\\media\\UI-LFG-ICON-ROLES",
	["texture"] = "Interface\\AddOns\\FreeUI\\media\\Texture1", 				-- statusbar texture
}

local mainFont

if C.appearance.fontUseAlternativeFont then
	mainFont = C.media.font2
elseif GetLocale() == "zhCN" then
	mainFont = "Fonts\\ARKai_T.TTF"
else
	mainFont = C.media.font
end

F.AddOptionsCallback("appearance", "fontUseAlternativeFont", function()
	if C.appearance.fontUseAlternativeFont then
		mainFont = C.media.font2
	elseif GetLocale() == "zhCN" then
		mainFont = "Fonts\\ARKai_T.TTF"
	else
		mainFont = C.media.font
	end
end)

C.classcolours = {
	["DEATHKNIGHT"] = {r = 187/255, g = 0, b = 42/255},
	["DEMONHUNTER"] = {r = 0.64, g = 0.19, b = 0.79},
	["DRUID"] = {r = 0.94, g = 0.39, b = 0.1},
	["HUNTER"] = {r = 126/255, g = 185/255, b = 18/255},
	["MAGE"] = {r = 0.35, g = 0.76, b = 0.93},
	["MONK"] = {r = 0.04, g = 0.85 , b = 0.53},
	["PALADIN"] = {r = 241/255, g = 0, b = 168/255},
	["PRIEST"] = {r = 219/255, g = 243/255, b = 1},
	["ROGUE"] = {r = 1, g = 238/255, b = 0},
	["SHAMAN"] = {r = 0.07, g = 0.42, b = 0.96},
	["WARLOCK"] = {r = 136/255, g = 73/255, b = 223/255},
	["WARRIOR"] = {r = 0.79, g = 0.61, b = 0.5},
}

FACTION_BAR_COLORS = {
	[1] = {r = 0.63, g = 0, b = 0},
	[2] = {r = 0.63, g = 0, b = 0},
	[3] = {r = 0.63, g = 0, b = 0},
	[4] = {r = 0.82, g = 0.67, b = 0},
	[5] = {r = 0.32, g = 0.67, b = 0},
	[6] = {r = 0.32, g = 0.67, b = 0},
	[7] = {r = 0.32, g = 0.67, b = 0},
	[8] = {r = 0, g = 0.75, b = 0.44},
};

local _, class = UnitClass("player")
if C.appearance.colourScheme == 2 then
	C.class = {C.appearance.customColour.r, C.appearance.customColour.g, C.appearance.customColour.b}
else
	C.class = {C.classcolours[class].r, C.classcolours[class].g, C.classcolours[class].b}
end

C.r, C.g, C.b = unpack(C.class)

C.reactioncolours = {
	[1] = {1, .12, .24},
	[2] = {1, .12, .24},
	[3] = {1, .12, .24},
	[4] = {1, 1, 0.3},
	[5] = {0.26, 1, 0.22},
	[6] = {0.26, 1, 0.22},
	[7] = {0.26, 1, 0.22},
	[8] = {0.26, 1, 0.22},
}

C.myClass = class
C.myName = UnitName("player")
C.myRealm = GetRealmName()

C.FONT_SIZE_NORMAL = 1
C.FONT_SIZE_LARGE = 2

-- [[ Functions ]]

F.dummy = function() end

-- compatibility with Aurora plugins that are compatible with Aurora's custom style system
F.AddPlugin = function(func)
	func()
end

local CreateBD = function(f, a)
	f:SetBackdrop({
		bgFile = C.media.backdrop,
		edgeFile = C.media.backdrop,
		edgeSize = 1,
	})
	f:SetBackdropColor(.06, .06, .06, a or .9)
	f:SetBackdropBorderColor(0, 0, 0)

	if not a then
        f.tex = f.tex or f:CreateTexture(nil, "BACKGROUND", nil, 1)
        f.tex:SetTexture([[Interface\AddOns\FreeUI\media\StripesThin]], true, true)
        f.tex:SetAlpha(.5)
        f.tex:SetAllPoints()
        f.tex:SetHorizTile(true)
        f.tex:SetVertTile(true)
        f.tex:SetBlendMode("ADD")
    else
        f:SetBackdropColor(0, 0, 0, a)
    end
end

F.CreateBD = CreateBD

F.CreateBG = function(frame)
	local f = frame
	if frame:GetObjectType() == "Texture" then f = frame:GetParent() end

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetPoint("TOPLEFT", frame, -1, 1)
	bg:SetPoint("BOTTOMRIGHT", frame, 1, -1)
	bg:SetTexture(C.media.backdrop)
	bg:SetVertexColor(0, 0, 0)

	return bg
end

F.CreateSD = function(parent, size, r, g, b, alpha, offset)
	local sd = CreateFrame("Frame", nil, parent)
	sd.size = size or 4
	sd.offset = offset or -1
	sd:SetBackdrop({
		edgeFile = C.media.glow,
		edgeSize = sd.size,
	})
	sd:SetPoint("TOPLEFT", parent, -sd.size - 0 - sd.offset, sd.size + 0 + sd.offset)
	sd:SetPoint("BOTTOMRIGHT", parent, sd.size + 0 + sd.offset, -sd.size - 0 - sd.offset)
	sd:SetBackdropBorderColor(r or .03, g or .03, b or .03)
	sd:SetAlpha(alpha or .6)
end

F.CreateFS = function(parent, fontSize, justify)
    local f = parent:CreateFontString(nil, "OVERLAY")
    F.SetFS(f, fontSize)

    if justify then f:SetJustifyH(justify) end

    return f
end

F.SetFS = function(fontObject, fontSize)
	local size

	if(not fontSize or fontSize == C.FONT_SIZE_NORMAL) then
		if GetLocale() == "zhCN" then
			size = 12
		else
			size = C.appearance.fontSizeNormal
		end
	elseif fontSize == C.FONT_SIZE_LARGE then
		size = C.appearance.fontSizeLarge
	elseif fontSize > 4 then -- actual size
		size = fontSize
	end

	local outline = nil
	if C.appearance.fontOutline then
		if GetLocale() == "zhCN" then
			outline = "OUTLINE"
		else
			outline = C.appearance.fontOutlineStyle == 2 and "OUTLINEMONOCHROME" or "OUTLINE"
		end
	end

	fontObject:SetFont(mainFont, size, outline)

	if C.appearance.fontShadow then
		fontObject:SetShadowColor(0, 0, 0)
		fontObject:SetShadowOffset(1, -1)
	else
		fontObject:SetShadowOffset(0, 0)
	end
end

F.CreatePulse = function(frame) -- pulse function originally by nightcracker
	local speed = .05
	local mult = 1
	local alpha = 1
	local last = 0
	frame:SetScript("OnUpdate", function(self, elapsed)
		last = last + elapsed
		if last > speed then
			last = 0
			self:SetAlpha(alpha)
		end
		alpha = alpha - elapsed*mult
		if alpha < 0 and mult > 0 then
			mult = mult*-1
			alpha = 0
		elseif alpha > 1 and mult < 0 then
			mult = mult*-1
		end
	end)
end

local r, g, b = unpack(C.class)
local buttonR, buttonG, buttonB, buttonA = .06, .06, .06, .8

local CreateGradient = function(f)
	local tex = f:CreateTexture(nil, "BORDER")
	tex:SetPoint("TOPLEFT", 1, -1)
	tex:SetPoint("BOTTOMRIGHT", -1, 1)
	tex:SetTexture(C.media.backdrop)
--	tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)
	tex:SetVertexColor(buttonR, buttonG, buttonB, buttonA)

	return tex
end

F.CreateGradient = CreateGradient

local function StartGlow(f)
	if not f:IsEnabled() then return end
	f:SetBackdropColor(r, g, b, .1)
	f:SetBackdropBorderColor(r, g, b)
	f.glow:SetAlpha(1)
	F.CreatePulse(f.glow)
end

local function StopGlow(f)
	f:SetBackdropColor(0, 0, 0, 0)
	f:SetBackdropBorderColor(0, 0, 0)
	f.glow:SetScript("OnUpdate", nil)
	f.glow:SetAlpha(0)
end

F.Reskin = function(f, noGlow)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")

	if f.Left then f.Left:SetAlpha(0) end
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end
	if f.LeftSeparator then f.LeftSeparator:Hide() end
	if f.RightSeparator then f.RightSeparator:Hide() end

	F.CreateBD(f, 0)

	CreateGradient(f)

	if not noGlow then
		f.glow = CreateFrame("Frame", nil, f)
		f.glow:SetBackdrop({
			edgeFile = C.media.glow,
			edgeSize = 5,
		})
		f.glow:SetPoint("TOPLEFT", -6, 6)
		f.glow:SetPoint("BOTTOMRIGHT", 6, -6)
		f.glow:SetBackdropBorderColor(r, g, b)
		f.glow:SetAlpha(0)

		f:HookScript("OnEnter", StartGlow)
 		f:HookScript("OnLeave", StopGlow)
	end
end

F.ReskinTab = function(f)
	f:DisableDrawLayer("BACKGROUND")

	local bg = CreateFrame("Frame", nil, f)
	bg:SetPoint("TOPLEFT", 8, -3)
	bg:SetPoint("BOTTOMRIGHT", -8, 0)
	bg:SetFrameLevel(f:GetFrameLevel()-1)
	F.CreateBD(bg)

	f:SetHighlightTexture(C.media.texture)
	local hl = f:GetHighlightTexture()
	hl:SetPoint("TOPLEFT", 9, -4)
	hl:SetPoint("BOTTOMRIGHT", -9, 1)
	hl:SetVertexColor(r, g, b, .25)
end

local function colourScroll(f)
	if f:IsEnabled() then
		f.tex:SetVertexColor(r, g, b)
	end
end

local function clearScroll(f)
	f.tex:SetVertexColor(1, 1, 1)
end

F.ReskinScroll = function(f, parent)
	local frame = f:GetName()

	if frame then
		if _G[frame.."Track"] then _G[frame.."Track"]:Hide() end
		if _G[frame.."BG"] then _G[frame.."BG"]:Hide() end
		if _G[frame.."Top"] then _G[frame.."Top"]:Hide() end
		if _G[frame.."Middle"] then _G[frame.."Middle"]:Hide() end
		if _G[frame.."Bottom"] then _G[frame.."Bottom"]:Hide() end
	else
		if f.trackBG then f.trackBG:Hide() end
		if f.Background then f.Background:Hide() end
		if f.Top then f.Top:Hide() end
		if f.Middle then f.Middle:Hide() end
		if f.Bottom then f.Bottom:Hide() end
		if f.ScrollBarTop then f.ScrollBarTop:Hide() end
		if f.ScrollBarMiddle then f.ScrollBarMiddle:Hide() end
		if f.ScrollBarBottom then f.ScrollBarBottom:Hide() end
	end

	local bu = f.ThumbTexture or f.thumbTexture or _G[frame.."ThumbTexture"]
	bu:SetAlpha(0)
	bu:SetWidth(17)

	bu.bg = CreateFrame("Frame", nil, f)
	bu.bg:SetPoint("TOPLEFT", bu, 0, -2)
	bu.bg:SetPoint("BOTTOMRIGHT", bu, 0, 4)
	F.CreateBD(bu.bg, 0)

	local tex = CreateGradient(f)
	tex:SetPoint("TOPLEFT", bu.bg, 1, -1)
	tex:SetPoint("BOTTOMRIGHT", bu.bg, -1, 1)

	local up = f.ScrollUpButton or f.UpButton or _G[(frame or parent).."ScrollUpButton"]
 	local down = f.ScrollDownButton or f.DownButton or _G[(frame or parent).."ScrollDownButton"]

	up:SetWidth(17)
	down:SetWidth(17)

	F.Reskin(up, true)
	F.Reskin(down, true)

	up:SetDisabledTexture(C.media.backdrop)
	local dis1 = up:GetDisabledTexture()
	dis1:SetVertexColor(0, 0, 0, .4)
	dis1:SetDrawLayer("OVERLAY")

	down:SetDisabledTexture(C.media.backdrop)
	local dis2 = down:GetDisabledTexture()
	dis2:SetVertexColor(0, 0, 0, .4)
	dis2:SetDrawLayer("OVERLAY")

	local uptex = up:CreateTexture(nil, "ARTWORK")
	uptex:SetTexture(C.media.arrowUp)
	uptex:SetSize(8, 8)
	uptex:SetPoint("CENTER")
	uptex:SetVertexColor(1, 1, 1)
	up.tex = uptex

	local downtex = down:CreateTexture(nil, "ARTWORK")
	downtex:SetTexture(C.media.arrowDown)
	downtex:SetSize(8, 8)
	downtex:SetPoint("CENTER")
	downtex:SetVertexColor(1, 1, 1)
	down.tex = downtex

	up:HookScript("OnEnter", colourScroll)
	up:HookScript("OnLeave", clearScroll)
	down:HookScript("OnEnter", colourScroll)
	down:HookScript("OnLeave", clearScroll)
end

local function colourArrow(f)
	if f:IsEnabled() then
		f.tex:SetVertexColor(r, g, b)
	end
end

local function clearArrow(f)
	f.tex:SetVertexColor(1, 1, 1)
end

F.colourArrow = colourArrow
F.clearArrow = clearArrow

F.ReskinDropDown = function(f)
	local frame = f:GetName()

	local left = _G[frame.."Left"]
	local middle = _G[frame.."Middle"]
	local right = _G[frame.."Right"]

	if left then left:SetAlpha(0) end
	if middle then middle:SetAlpha(0) end
	if right then right:SetAlpha(0) end

	local bg = CreateFrame("Frame", nil, f)
 	bg:SetPoint("TOPLEFT", 10, -4)
 	bg:SetPoint("BOTTOMRIGHT", -12, 8)
 	bg:SetFrameLevel(f:GetFrameLevel()-1)
 	F.CreateBD(bg, 0)
  
 	local gradient = F.CreateGradient(f)
 	gradient:SetPoint("TOPLEFT", bg, 1, -1)
 	gradient:SetPoint("BOTTOMRIGHT", bg, -1, 1)
 
 	local down = _G[frame.."Button"]

	down:SetSize(20, 20)
	down:ClearAllPoints()
	down:SetPoint("TOPRIGHT", bg)

	F.Reskin(down, true)

	down:SetDisabledTexture(C.media.backdrop)
	local dis = down:GetDisabledTexture()
	dis:SetVertexColor(0, 0, 0, .4)
	dis:SetDrawLayer("OVERLAY")
	dis:SetAllPoints()

	local tex = down:CreateTexture(nil, "ARTWORK")
	tex:SetTexture(C.media.arrowDown)
	tex:SetSize(8, 8)
	tex:SetPoint("CENTER")
	tex:SetVertexColor(1, 1, 1)
	down.tex = tex

	down:HookScript("OnEnter", colourArrow)
	down:HookScript("OnLeave", clearArrow)

end

local function colourClose(f)
	if f:IsEnabled() then
		for _, pixel in pairs(f.pixels) do
			pixel:SetVertexColor(r, g, b)
		end
	end
end

local function clearClose(f)
	for _, pixel in pairs(f.pixels) do
		pixel:SetVertexColor(1, 1, 1)
	end
end

F.ReskinClose = function(f, a1, p, a2, x, y)
	f:SetSize(17, 17)

	if a1 then
		f:ClearAllPoints()
		f:SetPoint(a1, p, a2, x, y)
	else
		f:SetPoint("TOPRIGHT", -4, -4)
	end

	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")

	F.CreateBD(f, 0)

	CreateGradient(f)

	f:SetDisabledTexture(C.media.backdrop)
	local dis = f:GetDisabledTexture()
	dis:SetVertexColor(0, 0, 0, .4)
	dis:SetDrawLayer("OVERLAY")
	dis:SetAllPoints()

	f.pixels = {}

	for i = 1, 9 do
		local tex = f:CreateTexture()
		tex:SetColorTexture(1, 1, 1)
		tex:SetSize(1, 1)
		tex:SetPoint("BOTTOMLEFT", 3+i, 3+i)
		tinsert(f.pixels, tex)
	end

	for i = 1, 9 do
		local tex = f:CreateTexture()
		tex:SetColorTexture(1, 1, 1)
		tex:SetSize(1, 1)
		tex:SetPoint("TOPLEFT", 3+i, -3-i)
		tinsert(f.pixels, tex)
	end

	f:HookScript("OnEnter", colourClose)
 	f:HookScript("OnLeave", clearClose)
end

F.ReskinInput = function(f, height, width)
	local frame = f:GetName()

	local left = f.Left or _G[frame.."Left"]
	local middle = f.Middle or _G[frame.."Middle"] or _G[frame.."Mid"]
	local right = f.Right or _G[frame.."Right"]

	left:Hide()
	middle:Hide()
	right:Hide()

	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", -2, 0)
	bd:SetPoint("BOTTOMRIGHT")
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	F.CreateBD(bd, 0)

	local gradient = CreateGradient(f)
	gradient:SetPoint("TOPLEFT", bd, 1, -1)
	gradient:SetPoint("BOTTOMRIGHT", bd, -1, 1)

	if height then f:SetHeight(height) end
	if width then f:SetWidth(width) end
end

F.ReskinArrow = function(f, direction)
	f:SetSize(18, 18)
	F.Reskin(f, true)

	f:SetDisabledTexture(C.media.backdrop)
	local dis = f:GetDisabledTexture()
	dis:SetVertexColor(0, 0, 0, .3)
	dis:SetDrawLayer("OVERLAY")

	local tex = f:CreateTexture(nil, "ARTWORK")
	tex:SetTexture("Interface\\AddOns\\FreeUI\\media\\arrow-"..direction.."-active")
	tex:SetSize(8, 8)
	tex:SetPoint("CENTER")
	f.tex = tex

	f:HookScript("OnEnter", colourArrow)
	f:HookScript("OnLeave", clearArrow)
end

F.ReskinCheck = function(f)
	f:SetNormalTexture("")
	f:SetPushedTexture("")
	f:SetHighlightTexture(C.media.texture)
	local hl = f:GetHighlightTexture()
	hl:SetPoint("TOPLEFT", 5, -5)
	hl:SetPoint("BOTTOMRIGHT", -5, 5)
	hl:SetVertexColor(r, g, b, .2)

	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", 4, -4)
	bd:SetPoint("BOTTOMRIGHT", -4, 4)
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	F.CreateBD(bd, 0)

	local tex = CreateGradient(f)
	tex:SetPoint("TOPLEFT", 5, -5)
	tex:SetPoint("BOTTOMRIGHT", -5, 5)

	local ch = f:GetCheckedTexture()
	ch:SetDesaturated(true)
	ch:SetVertexColor(r, g, b)
end

local function colourRadio(f)
	f.bd:SetBackdropBorderColor(r, g, b)
end

local function clearRadio(f)
	f.bd:SetBackdropBorderColor(0, 0, 0)
end

F.ReskinRadio = function(f)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetCheckedTexture(C.media.texture)

	local ch = f:GetCheckedTexture()
	ch:SetPoint("TOPLEFT", 4, -4)
	ch:SetPoint("BOTTOMRIGHT", -4, 4)
	ch:SetVertexColor(r, g, b, .6)

	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", 3, -3)
	bd:SetPoint("BOTTOMRIGHT", -3, 3)
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	F.CreateBD(bd, 0)
	f.bd = bd

	local tex = F.CreateGradient(f)
	tex:SetPoint("TOPLEFT", 4, -4)
	tex:SetPoint("BOTTOMRIGHT", -4, 4)

	f:HookScript("OnEnter", colourRadio)
	f:HookScript("OnLeave", clearRadio)
end

F.ReskinSlider = function(f)
	f:SetBackdrop(nil)
	f.SetBackdrop = F.dummy

	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", 14, -2)
	bd:SetPoint("BOTTOMRIGHT", -15, 3)
	bd:SetFrameStrata("BACKGROUND")
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	F.CreateBD(bd, 0)

	CreateGradient(bd)

	local slider = select(4, f:GetRegions())
	slider:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	slider:SetBlendMode("ADD")
end

local function colourExpandOrCollapse(f)
	if f:IsEnabled() then
		f.plus:SetVertexColor(r, g, b)
		f.minus:SetVertexColor(r, g, b)
	end
end

local function clearExpandOrCollapse(f)
	f.plus:SetVertexColor(1, 1, 1)
	f.minus:SetVertexColor(1, 1, 1)
end

F.colourExpandOrCollapse = colourExpandOrCollapse
F.clearExpandOrCollapse = clearExpandOrCollapse

F.ReskinExpandOrCollapse = function(f)
	f:SetSize(13, 13)

	F.Reskin(f, true)
	f.SetNormalTexture = F.dummy

	f.minus = f:CreateTexture(nil, "OVERLAY")
	f.minus:SetSize(7, 1)
	f.minus:SetPoint("CENTER")
	f.minus:SetTexture(C.media.backdrop)
	f.minus:SetVertexColor(1, 1, 1)

	f.plus = f:CreateTexture(nil, "OVERLAY")
	f.plus:SetSize(1, 7)
	f.plus:SetPoint("CENTER")
	f.plus:SetTexture(C.media.backdrop)
	f.plus:SetVertexColor(1, 1, 1)

	f:HookScript("OnEnter", colourExpandOrCollapse)
	f:HookScript("OnLeave", clearExpandOrCollapse)
end

F.SetBD = function(f, x, y, x2, y2)
	local bg = CreateFrame("Frame", nil, f)
	if not x then
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
	else
		bg:SetPoint("TOPLEFT", x, y)
		bg:SetPoint("BOTTOMRIGHT", x2, y2)
	end
	bg:SetFrameLevel(f:GetFrameLevel()-1)
	F.CreateBD(bg)
	F.CreateSD(bg)
end

F.ReskinPortraitFrame = function(f, isButtonFrame)
	local name = f:GetName()

	f.Bg:Hide()
	_G[name.."TitleBg"]:Hide()
	f.portrait:Hide()
	f.portraitFrame:Hide()
	_G[name.."TopRightCorner"]:Hide()
	f.topLeftCorner:Hide()
	f.topBorderBar:Hide()
	f.TopTileStreaks:SetTexture("")
	_G[name.."BotLeftCorner"]:Hide()
	_G[name.."BotRightCorner"]:Hide()
	_G[name.."BottomBorder"]:Hide()
	f.leftBorderBar:Hide()
	_G[name.."RightBorder"]:Hide()

	F.ReskinClose(f.CloseButton)
	f.portrait.Show = F.dummy

	if isButtonFrame then
		_G[name.."BtnCornerLeft"]:SetTexture("")
		_G[name.."BtnCornerRight"]:SetTexture("")
		_G[name.."ButtonBottomBorder"]:SetTexture("")

		f.Inset.Bg:Hide()
		f.Inset:DisableDrawLayer("BORDER")
	end

	F.CreateBD(f)
	F.CreateSD(f)
end

F.CreateBDFrame = function(f, a)
	local frame
	if f:GetObjectType() == "Texture" then
		frame = f:GetParent()
	else
		frame = f
	end

	local lvl = frame:GetFrameLevel()

	local bg = CreateFrame("Frame", nil, frame)
	bg:SetPoint("TOPLEFT", f, -1, 1)
	bg:SetPoint("BOTTOMRIGHT", f, 1, -1)
	bg:SetFrameLevel(lvl == 0 and 1 or lvl - 1)

	CreateBD(bg, a or .5)

	return bg
end

F.ReskinColourSwatch = function(f)
	local name = f:GetName()

	local bg = _G[name.."SwatchBg"]

	f:SetNormalTexture(C.media.backdrop)
	local nt = f:GetNormalTexture()

	nt:SetPoint("TOPLEFT", 3, -3)
	nt:SetPoint("BOTTOMRIGHT", -3, 3)

	bg:SetColorTexture(0, 0, 0)
	bg:SetPoint("TOPLEFT", 2, -2)
	bg:SetPoint("BOTTOMRIGHT", -2, 2)
end

F.ReskinFilterButton = function(f)
	f.TopLeft:Hide()
	f.TopRight:Hide()
	f.BottomLeft:Hide()
	f.BottomRight:Hide()
	f.TopMiddle:Hide()
	f.MiddleLeft:Hide()
	f.MiddleRight:Hide()
	f.BottomMiddle:Hide()
	f.MiddleMiddle:Hide()

	F.Reskin(f)
	f.Icon:SetTexture(C.media.arrowRight)

	f.Text:SetPoint("CENTER")
	f.Icon:SetPoint("RIGHT", f, "RIGHT", -5, 0)
	f.Icon:SetSize(8, 8)
end

F.ReskinNavBar = function(f)
	local overflowButton = f.overflowButton

	f:GetRegions():Hide()
	f:DisableDrawLayer("BORDER")
	f.overlay:Hide()
	f.homeButton:GetRegions():Hide()

	F.Reskin(f.homeButton)
	F.Reskin(overflowButton, true)

	local tex = overflowButton:CreateTexture(nil, "ARTWORK")
	tex:SetTexture(C.media.arrowLeft)
	tex:SetSize(8, 8)
	tex:SetPoint("CENTER")
	overflowButton.tex = tex

	overflowButton:HookScript("OnEnter", colourArrow)
	overflowButton:HookScript("OnLeave", clearArrow)
end

F.ReskinGarrisonPortrait = function(portrait)
	local level = portrait.Level
	local cover = portrait.PortraitRingCover

	portrait.PortraitRing:Hide()
	portrait.PortraitRingQuality:SetTexture("")

	portrait.LevelBorder:SetColorTexture(0, 0, 0, .5)
	portrait.LevelBorder:SetSize(44, 11)
	portrait.LevelBorder:ClearAllPoints()
	portrait.LevelBorder:SetPoint("BOTTOM", 0, 12)

	level:ClearAllPoints()
	level:SetPoint("BOTTOM", portrait, 0, 12)

	local squareBG = CreateFrame("Frame", nil, portrait)
	squareBG:SetFrameLevel(portrait:GetFrameLevel()-1)
	squareBG:SetPoint("TOPLEFT", 3, -3)
	squareBG:SetPoint("BOTTOMRIGHT", -3, 11)
	F.CreateBD(squareBG, 1)
	portrait.squareBG = squareBG

	if cover then
		cover:SetColorTexture(0, 0, 0)
		cover:SetAllPoints(squareBG)
	end
end

F.ReskinIcon = function(icon)
	icon:SetTexCoord(.08, .92, .08, .92)
	return F.CreateBG(icon)
end



DEFAULT_CHAT_FRAME:AddMessage("FreeUI.Fluffy |cffffffff"..GetAddOnMetadata("FreeUI", "Version"), unpack(C.class))
DEFAULT_CHAT_FRAME:AddMessage("|cfffffffftype|r /freeui |cffffffffto open options GUI|r", unpack(C.class))
DEFAULT_CHAT_FRAME:AddMessage("|cffffffffFor more info visit|r https://github.com/solor/FreeUI.Fluffy|r", unpack(C.class))
