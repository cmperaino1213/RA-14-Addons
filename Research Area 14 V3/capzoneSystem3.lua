-- made by cmperaino1213 :heart:
-- Capzone system 3
-- This was the most painful to make :sob:
-- e

local pauseCaps = false
local capActive = false
local hostID,hostName = getHost()

local capzones = {
    EA = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        pos1 = Vector3.new(1887, -86, -183),
        pos2 = Vector3.new(1813, -105, -108),
        oldAlarms = {
            distress = false,
            recapped = true,
            underAttack = false,
            moveSpawnA = true,
            moveSpawnB = false
        }
    }, 
    S1 = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        pos1 = Vector3.new(472, 7, -575),
        pos2 = Vector3.new(584, 39, -438),
        oldAlarms = {
            distress = false,
            recapped = true,
            underAttack = false,
            moveSpawnA = true,
            moveSpawnB = false
        }
    },
    TSZ = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        pos1 = Vector3.new(999, 32, -397),
        pos2 = Vector3.new(1055, 51, -462),
        oldAlarms = {
            distress = false,
            recapped = true,
            underAttack = false,
            moveSpawnA = true,
            moveSpawnB = false
        }
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

local players = getPlayers()

local function clamp(initial,min,max)
    if initial > max then
    initial = max
    end
    if initial < min then
    initial = min
    end
    return initial
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

local function updateCaps()
    for _, capzone in pairs(capzones) do
    capzone.capChange = clamp(capzone.hostilesInCap - capzone.friendliesInCap , -3 , 3)
    capzone.capPoints = clamp(capzone.capPoints + capzone.capChange, 0, 200)
        if capzone.hostilesInCap >= 1 or capzone.friendliesInCap >= 1 then
        capzone.capActive = true
        else
        capzone.capActive = false
        end
    end
    -- update EA signs
    setSignText("EACapSign1", capzones.EA.capPoints)
    setSignText("EACapSign2", capzones.EA.capPoints)
    setSignText("EACapSign3", capzones.EA.capPoints)
    setSignText("EACapSign4", capzones.EA.capPoints)
    -- update S1 signs
    setSignText("S1CapSign1", capzones.S1.capPoints)
    setSignText("S1CapSign2", capzones.S1.capPoints)
    setSignText("S1CapSign3", capzones.S1.capPoints)
    setSignText("S1CapSign4", capzones.S1.capPoints)
    -- update TSZ signs
    setSignText("TSZCapSign1", capzones.TSZ.capPoints)
    setSignText("TSZCapSign2", capzones.TSZ.capPoints)
    -- if any caps are active then turn cap active on
    if capzones.EA.capActive or capzones.S1.capActive or capzones.TSZ.capActive then
        capActive = true
    else
        -- else turn it off
        capActive = false
    end
end

local function checkInCap(player)
local auth,affiliation = checkTeam(player)
    if auth then
local playerPos = getPlayerPosition(player)
local inXEA = false
local inYEA = false
local inZEA = false
local inXS1 = false
local inYS1 = false
local inZS1 = false
local inXTSZ = false
local inYTSZ = false
local inZTSZ = false
    if playerPos.X >= capzones.EA.pos2.X and playerPos.X <= capzones.EA.pos1.X then
        inXEA = true
    end
    if playerPos.Y >= capzones.EA.pos2.Y and playerPos.Y <= capzones.EA.pos1.Y then
        inYEA = true
    end
    if playerPos.Z >= capzones.EA.pos1.Z and playerPos.Z <= capzones.EA.pos2.Z then
        inZEA = true
    end
        if inXEA and inYEA and inZEA then
        return affiliation, "EA"
        end
    if playerPos.X >= capzones.S1.pos1.X and playerPos.X <= capzones.S1.pos2.X then
        inXS1 = true
    end
    if playerPos.Y >= capzones.S1.pos1.Y and playerPos.Y <= capzones.S1.pos2.Y then
        inYS1 = true
    end
    if playerPos.Z >= capzones.S1.pos1.Z and playerPos.Z <= capzones.S1.pos2.Z then
        inZS1 = true
    end
        if inXS1 and inYS1 and inZS1 then
        return affiliation, "S1"
        end
    if playerPos.X >= capzones.TSZ.pos1.X and playerPos.X <= capzones.TSZ.pos2.X then
        inXTSZ = true
    end
    if playerPos.Y >= capzones.TSZ.pos1.Y and playerPos.Y <= capzones.TSZ.pos2.Y then
        inYTSZ = true
    end
    if playerPos.Z >= capzones.TSZ.pos2.Z and playerPos.Z <= capzones.TSZ.pos1.Z then
        inZTSZ = true
    end
        if inXTSZ and inYTSZ and inZTSZ then
        return affiliation, "TSZ"
        end
    end
    return "N/A", "N/A"
