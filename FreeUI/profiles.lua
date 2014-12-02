local F, C, L = unpack(select(2, ...))

--[[
	This file allows you to override any option in options.lua, or append to it, for example to the buffTracker table.
	Since this file is mostly blank, it will most likely updated.
	You can therefore simply copy and paste it every time you update the UI, and keep your settings, unless mentioned otherwise.

	To override an option in a table which uses key-value pairs, format it like this:
	C.general.autorepair_guild = true

	To override an option in a table which uses indexes (=the table is simply a summary of values), use this:
	C.buffTracker.PALADIN[1] = {spellId = 59578, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3}
	(if you are adding a table for a new class, you have to use C.buffTracker.NEWCLASSHERE = {} first)

	To append an option to an existing table, use this format:
	tinsert(C.buffTracker.PALADIN, {spellId = 114250, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3})

	To remove an element from an existing table (in this case the first):
	tremove(C.buffTracker.PALADIN, 1)
]]

local name = C.myName
local class = C.myClass
local realm = C.myRealm

C["appearance"] = {
	["fontUseAlternativeFont"] = true,
	["fontSizeNormal"] = 14,
	["fontOutlineStyle"] = 1,		-- 1 = normal, 2 = monochrome
	["padding"] = 0 							-- padding from the edge pf the screen
}

C["minimap"] = {
	["position"] = 1  			 	-- 1 = top right, 2 = bottom right, 3 = top left, 4 = bottom left
}

C["actionbars"] = {
	["buttonSize"] = 40,				-- size of the buttons
	["stanceBar"] = false, 			-- toggle the stancebar

	["hotkey"] = true, 				-- show hot keys on buttons
	["rightbars_mouseover"] = true	-- show right bars on mouseover (show/hide: use blizz option)
}

C["bags"] = {
	["style"] = 2							-- 1 = all-in-one, 2 = restyle default bags, 3 = do nothing
}

C["menubar"] = {
	["enable"] = false
}

C["unitframes"] = {
	["enableArena"] = false,								-- enable arena/flag carrier frames
	["targettarget"] = true, 							-- show target of target frame

	["cast"] = {"BOTTOM", UIParent, "CENTER", 0, -305},	-- only applies with 'castbar' set to 2
	["castbarSeparate"] = false, 						-- true for a separate player cast bar
		["castbarSeparateOnlyCasters"] = false, 				-- separate bar only for mages/warlocks/priests
	["pvp"] = false, 									-- show pvp icon on player frame
	["statusIndicator"] = false,						-- show combat/resting status on player frame
		["statusIndicatorCombat"] = false,					-- show combat status (else: only resting)

	["player_height"] = 24,
	["target_height"] = 24,
	["party_width_healer"] = 75,
}

C["classmod"] = {
	["monk"] = false, 			-- chi, stagger bar
}
