local _, ns = ...
local Filger = ns.Filger

-- Blizzard
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo

local EXPANSION = _G.LE_EXPANSION_LEVEL_CURRENT or -1
local LE_EXPANSION_CLASSIC = _G.LE_EXPANSION_CLASSIC or 0
local LE_EXPANSION_BURNING_CRUSADE = _G.LE_EXPANSION_BURNING_CRUSADE or 1
local LE_EXPANSION_WRATH_OF_THE_LICH_KING = _G.LE_EXPANSION_WRATH_OF_THE_LICH_KING or 2
local LE_EXPANSION_CATACLYSM = _G.LE_EXPANSION_CATACLYSM or 3
local LE_EXPANSION_MISTS_OF_PANDARIA = _G.LE_EXPANSION_MISTS_OF_PANDARIA or 4
local LE_EXPANSION_WARLORDS_OF_DRAENOR = _G.LE_EXPANSION_WARLORDS_OF_DRAENOR or 5
local LE_EXPANSION_LEGION = _G.LE_EXPANSION_LEGION or 6
local LE_EXPANSION_BATTLE_FOR_AZEROTH = _G.LE_EXPANSION_BATTLE_FOR_AZEROTH or 7
local LE_EXPANSION_SHADOWLANDS = _G.LE_EXPANSION_SHADOWLANDS or 8
local LE_EXPANSION_DRAGONFLIGHT = _G.LE_EXPANSION_DRAGONFLIGHT or 9
local LE_EXPANSION_WAR_WITHIN = _G.LE_EXPANSION_WAR_WITHIN or 10

-- Mine
local interface = Filger.interface
local isRetail = Filger.isRetail
local isClassic = Filger.isClassic
local isBCC = Filger.isBCC
local isWrath = Filger.isWrath
local isCata = Filger.isCata

local import = function(source, dest)
    for spellId, enabled in next, source do
        if enabled then
            if type(spellId) == "string" then
                dest[spellId] = true
            else
                local data = GetSpellInfo(spellId)
                if data then
                    dest[spellId] = true
                else
                    Filger:warn("Blacklist", "Spell " .. spellId .. " do not exists.")
                end
            end
        end
    end
end

--------------------------------------------------
-- Black List
--------------------------------------------------
local blacklist = {}

local general = {
    ["Well Fed"] = true,
    ["Drink"] = true,
    ["Food"] = true,
 
    -- Lust
    [57723] = (EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING),   -- Exhaustion (Heroism)
    [57724] = (EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING),   -- Sated (Bloodlust)
    [80354] = (EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA),        -- Temporal Displacement (Mage)
    [264689] = (EXPANSION >= LE_EXPANSION_SHADOWLANDS),             -- Fatigued (Hunter)
    [390435] = (EXPANSION >= LE_EXPANSION_DRAGONFLIGHT),            -- Exhaustion (Evoker - Fury of the Aspects)

    -- DRUID
    ["Mark of the Wild"] = true,
    [1126] = true,                                              -- Mark of the Wild
    [768] = true,                                               -- Cat Form
    [5487] = true,                                              -- Bear Form
    [24858] = true,                                             -- Moonkin Form
    [114282] = (EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA),   -- Treant Form

    -- MAGE
    ["Arcane Intellect"] = true,

    -- PALADIN
    [7294] = (EXPANSION <= LE_EXPANSION_CATACLYSM),             -- Retribution Aura
    [19746] = (EXPANSION <= LE_EXPANSION_CATACLYSM),            -- Concentration Aura
    [19891] = (EXPANSION <= LE_EXPANSION_CATACLYSM),            -- Resistance Aura
    [32223] = (EXPANSION >= LE_EXPANSION_BURNING_CRUSADE),      -- Crusader Aura

    -- PRIEST
    ["Power Word: Fortitude"] = true,
}

import(general, blacklist)

