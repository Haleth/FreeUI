local F, C, L = unpack(select(2, ...))

-- All exceptions and special rules for these options are in profiles.lua!
-- Consider using the in-game options instead, accessed through the game menu or by typing /freeui.

--[[ Global config ]]

C["general"] = {
	["buffreminder"] = true, 		-- reminder for selfbuffs
	["buffTracker"] = true, 		-- track important buffs for some classes (scroll down to buffTracker table to configure)
	["combatText"] = true, 			-- show incoming damage and healing near player frame
	["helmcloakbuttons"] = true, 		-- show buttons to toggle helm/cloak on character frame
	["interrupt"] = true,			-- announce your interrupts
		["interrupt_party"] = true,		-- enable in 5 mans / scenarios
		["interrupt_bgs"] = false,		-- enable in battlegrounds
		["interrupt_lfg"] = true, 		-- enable in dungeon/raid finder/scenario groups
		["interrupt_outdoors"] = true,	-- enable when not in an instance
	["mailButton"] = true, 			-- adds a button to the mail frame to collect all attachments
	["nameplates"] = true, 			-- enable nameplates
	["rareAlert"] = true, 			-- raid warning when a rare mob is spotted (5.4)
		["rareAlert_playSound"] = true, 			-- play sound
	["threatMeter"] = true,			-- threat bar above the target frame in dps/healer layout
	["uiScaleAuto"] = true,			-- force the correct UI scale
	["undressButton"] = true, 		-- undress button on dressup frame
}

C["appearance"] = {
	["colourScheme"] = 1,			-- 1 = class coloured, 2 = custom
		["customColour"] = {r = 1, g = 1, b = 1},
	["fontUseAlternativeFont"] = false,
	["fontSizeNormal"] = 8,
	["fontSizeLarge"] = 16,
	["fontOutline"] = true,
	["fontOutlineStyle"] = 2,		-- 1 = normal, 2 = monochrome
	["fontShadow"] = false,
	["padding"] = 30			-- padding between edge of screen and UI elements
}

C["minimap"] = {
	["size"] = 130,				-- size of the minimap
	["position"] = 2,			-- 1 = top right, 2 = bottom right, 3 = top left, 4 = bottom left
	["buffPadding"] = 30			-- amount of padding between map and buffs (only if position = 1)
}

C["automation"] = {
	["autoAccept"] = true,			-- auto accept invites from friends and guildies
	["autoRepair"] = true,			-- automatically repair items
		["autoRepair_guild"] = false,		-- use guild funds for auto repairs
	["autoRoll"] = true, 			-- automatically DE or greed on BoE greens (DE priority)
		["autoRoll_maxLevel"] = true, 		-- only automatically roll on items at max level
	["autoSell"] = true,			-- automatically sell greys
	["autoSetRole"] = true,			-- automatically set role and hide dialog where possible
		["autoSetRole_useSpec"] = true,		-- attempt to set role based on your current spec
		["autoSetRole_verbose"] = false,	-- tells you what happens when setting role
	["questRewardHighlight"] = true, -- highlights the quest reward with highest vendor price
}

C["actionbars"] = {
	["enable"] = true,					-- enable the action bars
	["enableStyle"] = true,				-- style the action bars (might have to be turned off for other addons)
	["buttonSize"] = 26	,			-- size of the buttons
	["buttonCooldownColor"] = {r = 1, g = 1, b = 1}, 	-- color of the cooldown text on the buttons
	["smallFont"] = false,			-- enable if you use the alternative font but still want pixel font for button text
	["stanceBar"] = true,			-- toggle the stancebar

	["hotkey"] = false, 				-- show hot keys on buttons
	["rightbars_mouseover"] = false,	-- show right bars on mouseover (show/hide: use blizz option)
}

C["bags"] = {
	["style"] = 1,						-- 1 = all-in-one, 2 = restyle default bags, 3 = do nothing

	["size"] = 37,						-- change the size of the bags/bank, default = 37
	["slotsShowAlways"] = false, 		-- always show the bag item slots

	["hideSlots"] = true,				-- hide bag slots if style is 2 or 3
}

