local F, C, L = unpack(select(2, ...))

local name = C.myName
local class = C.myClass
local realm = C.myRealm

C.appearance.fontUseAlternativeFont = true
C.appearance.fontSizeNormal = 14
C.appearance.fontOutlineStyle = 1		
C.appearance.padding = 0 

C.minimap.size = 220
C.minimap.position = 1  			 	-- 1 = top right, 2 = bottom right, 3 = top left, 4 = bottom left
C.minimap.buffPadding = 30

C.actionbars.buttonSize = 40				-- size of the buttons
C.actionbars.stanceBar = false 			-- toggle the stancebar
C.actionbars.hotkey = true				-- show hot keys on buttons
C.actionbars.rightbars_mouseover = true	-- show right bars on mouseover (show/hide: use blizz option)
C.actionbars.smallFont = true

C.bags.style = 2							-- 1 = all-in-one, 2 = restyle default bags, 3 = do nothing

C.menubar.enable = false

C.unitframes.enableArena = false								-- enable arena/flag carrier frames
C.unitframes.targettarget = true 							-- show target of target frame

C.unitframes.cast = BOTTOM, UIParent, CENTER, 0, -305	-- only applies with 'castbar' set to 2
C.unitframes.castbarSeparate = false 						-- true for a separate player cast bar
C.unitframes.castbarSeparateOnlyCasters = false 				-- separate bar only for mages/warlocks/priests
C.unitframes.pvp = false 									-- show pvp icon on player frame
C.unitframes.statusIndicator = false						-- show combat/resting status on player frame
C.unitframes.statusIndicatorCombat = false					-- show combat status (else: only resting)
  
C.unitframes.healerClasscolours = true

C.unitframes.player_height = 24
C.unitframes.target_height = 24
C.unitframes.party_width_healer = 75

C.classmod.paladinHP = false
C.classmod.paladinRF = false

C.classmod.monk = false 			-- chi, stagger bar

tremove(C.buffTracker.MONK, 1)
tremove(C.buffTracker.MONK, 2)

local ot = ObjectiveTrackerFrame
local offset = -(C.minimap.size + C.minimap.buffPadding)
ot:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, offset)
ot:SetPoint("BOTTOM", yAnchor, "TOP", 0, 320) -- bogus positioning because we can't touch ObjectiveTracker_CanFitBlock