--------------------------------------------------
-- Classic
--------------------------------------------------
do
    local data = {
        -- DRUID
        [1126] = true,                                      -- Mark of the Wild (Rank 1)
        [5232] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 2)
        [6756] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 3)
        [5234] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 4)
        [8907] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 5)
        [9884] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 6)
        [9885] = isClassic or isBCC or isWrath,             -- Mark of the Wild (Rank 7)
        [26990] = isBCC or isWrath,                         -- Mark of the Wild (Rank 8)
        [48469] = isWrath,                                  -- Mark of the Wild (Rank 9)

        [467] = (EXPANSION < LE_EXPANSION_CATACLYSM),       -- Thorns (Rank 1)
        [782] = isClassic or isBCC or isWrath,              -- Thorns (Rank 2)
        [1075] = isClassic or isBCC or isWrath,             -- Thorns (Rank 3)
        [8914] = isClassic or isBCC or isWrath,             -- Thorns (Rank 4)
        [9756] = isClassic or isBCC or isWrath,             -- Thorns (Rank 5)
        [9910] = isClassic or isBCC or isWrath,             -- Thorns (Rank 6)
        [26992] = isBCC or isWrath,                         -- Thorns (Rank 7)
        [53307] = isWrath,                                  -- Thorns (Rank 8)

        [24907] = (EXPANSION <= LE_EXPANSION_MISTS_OF_PANDARIA), -- Moonkin Aura

        -- HUNTER
        [19506] = (EXPANSION <= LE_EXPANSION_MISTS_OF_PANDARIA), -- Trueshot Aura

        -- MAGE
        [1459] = true,                                      -- Arcane Intellect (Rank 1)
        [1460] = isClassic or isBCC or isWrath,             -- Arcane Intellect (Rank 2)
        [1461] = isClassic or isBCC or isWrath,             -- Arcane Intellect (Rank 3)
        [10156] = isClassic or isBCC or isWrath,            -- Arcane Intellect (Rank 4)
        [10157] = isClassic or isBCC or isWrath,            -- Arcane Intellect (Rank 5)
        [27126] = isBCC or isWrath,                         -- Arcane Intellect (Rank 6)
        [42995] = isWrath,                                  -- Arcane Intellect (Rank 7)

        -- PALADIN
        [19740] = (EXPANSION <= LE_EXPANSION_MISTS_OF_PANDARIA), -- Blessing of Might

        -- PRIEST
        [1243] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 1)
        [1244] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 2)
        [1245] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 3)
        [2791] = isClassic or isBCC or isWrath,             -- Power Word: Fortitude (Rank 4)
        [10937] = isClassic or isBCC or isWrath,            -- Power Word: Fortitude (Rank 5)
        [10938] = isClassic or isBCC or isWrath,            -- Power Word: Fortitude (Rank 6)
        [25389] = isBCC or isWrath,                         -- Power Word: Fortitude (Rank 7)
        [48161] = isWrath,                                  -- Power Word: Fortitude (Rank 8)
        
        [21562] = isClassic,                                -- Prayer of Fortitude (Rank 1)
        [21564] = isClassic,                                -- Prayer of Fortitude (Rank 2)
        
        [27681] = isClassic,                                -- Prayer of Spirit

        -- ROGUE
        [1784] = false,                                     -- Stealth
        [2823] = true,                                      -- Deadly Poison
        [3408] = true,                                      -- Crippling Poison

        -- WARLOCK
        [687] = isClassic or isBCC or isWrath or isCata,    -- Demon Skin (Rank 1)
        [696] = isClassic or isBCC or isWrath,              -- Demon Skin (Rank 2)

        [6307] = isClassic or isBCC or isWrath or isCata,   -- Blood Pact (Rank 1)
        [7804] = isClassic or isBCC or isWrath,             -- Blood Pact (Rank 2)
        [7805] = isClassic or isBCC or isWrath,             -- Blood Pact (Rank 3)
        [11766] = isClassic or isBCC or isWrath,            -- Blood Pact (Rank 4)
        [11787] = isClassic or isBCC or isWrath,            -- Blood Pact (Rank 5)
        [27267] = isBCC or isWrath,                         -- Blood Pact (Rank 6)
        [47982] = isWrath,                                  -- Blood Pact (Rank 7)

        -- Consumables
        [673] = true,                                       -- Elixir of Minor Defense
        [2367] = true,                                      -- Elixir of Lion's Strength
        [2374] = true,                                      -- Elixir of Minor Agility
        [2378] = true,                                      -- Elixir of Minor Fortitude
        [3160] = true,                                      -- Elixir of Lesser Agility
        [3164] = true,                                      -- Elixir of Ogre's Strength
        [3166] = true,                                      -- Elixir of Wisdom
        [3220] = true,                                      -- Elixir of Defense
        [3593] = true,                                      -- Elixir of Fortitude
        [6512] = true,                                      -- Elixir of Detect Lesser Invisibility
        [7178] = true,                                      -- Elixir of Water Breathing
        [7844] = true,                                      -- Elixir of Fire Power
        [8212] = true,                                      -- Elixir of Giant Growth
        [11319] = true,                                     -- Elixir of Water Walking
        [11328] = true,                                     -- Elixir of Agility
        [11334] = true,                                     -- Elixir of Greater Agility
        [11348] = true,                                     -- Elixir of Superior Defense
        [11349] = true,                                     -- Elixir of Greater Defense
        [11389] = true,                                     -- Elixir of Detect Undead
        [11390] = true,                                     -- Arcane Elixir
        [11396] = true,                                     -- Elixir of Greater Intellect
        [11403] = true,                                     -- Elixir of Dream Vision
        [11405] = true,                                     -- Elixir of the Giants
        [11406] = true,                                     -- Elixir of Demonslaying
        [11407] = true,                                     -- Elixir of Detect Demon
        [11474] = true,                                     -- Elixir of Shadow Power
        [12608] = true,                                     -- Catseye Elixir
        [17535] = true,                                     -- Elixir of the Sages
        [17537] = true,                                     -- Elixir of Brute Force
        [17538] = true,                                     -- Elixir of the Mongoose
        [17539] = true,                                     -- Greater Arcane Elixir
        [21920] = true,                                     -- Elixir of Frost Power
        [22807] = false,                                    -- Elixir Greater Water Breathing
        [26276] = true,                                     -- Elixir of Greater Firepower
        [26677] = true,                                     -- Elixir of Poison Resistance
        
        [17624] = false,                                    -- Flask of Petrification
        [17626] = true,                                     -- Flask of the Titans
        [17627] = true,                                     -- Flask of Distilled Wisdom
        [17628] = true,                                     -- Flask od Supreme Power
        [17629] = isClassic or isBCC or isCata,             -- Flask of Chromatic Resistance

        -- Scrolls
        [8091] = isClassic,                                 -- Armor (Scroll of Protection)
        [8094] = isClassic,                                 -- Armor (Scroll of Protection II)
        [8095] = isClassic,                                 -- Armor (Scroll of Protection III) 
        [12175] = isClassic,                                -- Armor (Scroll of Protection IV)
        [33079] = isBCC,                                    -- Armor (Scroll of Protection V)
        
        [8096] = isClassic,                                 -- Intellect (Scroll of Intellect)
        [8097] = isClassic,                                 -- Intellect (Scroll of Intellect II)
        [8098] = isClassic,                                 -- Intellect (Scroll of Intellect III)
        [12176] = isClassic,                                -- Intellect (Scroll of Intellect IV)
        [33078] = isBCC,                                    -- Intellect (Scroll of Intellect V)
        
        [8099] = isClassic,                                 -- Stamina (Scroll of Stamina)
        [8100] = isClassic,                                 -- Stamina (Scroll of Stamina II)
        [8101] = isClassic,                                 -- Stamina (Scroll of Stamina III)
        [12178] = isClassic,                                -- Stamina (Scroll of Stamina IV)
        [33081] = isBCC,                                    -- Stamina (Scroll of Stamina V)
        
        [8112] = isClassic,                                 -- Spirit Magic (Scroll of Spirit)
        [8113] = isClassic,                                 -- Spirit Magic (Scroll of Spirit II)
        [8114] = isClassic,                                 -- Spirit Magic (Scroll of Spirit III)
        [12177] = isClassic,                                -- Spirit Magic (Scroll of Spirit IV)
        [33080] = isBCC,                                    -- Spirit Magic (Scroll of Spirit V)
        
        [8115] = isClassic,                                 -- Agility (Scroll of Agility)
        [8116] = isClassic,                                 -- Agility (Scroll of Agility II)
        [8117] = isClassic,                                 -- Agility (Scroll of Agility III)
        [12174] = isClassic,                                -- Agility (Scroll of Agility IV)
        [33077] = isBCC,                                    -- Agility (Scroll of Agility V)
        
        [8118] = isClassic,                                 -- Strength (Scroll of Strength)
        [8119] = isClassic,                                 -- Strength (Scroll of Strength II)
        [8120] = isClassic,                                 -- Strength (Scroll of Strength III)
        [12179] = isClassic,                                -- Strength (Scroll of Strength IV)
        [33082] = isBCC,                                    -- Strength (Scroll of Strength V)

        -- Christimas
        [26218] = isClassic,                                -- Mistletoe

        -- Costumes
        [8220] = true,                                      -- Flip Out!
        [8222] = true,                                      -- Yaaarrrr
        [16739] = true,                                     -- Orb of Deception

        -- Items
        [17619] = true,                                     -- Alchemist Stone

        --------------------------------------------------
        -- Season of Discovery
        --------------------------------------------------
        [349981] = not isRetail,                            -- Supercharged Chronoboon Displacer
        [410935] = isClassic,                               -- Meditation on the Light
        [417316] = isClassic,                               -- Meditation on the Loa
        [418459] = isClassic,                               -- Meditation on Undeath
        [419307] = isClassic,                               -- Meditation on Elune
        [430947] = isClassic,                               -- Boon of Blackfathom (World Buff)
        [436412] = isClassic,                               -- Discoverer's Delight
    }

    import(data, blacklist)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
