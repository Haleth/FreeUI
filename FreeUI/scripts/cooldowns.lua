-- 'Basic' version of OmniCC

local F, C, L = unpack(select(2, ...))

local format, floor, GetTime = string.format, math.floor, GetTime

local function GetFormattedTime(s)
	if s>3600 then
		return format("%dh", floor(s/3600 + 0.5)), s % 3600
	elseif s>60 then
		return format("%dm", floor(s/60 + 0.5)), s % 60
	end
	return floor(s + 0.5), s - floor(s)
end

local function Timer_OnUpdate(self, elapsed)
	if self.text:IsShown() then
		if self.nextUpdate>0 then
			self.nextUpdate = self.nextUpdate - elapsed
		else
			local remain = self.duration - (GetTime() - self.start)
			if floor(remain + 0.5) > 0 then
				local time, nextUpdate = GetFormattedTime(remain)
				self.text:SetText(time)
				self.nextUpdate = nextUpdate
			else
				self.text:Hide()
			end
		end
	end
end

local methods = getmetatable(ActionButton1Cooldown).__index
hooksecurefunc(methods, "SetCooldown", function(self, start, duration, fontSize, charges)
	if not duration then
		duration = 0
	end

	if start > 0 and duration > 2.5 then
		if self.noshowcd or (charges and charges ~= 0) then return end

		self.start = start
		self.duration = duration
		self.nextUpdate = 0
		
		local fontSize = fontSize
		local text = self.text

		if not fontSize then
			fontSize = C.appearance.fontSizeNormal
		end

		if not text then
			text = F.CreateFS(self, fontSize, "CENTER")

			if C.actionbars.smallFont and C.actionbars.fontUseAlternativeFont == true and fontSize > 8 then
				text:SetPoint("CENTER", 0, 0)
				text:SetFont(C.media.font2, fontSize, "OUTLINE")
			else
				text:SetFont(C.media.font, fontSize, "OUTLINE")
				text:SetPoint("BOTTOM", 0, 0)
			end
			
			text:SetTextColor(C.actionbars.buttonCooldownColor.r, C.actionbars.buttonCooldownColor.g, C.actionbars.buttonCooldownColor.b, 1.0)
			
			self.text = text
			self:SetScript("OnUpdate", Timer_OnUpdate)
		end

		text:Show()
	elseif self.text then
		self.text:Hide()
	end
end)

local hooked = {}
local active = {}

local abEventWatcher = CreateFrame("Frame")
abEventWatcher:Hide()
abEventWatcher:SetScript("OnEvent", function(self, event)
	for cooldown in pairs(active) do
		local button = cooldown:GetParent()
		local start, duration, enable, charges, maxCharges = GetActionCooldown(button.action)
		local fontSize = C.appearance.fontSizeNormal
		
		if C.appearance.fontUseAlternativeFont == true then
			fontSize = 16
		end
		
		cooldown:SetCooldown(start, duration, fontSize, charges, maxCharges)
	end
end)
abEventWatcher:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")

local function cooldown_OnShow(self)
	active[self] = true
   end

local function cooldown_OnHide(self)
	active[self] = nil
end

local function actionButton_Register(frame)
	local cooldown = frame.cooldown
	if not hooked[cooldown] then
		cooldown:HookScript("OnShow", cooldown_OnShow)
		cooldown:HookScript("OnHide", cooldown_OnHide)
		hooked[cooldown] = true
	end
end

for i, frame in pairs(ActionBarButtonEventsFrame.frames) do
	actionButton_Register(frame)
end

hooksecurefunc("ActionBarButtonEventsFrame_RegisterFrame", actionButton_Register)