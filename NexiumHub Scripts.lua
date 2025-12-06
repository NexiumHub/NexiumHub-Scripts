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

-- URL constant for the majority of scripts
local BASE_URL = "https://raw.githubusercontent.com/gumanba/Scripts/main/"

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NexiumHubGamesMini"
screenGui.Parent = playerGui

local GUI_WIDTH = 380
local GUI_HEIGHT = 280
local ITEM_HEIGHT = 25
local PADDING = 6

-- ===============================================
-- 2. Condensed Data Structure
-- (Optimized for faster parsing and smaller source file size)
-- ===============================================

-- Scripts from gumanba's list (Key = Raw Script Name, Value = URL Path/Endpoint)
local gumanbaScripts = {
    ["99NightsintheBunker"] = "99NightsintheBunker", ["99NightsintheWildWest"] = "99NightsintheWildWest",
    ["AdoptMeEvent"] = "AdoptMeEvent", ["AnimalTraining"] = "AnimalTraining",
    ["AnimeCardMaster"] = "AnimeCardMaster", ["AnimeCombats"] = "AnimeCombats",
    ["AnimeRNGTD"] = "AnimeRNGTD", ["AnimeRails"] = "AnimeRails",
    ["AnimeRangersX"] = "AnimeRangersX", ["AnimeSaga"] = "AnimeSaga",
    ["AnimeSimulator"] = "AnimeSimulator", ["AnimeSlashing"] = "AnimeSlashing",
    ["AnimeStrike"] = "AnimeStrike", ["AquaRacer"] = "AquaRacer",
    ["AriseCrossover"] = "AriseCrossover", ["ArrestBrainrot"] = "ArrestBrainrot",
    ["BattleforBrainrots"] = "BattleforBrainrots", ["Bayside"] = "Bayside",
    ["BeNPCorDIE"] = "BeNPCorDIE", ["BeaBeggar"] = "BeaBeggar",
    ["BeaCar"] = "BeaCar", ["BeaNinja"] = "BeaNinja",
    ["BeaSillySeal"] = "BeaSillySeal", ["Beaks"] = "Beaks",
    ["BeastGames"] = "BeastGames", ["Beastify"] = "Beastify",
    ["BeeRich"] = "BeeRich", ["BladeLeague"] = "BladeLeague",
    ["BloodofPunch"] = "BloodofPunch", ["BloxFruitButGood"] = "BloxFruitButGood",
    ["BloxLoot"] = "BloxLoot", ["BlueLock"] = "BlueLock",
    ["BombtoMine"] = "BombtoMine", ["BoxingBattles"] = "BoxingBattles",
    ["Boxingfitness"] = "Boxingfitness", ["BrainrotBattlegrounds"] = "BrainrotBattlegrounds",
    ["BrainrotEvolution"] = "BrainrotEvolution", ["BrainrotGarden"] = "BrainrotGarden",
    ["BrainrotRoyale"] = "BrainrotRoyale", ["BrainrotSlayers"] = "BrainrotSlayers",
    ["BrainrotSlingshot"] = "BrainrotSlingshot", ["BrainrotTraining"] = "BrainrotTraining",
    ["BrainrotZombie"] = "BrainrotZombie", ["BrainrotZombieTower"] = "BrainrotZombieTower",
    ["BreakBrainrotBones"] = "BreakBrainrotBones", ["BreakaFriend"] = "BreakaFriend",
    ["BreakyourBones"] = "BreakyourBones", ["Breedingranch"] = "Breedingranch",
    ["BridgeBattles"] = "BridgeBattles", ["BrookhavenHalloween"] = "BrookhavenHalloween",
    ["BubbleGumJumping"] = "BubbleGumJumping", ["BuildACart"] = "BuildACart",
    ["BuildAMiningMachine"] = "BuildAMiningMachine", ["BuildAPlane"] = "BuildAPlane",
    ["BuildAnObby"] = "BuildAnObby", ["BuildCarZombies"] = "BuildCarZombies",
    ["BuildFightSteal"] = "BuildFightSteal", ["BuildMyCar"] = "BuildMyCar",
    ["BuildToClimb"] = "BuildToClimb", ["BuildaBrainrot"] = "BuildaBrainrot",
    ["BuildaCannon"] = "BuildaCannon", ["BuildaCar"] = "BuildaCar",
    ["BuildaScamEmpire"] = "BuildaScamEmpire", ["BuildaStore"] = "BuildaStore",
    ["BuildaTractor"] = "BuildaTractor", ["BuildandSurvivetheForest"] = "BuildandSurvivetheForest",
    ["Buildur99NightsBase"] = "Buildur99NightsBase", ["BuildyourEscape"] = "BuildyourEscape",
    ["BulletCart"] = "BulletCart", ["CapybaraEvolution"] = "CapybaraEvolution",
    ["CarDealershipCOPS"] = "CarDealershipCOPS", ["CarDealershipCarEvent"] = "CarDealershipCarEvent",
    ["CarDealershipEaster"] = "CarDealershipEaster", ["CarDealershipEvent"] = "CarDealershipEvent",
    ["CarDealershipHUNT"] = "CarDealershipHUNT", ["CarDealershipHalloween"] = "CarDealershipHalloween",
    ["CarDealershipPagani"] = "CarDealershipPagani", ["CarDealershipPolice"] = "CarDealershipPolice",
    ["CarDealershipSEASON"] = "CarDealershipSEASON", ["CarTraining"] = "CarTraining",
    ["CarsvsTrucks"] = "CarsvsTrucks", ["CatchaMonster"] = "CatchaMonster",
    ["Chained"] = "Chained", ["ClassClash"] = "ClassClash",
    ["CleanaHouse"] = "CleanaHouse", ["ClimbandJump"] = "ClimbandJump",
    ["ClimbandSlide"] = "ClimbandSlide", ["ClimbtoSaveBrainrot"] = "ClimbtoSaveBrainrot",
    ["CollectforUGC"] = "CollectforUGC", ["CoolaBaddie"] = "CoolaBaddie",
    ["CrashBots"] = "CrashBots", ["CreateaFactory"] = "CreateaFactory",
    ["CriminalTycoon"] = "CriminalTycoon", ["CutGrass"] = "CutGrass",
    ["CutTrees"] = "CutTrees", ["DUMP"] = "DUMP",
    ["DalgonaTycoon"] = "DalgonaTycoon", ["DanceForUGC"] = "DanceForUGC",
    ["Dandy"] = "Dandy", ["DeadDefense"] = "DeadDefense",
    ["DeadOcean"] = "DeadOcean", ["DeadRails"] = "DeadRails",
    ["DeadRailsAuto"] = "DeadRailsAuto", ["DeadRivers"] = "DeadRivers",
    ["DeadSails"] = "DeadSails", ["DeadSpells"] = "DeadSpells",
    ["DeadlyDelivery"] = "DeadlyDelivery", ["DemonBlade"] = "DemonBlade",
    ["DemonWarriors"] = "DemonWarriors", ["Demonfall"] = "Demonfall",
    ["DesertDetectors"] = "DesertDetectors", ["DigGrandmasBackyard"] = "DigGrandmasBackyard",
    ["DigandHatchaBrainrot"] = "DigandHatchaBrainrot", ["Digit"] = "Digit",
    ["DigtheBackyard"] = "DigtheBackyard", ["DigtoEarth"] = "DigtoEarth",
    ["DigtoEscape"] = "DigtoEscape", ["DigtoSaveBrainrot"] = "DigtoSaveBrainrot",
    ["DogMan"] = "DogMan", ["DontStealthe99Nights"] = "DontStealthe99Nights",
    ["DontStealtheLabubu"] = "DontStealtheLabubu", ["DontWakeTheFish"] = "DontWakeTheFish",
    ["DontWaketheBrainrots"] = "DontWaketheBrainrots", ["DontWaketheSpookyBrainrots"] = "DontWaketheSpookyBrainrots",
    ["DragonTraining"] = "DragonTraining", ["DrillDigging"] = "DrillDigging",
    ["DriveWorld"] = "DriveWorld", ["DrivingEmpireLEGO"] = "DrivingEmpireLEGO",
    ["DropaPoop"] = "DropaPoop", ["DungeonHeroes"] = "DungeonHeroes",
    ["DungeonLeveling"] = "DungeonLeveling", ["EatBrainrotforfight"] = "EatBrainrotforfight",
    ["EattheWorld"] = "EattheWorld", ["Edward"] = "Edward",
    ["ElementalPowers"] = "ElementalPowers", ["EpicMinigames"] = "EpicMinigames",
    ["EscapeAndSurviveHead"] = "EscapeAndSurviveHead", ["EvadeEvent"] = "EvadeEvent",
    ["EvolvetoSupreme"] = "EvolvetoSupreme", ["FREEUGCOBBY"] = "FREEUGCOBBY",
    ["FightinaSupermarket"] = "FightinaSupermarket", ["FindtheBrainrot"] = "FindtheBrainrot",
    ["FischModded"] = "FischModded", ["FishGo"] = "FishGo",
    ["FishTraining"] = "FishTraining", ["FishaBrainrot"] = "FishaBrainrot",
    ["FlyingWings"] = "FlyingWings", ["FlytoSPACE"] = "FlytoSPACE",
    ["Forkthefish"] = "Forkthefish", ["GOFISHING"] = "GOFISHING",
    ["GardenTowerDefense"] = "GardenTowerDefense", ["Givenchy"] = "Givenchy",
    ["GlassBridge2"] = "GlassBridge2", ["GoKartTraining"] = "GoKartTraining",
    ["GoalKick"] = "GoalKick", ["GrabBattles"] = "GrabBattles",
    ["GrowAKingdom"] = "GrowAKingdom", ["GrowCrystals"] = "GrowCrystals",
    ["GrowEggs"] = "GrowEggs", ["GrowaBusiness"] = "GrowaBusiness",
    ["GrowaGarden"] = "GrowaGarden", ["GrowaTree"] = "GrowaTree",
    ["GuesstheKiller"] = "GuesstheKiller", ["GunfightArena"] = "GunfightArena",
    ["GymTrackRace"] = "GymTrackRace", ["HatchaDuck"] = "HatchaDuck",
    ["HireaFisher"] = "HireaFisher", ["HomelessSimulator"] = "HomelessSimulator",
    ["HorseRace"] = "HorseRace", ["HorseValley"] = "HorseValley",
    ["Hunters"] = "Hunters", ["HuntyZombie"] = "HuntyZombie",
    ["Hyundai"] = "Hyundai", ["InfectionGunfight"] = "InfectionGunfight",
    ["InkGame"] = "InkGame", ["ItalianBrainrotThieves"] = "ItalianBrainrotThieves",
    ["JackAndJill"] = "JackAndJill", ["JetpackTraining"] = "JetpackTraining",
    ["Jujutsu"] = "Jujutsu", ["JumpInTheHole"] = "JumpInTheHole",
    ["JumpandSplash"] = "JumpandSplash", ["JumpwithBrainrot"] = "JumpwithBrainrot",
    ["KIDZBOP"] = "KIDZBOP", ["KPOPSPEED"] = "KPOPSPEED",
    ["KayakRacing"] = "KayakRacing", ["KayakandSurf"] = "KayakandSurf",
    ["Keys"] = "Keys", ["KeysandKnives"] = "KeysandKnives",
    ["Kingdom"] = "Kingdom", ["Lancome"] = "Lancome",
    ["LastRun"] = "LastRun", ["LiftEverything"] = "LiftEverything",
    ["LightGame"] = "LightGame", ["LittlestPet"] = "LittlestPet",
    ["Logitech"] = "Logitech", ["Lootify"] = "Lootify",
    ["MINGLE"] = "MINGLE", ["MONSTERMETRO"] = "MONSTERMETRO",
    ["MakeWeapons"] = "MakeWeapons", ["MakeaArmy"] = "MakeaArmy",
    ["MakeaBoat"] = "MakeaBoat", ["MathMurder"] = "MathMurder",
    ["MemeFruits"] = "MemeFruits", ["MemoryMurder"] = "MemoryMurder",
    ["MergeBrainrot"] = "MergeBrainrot", ["MergeTowerDefense"] = "MergeTowerDefense",
    ["MergeandFight"] = "MergeandFight", ["MergeforSPEED"] = "MergeforSPEED",
    ["MetroLife"] = "MetroLife", ["MindsFall"] = "MindsFall",
    ["Mines"] = "Mines", ["MonsterEvolution"] = "MonsterEvolution",
    ["MotorcycleRacing"] = "MotorcycleRacing", ["MyBrainrotEggFarm"] = "MyBrainrotEggFarm",
    ["MyBrainrotRestaurant"] = "MyBrainrotRestaurant", ["MyFishingPier"] = "MyFishingPier",
    ["MyPlanetTycoon"] = "MyPlanetTycoon", ["MySingingBrainrot"] = "MySingingBrainrot",
    ["NPO"] = "NPO", ["NavyTycoon"] = "NavyTycoon",
    ["NetflixCPPB"] = "NetflixCPPB", ["NetflixCobraKai"] = "NetflixCobraKai",
    ["NetflixSquid"] = "NetflixSquid", ["NetflixXO"] = "NetflixXO",
    ["NinjaTime"] = "NinjaTime", ["NinjaTycoon"] = "NinjaTycoon",
    ["NoobDefense"] = "NoobDefense", ["NoobMergeArmy"] = "NoobMergeArmy",
    ["ONEBLOCK"] = "ONEBLOCK", ["ObbyBike"] = "ObbyBike",
    ["ObbyOtter"] = "ObbyOtter", ["OldToiletTD"] = "OldToiletTD",
    ["OnePunchTraining"] = "OnePunchTraining", ["PSGObby"] = "PSGObby",
    ["PaddleRush"] = "PaddleRush", ["PaperPlane"] = "PaperPlane",
    ["PeakEvolution"] = "PeakEvolution", ["PetMine"] = "PetMine",
    ["PetSimCannon"] = "PetSimCannon", ["PetSimGames"] = "PetSimGames",
    ["PetSimSquid"] = "PetSimSquid", ["PixelBlade"] = "PixelBlade",
    ["PlaneTraining"] = "PlaneTraining", ["PlantEvolution"] = "PlantEvolution",
    ["PlantsVsBrainrots"] = "PlantsVsBrainrots", ["PrisonPump"] = "PrisonPump",
    ["Prospecting"] = "Prospecting", ["ProtectTheHouseFromMonsters"] = "ProtectTheHouseFromMonsters",
    ["ProtectaFriend"] = "ProtectaFriend", ["PullaSword"] = "PullaSword",
    ["PunchWall"] = "PunchWall", ["PushandSlide"] = "PushandSlide",
    ["RaceClicker"] = "RaceClicker", ["RaceRNG"] = "RaceRNG",
    ["RaiseaFarm"] = "RaiseaFarm", ["RebornAsSword"] = "RebornAsSword",
    ["RescueAnimals"] = "RescueAnimals", ["RideandSlide"] = "RideandSlide",
    ["RobotEvolution"] = "RobotEvolution", ["RockFruit"] = "RockFruit",
    ["RollerTraining"] = "RollerTraining", ["SMASHaTower"] = "SMASHaTower",
    ["SOURPATCH"] = "SOURPATCH", ["STEALCOOKIES"] = "STEALCOOKIES",
    ["Seasouls"] = "Seasouls", ["SecretAgent"] = "SecretAgent",
    ["SecretVillage"] = "SecretVillage", ["Shed"] = "Shed",
    ["ShootTheBrains"] = "ShootTheBrains", ["ShootaBrainrot"] = "ShootaBrainrot",
    ["Shrek"] = "Shrek", ["SinkTheShip"] = "SinkTheShip",
    ["SlitherBlox"] = "SlitherBlox", ["SnailRace"] = "SnailRace",
    ["SnowBall"] = "SnowBall", ["SoccerSimulator"] = "SoccerSimulator",
    ["SortTheBrainrot"] = "SortTheBrainrot", ["SpeedForEggs"] = "SpeedForEggs",
    ["SpeedForStep"] = "SpeedForStep", ["SpeedGunfight"] = "SpeedGunfight",
    ["SpeedJump"] = "SpeedJump", ["SpeedMerge"] = "SpeedMerge",
    ["SpeedObby"] = "SpeedObby", ["SpeedPrisonEscape"] = "SpeedPrisonEscape",
    ["SpinaBrainrot"] = "SpinaBrainrot", ["SprunbieRail"] = "SprunbieRail",
    ["SquidEvolution"] = "SquidEvolution", ["SquidGame"] = "SquidGame",
    ["SquidGame3"] = "SquidGame3", ["SquidGameX"] = "SquidGameX",
    ["Steal99Nights"] = "Steal99Nights", ["StealADeadRails"] = "StealADeadRails",
    ["StealAFish"] = "StealAFish", ["StealAFruit"] = "StealAFruit",
    ["StealBloxFruit"] = "StealBloxFruit", ["StealBrainrotMOD"] = "StealBrainrotMOD",
    ["StealFruits"] = "StealFruits", ["StealaBaddie"] = "StealaBaddie",
    ["StealaBrainrot"] = "StealaBrainrot", ["StealaBrainrotMOD"] = "StealaBrainrotMOD",
    ["StealaCapybara"] = "StealaCapybara", ["StealaCar"] = "StealaCar",
    ["StealaCharacter"] = "StealaCharacter", ["StealaCountry"] = "StealaCountry",
    ["StealaFreddy"] = "StealaFreddy", ["StealaGarden"] = "StealaGarden",
    ["StealaGubby"] = "StealaGubby", ["StealaLabubu"] = "StealaLabubu",
    ["StealaPet"] = "StealaPet", ["StealaPlane"] = "StealaPlane",
    ["StealaTruck"] = "StealaTruck", ["Stealall"] = "Stealall",
    ["StealandEat"] = "StealandEat", ["StealtheBrainrot"] = "StealtheBrainrot",
    ["StealtheDough"] = "StealtheDough", ["StealtheFish"] = "StealtheFish",
    ["StealthePets"] = "StealthePets", ["StealtheUGC"] = "StealtheUGC",
    ["StealtheVillain"] = "StealtheVillain", ["StomachAche"] = "StomachAche",
    ["StrongmanSim"] = "StrongmanSim", ["SuperHeroFight"] = "SuperHeroFight",
    ["SuperSavage"] = "SuperSavage", ["SurviveOnPlane"] = "SurviveOnPlane",
    ["SurviveTheBrainrot"] = "SurviveTheBrainrot", ["SurviveTheTsunami"] = "SurviveTheTsunami",
    ["SurviveTheWave"] = "SurviveTheWave", ["SurviveonaRaft"] = "SurviveonaRaft",
    ["SurviveWaveZ"] = "SurviveWaveZ", ["SwimtoSavePrincess"] = "SwimtoSavePrincess",
    ["SwordFishing"] = "SwordFishing", ["TBSEscape"] = "TBSEscape",
    ["TankWar"] = "TankWar", ["TapAll"] = "TapAll",
    ["TapToEarn"] = "TapToEarn", ["TheGreatEscape"] = "TheGreatEscape",
    ["TheKill"] = "TheKill", ["TheStrongest"] = "TheStrongest",
    ["TowerOfHell"] = "TowerOfHell", ["TowerWarfare"] = "TowerWarfare",
    ["TradeUp"] = "TradeUp", ["TrainAndBattle"] = "TrainAndBattle",
    ["TrainYourBrainrot"] = "TrainYourBrainrot", ["TrainYourDog"] = "TrainYourDog",
    ["TreasureHunter"] = "TreasureHunter", ["Treadmill"] = "Treadmill",
    ["TryNotToFall"] = "TryNotToFall", ["UltimateBaseball"] = "UltimateBaseball",
    ["UnboxRandom"] = "UnboxRandom", ["Unboxing"] = "Unboxing",
    ["Unstoppable"] = "Unstoppable", ["WashingSimulator"] = "WashingSimulator",
    ["WaveBattle"] = "WaveBattle", ["WestGunfight"] = "WestGunfight",
    ["WestTower"] = "WestTower", ["WizardWest"] = "WizardWest",
    ["WonderChase"] = "WonderChase", ["YardSale"] = "YardSale",
    ["YeetAFriend"] = "YeetAFriend", ["YourBank"] = "YourBank",
    ["adustytrip"] = "adustytrip", ["bladebattle"] = "bladebattle",
    ["buildurbase"] = "buildurbase", ["elfScientist"] = "elfScientist",
    ["elfUP"] = "elfUP",
}

