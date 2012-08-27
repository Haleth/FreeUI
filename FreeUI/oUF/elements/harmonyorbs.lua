local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_LIGHT_FORCE = SPELL_POWER_LIGHT_FORCE

local Update = function(self, event, unit)
	if(unit ~= 'player') then return end

	local element = self.Harmony
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local chi = UnitPower(unit, SPELL_POWER_LIGHT_FORCE)

	for index = 1, UnitPowerMax(unit, SPELL_POWER_LIGHT_FORCE) do
		if(index <= chi) then
			element[index]:Show()
		else
			element[index]:Hide()
		end
	end

	if(element.PostUpdate) then
		return element:PostUpdate(chi)
	end
end

local Path = function(self, ...)
	return (self.Harmony.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local Enable = function(self, unit)
	local element = self.Harmony
	if(element and unit == 'player') then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path, true)
		self:RegisterEvent('UNIT_DISPLAYPOWER', Path, true)

		return true
	end
end

local Disable = function(self)
	local element = self.Harmony
	if(element) then
		self:UnregisterEvent('UNIT_POWER', Path)
		self:UnregisterEvent('UNIT_DISPLAYPOWER', Path)
	end
end

oUF:AddElement('Harmony', Path, Enable, Disable)