C["menubar"] = {
	["enable"] = true,

	["enableButtons"] = true,			-- show buttons for quick access on the menu bar
		["buttons_mouseover"] = true,			-- only on mouseover
}

C["notifications"] = {
	["enable"] = true,

	["playSounds"] = true,
	["animations"] = true,
	["timeShown"] = 5,

	["checkBagsFull"] = true,
	["checkEvents"] = true,
	["checkGuildEvents"] = true,
	["checkMail"] = true,
}

C["tooltip"] = {
	["anchorCursor"] = false,
	["guildrank"] = true,
	["title"] = false,
}

C["unitframes"] = {
	["enable"] = true, 									-- enable the unit frames and their included modules

	["autoPosition"] = true,							-- automatically postion unit frames based on resolution

	["enableGroup"] = true,								-- enable party/raid frames
		["healerClasscolours"] = false,						-- colour unitframes by class in healer layout
		["limitRaidSize"] = false, 							-- show a maximum of 25 players in a raid
		["partyNameAlways"] = false,						-- show name on party/raid frames in dps/tank layout
	["enableArena"] = true,								-- enable arena/flag carrier frames
	["targettarget"] = false, 							-- show target of target frame

	["absorb"] = true, 									-- absorb bar/over absorb glow
	["cast"] = {"BOTTOM", UIParent, "CENTER", 0, -105},	-- only applies with 'castbar' set to 2
	["castbarSeparate"] = true, 						-- true for a separate player cast bar
		["castbarSeparateOnlyCasters"] = true, 				-- separate bar only for mages/warlocks/priests
	["pvp"] = true, 									-- show pvp icon on player frame
	["statusIndicator"] = false,						-- show combat/resting status on player frame
		["statusIndicatorCombat"] = true,					-- show combat status (else: only resting)

	["player"] = {"BOTTOM", UIParent, "CENTER", -275, -105},
	["target"] = {"TOP", UIParent, "CENTER", 0, -225},
	["target_heal"] = {"BOTTOM", UIParent, "CENTER", 275, -105},
	["party"] = {"TOP", UIParent, "CENTER", 0, -225}, 	-- only applies with healer layout enabled
	["raid"] = {"TOP", UIParent, "CENTER", 0, -185}, 	-- only applies with healer layout enabled

	["altpower_height"] = 1,
	["power_height"] = 1,

	["player_width"] = 229,
	["player_height"] = 14,
	["target_width"] = 229,
	["target_height"] = 14,
	["targettarget_width"] = 229,
	["targettarget_height"] = 8,
	["focus_width"] = 113,
	["focus_height"] = 8,
	["pet_width"] = 113,
	["pet_height"] = 8,
	["boss_width"] = 170,
	["boss_height"] = 14,
	["arena_width"] = 229,
	["arena_height"] = 14,
	["party_width"] = 38,
	["party_height"] = 24,
	["party_width_healer"] = 56,
	["party_height_healer"] = 42,

	["num_player_debuffs"] = 8,
	["num_target_debuffs"] = 16,
	["num_target_buffs"] = 16,
	["num_boss_buffs"] = 5,
	["num_arena_buffs"] = 8,
	["num_focus_debuffs"] = 4,
}

C["classmod"] = {
	["deathknight"] = true, 	-- runes
	["druidEclipse"] = true, 	-- eclipse bar
	["druidMana"] = true, 		-- shapeshift mana bar
	["mage"] = true, 			-- rune of power
	["monk"] = true, 			-- chi, stagger bar
	["paladinHP"] = true, 		-- holy power
	["paladinRF"] = true, 		-- righteous fury
	["priest"] = true,			-- shadow orbs
	["warlock"] = true, 		-- spec bar
}

-- lower = smoother = more CPU usage
C["performance"] = {
	["mapcoords"] = .1, 	-- update interval for map coords in seconds (only with map open)
	["nameplates"] = .1, 	-- update interval for nameplates in seconds (always)
	["nameplatesHealth"] = .2, 	-- update interval for nameplate health bar colour (only with name plates shown)
}