-- Special Scripts with non-standard URLs
local specialScripts = {
    ["Fish It 1"] = "https://pandadevelopment.net/virtual/file/ecd9069dab3d2aa3",
    ["Flick 1"] = "https://apigetunx.vercel.app/UNX.lua",
    ["ROBLOX Purchase Exploits 1"] = "https://raw.githubusercontent.com/Sqweex-lua/Free-Product-Obfs/main/obfuscated.lua",
    ["Violence District 1"] = "https://raw.githubusercontent.com/arcadeisreal/717exe_Violence_District/refs/heads/main/loader.lua",
    ["Violence District 2"] = "https://raw.githubusercontent.com/skidma/solarae/refs/heads/main/vd.lua",
    ["Pixel Quest 1"] = "https://raw.githubusercontent.com/darkhub99/pixelquest/refs/heads/main/obfuscated_script-1762689711545.lua.txt",
    ["Bake Or Die 1"] = "https://rawscripts.net/raw/Bake-or-Die-Kill-All-Bring-Items-Esp-etc-68463",
    ["Deadly Delivery 2"] = "https://raw.githubusercontent.com/VGXMODPLAYER68/Vgxmod-Hub/refs/heads/main/Deadly%20delivery.lua",
}

-- ===============================================
-- 3. Data Processing and Sorting
-- (The most performance-heavy work is done once here)
-- ===============================================