end

local function updateInCap()
    for _, capzone in pairs (capzones) do
    capzone.hostilesInCap = 0
    capzone.friendliesInCap = 0
    end
    players = getPlayers()
    for _, player in pairs(players) do
    local affiliation,capzone = checkInCap(player)
        if affiliation == "hostile" and capzone == "EA" then
            capzones.EA.hostilesInCap = capzones.EA.hostilesInCap + 1
        elseif affiliation == "friendly" and capzone == "EA" then
            capzones.EA.friendliesInCap = capzones.EA.friendliesInCap + 1
        elseif affiliation == "hostile" and capzone == "S1" then
            capzones.S1.hostilesInCap = capzones.S1.hostilesInCap + 1
        elseif affiliation == "friendly" and capzone == "S1" then
            capzones.S1.friendliesInCap = capzones.S1.friendliesInCap + 1
        elseif affiliation == "hostile" and capzone == "TSZ" then
            capzones.TSZ.hostilesInCap = capzones.TSZ.hostilesInCap + 1
        elseif affiliation == "friendly" and capzone == "TSZ" then
            capzones.TSZ.friendliesInCap = capzones.TSZ.friendliesInCap + 1
        end
    end
        updateCaps()    
end

local function updateAlarms()
-- reset alarms
    --EA
    for _, capzone in pairs(capzones) do
        if capzone.capPoints <= 175 then
            capzone.oldAlarms.distress = false
            if capzone.capPoints == 0 then
                capzone.oldAlarms.underAttack = false
            end
        end
        if capzone.capPoints >= 100 then
        capzone.oldAlarms.moveSpawnA = false
        elseif capzone.capPoints <= 99 then
            capzone.oldAlarms.moveSpawnB = false
        end
        if capzone.capPoints >= 1 then
            capzone.oldAlarms.recapped = false
        end
    end
-- turn on alarms
    -- EA
    if capzones.EA.capPoints == 200 and not capzones.EA.oldAlarms.distress then
        -- if EA cap points is above 200 and it isnt an old alarm then
        announce("[COMMAND]: A distress signal has been recieved from the Entity Area.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144649529")
        capzones.EA.oldAlarms.distress = true
    end
    if capzones.EA.capPoints <= 99 and not capzones.EA.oldAlarms.moveSpawnA then
        announce(hostName, "Move TC spawn to EA and close RW EA access")
        capzones.EA.oldAlarms.moveSpawnA = true
    end
    if capzones.EA.capPoints >= 100 and not capzones.EA.oldAlarms.moveSpawnB then
        announce(hostName, "Move TC spawn to main armory and open RW EA access")
        capzones.EA.oldAlarms.moveSpawnB = true
    end
    if capzones.EA.capPoints == 0 and not capzones.EA.oldAlarms.recapped then
        -- if EA cap points are at 0 and it isnt an old alarm then
        announce("[COMMAND]: The Entity Area has been taken back by the Corporation.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 4913624102")
        capzones.EA.oldAlarms.recapped = true
    end
    if capzones.EA.capPoints >= 1 and not capzones.EA.oldAlarms.underAttack then
        -- if EA cap points are above 1 and it isnt an old alarm then
        announce("[COMMAND]: The Entity Area is under attack.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144640726")
        capzones.EA.oldAlarms.underAttack = true
    end
-- TSZ
    if capzones.TSZ.capPoints == 200 and not capzones.TSZ.oldAlarms.distress then
        -- if TSZ cap points are above 200 and it isnt an old alarm then
        announce("[COMMAND]: A distress signal has been received coming from the Test Subject Zone.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144649529")
        runCommand("delay 20 riot M9,l2 60")
        capzones.TSZ.oldAlarms.distress = true
    end
    if capzones.TSZ.capPoints <= 99 and not capzones.TSZ.oldAlarms.moveSpawnA then
        announce(hostName, "Remove RW TSZ access")
        capzones.TSZ.oldAlarms.moveSpawnA = true
    end
    if capzones.TSZ.capPoints >= 100 and not capzones.TSZ.oldAlarms.moveSpawnB then
        announce(hostName, "Open RW TSZ access")
        capzones.TSZ.oldAlarms.moveSpawnB = true
    end
    if capzones.TSZ.capPoints == 0 and not capzones.TSZ.oldAlarms.recapped then
        -- if TSZ cap points are at 0 and it isnt an old alarm then
        announce("[COMMAND]: The Test Subject Zone has been taken back by the Corporation.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 4913624102")
        runCommand("delay 20 riot end")
        capzones.TSZ.oldAlarms.recapped = true
    end
    if capzones.TSZ.capPoints >= 1 and not capzones.TSZ.oldAlarms.underAttack then
        -- if TSZ cap points are above 1 and it isnt an old alarm then
        announce("[COMMAND]: The Test Subject Zone is under attack.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144640726")
        capzones.TSZ.oldAlarms.underAttack = true
    end
