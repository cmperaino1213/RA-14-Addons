-- made by cmperaino1213 :heart:
-- Capzone system
-- pain

local EACap = f("EACapTest")
local S1Cap = ""
local TSZCap = ""

local distance = Vector3.new(0, 0, 0)
local currentPos = distance

local startLoop = false

local capzones = {
    S1 = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        centerPos = Vector3.new(0, 0, 0)
    },
    EA = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        centerPos = Vector3.new(1853, -101, -145)
    }, 
    TSZ = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        centerPos = Vector3.new(0, 0, 0)
    }
}

local friendlyTeams = {
    "Security Corps",
    "Tactical Intervention Unit",
    "Iron Fist",
    "The Crazies",
    "The Armed Gentlemen",
    "Nothing To See Here",
    "Department of Operations"
}

local hostileTeams = {
    "The Red Wolves",
    "The Wolves Claws",
    "The Wolves Hunt",
    "The Wolves Shadows",
    "The Wolves Eyes"
}

local function clamp(var,min,max)
    if var > max then
    var = max
    end
    if var < min then
    var = min
    end
end

local function magnitude(vectorA, vectorB)
local distanceC = 0
vectorA = math.abs(vectorA) 
vectorB = math.abs(vectorB)
local a = math.round(vectorA)
local b = math.round(vectorB)

    if vectorA > vectorB then
        distanceC = a - b
    elseif vectorB > vectorA then
        distanceC = b - a
    end
return distanceC
end

local function checkTeam(player)
local team = getTeam(player)
    for _, friendlyTeam in pairs(friendlyTeams) do
        if team == friendlyTeam then
            return true, "friendly"
        end
    end
    for _, hostileTeam in pairs(hostileTeams) do
        if team == hostileTeam then
        return true, "hostile"
        end
    end
    return false, ""
end

local function updateCaps(player,side,cap)
    local playerPos = getPlayerPosition(player)
    if cap == "EACap" then
	capzones.EA.capActive = true
    local xResult = magnitude(playerPos.X, capzones.EA.centerPos.X)
    local yResult = magnitude(playerPos.Y, capzones)
    end
end

local Player = ""

EACap.Touched:Connect(function(player)
  local capzone = "EACap"
  local auth,affiliation = checkTeam(player)
    if auth == true then
        startLoop = true
        updateCaps(player,affiliation,capzone)
		Player = player
    end
end)

if startLoop then
while true do
local capActive = false
    if capzones.TSZ.capActive == true then
        capActive = true
    end
    if capzones.EA.capActive == true then
        capActive = true
  local auth,affiliation = checkTeam(Player)
    if auth == true then
        updateCaps(Player,affiliation,capzone)
    end
    end
    if capzones.S1.capActive == true then
        capActive = true
    end
    if not capActive then
        task.wait(10)
    else
        task.wait(3)
    end
end
print("looped")
end