if Filger.isBCC then
    local data = {
        -- PRIEST
        [25431] = true, -- Inner Fire (Rank 7)
        [32999] = true, -- Prayer of Spirit (Rank 2)
    }

    import(data, blacklist)
end

if EXPANSION >= LE_EXPANSION_BURNING_CRUSADE then
    local data = {
        -- Events
        [44185] = true, -- Jack-o'-Lanterned!
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if Filger.isWrath then
    local data  = {
        -- DEATHKNIGHT
        [55610] = true, -- Improved Icy Talons

        -- MAGE
        [61316] = true, -- Dalaran Brilliance

        -- PRIEST
        [48040] = true, -- Inner Fire (Rank 8)
        [48168] = true, -- Inner Fire (Rank 9)
        [48074] = true, -- Prayer of Spirit (Rank 3)
        [49868] = true, -- Mind Quickening

        -- SHAMAN
        [30809] = true, -- Unleashed Rage
        [51470] = true, -- Elemental Oath
    }

    import(data, blacklist)
end

if EXPANSION >= LE_EXPANSION_WRATH_OF_THE_LICH_KING then
    local data = {
        -- Items
        [72968] = true, -- Precious's Ribbon

        -- Dungeons
        [72221] = true, -- Luck of the Draw

        -- World Buffs
        [57940] = true, -- Essence of Wintergrasp
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if Filger.isCata then
    local data = {
        -- DEATHKNIGHT
        [55610] = true, -- Improved Icy Talons

        -- HUNTER
        [77769] = true, -- Trap Launcher

        -- MAGE
        [61316] = true, -- Dalaran Brilliance

        -- PALADIN
        [79102] = true, -- Blessing of Might
        [20165] = true, -- Seal of Insight

        -- PRIEST
        [588] = true, -- Inner Fire
        [49868] = true, -- Mind Quickening
        [79107] = true, -- Shadow Protection
        [73413] = true, -- Inner Will

        -- SHAMAN
        [30809] = true, -- Unleashed Rage
        [51470] = true, -- Elemental Oath
        [77747] = true, -- Totemic Wrath
    }

    import(data, blacklist)
end

if EXPANSION >= LE_EXPANSION_CATACLYSM then
    local data = {
        -- WARLOCK
        [108503] = true, -- Grimoire of Sacrifice

        -- Items
        [93337] = true, -- Champion of Ramkahen
        [93795] = true, -- Stormwind Champion
        [93806] = true, -- Darnassus Champion
        [93825] = true, -- Orgrimmar Champion
        [93828] = true, -- Silvermoon Champion
        [97341] = true, -- Guild Champion

        -- Customes
        [74589] = true, -- Identity Crisis (Faded Wizard Hat)
        [96312] = true, -- Kalytha's Haunted Locket
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if Filger.isMoP then 
    local data = {
        -- DEATHKNIGHT
        [55610] = true, -- Unholy Aura

        -- HUNTER
        [77769] = true, -- Trap Launcher

        -- MAGE
        [61316] = true, -- Dalaran Brilliance

        -- MONK
        [117666] = true, -- Legacy of the Emperor
        [116781] = true, -- Legacy of the White Tiger

        -- PRIEST
        [49868] = true, -- Mind Quickening

        -- ROGUE
        [113742] = true, -- Swiftblade's Cunning
        [112942] = true, -- Shadow Focus
        


        -- SHAMAN
        [30809] = true, -- Unleashed Rage
        [51470] = true, -- Elemental Oath
        [77747] = true, -- Burning Wrath
        [116956] = true, -- Grace of Air

        -- WARLOCK
        [109773] = true, -- Dark Intent
    }
    import(data, blacklist)
end

if EXPANSION >= LE_EXPANSION_MISTS_OF_PANDARIA then
    local data = {
        -- HUNTER
        [109260] = true, -- Aspect of the Iron Hawk

        -- Items
        [105689] = true, -- Flask of Spring Blossoms
        [105691] = true, -- Flask of the Warn Sun
        [105694] = true, -- Flask of the Earth
        [105696] = true, -- Flask of Winter's Bite
        [126434] = true, -- Tushui Champion
        [127230] = true, -- Visions of Insanity

        -- Factions
        [119966] = true, -- Blessing of the Pearlfin

        -- Klaxxi
        [124529] = true, -- Iron Mantid (Enhancement)
        [123075] = true, -- Angel of Death (Enhancement)
        [127382] = true, -- Silent Lucidity (Enhancement)
        [127794] = true, -- Children of the Grave (Enhancement)
        [127375] = true, -- Speed King (Augmentation)
        [123219] = true, -- Battle Hymn (Augmentation)
        [123211] = true, -- Pain Killer (Augmentation)
        [127351] = true, -- Master of Puppets (Augmentation)

        -- World Buff
        [130609] = true, -- Valor of the Ancients

        -- Others
        [131493] = true, -- B.F.F
        [134522] = true, -- Dressed to Kill
        [114800] = true, -- Polyformic Acid Potion
        [110880] = true, -- 1st Place
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Warlords of Draenor
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_WARLORDS_OF_DRAENOR then
    local data = {
        -- World Buffs
        [186401] = true, -- Sign of the Skirmisher
        [186403] = true, -- Sign of Battle
        [186406] = true, -- Sign of the Critter

        -- ???
        [182422] = true, -- Training Gear
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Legion
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_LEGION then
    local data = {
        -- PvP
        [282559] = true, -- Enlisted

        -- Items
        [203533] = true, -- Black Icey Bling
        [227723] = true, -- Mana Diving Stone
        [245686] = true, -- Fashionable!
        [297871] = true, -- Anglers' Water Striders

        -- World Buffs
        [225787] = true, -- Sign of of Warrior
        [225788] = true, -- Sign of the Emissary

        -- Mythic+
        [206151] = true, -- Challenger's Burden
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Battle for Azeroth
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_BATTLE_FOR_AZEROTH then
    local data = {
        -- World Buffs
        [335148] = true, -- Sign of the Twisting Nether
        [335149] = true, -- Sign of the Scourge
        [335150] = true, -- Sign of the Destroyer
        [335151] = true, -- Sign of the Mists
        [335152] = true, -- Sign of Iron

        --------------------------------------------------
        -- Patch 8.1.0
        --------------------------------------------------
        [147728] = true, -- Severed Crimsonscale Head

        --------------------------------------------------
        -- Patch 8.2.0
        --------------------------------------------------
        [306600] = true, -- Experience Eliminated

        --------------------------------------------------
        -- Patch 8.3.0
        --------------------------------------------------
        -- Horric Visions
        [291295] = true, -- Mind Protected

        [307518] = true, -- Vision Hunter
        [312583] = true, -- Vision Hunter
        [312585] = true, -- Vision Hunter

        [305380] = true, -- Experimental Destabilization
        [305381] = true, -- Experimental Destabilization
        [305385] = true, -- Experimental Destabilization
        [312620] = true, -- Experimental Destabilization
        [312621] = true, -- Experimental Destabilization

        [304852] = true, -- Singular Sanitation Expertise
        [312545] = true, -- Singular Sanitation Expertise
        [312544] = true, -- Singular Sanitation Expertise
        [304853] = true, -- Singular Sanitation Expertise

        [312629] = true, -- Clear Sight
        [307519] = true, -- Clear Sight
        [312628] = true, -- Clear Sight

        [312456] = true, -- Elite Extermination
        [310720] = true, -- Elite Extermination
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Shadowlands
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_SHADOWLANDS then
    local data = {
        -- World Buffs
        [347600] = true, -- Infused Ruby Tracking
        [359082] = true, -- Sign of the Legion

        -- Items
        [345545] = true, -- Flayedwing Toxin
        [368510] = true, -- So'leash's Secret Technique
        [368512] = true, -- So'leash's Secret Technique
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Dragonflight
--------------------------------------------------
if EXPANSION >= LE_EXPANSION_DRAGONFLIGHT then
    local data = {
        -- DEATHKNIGHT
        
        -- MONK
        [166646] = true, -- Windwalking

        -- PALADIN
        [465] = true, -- Devotion Aura
        [32223] = true,  -- Crusader Aura

        -- PRIEST
        [21562] = true, -- Power Word: Fortitude
        [280398] = true, -- Sins of the Many

        -- SHAMAN
        [395197] = true, -- Mana Spring

        -- WARRIOR
        [6673] = true, -- Battle Shout
        [202602] = true, -- Into the Fray

        -- Dragons Island
        [385081] = true, -- Unstable Blink
        [390493] = true, -- Cobalt Boost
        [394258] = true, -- Cobalt Cutthroat

        -- Forbiden Reach
        [405261] = true, -- Dragonscale's Favor
        [405263] = true, -- Iskaara's Favor
        [405264] = true, -- Maruukai's Favor
        [405265] = true, -- Valdrakken's Favor

        -- Zaralek Cavern
        [411060] = true, -- New Niffen No-Sniffin' Tonic

        -- Professions
        [382093] = true, -- Alchemically Inspired

        -- Items
        [399502] = true, -- Automically Recalibrated
        [401518] = true, -- Bronze Resonance (Ominous Chromatic Essence)
        [410762] = true, -- The Silent Star (Voice of the Silent Star)
        [391594] = true, -- Lemon Silverleaf Tea

        -- Tier Set
        [426262] = true, -- Larodar's Fiery Reverie (Priest Discipline / Holy)
        [426341] = true, -- Tindral's Fowl Fantasia (Priest Shadow)
        [426288] = true, -- Smolderon's Delusions of Gradeour

        -- WoW Remix
        [424143] = true, -- WoW Remix: Mists of Pandaria
        [440393] = true, -- Timerunner's Advantage
        [459337] = true, -- Timerunner's Mastery

        --------------------------------------------------
        -- Patch 10.0.2
        --------------------------------------------------
        -- World Buffs
        [397734] = true, -- Word of a Worthy Ally

        -- Professions
        [394006] = true, -- Rockin' Mining Gear

        --------------------------------------------------
        -- Patch 10.1.5
        --------------------------------------------------
        -- World Buffs
        [417275] = true, -- Greater Encapsulated Destiny

        -- Rifts
        [415603] = true, -- Encapsulated Destiny

        --------------------------------------------------
        -- Patch 10.1.7
        --------------------------------------------------
        -- Dreamsourge
        [415216] = true, -- Dreamsurge Heartbloom
        [415275] = true, -- Dreamsurge Hibernation
        [416101] = true, -- Dreamsurge Dreamfall
        [418630] = true, -- Dreamsurge Thunderbounce
        [418652] = true, -- Dreamsurge Wrathbloom
        [418656] = true, -- Dreamsurge Magpies
        [418694] = true, -- Dreamsurge Helpers
        [418744] = true, -- Dreamsurge Learnings
        [418769] = true, -- Dreamsurge Greenwalker
        [418810] = true, -- Dreamsurge Lone Wolves
        [418813] = true, -- Self Sufficient
        [418842] = true, -- Dreamsurge Pack Hunters
        [419079] = true, -- Dreamsurge Defenders
        [419081] = true, -- Dreamsurge Defenders
        [419239] = true, -- Dreaming Winds
        [419530] = true, -- Dreamsurge Thorncloak
        [426647] = true, -- Best Friends with Pip
        [426672] = true, -- Best Friends with Urctos
        [426676] = true, -- Best Friends with Aerwynn

        --------------------------------------------------
        -- Patch 10.2.0
        --------------------------------------------------
        -- World Buffs
        [420511] = true, -- Going Green

        --------------------------------------------------
        -- Patch 10.2.6
        --------------------------------------------------
        -- World Buffs
        [430666] = true, -- Sign of Awakened Storms
        [430668] = true, -- Sign of Awakened Embers
        [430669] = true, -- Sign of Awakened Dreams
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Retail
--------------------------------------------------
if Filger.isRetail then
    local data = {
        -- Classes
        -- DEMONHUNTER
        [452550] = true, -- Monster Rising
        [453314] = true, -- Enduring Torment
        [1214887] = true, -- Cycle of Hatred

        -- EVOKER
        [369459] = true, -- Source of Magic
        [381753] = true, -- Blessing of the Bronze
        [372014] = true, -- Visage

        -- DRUID
        [400734] = true, -- After the Wildfire

        -- MAGE
        [1217242] = true, -- Enlightened

        -- MONK
        [383733] = true, -- Training of Niuzao
        [450552] = true, -- Jade Walk
        [450572] = true, -- Flow of Chi
        [450574] = true, -- Flow of Chi
        [443574] = true, -- Ox Stance
        [443575] = true, -- Tiger Stance
        [166646] = true, -- Windwalking
        [129914] = true, -- Combat Wisdom
        [450380] = true, -- Chi Wave

        -- PRIEST
        [21562] = true,   -- Power Word: Fortitude

        -- SHAMAN
        [462854] = true, -- Skyfury

        -- WARRIOR
        [386196] = true, -- Berserker Stance

        -- Mount
        [404464] = true, -- Flight Style: Skyriding
        [404468] = true, -- Flight Style: Steady
        [456820] = true, -- Ride Along

        -- Mythic+
        [206150] = true, -- Challenger's Might

        -- Items
        [447962] = true, -- Stance - Surekian Flourish
        [447978] = true, -- Stance - Surekian Decimation
        [448036] = true, -- Stance - Surekian Barrage
        [448433] = true, -- Surekian Grace
        [450696] = true, -- "The 50 Verses of Radiance" (Tome of Light's Devotion)
        [450699] = true, -- "The 50 Verses of Radiance" (Tome of Light's Devotion)
        [450706] = false, -- Inner Radiance (Tome of Light's Devotion)
        [450720] = true, -- Inner Radiance (Tome of Light's Devotion)
        [452226] = true, -- Spiderling (Ara-Kara Sacbrood)
        [457925] = true, -- Venomous Potential (Seal of the Poisoned Pact)
        [451369] = true, -- Empowering Darkness

        -- Costumes
        [452533] = true, -- Magical Mischief

        -- Warband
        [430191] = true, -- Warband Mentored Leveling

        -- Professions
        [442981] = true, -- Weaver's Tutelage
        [462810] = true, -- Weaver's Prodigy

        -- Factions
        [442983] = true, -- Vizier's Savvy
        [462806] = true, -- Vizier's Supremacy
        [440645] = true, -- Fire Flies
        [443248] = true, -- Azj-Kahet Pheromones
        [462821] = true, -- General's Bulwark

        -- Consumables
        ["Well Fed"] = true,
        ["Hearty Well Fed"] = true,
        [454188] = true, -- Hearty Well Fed
        [462180] = true, -- Hearty Well Fed
        [462181] = true, -- Hearty Well Fed
        [462182] = true, -- Hearty Well Fed
        [462183] = true, -- Hearty Well Fed
        [462184] = true, -- Hearty Well Fed
        [462185] = true, -- Hearty Well Fed
        [462186] = true, -- Hearty Well Fed
        [462187] = true, -- Hearty Well Fed
        [462188] = true, -- Hearty Well Fed
        [462189] = true, -- Hearty Well Fed
        [462190] = true, -- Hearty Well Fed
        [462191] = true, -- Hearty Well Fed
        [462192] = true, -- Hearty Well Fed
        [462193] = true, -- Hearty Well Fed
        [462194] = true, -- Hearty Well Fed
        [462195] = true, -- Hearty Well Fed
        [462196] = true, -- Hearty Well Fed
        [462197] = true, -- Hearty Well Fed
        [462198] = true, -- Hearty Well Fed
        [462199] = true, -- Hearty Well Fed
        [462200] = true, -- Hearty Well Fed
        [462201] = true, -- Hearty Well Fed
        [462202] = true, -- Hearty Well Fed
        [462203] = true, -- Hearty Well Fed
        [462204] = true, -- Hearty Well Fed
        [462205] = true, -- Hearty Well Fed
        [462206] = true, -- Hearty Well Fed
        [462207] = true, -- Hearty Well Fed
        [462208] = true, -- Hearty Well Fed
        [462209] = true, -- Hearty Well Fed
        [462210] = true, -- Hearty Well Fed

        [431971] = true, -- Flask of Tempered Aggression
        [431972] = true, -- Flask of Tempered Swiftness
        [431973] = true, -- Flask of Tempered Versatility
        [431974] = true, -- Flask of Tempered Mastery

        --------------------------------------------------
        -- Patch 11.0.0
        --------------------------------------------------
        -- Delves
        [423852] = true, -- Dormouse Ecila
        [448868] = true, -- Lucky Cursed Potion
        [459058] = true, -- Miniature
        [459059] = true, -- Massive
        [459254] = true, -- Loader Signal

        -- Professions
        [457674] = true, -- Duskthread Lining
        [457666] = true, -- Dawnthread Lining

        --------------------------------------------------
        -- Patch 11.0.2
        --------------------------------------------------
        -- World Buffs
        [471521] = true, -- Sign of the Explorer

        --------------------------------------------------
        -- Patch 11.0.5
        --------------------------------------------------
        -- World Buffs
        [452307] = true, -- Sign of the Past
        [455020] = true, -- WoW's Anniversary

        -- Events
        [455050] = true, -- Blessing of the Brozen Drgonflight

        -- Items
        [465642] = true, -- Blizzard Bling

        --------------------------------------------------
        -- Patch 11.0.7
        --------------------------------------------------
        -- Items
        [1215495] = true, -- Cyrce's Circlet

        --------------------------------------------------
        -- Patch 11.1.5
        --------------------------------------------------
        -- World Buffs
        [1214848] = true, -- Winds of Mysterious Fortune
        [1227124] = true, -- Sacred Flame's Ward

        -- Horric Visions
        [472265] = true, -- Vision Hunter
        [472266] = true, -- Vision Hunter
        [472267] = true, -- Vision Hunter
        [472261] = true, -- Experimental Destabilization
        [472263] = true, -- Experimental Destabilization
        [472264] = true, -- Experimental Destabilization
        [1215082] = true, -- Experimental Destabilization
        [471497] = true, -- Singular Sanitation Expertise
        [472160] = true, -- Singular Sanitation Expertise
        [472152] = true, -- Singular Sanitation Expertise
        [472238] = true, -- Clear Sight
        [472248] = true, -- Clear Sight
        [472246] = true, -- Clear Sight
        [472241] = true, -- Elite Extermination
        [1215782] = true, -- Elite Extermination
        [1215783] = true, -- Elite Extermination
        [471317] = true, -- Steeled Mind
        [471318] = true, -- Steeled Mind
        [471320] = true, -- Steeled Mind
        [471321] = true, -- Steeled Mind
        [471322] = true, -- Steeled Mind
        [1216153] = true, -- Steeled Mind
        [1221899] = true, -- Tattered Wold Rider Gear

        --------------------------------------------------
        -- Patch 11.1.7
        --------------------------------------------------
        -- World Buffs
        [1223878] = true, -- Sign of Azeroth
        
        [1250683] = true, -- Collector's Bounty
        [1250685] = true, -- Greedy Emisarry

        [1229050] = true, -- Mastery of Timeways
        [1220736] = true, -- Mysterious Revivification
        [1218497] = true, -- Mysterious Tenacity
        [1218388] = true, -- Mysterious Celerity
        [1218454] = true, -- Mysterious Swiftstrike

        --------------------------------------------------
        -- Patch 11.2.0
        --------------------------------------------------
        [1244018] = true, -- Tazavesh, the Vailed Market, Hard Mode
        [1246366] = true, -- Stree Smart

        --------------------------------------------------
        -- Legion Remix
        --------------------------------------------------
        [1232454] = true, -- Initife Power
        [1238465] = true, -- Heroic World Tier
        [1213439] = true, -- WoW Remix: Legion

        [440361] = true, -- Timeless Scroll of the Wild
        
    }

    import(data, blacklist)
end

Filger.blacklist = blacklist
