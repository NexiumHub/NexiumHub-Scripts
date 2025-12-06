-- Remember:-- LocalScript in StarterGui -> ScreenGui

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local playerGui = player.PlayerGui
local Players = game:GetService("Players")

-- ===============================================
-- 1. Setup & Constants
-- ===============================================

-- LOAD EXTERNAL NOTIFICATION LIBRARY (Wrapped in pcall for robustness)
local NotificationLibrary = nil
local success, lib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/Main/Library.lua"))()
end)

if success then
    NotificationLibrary = lib
else
    warn("Failed to load NotificationLibrary:", lib)
end

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NexiumHubGamesMini"
screenGui.Parent = playerGui

local GUI_WIDTH = 380
local GUI_HEIGHT = 280
local ITEM_HEIGHT = 25
local PADDING = 6


-- ===============================================
-- 2. Data & Formatting Functions
-- ===============================================

-- Master List of ALL scripts (Formatted automatically below)
local rawScriptData = {
    -[span_1](start_span)- Scripts from All List.txt[span_1](end_span)
    {name = "99NightsintheBunker", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/99NightsintheBunker"))()'},
    {name = "99NightsintheWildWest", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/99NightsintheWildWest"))()'},
    {name = "AdoptMeEvent", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AdoptMeEvent"))()'},
    {name = "AnimalTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimalTraining"))()'},
    {name = "AnimeCardMaster", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeCardMaster"))()'},
    {name = "AnimeCombats", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeCombats"))()'},
    {name = "AnimeRNGTD", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeRNGTD"))()'},
    {name = "AnimeRails", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeRails"))()'},
    {name = "AnimeRangersX", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeRangersX"))()'},
    {name = "AnimeSaga", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeSaga"))()'},
    {name = "AnimeSimulator", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeSimulator"))()'},
    {name = "AnimeSlashing", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeSlashing"))()'},
    {name = "AnimeStrike", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AnimeStrike"))()'},
    {name = "AquaRacer", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AquaRacer"))()'},
    {name = "AriseCrossover", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/AriseCrossover"))()'},
    {name = "ArrestBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ArrestBrainrot"))()'},
    {name = "BattleforBrainrots", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BattleforBrainrots"))()'},
    {name = "Bayside", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Bayside"))()'},
    {name = "BeNPCorDIE", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeNPCorDIE"))()'},
    {name = "BeaBeggar", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeaBeggar"))()'},
    {name = "BeaCar", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeaCar"))()'},
    {name = "BeaNinja", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeaNinja"))()'},
    {name = "BeaSillySeal", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeaSillySeal"))()'},
    {name = "Beaks", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Beaks"))()'},
    {name = "BeastGames", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeastGames"))()'},
    {name = "Beastify", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Beastify"))()'},
    {name = "BeeRich", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeeRich"))()'},
    {name = "BladeLeague", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BladeLeague"))()'},
    {name = "BloodofPunch", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BloodofPunch"))()'},
    {name = "BloxFruitButGood", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BloxFruitButGood"))()'},
    {name = "BloxLoot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BloxLoot"))()'},
    {name = "BlueLock", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BlueLock"))()'},
    {name = "BombtoMine", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BombtoMine"))()'},
    {name = "BoxingBattles", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BoxingBattles"))()'},
    {name = "Boxingfitness", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Boxingfitness"))()'},
    {name = "BrainrotBattlegrounds", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotBattlegrounds"))()'},
    {name = "BrainrotEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotEvolution"))()'},
    {name = "BrainrotGarden", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotGarden"))()'},
    {name = "BrainrotRoyale", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotRoyale"))()'},
    {name = "BrainrotSlayers", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotSlayers"))()'},
    {name = "BrainrotSlingshot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotSlingshot"))()'},
    {name = "BrainrotTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotTraining"))()'},
    {name = "BrainrotZombie", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotZombie"))()'},
    {name = "BrainrotZombieTower", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrainrotZombieTower"))()'},
    {name = "BreakBrainrotBones", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BreakBrainrotBones"))()'},
    {name = "BreakaFriend", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BreakaFriend"))()'},
    {name = "BreakyourBones", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BreakyourBones"))()'},
    {name = "Breedingranch", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Breedingranch"))()'},
    {name = "BridgeBattles", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BridgeBattles"))()'},
    {name = "BrookhavenHalloween", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BrookhavenHalloween"))()'},
    {name = "BubbleGumJumping", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BubbleGumJumping"))()'},
    {name = "BuildACart", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildACart"))()'},
    {name = "BuildAMiningMachine", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildAMiningMachine"))()'},
    {name = "BuildAPlane", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildAPlane"))()'},
    {name = "BuildAnObby", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildAnObby"))()'},
    {name = "BuildCarZombies", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildCarZombies"))()'},
    {name = "BuildFightSteal", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildFightSteal"))()'},
    {name = "BuildMyCar", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildMyCar"))()'},
    {name = "BuildToClimb", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildToClimb"))()'},
    {name = "BuildaBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildaBrainrot"))()'},
    {name = "BuildaCannon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildaCannon"))()'},
    {name = "BuildaCar", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildaCar"))()'},
    {name = "BuildaScamEmpire", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildaScamEmpire"))()'},
    {name = "BuildaStore", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildaStore"))()'},
    {name = "BuildaTractor", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildaTractor"))()'},
    {name = "BuildandSurvivetheForest", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildandSurvivetheForest"))()'},
    {name = "Buildur99NightsBase", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Buildur99NightsBase"))()'},
    {name = "BuildyourEscape", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BuildyourEscape"))()'},
    {name = "BulletCart", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BulletCart"))()'},
    {name = "CapybaraEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CapybaraEvolution"))()'},
    {name = "CarDealershipCOPS", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipCOPS"))()'},
    {name = "CarDealershipCarEvent", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipCarEvent"))()'},
    {name = "CarDealershipEaster", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipEaster"))()'},
    {name = "CarDealershipEvent", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipEvent"))()'},
    {name = "CarDealershipHUNT", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipHUNT"))()'},
    {name = "CarDealershipHalloween", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipHalloween"))()'},
    {name = "CarDealershipPagani", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipPagani"))()'},
    {name = "CarDealershipPolice", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipPolice"))()'},
    {name = "CarDealershipSEASON", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarDealershipSEASON"))()'},
    {name = "CarTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarTraining"))()'},
    {name = "CarsvsTrucks", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CarsvsTrucks"))()'},
    {name = "CatchaMonster", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CatchaMonster"))()'},
    {name = "Chained", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Chained"))()'},
    {name = "ClassClash", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ClassClash"))()'},
    {name = "CleanaHouse", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CleanaHouse"))()'},
    {name = "ClimbandJump", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ClimbandJump"))()'},
    {name = "ClimbandSlide", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ClimbandSlide"))()'},
    {name = "ClimbtoSaveBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ClimbtoSaveBrainrot"))()'},
    {name = "CollectforUGC", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CollectforUGC"))()'},
    {name = "CoolaBaddie", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CoolaBaddie"))()'},
    {name = "CrashBots", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CrashBots"))()'},
    {name = "CreateaFactory", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CreateaFactory"))()'},
    {name = "CriminalTycoon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CriminalTycoon"))()'},
    {name = "CutGrass", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CutGrass"))()'},
    {name = "CutTrees", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/CutTrees"))()'},
    {name = "DUMP", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DUMP"))()'},
    {name = "DalgonaTycoon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DalgonaTycoon"))()'},
    {name = "DanceForUGC", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DanceForUGC"))()'},
    {name = "Dandy", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Dandy"))()'},
    {name = "DeadDefense", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadDefense"))()'},
    {name = "DeadOcean", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadOcean"))()'},
    {name = "DeadRails", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadRails"))()'},
    {name = "DeadRailsAuto", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadRailsAuto"))()'},
    {name = "DeadRivers", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadRivers"))()'},
    {name = "DeadSails", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadSails"))()'},
    {name = "DeadSpells", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadSpells"))()'},
    {name = "DeadlyDelivery", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadlyDelivery"))()'},
    {name = "DemonBlade", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DemonBlade"))()'},
    {name = "DemonWarriors", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DemonWarriors"))()'},
    {name = "Demonfall", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Demonfall"))()'},
    {name = "DesertDetectors", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DesertDetectors"))()'},
    {name = "DigGrandmasBackyard", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DigGrandmasBackyard"))()'},
    {name = "DigandHatchaBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DigandHatchaBrainrot"))()'},
    {name = "Digit", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Digit"))()'},
    {name = "DigtheBackyard", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DigtheBackyard"))()'},
    {name = "DigtoEarth", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DigtoEarth"))()'},
    {name = "DigtoEscape", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DigtoEscape"))()'},
    {name = "DigtoSaveBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DigtoSaveBrainrot"))()'},
    {name = "DogMan", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DogMan"))()'},
    {name = "DontStealthe99Nights", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DontStealthe99Nights"))()'},
    {name = "DontStealtheLabubu", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DontStealtheLabubu"))()'},
    {name = "DontWakeTheFish", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DontWakeTheFish"))()'},
    {name = "DontWaketheBrainrots", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DontWaketheBrainrots"))()'},
    {name = "DontWaketheSpookyBrainrots", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DontWaketheSpookyBrainrots"))()'},
    {name = "DragonTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DragonTraining"))()'},
    {name = "DrillDigging", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DrillDigging"))()'},
    {name = "DriveWorld", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DriveWorld"))()'},
    {name = "DrivingEmpireLEGO", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DrivingEmpireLEGO"))()'},
    {name = "DropaPoop", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DropaPoop"))()'},
    {name = "DungeonHeroes", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DungeonHeroes"))()'},
    {name = "DungeonLeveling", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DungeonLeveling"))()'},
    {name = "EatBrainrotforfight", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EatBrainrotforfight"))()'},
    {name = "EattheWorld", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EattheWorld"))()'},
    {name = "Edward", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Edward"))()'},
    {name = "ElementalPowers", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ElementalPowers"))()'},
    {name = "EpicMinigames", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EpicMinigames"))()'},
    {name = "EscapeAndSurviveHead", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeAndSurviveHead"))()'},
    {name = "EvadeEvent", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EvadeEvent"))()'},
    {name = "EvolvetoSupreme", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EvolvetoSupreme"))()'},
    {name = "FREEUGCOBBY", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FREEUGCOBBY"))()'},
    {name = "FightinaSupermarket", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FightinaSupermarket"))()'},
    {name = "FindtheBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FindtheBrainrot"))()'},
    {name = "FischModded", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FischModded"))()'},
    {name = "FishGo", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FishGo"))()'},
    {name = "FishTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FishTraining"))()'},
    {name = "FishaBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FishaBrainrot"))()'},
    {name = "FlyingWings", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FlyingWings"))()'},
    {name = "FlytoSPACE", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/FlytoSPACE"))()'},
    {name = "Forkthefish", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Forkthefish"))()'},
    {name = "GOFISHING", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GOFISHING"))()'},
    {name = "GardenTowerDefense", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GardenTowerDefense"))()'},
    {name = "Givenchy", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Givenchy"))()'},
    {name = "GlassBridge2", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GlassBridge2"))()'},
    {name = "GoKartTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GoKartTraining"))()'},
    {name = "GoalKick", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GoalKick"))()'},
    {name = "GrabBattles", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrabBattles"))()'},
    {name = "GrowAKingdom", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowAKingdom"))()'},
    {name = "GrowCrystals", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowCrystals"))()'},
    {name = "GrowEggs", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowEggs"))()'},
    {name = "GrowaBusiness", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowaBusiness"))()'},
    {name = "GrowaGarden", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowaGarden"))()'},
    {name = "GrowaTree", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowaTree"))()'},
    {name = "GuesstheKiller", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GuesstheKiller"))()'},
    {name = "GunfightArena", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GunfightArena"))()'},
    {name = "GymTrackRace", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GymTrackRace"))()'},
    {name = "HatchaDuck", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HatchaDuck"))()'},
    {name = "HireaFisher", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HireaFisher"))()'},
    {name = "HomelessSimulator", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HomelessSimulator"))()'},
    {name = "HorseRace", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HorseRace"))()'},
    {name = "HorseValley", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HorseValley"))()'},
    {name = "Hunters", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Hunters"))()'},
    {name = "HuntyZombie", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/HuntyZombie"))()'},
    {name = "Hyundai", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Hyundai"))()'},
    {name = "InfectionGunfight", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/InfectionGunfight"))()'},
    {name = "InkGame", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/InkGame"))()'},
    {name = "ItalianBrainrotThieves", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ItalianBrainrotThieves"))()'},
    {name = "JackAndJill", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/JackAndJill"))()'},
    {name = "JetpackTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/JetpackTraining"))()'},
    {name = "Jujutsu", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Jujutsu"))()'},
    {name = "JumpInTheHole", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/JumpInTheHole"))()'},
    {name = "JumpandSplash", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/JumpandSplash"))()'},
    {name = "JumpwithBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/JumpwithBrainrot"))()'},
    {name = "KIDZBOP", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KIDZBOP"))()'},
    {name = "KPOPSPEED", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KPOPSPEED"))()'},
    {name = "KayakRacing", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KayakRacing"))()'},
    {name = "KayakandSurf", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KayakandSurf"))()'},
    {name = "Keys", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Keys"))()'},
    {name = "KeysandKnives", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KeysandKnives"))()'},
    {name = "Kingdom", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Kingdom"))()'},
    {name = "Lancome", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Lancome"))()'},
    {name = "LastRun", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/LastRun"))()'},
    {name = "LiftEverything", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/LiftEverything"))()'},
    {name = "LightGame", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/LightGame"))()'},
    {name = "LittlestPet", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/LittlestPet"))()'},
    {name = "Logitech", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Logitech"))()'},
    {name = "Lootify", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Lootify"))()'},
    {name = "MINGLE", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MINGLE"))()'},
    {name = "MONSTERMETRO", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MONSTERMETRO"))()'},
    {name = "MakeWeapons", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MakeWeapons"))()'},
    {name = "MakeaArmy", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MakeaArmy"))()'},
    {name = "MakeaBoat", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MakeaBoat"))()'},
    {name = "MathMurder", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MathMurder"))()'},
    {name = "MemeFruits", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MemeFruits"))()'},
    {name = "MemoryMurder", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MemoryMurder"))()'},
    {name = "MergeBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MergeBrainrot"))()'},
    {name = "MergeTowerDefense", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MergeTowerDefense"))()'},
    {name = "MergeandFight", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MergeandFight"))()'},
    {name = "MergeforSPEED", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MergeforSPEED"))()'},
    {name = "MetroLife", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MetroLife"))()'},
    {name = "MindsFall", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MindsFall"))()'},
    {name = "Mines", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Mines"))()'},
    {name = "MonsterEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MonsterEvolution"))()'},
    {name = "MotorcycleRacing", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MotorcycleRacing"))()'},
    {name = "MyBrainrotEggFarm", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MyBrainrotEggFarm"))()'},
    {name = "MyBrainrotRestaurant", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MyBrainrotRestaurant"))()'},
    {name = "MyFishingPier", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MyFishingPier"))()'},
    {name = "MyPlanetTycoon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MyPlanetTycoon"))()'},
    {name = "MySingingBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/MySingingBrainrot"))()'},
    {name = "NPO", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NPO"))()'},
    {name = "NavyTycoon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NavyTycoon"))()'},
    {name = "NetflixCPPB", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NetflixCPPB"))()'},
    {name = "NetflixCobraKai", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NetflixCobraKai"))()'},
    {name = "NetflixSquid", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NetflixSquid"))()'},
    {name = "NetflixXO", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NetflixXO"))()'},
    {name = "NinjaTime", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NinjaTime"))()'},
    {name = "NinjaTycoon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NinjaTycoon"))()'},
    {name = "NoobDefense", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NoobDefense"))()'},
    {name = "NoobMergeArmy", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/NoobMergeArmy"))()'},
    {name = "ONEBLOCK", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ONEBLOCK"))()'},
    {name = "ObbyBike", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ObbyBike"))()'},
    {name = "ObbyOtter", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ObbyOtter"))()'},
    {name = "OldToiletTD", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/OldToiletTD"))()'},
    {name = "OnePunchTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/OnePunchTraining"))()'},
    {name = "PSGObby", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PSGObby"))()'},
    {name = "PaddleRush", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PaddleRush"))()'},
    {name = "PaperPlane", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PaperPlane"))()'},
    {name = "PeakEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PeakEvolution"))()'},
    {name = "PetMine", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PetMine"))()'},
    {name = "PetSimCannon", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PetSimCannon"))()'},
    {name = "PetSimGames", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PetSimGames"))()'},
    {name = "PetSimSquid", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PetSimSquid"))()'},
    {name = "PixelBlade", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PixelBlade"))()'},
    {name = "PlaneTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PlaneTraining"))()'},
    {name = "PlantEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PlantEvolution"))()'},
    {name = "PlantsVsBrainrots", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PlantsVsBrainrots"))()'},
    {name = "PrisonPump", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PrisonPump"))()'},
    {name = "Prospecting", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Prospecting"))()'},
    {name = "ProtectTheHouseFromMonsters", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ProtectTheHouseFromMonsters"))()'},
    {name = "ProtectaFriend", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ProtectaFriend"))()'},
    {name = "PullaSword", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PullaSword"))()'},
    {name = "PunchWall", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PunchWall"))()'},
    {name = "PushandSlide", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/PushandSlide"))()'},
    {name = "RaceClicker", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RaceClicker"))()'},
    {name = "RaceRNG", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RaceRNG"))()'},
    {name = "RaiseaFarm", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RaiseaFarm"))()'},
    {name = "RebornAsSword", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RebornAsSword"))()'},
    {name = "RescueAnimals", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RescueAnimals"))()'},
    {name = "RideandSlide", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RideandSlide"))()'},
    {name = "RobotEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RobotEvolution"))()'},
    {name = "RockFruit", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RockFruit"))()'},
    {name = "RollerTraining", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/RollerTraining"))()'},
    {name = "SMASHaTower", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SMASHaTower"))()'},
    {name = "SOURPATCH", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SOURPATCH"))()'},
    {name = "STEALCOOKIES", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/STEALCOOKIES"))()'},
    {name = "Seasouls", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Seasouls"))()'},
    {name = "SecretAgent", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SecretAgent"))()'},
    {name = "SecretVillage", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SecretVillage"))()'},
    {name = "Shed", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Shed"))()'},
    {name = "ShootTheBrains", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ShootTheBrains"))()'},
    {name = "ShootaBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ShootaBrainrot"))()'},
    {name = "Shrek", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Shrek"))()'},
    {name = "SinkTheShip", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SinkTheShip"))()'},
    {name = "SlitherBlox", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SlitherBlox"))()'},
    {name = "SnailRace", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SnailRace"))()'},
    {name = "SnowBall", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SnowBall"))()'},
    {name = "SoccerSimulator", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SoccerSimulator"))()'},
    {name = "SortTheBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SortTheBrainrot"))()'},
    {name = "SpeedForEggs", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedForEggs"))()'},
    {name = "SpeedForStep", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedForStep"))()'},
    {name = "SpeedGunfight", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedGunfight"))()'},
    {name = "SpeedJump", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedJump"))()'},
    {name = "SpeedMerge", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedMerge"))()'},
    {name = "SpeedObby", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedObby"))()'},
    {name = "SpeedPrisonEscape", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpeedPrisonEscape"))()'},
    {name = "SpinaBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SpinaBrainrot"))()'},
    {name = "SprunbieRail", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SprunbieRail"))()'},
    {name = "SquidEvolution", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SquidEvolution"))()'},
    {name = "SquidGame", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SquidGame"))()'},
    {name = "SquidGame3", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SquidGame3"))()'},
    {name = "SquidGameX", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SquidGameX"))()'},
    {name = "Steal99Nights", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Steal99Nights"))()'},
    {name = "StealADeadRails", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealADeadRails"))()'},
    {name = "StealAFish", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealAFish"))()'},
    {name = "StealAFruit", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealAFruit"))()'},
    {name = "StealBloxFruit", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealBloxFruit"))()'},
    {name = "StealBrainrotMOD", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealBrainrotMOD"))()'},
    {name = "StealFruits", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealFruits"))()'},
    {name = "StealaBaddie", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaBaddie"))()'},
    {name = "StealaBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaBrainrot"))()'},
    {name = "StealaBrainrotMOD", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaBrainrotMOD"))()'},
    {name = "StealaCapybara", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaCapybara"))()'},
    {name = "StealaCar", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaCar"))()'},
    {name = "StealaCharacter", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaCharacter"))()'},
    {name = "StealaCountry", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaCountry"))()'},
    {name = "StealaFreddy", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaFreddy"))()'},
    {name = "StealaGarden", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaGarden"))()'},
    {name = "StealaGubby", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaGubby"))()'},
    {name = "StealaLabubu", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaLabubu"))()'},
    {name = "StealaPet", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaPet"))()'},
    {name = "StealaPlane", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaPlane"))()'},
    {name = "StealaTruck", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaTruck"))()'},
    {name = "Stealall", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Stealall"))()'},
    {name = "StealandEat", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealandEat"))()'},
    {name = "StealtheBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealtheBrainrot"))()'},
    {name = "StealtheDough", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealtheDough"))()'},
    {name = "StealtheFish", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealtheFish"))()'},
    {name = "StealthePets", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealthePets"))()'},
    {name = "StealtheUGC", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealtheUGC"))()'},
    {name = "StealtheVillain", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealtheVillain"))()'},
    {name = "StomachAche", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StomachAche"))()'},
    {name = "StrongmanSim", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StrongmanSim"))()'},
    {name = "SuperHeroFight", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SuperHeroFight"))()'},
    {name = "SuperSavage", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SuperSavage"))()'},
    {name = "SurviveOnPlane", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveOnPlane"))()'},
    {name = "SurviveTheBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveTheBrainrot"))()'},
    {name = "SurviveTheTsunami", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveTheTsunami"))()'},
    {name = "SurviveTheWave", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveTheWave"))()'},
    {name = "SurviveonaRaft", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveonaRaft"))()'},
    {name = "SurviveWaveZ", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveWaveZ"))()'},
    {name = "SwimtoSavePrincess", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SwimtoSavePrincess"))()'},
    {name = "SwordFishing", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SwordFishing"))()'},
    {name = "TBSEscape", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TBSEscape"))()'},
    {name = "TankWar", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TankWar"))()'},
    {name = "TapAll", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TapAll"))()'},
    {name = "TapToEarn", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TapToEarn"))()'},
    {name = "TheGreatEscape", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TheGreatEscape"))()'},
    {name = "TheKill", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TheKill"))()'},
    {name = "TheStrongest", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TheStrongest"))()'},
    {name = "TowerOfHell", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TowerOfHell"))()'},
    {name = "TowerWarfare", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TowerWarfare"))()'},
    {name = "TradeUp", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TradeUp"))()'},
    {name = "TrainAndBattle", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TrainAndBattle"))()'},
    {name = "TrainYourBrainrot", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TrainYourBrainrot"))()'},
    {name = "TrainYourDog", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TrainYourDog"))()'},
    {name = "TreasureHunter", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TreasureHunter"))()'},
    {name = "Treadmill", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Treadmill"))()'},
    {name = "TryNotToFall", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/TryNotToFall"))()'},
    {name = "UltimateBaseball", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/UltimateBaseball"))()'},
    {name = "UnboxRandom", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/UnboxRandom"))()'},
    {name = "Unboxing", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Unboxing"))()'},
    {name = "Unstoppable", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/Unstoppable"))()'},
    {name = "WashingSimulator", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/WashingSimulator"))()'},
    {name = "WaveBattle", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/WaveBattle"))()'},
    {name = "WestGunfight", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/WestGunfight"))()'},
    {name = "WestTower", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/WestTower"))()'},
    {name = "WizardWest", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/WizardWest"))()'},
    {name = "WonderChase", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/WonderChase"))()'},
    {name = "YardSale", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/YardSale"))()'},
    {name = "YeetAFriend", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/YeetAFriend"))()'},
    {name = "YourBank", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/YourBank"))()'},
    {name = "adustytrip", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/adustytrip"))()'},
    {name = "bladebattle", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/bladebattle"))()'},
    {name = "buildurbase", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/buildurbase"))()'},
    {name = "elfScientist", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/elfScientist"))()'},
    {name = "elfUP", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/elfUP"))()'},
    -- Unique Scripts from previous step (not in All List.txt from gumanba)
    {name = "Fish It 1", command = 'loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/ecd9069dab3d2aa3"))()'},
    {name = "Flick 1", command = 'loadstring(game:HttpGet("https://apigetunx.vercel.app/UNX.lua",true))()'},
    {name = "ROBLOX Purchase Exploits 1", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua"))()'},
    {name = "Violence District 1", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/arcadeisreal/717exe_Violence_District/refs/heads/main/loader.lua"))()'},
    {name = "Violence District 2", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/skidma/solarae/refs/heads/main/vd.lua"))()'},
    {name = "Pixel Quest 1", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/darkhub99/pixelquest/refs/heads/main/obfuscated_script-1762689711545.lua.txt"))()'},
    {name = "Bake Or Die 1", command = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Bake-or-Die-Kill-All-Bring-Items-Esp-etc-68463"))()'},
    {name = "Deadly Delivery 2", command = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/VGXMODPLAYER68/Vgxmod-Hub/refs/heads/main/Deadly%20delivery.lua"))()'},
}

-- Function to automatically add spaces to concatenated names like 'BuildAMiningMachine'
local function formatName(name)
    -- Add space between lowercase and uppercase (e.g., 'forBrainrots' -> 'for Brainrots')
    local formatted = name:gsub("([a-z])([A-Z])", "%1 %2")
    
    -- Add space between a digit and a letter (e.g., '99Nights' -> '99 Nights', 'SquidGame3' -> 'SquidGame 3')
    formatted = formatted:gsub("([a-zA-Z])(%d)", "%1 %2")
    formatted = formatted:gsub("(%d)([a-zA-Z])", "%1 %2")

    -- Clean up multiple spaces and trim
    formatted = formatted:gsub(" +", " "):match("^%s*(.-)%s*$")
    
    return formatted
end

local scriptData = {}

-- 3. Process the raw data and apply formatting
for _, data in ipairs(rawScriptData) do
    -- Only format if the name doesn't already contain a space (for the manual entries)
    local finalName = data.name:find(" ") and data.name or formatName(data.name)
    table.insert(scriptData, {
        name = finalName,
        command = data.command
    })
end

-- Sorting function to ensure version numbers sort correctly (e.g., Game 1 before Game 10)
local function extractBaseNameAndNumber(name)
    -- Match name followed by space and digits
    local base, numStr = name:match("^(.*) (%d+)$")
    if base and numStr then
        return base, tonumber(numStr)
    end
    return name, 0 -- If no number is found, return the full name and 0
end

local function customSortScripts(a, b)
    local baseA, numA = extractBaseNameAndNumber(a.name)
    local baseB, numB = extractBaseNameAndNumber(b.name)

    if baseA == baseB then
        -- Bases are the same, sort numerically
        return numA < numB
    else
        -- Bases are different, sort alphabetically
        return baseA < baseB
    end
end

-- Sort the final list
table.sort(scriptData, customSortScripts)


-- ===============================================
-- 4. Main GUI Frame & Elements
-- ===============================================

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, GUI_WIDTH, 0, GUI_HEIGHT)
mainFrame.Position = UDim2.new(0.5, -GUI_WIDTH/2, 0.5, -GUI_HEIGHT/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 1
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

-- Close Button (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20 - PADDING, 0, PADDING)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

-- Restore button (movable)
local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 100, 0, 25)
restoreButton.Position = UDim2.new(0.5, -50, 0, 10)
restoreButton.Text = "Nexium Hub"
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 14
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
restoreButton.BorderSizePixel = 0
restoreButton.Visible = false
restoreButton.Parent = screenGui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 5)
restoreCorner.Parent = restoreButton

-- Close & Restore behavior:
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    restoreButton.Visible = true
end)

restoreButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    restoreButton.Visible = false
end)

-- ===============================================
-- 5. Drag Functionality
-- ===============================================

local function makeFrameDraggable(frame)
    local dragging = false
    local dragInput
    local dragOffset = Vector2.new(0, 0)

    local function update(input)
        local delta = input.Position - dragOffset
        frame.Position = UDim2.new(
            0,
            frame.Position.X.Offset + delta.X,
            0,
            frame.Position.Y.Offset + delta.Y
        )
        dragOffset = input.Position
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragOffset = input.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Apply the drag function to the main frames
makeFrameDraggable(mainFrame)
makeFrameDraggable(restoreButton)

-- ===============================================
-- 6. GUI Content and Items
-- ===============================================
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -closeButton.Size.X.Offset - PADDING, 0, 20)
titleLabel.Position = UDim2.new(0, PADDING, 0, PADDING)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "NexiumHub Scripts"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = mainFrame

-- Search box
local searchBox = Instance.new("TextBox")
local searchBoxY = titleLabel.Position.Y.Offset + titleLabel.Size.Y.Offset + PADDING
searchBox.Size = UDim2.new(1, -PADDING * 2, 0, 20)
searchBox.Position = UDim2.new(0, PADDING, 0, searchBoxY)
searchBox.PlaceholderText = "Search games (" .. #scriptData .. " available)..."
searchBox.Text = ""
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 12
searchBox.BorderSizePixel = 0
searchBox.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 5)
searchCorner.Parent = searchBox

-- Scrolling frame
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -PADDING * 2, 1, -(searchBoxY + searchBox.Size.Y.Offset + PADDING * 2))
scrollingFrame.Position = UDim2.new(0, PADDING, 0, searchBoxY + searchBox.Size.Y.Offset + PADDING)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 4
scrollingFrame.Parent = mainFrame
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local framePadding = Instance.new("UIPadding")
framePadding.PaddingLeft = UDim.new(0, 2)
framePadding.PaddingRight = UDim.new(0, 2)
framePadding.PaddingTop = UDim.new(0, 2)
framePadding.PaddingBottom = UDim.new(0, 2)
framePadding.Parent = scrollingFrame

local gridLayout = Instance.new("UIGridLayout")
gridLayout.Parent = scrollingFrame
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.CellSize = UDim2.new(0.49, 0, 0, ITEM_HEIGHT) 
gridLayout.CellPadding = UDim2.new(0.005, 0, 0.005, 0)
gridLayout.FillDirectionMaxCells = 2

local uiItems = {}

-- Function to create a standard button item
local function createButton(data, layoutOrder)
    local name = data.name
    local command = data.command
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, ITEM_HEIGHT)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    
    btn.LayoutOrder = layoutOrder 
    
    btn.TextScaled = true 
    btn.Text = name
    btn.TextWrapped = true
    btn.TextXAlignment = Enum.TextXAlignment.Center 
    btn.TextYAlignment = Enum.TextYAlignment.Center
    
    local textConstraint = Instance.new("UITextSizeConstraint")
    textConstraint.MaxTextSize = 14
    textConstraint.Parent = btn

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 3)
    uiPadding.PaddingRight = UDim.new(0, 3)
    uiPadding.Parent = btn

    btn.BorderSizePixel = 0
    btn.Parent = scrollingFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn

    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(100, 100, 100)
    border.Thickness = 1
    border.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(75, 75, 75)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        if NotificationLibrary then
            NotificationLibrary:SendNotification("Success", "Executed " .. name, 1.5)
        end
        
        local success, result = pcall(function()
            local compiled, err = loadstring(command)
            
            if compiled then
                compiled()
            else
                if NotificationLibrary then
                    NotificationLibrary:SendNotification("Error", "Error compiling: " .. name, 3)
                end
                warn("Failed to load/compile script:", name, err)
            end
        end)
        
        if not success then
            if NotificationLibrary then
                NotificationLibrary:SendNotification("Error", "Execution failed for: " .. name, 3)
            end
            warn("Critical error during pcall execution:", name, result)
        end
    end)

    table.insert(uiItems, {name = name, button = btn})
end

-- Generate all items using the custom sorted scriptData
for i, data in ipairs(scriptData) do
    createButton(data, i)
end

-- ===============================================
-- 7. Search filter
-- ===============================================
local function updateFilter(query)
    query = query:lower()
    for i, obj in ipairs(uiItems) do
        obj.button.Visible = obj.name:lower():find(query) ~= nil
    end
    -- Must call ApplyLayout after changing visibility for the Grid to adjust
    gridLayout:ApplyLayout()
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateFilter(searchBox.Text)
end)

-- Initial population of the grid
updateFilter("")