-- S1
    if capzones.S1.capPoints == 200 and not capzones.S1.oldAlarms.distress then
        -- if S1 cap points is above 200 and it isnt an old alarm then
        announce("[COMMAND]: A distress signal has been recieved from Sector 1.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144649529")
        capzones.S1.oldAlarms.distress = true
    end
    if capzones.S1.capPoints <= 99 and not capzones.S1.oldAlarms.moveSpawnA then
        announce(hostName, "Move S1 spawns to S1 and close RW S1 access")
        capzones.S1.oldAlarms.moveSpawnA = true
    end
    if capzones.S1.capPoints >= 100 and not capzones.S1.oldAlarms.moveSpawnB then
        announce(hostName, "Move S1 spawns out of S1 and open RW S1 access")
        capzones.S1.oldAlarms.moveSpawnB = true
    end
    if capzones.S1.capPoints == 0 and not capzones.S1.oldAlarms.recapped then
        -- if S1 cap points are at 0 and it isnt an old alarm then
        announce("[COMMAND]: Sector 1 has been taken back by the Corporation.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 4913624102")
        capzones.S1.oldAlarms.recapped = true
    end
    if capzones.S1.capPoints >= 1 and not capzones.S1.oldAlarms.underAttack then
        -- if S1 cap points are above 1 and it isnt an old alarm then
        announce("[COMMAND]: Sector 1 is under attack.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144640726")
        capzones.S1.oldAlarms.underAttack = true
    end
end

event("chatted", function(data)
local player = tostring(data.Value[1])
local message = string.lower(data.Value[2])
local MCRank = getPlayerRankInGroup(player, 32586058)
local devRankID = getPlayerRankInGroup(player,32613990)

    if MCRank >= 7 or devRankID == 4 or devRankID == 5 or devRankID >= 7 or player == "NovaCorpSSUH" then
        if message == "/e pausecaps" or message == "/e pausecap" then
            if not pauseCaps then
            pauseCaps = true
            announce(player, "Caps have been paused")
            return
            elseif pauseCaps then
            pauseCaps = false
            announce(player, "Caps have been unpaused")
            return
            end
        end
    end
end)

local function checkHost()
    for _, player in pairs(players) do
    local playerID = getUserId(player)
        if playerID == hostID then
        return true
        end
    end
    return false
end

local function resetCaps()
    for _, capzone in pairs(capzones) do
-- Deactivate caps and set their points to 0
    capzone.capPoints = 0
    capzone.capActive = false
-- Reset Alarms
    capzone.oldAlarms.distress = false
    capzone.oldAlarms.underAttack = false
    capzone.oldAlarms.recapped = true
    capzone.oldAlarms.moveSpawnA = true
    capzone.oldAlarms.moveSpawnB = false
    end
    capActive = false
    -- Reset signs
    -- EA
    setSignText("EACapSign1", capzones.EA.capPoints)
    setSignText("EACapSign2", capzones.EA.capPoints)
    setSignText("EACapSign3", capzones.EA.capPoints)
    setSignText("EACapSign4", capzones.EA.capPoints)
    -- S1
    setSignText("S1CapSign1", capzones.S1.capPoints)
    setSignText("S1CapSign2", capzones.S1.capPoints)
    setSignText("S1CapSign3", capzones.S1.capPoints)
    setSignText("S1CapSign4", capzones.S1.capPoints)
    -- TSZ
    setSignText("TSZCapSign1", capzones.TSZ.capPoints)
    setSignText("TSZCapSign2", capzones.TSZ.capPoints)
end

while true do
    local hostIngame = checkHost()
    if hostIngame then
        if not pauseCaps then
        updateInCap()
        updateAlarms()
            if not capActive then
            task.wait(5)
            else
            task.wait(1)
            end
        elseif pauseCaps then
        resetCaps()
        task.wait(5)
        end
    elseif not hostIngame then
        resetCaps()
        task.wait(5)
    end
end