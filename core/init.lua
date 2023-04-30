local addon, ns = ...
local LibStub = LibStub

-- Blizzard
local GetAddOnMetadata, GetRealmName = GetAddOnMetadata, GetRealmName
local UnitClass, UnitName, UnitLevel, UnitRace, UnitFactionGroup = UnitClass, UnitName, UnitLevel, UnitRace, UnitFactionGroup
local Interface = select(4, GetBuildInfo())

ns.Filger = CreateFrame("Frame", "Filger", UIParent)
ns.Config = {}
ns.SpellList = {}
ns.BlackList = {}
ns.Cooldowns = {}

function ns:unpack()
	return self[1], self[2], self[3], self[4]
end

-- Interface
ns.Filger.Interface = Interface
ns.Filger.isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
ns.Filger.isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
ns.Filger.isTBC = (Interface >= 20000 and Interface < 30000)
ns.Filger.isWOTLK = (Interface >= 30000 and Interface < 40000)
ns.Filger.isCataclysm = (Interface >= 40000 and Interface < 50000)
ns.Filger.isMoP = (Interface >= 50000 and Interface < 60000)
ns.Filger.isWoD = (Interface >= 60000 and Interface < 70000)
ns.Filger.isLegion = (Interface >= 70000 and Interface < 80000)
ns.Filger.isBFA = (Interface >= 80000 and Interface < 90000)
ns.Filger.isShadowlands = (Interface >= 90000 and Interface < 100000)
ns.Filger.isDragonflight = (Interface >= 100000 and Interface < 110000)

-- Addon
ns.Filger.Title = GetAddOnMetadata(addon, 'Title')
ns.Filger.Version = GetAddOnMetadata(addon, 'Version')
ns.Filger.VersionNumber = tonumber(ns.Filger.Version)
ns.Filger.Description = GetAddOnMetadata(addon, 'Notes')
ns.Filger.WelcomeMessage = string.format("|cffb3ff19Filger %s|r - /filger help", ns.Filger.VersionNumber)

-- Character
ns.Filger.MyName = UnitName("player")
ns.Filger.MyClass = select(2, UnitClass("player"))
ns.Filger.MyLevel = UnitLevel("player")
ns.Filger.MyFaction = select(2, UnitFactionGroup("player"))
ns.Filger.MyRace = select(2, UnitRace("player"))
ns.Filger.MyRealm = GetRealmName()
ns.Filger.Dummy = function() end

if (ns.Filger.isClassic) then
	local LibClassicDurations = LibStub("LibClassicDurations", true)
	if (LibClassicDurations) then
		LibClassicDurations:Register("Filger")
		ns.Filger.LibClassicDurations = LibClassicDurations
	end
end