-- Selfbuff reminder
-- put all possible buffs with the same effect in the same list, even when you can't cast them yourself
-- outer tables are for buffs that you want together (e.g. an outer table with inner fire and an outer table with PW:F)
-- tables within those tables are for buffs that are exclusive to each other (e.g. blessing of might and blessing of kings)
C["selfbuffs"] = {
	DEATHKNIGHT = {
		{
			{
				6673, -- Battle Shout
				57330, -- Horn of Winter
				19506, -- Trueshot Aura
			},
		},
	},
	DRUID = {
		{
			{
				20217, -- Blessing of Kings
				115921, -- Legacy of the Emperor
				116781, -- Legacy of the White Tiger
				1126, -- Mark of the Wild
			},
		},
	},
	MAGE = {
		{
			{
				1459, -- Arcane Brilliance
				61316, -- Dalaran Brilliance
				109773, -- Dark Intent
			},
			{
				1459, -- Arcane Brilliance
				61316, -- Dalaran Brilliance
				17007, -- Leader of the Pack
				116781, -- Legacy of the White Tiger
			},
		},
	},
	MONK = {
		{
			{
				20217, -- Blessing of Kings
				115921, -- Legacy of the Emperor
				116781, -- Legacy of the White Tiger
				1126, -- Mark of the Wild
			},
			{
				1459, -- Arcane Brilliance
				61316, -- Dalaran Brilliance
				17007, -- Leader of the Pack
				116781, -- Legacy of the White Tiger
			},
		},
	},
	PALADIN = {
		{
			{
				20217, -- Blessing of Kings
				115921, -- Legacy of the Emperor
				116781, -- Legacy of the White Tiger
				1126, -- Mark of the Wild
			},
			{
				19740, -- Blessing of Might
				116956, -- Grace of Air
				24907, -- Moonkin Aura
				155522, -- Power of the Grave
			},
		},
	},
	PRIEST = {
		{
			{
				166928, -- Blood Pact
				469, -- Commanding Shout
				21562, -- Power Word: Fortitude
			},
		},
	},
	ROGUE = {
		{
			{
				2823, -- Deadly Poison
				8679, -- Wound Poison
			},
		},
	},
	SHAMAN = {
		{
			{
				974, -- Earth shield
				324, -- Lightning shield
				52127, -- Water shield
			},
		},
	},
	WARLOCK = {
		{
			{
				1459, -- Arcane Brilliance
				61316, -- Dalaran Brilliance
				109773, -- Dark Intent
			},
			{
				109773, -- Dark Intent
				49868, -- Mind Quickening
				113742, -- Swiftblade's Cunning
				166916, -- Windflurry
			},
		},
	},
	WARRIOR = {
		{
			{
				166928, -- Blood Pact
				469, -- Commanding Shout
				21562, -- Power Word: Fortitude
			},
			{
				6673, -- Battle Shout
				57330, -- Horn of Winter
				19506, -- Trueshot Aura
			},
		},
	},
}