local finalScriptData = {}

-- Function to automatically add spaces to concatenated names like 'BuildAMiningMachine'
local function formatName(name)
    -- Add space between lowercase and uppercase
    local formatted = name:gsub("([a-z])([A-Z])", "%1 %2")
    
    -- Add space between a digit and a letter (e.g., '99 Nights', 'Squid Game 3')
    formatted = formatted:gsub("([a-zA-Z])(%d)", "%1 %2")
    formatted = formatted:gsub("(%d)([a-zA-Z])", "%1 %2")

    -- Clean up multiple spaces and trim
    formatted = formatted:gsub(" +", " "):match("^%s*(.-)%s*$")
    
    return formatted
end

-- Process gumanbaScripts
for rawName, urlPath in pairs(gumanbaScripts) do
    local formattedName = formatName(rawName)
    local command = string.format('loadstring(game:HttpGet("%s%s"))()', BASE_URL, urlPath)
    
    table.insert(finalScriptData, {name = formattedName, command = command})
end

-- Process specialScripts (already formatted or URL is non-standard)
for name, url in pairs(specialScripts) do
    local command = string.format('loadstring(game:HttpGet("%s"))()', url)
    
    -- Special case for Flick to include the 'true' argument if necessary
    if url:find("UNX.lua") then
         command = 'loadstring(game:HttpGet("' .. url .. '",true))()'
    end
    
    table.insert(finalScriptData, {name = name, command = command})
