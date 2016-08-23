-- FastError by AlleyKat, modified.

local F, C, L = unpack(select(2, ...))

local holdtime = 0.52 -- hold time (seconds)
local fadeintime = 0.08 -- fadein time (seconds)
local fadeouttime = 0.16 -- fade out time (seconds)

UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")

local firstErrorFrame = CreateFrame("Frame", "FreeUIErrors1", UIParent)
firstErrorFrame:SetScript("OnUpdate", FadingFrame_OnUpdate)
firstErrorFrame.fadeInTime = fadeintime
firstErrorFrame.fadeOutTime = fadeouttime
firstErrorFrame.holdTime = holdtime
firstErrorFrame:Hide()
firstErrorFrame:SetFrameStrata("TOOLTIP")
firstErrorFrame:SetFrameLevel(30)

local secondErrorFrame = CreateFrame("Frame", "FreeUIErrors2", UIParent)
secondErrorFrame:SetScript("OnUpdate", FadingFrame_OnUpdate)
secondErrorFrame.fadeInTime = fadeintime
secondErrorFrame.fadeOutTime = fadeouttime
secondErrorFrame.holdTime = holdtime
secondErrorFrame:Hide()
secondErrorFrame:SetFrameStrata("TOOLTIP")
secondErrorFrame:SetFrameLevel(30)

firstErrorFrame.text = F.CreateFS(firstErrorFrame)
firstErrorFrame.text:SetPoint("TOP", UIParent, 0, -76)
secondErrorFrame.text = F.CreateFS(secondErrorFrame)
secondErrorFrame.text:SetPoint("TOP", UIParent, 0, -85)

-- Translate from Error Number to a user-friendly string.
local function TranslateError(err)

	-- By no means a full list, but covers most common ones and some Fury specific ones.
	if err == 55 then return "That is not ready yet." end
	if err == 149 then return "" end -- Isn't a blizzard error, not shown. Probably (You cannot do that while mounted)
	if err == 193 then return "There is nothing to attack." end
	if err == 220 then return "You need a target." end
	if err == 250 then return "You need a 2H Weapon in your Offhand." end
	if err == 359 then return "That is too far away." end

	return "Unknown error: " .. err
end

local state = 0
firstErrorFrame:SetScript("OnHide", function() state = 0 end)
local Error = CreateFrame("Frame")
Error:RegisterEvent("UI_ERROR_MESSAGE")
Error:SetScript("OnEvent", function(_, _, error)
	if state == 0 then
		firstErrorFrame.text:SetText(TranslateError(error))
		FadingFrame_Show(firstErrorFrame)
		state = 1
	 else
		secondErrorFrame.text:SetText(TranslateError(error))
		FadingFrame_Show(secondErrorFrame)
		state = 0
	 end
end)
