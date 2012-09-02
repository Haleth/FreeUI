local F, C, L = unpack(select(2, ...))

local r, g, b = unpack(C.class)

local last = 0
local damageMeter = false

F.menuShown = false

local function onMouseUp(self)
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnMouseUp", nil)
	if F.menuShown then
		ToggleFrame(DropDownList1)
		F.menuShown = false
		return
	end
	
	if damageMeter then
		if damageMeter == "alDamageMeter" then
			if alDamageMeterFrame:IsShown() then
				alDamageMeterFrame:Hide()
			else
				alDamageMeterFrame:Show()
			end
		elseif damageMeter == "Skada" then
			local skadaWindows = Skada:GetWindows()
			if #skadaWindows >= 1 then
				skadaShown = skadaWindows[1]:IsShown()
				for _, window in ipairs(skadaWindows) do
					if skadaShown then
						window:Hide()
					else
						window:Show()
					end
				end
			end
		elseif damageMeter == "Recount" then
			if Recount_MainWindow:IsShown() then
				Recount_MainWindow:Hide()
			else
				Recount_MainWindow:Show()
			end
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDamage Meter not found!|r", unpack(C.class))
	end
end

local f = CreateFrame("Frame")
f:SetBackdrop({
	bgFile = C.media.backdrop,
	edgeFile = C.media.glow,
	edgeSize = 3,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
f:SetBackdropColor(1, 0, 0)
f:SetBackdropBorderColor(1, 0, 0)
f:SetAlpha(0)
f:SetSize(8, 8)
f:SetPoint("BOTTOMRIGHT")
f:EnableMouse(true)
f:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		f:HookScript("OnUpdate", function(self, elapsed)
			last = last + elapsed
			if last > .5 then
				self:SetScript("OnUpdate", nil)
				self:SetScript("OnMouseUp", nil)
				last = 0
				if F.menuShown then
					ToggleFrame(DropDownList1)
					F.menuShown = false
				else
					F.MicroMenu()
					F.menuShown = true
				end
			end
		end)
		self:SetScript("OnMouseUp", onMouseUp)
	elseif button == "RightButton" then
		if F.menuShown then
			ToggleFrame(DropDownList1)
			F.menuShown = false
			return
		end
		if IsAddOnLoaded("DBM-Core") then
			DisableAddOn("DBM-Core")
			DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDBM disabled. Type|r /rl |cfffffffffor the changes to apply.|r", unpack(C.class))
		else
			EnableAddOn("DBM-Core")
			LoadAddOn("DBM-Core")
			if IsAddOnLoaded("DBM-Core") then
				DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDBM loaded.|r", unpack(C.class))
			else
				DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDBM not found!|r", unpack(C.class))
			end
		end
	end
end)

f:SetScript("OnEnter", function()
	f:SetAlpha(1)
	F.CreatePulse(f)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(f, "ANCHOR_NONE")
		GameTooltip:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -14, 14)
		GameTooltip:AddLine("FreeUI", unpack(C.class))
		GameTooltip:AddLine(" ")
		if damageMeter then
			GameTooltip:AddDoubleLine("Left-click:", "Toggle " .. damageMeter, r, g, b, 1, 1, 1)
		end
		GameTooltip:AddDoubleLine("Right-click:", "Toggle DBM", r, g, b, 1, 1, 1)
		GameTooltip:AddDoubleLine("Click and hold:", "Toggle micro menu", r, g, b, 1, 1, 1)
		GameTooltip:Show()
	end
end)

f:SetScript("OnLeave", function()
	f:SetScript("OnUpdate", nil)
	f:SetAlpha(0)
	GameTooltip:Hide()
end)

f:SetScript("OnEvent", function(event, arg1)
		if event == "ADDON_LOADED" then
			if arg1 == "alDamageMeter" then -- not tested
				damageMeter = "alDamageMeter"
			elseif arg1 == "Skada" then -- tested
				damageMeter = "Skada"
			elseif arg1 == "Recount" then-- not tested
				damageMeter = "Recount"
			end
			if damageMeter then
				f:UnregisterEvent("ADDON_LOADED")
			end
		end
end)
f:RegisterEvent("ADDON_LOADED")

local g = CreateFrame("Frame")
g:SetBackdrop({
	bgFile = C.media.backdrop,
	edgeFile = C.media.glow,
	edgeSize = 3,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
g:SetBackdropColor(.4, .6, 1)
g:SetBackdropBorderColor(.4, .6, 1)
g:SetAlpha(0)
g:SetSize(8, 8)
g:SetPoint("BOTTOMLEFT")
g:EnableMouse(true)
g:SetScript("OnMouseDown", function(self, button)
		ToggleFrame(ChatMenu)
end)

g:SetScript("OnEnter", function()
	g:SetAlpha(1)
	F.CreatePulse(g)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(g, "ANCHOR_NONE")
		GameTooltip:SetPoint("BOTTOMLEFT", g, "BOTTOMLEFT", 14, 14)
		GameTooltip:AddLine("FreeUI", unpack(C.class))
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Click to toggle chat menu", 1, 1, 1)
		GameTooltip:Show()
	end
end)

g:SetScript("OnLeave", function()
	g:SetScript("OnUpdate", nil)
	g:SetAlpha(0)
	GameTooltip:Hide()
end)