-- buff tracker: slot 1 is left, slot 2 is middle, slot 3 is right
-- spellIDs, size, unitId, isMine, filter, slot (1-3: left, middle, right), customPoint (table, overrides slot), spec (1-3)
-- if you use multiple spellIDs, first available gets displayed
C["buffTracker"] = {
	["MAGE"] = {
		-- Alter Time
		{spellIds = {[110909]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3},
		-- Arcane Power
		{spellIds = {[12042]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 2},
	},
	["MONK"] = {
		-- Tiger Power
		{spellIds = {[125359]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 1},
		-- Tigereye Brew
		{spellIds = {[125195]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3, minStack = 10},
	},
	["PALADIN"] = {
		-- Sacred Shield
		{spellIds = {[20925]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3},
		-- Selfless Healer
		{spellIds = {[114250]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3, minStack = 3},
		-- Divine Shield, Hand of Protection, Avenging Wrath, Holy Avenger
		{spellIds = {[642]=true, [1022]=true, [31884]=true, [105809]=true}, unitId = "player", isMine = "all", filter = "HELPFUL", slot = 2},
		-- Bastion of Glory
		{spellIds = {[114637]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 1},
	},
	["ROGUE"] = {
		-- Bandit's Guile
		{spellIds = {[84745]=true, [84746]=true, [84747]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3},
		-- Adrenaline Rush
		{spellIds = {[13750]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 2},
		-- Slice and dice
		{spellIds = {[5171]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 1},
	},
	["WARRIOR"] = {
		-- Last Stand, Shield Wall, Recklessness
		{spellIds = {[12975]=true, [871]=true, [1719]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 2},
		-- Shield Block
		{spellIds = {[2565]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3},
		-- Enrage
		{spellIds = {[12880]=true}, unitId = "player", isMine = 1, filter = "HELPFUL", slot = 3, spec = 1},
	}
}

-- [[ Filters ]]

-- Debuffs by other players or NPCs you want to show on enemy target

C["debuffFilter"] = {
	-- Stuns
	[408] = true, -- Kidney Shot
	[1833] = true, -- Cheap Shot
	[5211] = true, -- Mighty Bash
	[853] = true, -- Hammer of Justice
	[105593] = true, -- Fist of Justice
	[119381] = true, -- Leg Sweep

	-- Silence
	[47476] = true, -- Strangulate
	[15487] = true, -- Silence

	-- Taunt
	[355] = true, -- Taunt
	[21008] = true, -- Mocking Blow
	[62124] = true, -- Reckoning
	[49576] = true, -- Death Grip
	[56222] = true, -- Dark Command
	[6795] = true, -- Growl
	[2649] = true, -- Growl (pet)
	[116189] = true, -- Provoke

	-- Crowd control
	[118] = true, -- Polymorph (sheep)
	[61305] = true, -- Polymorph (black cat)
	[28272] = true, -- Polymorph (pig)
	[61721] = true, -- Polymorph (rabbit)
	[28271] = true, -- Polymorph (turtle)
	[61780] = true, -- Polymorph (turkey)
	[2094] = true, -- Blind
	[6770] = true, -- Sap
	[20066] = true, -- Repentance
	[9484] = true, -- Shackle Undead
	[339] = true, -- Entangling Roots
	[710] = true, -- Banish
	[19386] = true, -- Wyvern Sting
	[51514] = true, -- Hex
	[5782] = true, -- Fear
	[1499] = true, -- Freezing Trap (1?)
	[3355] = true, -- Freezing Trap (2?)
	[6358] = true, -- Seduction
	[10326] = true, -- Turn Evil
	[33786] = true, -- Cyclone
	[115078] = true, -- Paralysis
}

-- Buffs to show on enemy players

C["dangerousBuffs"] = {
	[13750] = true, -- Adrenaline Rush
	[23335] = true, -- Alliance Flag
	[90355] = true, -- Ancient Hysteria
	[48707] = true, -- Anti-Magic Shell
	[31850] = true, -- Ardent Defender
	[31821] = true, -- Aura Mastery
	[31884] = true, -- Avenging Wrath
	[46924] = true, -- Bladestorm
	[2825] = true, -- Bloodlust
	[51753] = true, -- Camouflage
	[31224] = true, -- Cloak of Shadows
	[74001] = true, -- Combat Readiness
	[19263] = true, -- Deterrence
	[122783] = true, -- Diffuse Magic
	[47585] = true, -- Dispersion
	[498] = true, -- Divine Protection
	[642] = true, -- Divine Shield
	[5277] = true, -- Evasion
	[110959] = true, -- Greater Invisibility
	[86659] = true, -- Guardian of Ancient Kings
	[47788] = true, -- Guardian Spirit
	[1022] = true, -- Hand of Protection
	[32182] = true, -- Heroism
	[105809] = true, -- Holy Avenger
	[23333] = true, -- Horde Flag
	[11426] = true, -- Ice Barrier
	[45438] = true, -- Ice Block
	[48792] = true, -- Icebound Fortitude
	[66] = true, -- Invisibility
	[12975] = true, -- Last Stand
	[1463] = true, -- Mana Shield
	[103958] = true, -- Metamorphosis
	[33206] = true, -- Pain Suppression
	[10060] = true, -- Power Infusion
	[17] = true, -- Power Word: Shield
	[15473] = true, -- Shadowform
	[871] = true, -- Shield Wall
	[23920] = true, -- Spell Reflection
	[2983] = true, -- Sprint
	[80353] = true, -- Time Warp
	[122470] = true, -- Touch of Karma
	[115176] = true, -- Zen Meditation
}

-- Debuffs healers don't want to see on raid frames

C["hideDebuffs"] = {
	[57724] = true, -- Sated
	[57723] = true, -- Exhaustion
	[80354] = true, -- Temporal Displacement
	[41425] = true, -- Hypothermia
	[95809] = true, -- Insanity
	[36032] = true, -- Arcane Blast
	[26013] = true, -- Deserter
	[95223] = true, -- Recently Mass Resurrected
	[97821] = true, -- Void-Touched (death knight resurrect)
	[36893] = true, -- Transporter Malfunction
	[36895] = true, -- Transporter Malfunction
	[36897] = true, -- Transporter Malfunction
	[36899] = true, -- Transporter Malfunction
	[36900] = true, -- Soul Split: Evil!
	[36901] = true, -- Soul Split: Good
	[25163] = true, -- Disgusting Oozeling Aura
	[85178] = true, -- Shrink (Deviate Fish)
	[8064] = true, -- Sleepy (Deviate Fish)
	[8067] = true, -- Party Time! (Deviate Fish)
	[24755] = true, -- Tricked or Treated (Hallow's End)
	[42966] = true, -- Upset Tummy (Hallow's End)
	[89798] = true, -- Master Adventurer Award (Maloriak kill title)
	[6788] = true, -- Weakened Soul
	[92331] = true, -- Blind Spot (Jar of Ancient Remedies)
	[71041] = true, -- Dungeon Deserter
	[26218] = true, -- Mistletoe
	[117870] = true, -- Touch of the Titans
}

if select(2, UnitClass("player")) == "PRIEST" then C.hideDebuffs[6788] = false end

-- Buffs cast by the player that healers want to see on raid frames

C["myBuffs"] = {
	[774] = true, -- Rejuvenation
	[8936] = true, -- Regrowth
	[33763] = true, -- Lifebloom

	[33110] = true, -- Prayer of Mending
	[33076] = true, -- Prayer of Mending
	[41635] = true, -- Prayer of Mending
	[41637] = true, -- Prayer of Mending
	[139] = true, -- Renew
	[17] = true, -- Power Word: Shield

	[61295] = true, -- Riptide
	[974] = true, -- Earth Shield

	[53563] = true, -- Beacon of Light
	[156322] = true, -- Eternal Flame
	[20925] = true, -- Sacred Shield

	[119611] = true, -- Renewing Mist
	[116849] = true, -- Life Cocoon
	[124682] = true, -- Enveloping Mist
	[124081] = true, -- Zen Sphere
}

-- Buffs cast by anyone that healers want to see on raid frames

C["allBuffs"] = {
	[86657] = true, -- Ancient Guardian
	[31850] = true, -- Ardent Defender
	[642] = true, -- Divine Shield
	[110959] = true, -- Greater Invisibility
	[86659] = true, -- Guardian of Ancient Kings
	[47788] = true, -- Guardian Spirit
	[45438] = true, -- Ice Block
	[48792] = true, -- Icebound Fortitude
	[66] = true, -- Invisibility
	[12975] = true, -- Last Stand
	[33206] = true, -- Pain Suppression
	[871] = true, -- Shield Wall
	[61336] = true, -- Survival Instincts
	[122470] = true, -- Touch of Karma

	[1022] = true, -- Hand of Protection
	[1038] = true, -- Hand of Salvation
	[6940] = true, -- Hand of Sacrifice
}