end

-- Sorting function to ensure version numbers sort correctly (e.g., Game 1 before Game 10)
local function extractBaseNameAndNumber(name)
    local base, numStr = name:match("^(.*) (%d+)$")
    if base and numStr then
        return base, tonumber(numStr)
    end
    return name, 0
end

local function customSortScripts(a, b)
    local baseA, numA = extractBaseNameAndNumber(a.name)
    local baseB, numB = extractBaseNameAndNumber(b.name)

    if baseA == baseB then
        return numA < numB
    else
        return baseA < baseB
    end
end

table.sort(finalScriptData, customSortScripts)


-- ===============================================
-- 4. Main GUI Frame & Elements
-- ===============================================
-- (UI instantiation remains similar, but data handling is cleaner)

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

makeFrameDraggable(mainFrame)
makeFrameDraggable(restoreButton)

-- ===============================================
-- 6. GUI Content and Items
-- ===============================================
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -closeButton.Size.X.Offset - PADDING, 0, 20)
local titleLabelY = PADDING
titleLabel.Position = UDim2.new(0, PADDING, 0, titleLabelY)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "NexiumHub Scripts"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = mainFrame

-- Search box
local searchBox = Instance.new("TextBox")
local searchBoxY = titleLabelY + titleLabel.Size.Y.Offset + PADDING
searchBox.Size = UDim2.new(1, -PADDING * 2, 0, 20)
searchBox.Position = UDim2.new(0, PADDING, 0, searchBoxY)
searchBox.PlaceholderText = string.format("Search games (%d available)...", #finalScriptData)
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
local scrollingFrameY = searchBoxY + searchBox.Size.Y.Offset + PADDING
scrollingFrame.Size = UDim2.new(1, -PADDING * 2, 1, -(scrollingFrameY + PADDING))
scrollingFrame.Position = UDim2.new(0, PADDING, 0, scrollingFrameY)
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
for i, data in ipairs(finalScriptData) do
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
    gridLayout:ApplyLayout()
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateFilter(searchBox.Text)
end)

-- Initial population of the grid
updateFilter("")
