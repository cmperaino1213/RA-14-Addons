-- made by cmperaino1213 :heart:
-- Capzone system 3
-- This was the most painful to make :sob:

local pauseCaps = false
local capActive = false
local hostID,hostName = getHost()
local hostIngameAlert = {
    outOfGame = false,
    ingame = true
}

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

local spawns = {
    nova = {
    -- spawn names
        SC = {
            TC = f("TCSpawn"),
            TAG = f("TAGSpawn")
        },
        Civils = {
            ED = {
                ED1 = f("EDSpawn1")
            },
            ID = {
                ID1 = f("IDSpawn1")
            },
            RD = {
                RD1 = f("RDSpawn1"),
                TLA1 = f("TLASpawn1")
            },
            NCM = {
                NCM1 = f("NCMSpawn1"),
                NCM2 = f("NCMSpawn2"),
                NCM3 = f("NCMSpawn3"),
                NCM4 = f("NCMSpawn4")
            }
        },
    },
    RW = {
    -- spawn names
        RWTSZ = f("RWMainforceSpawnTSZ"),
        RWS1 = f("RWMainforceSpawnS1"),
        RWEA = f("RWMainforceSpawnEA"),
        
        Divs = {
        ShadowsTSZ = f("RWShadowsSpawnTSZ"),
        ShadowsS1 = f("RWShadowsSpawnS1"),
        ShadowsEA = f("RWShadowsSpawnEA"),
        ClawsTSZ = f("RWClawsSpawnTSZ"),
        ClawsS1 = f("RWClawsSpawnS1"),
        ClawsEA = f("RWClawsSpawnEA"),
        EyesTSZ = f("RWEyesSpawnTSZ"),
        EyesS1 = f("RWEyesSpawnS1"),
        EyesEA = f("RWEyesSpawnEA"),
        HuntTSZ = f("RWHuntSpawnTSZ"),
        HuntS1 = f("RWHuntSpawnS1"),
        HuntEA = f("RWHuntSpawnEA")
        }
    }
}

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

local function updateSpawns()
    -- DO NOT MESS WITH THIS FUNCTION, ESPECIALLY THE VECTOR3 POSITIONS UNLESS YOU KNOW WHAT YOU ARE DOING
local TSZGate = f("TSZCapGate")
local S1Gate = f("S1CapGate")
local EAGate = f("EACapGate")

    -- EA
    if capzones.EA.capPoints >= 100 then
        EAGate.Position = Vector3.new(-549.706,-9.35,683.029)
        spawns.nova.SC.TC.Position = Vector3.new(982,10,142)
        spawns.RW.RWEA.Position = Vector3.new(2057,-11,-321)
        spawns.RW.Divs.ShadowsEA.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.ClawsEA.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.EyesEA.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.HuntEA.Position = Vector3.new(679,-24,136)
    else
        EAGate.Position = Vector3.new(-549.706,-0.65,683.029)
        spawns.nova.SC.TC.Position = Vector3.new(1778,-12,-223)
        spawns.RW.RWEA.Position = Vector3.new(-587,-3.7,697) 
        spawns.RW.Divs.ShadowsEA.Position = Vector3.new(-580.96,-3.7,652.72)
        spawns.RW.Divs.ClawsEA.Position = Vector3.new(-594.94,-3.7,652.72)
        spawns.RW.Divs.EyesEA.Position = Vector3.new(-572.94,-3.7,652.72)
        spawns.RW.Divs.HuntEA.Position = Vector3.new(-587.96,-3.7,652.72)
    end
    -- S1
    if capzones.S1.capPoints >= 100 then
        S1Gate.Position = Vector3.new(-549.706,-9.35,667.829)
        spawns.nova.SC.TAG.Position = Vector3.new(992,10,142)
        for _, spawn in pairs(spawns.nova.Civils.ED) do
        spawn.Position = Vector3.new(893, -10, -173)
        end
        for _, spawn in pairs(spawns.nova.Civils.ID) do
        spawn.Position = Vector3.new(893, -10, -173)
        end
        for _, spawn in pairs(spawns.nova.Civils.RD) do
        spawn.Position = Vector3.new(893, -10, -173)
        end
        for _, spawn in pairs(spawns.nova.Civils.NCM) do
        spawn.Position = Vector3.new(893, -10, -173)
        end
        -- RW
        spawns.RW.RWS1.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.ShadowsS1.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.ClawsS1.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.EyesS1.Position = Vector3.new(679,-24,136)
        spawns.RW.Divs.HuntS1.Position = Vector3.new(679,-24,136)
    else
        S1Gate.Position = Vector3.new(-549.706,-0.65,667.829)
        spawns.nova.SC.TAG.Position = Vector3.new(653,10,121)
        -- civils
        spawns.nova.Civils.ED.ED1.Position = Vector3.new(675,-27,136)
        spawns.nova.Civils.ID.ID1.Position = Vector3.new(427,26,143)
        spawns.nova.Civils.RD.RD1.Position = Vector3.new(608,27,-311)
        spawns.nova.Civils.RD.TLA1.Position = Vector3.new(716,8,-215)
        spawns.nova.Civils.NCM.NCM1.Position = Vector3.new(669,8,-11)
        spawns.nova.Civils.NCM.NCM2.Position = Vector3.new(669,8,13)
        spawns.nova.Civils.NCM.NCM3.Position = Vector3.new(634,8,-8)
        spawns.nova.Civils.NCM.NCM4.Position = Vector3.new(634,8,14)
        -- RW
        spawns.RW.RWS1.Position = Vector3.new(-591,-3.7,692)
        spawns.RW.Divs.ShadowsS1.Position = Vector3.new(-583.9,-3.7,652.72)
        spawns.RW.Divs.ClawsS1.Position = Vector3.new(-597.88,-3.7,652.72)
        spawns.RW.Divs.EyesS1.Position = Vector3.new(-575.9,-3.7,652.72)
        spawns.RW.Divs.HuntS1.Position = Vector3.new(-590.88,-3.7,652.72)
    end
    -- TSZ
    if capzones.TSZ.capPoints >= 100 then
        TSZGate.Position = Vector3.new(-549.706,-9.35,675.529)
        local cavePart = f("RWTSZCapWall")
        cavePart.Position = Vector3.new(1242,-7,-670)
        spawns.RW.RWTSZ.Position = Vector3.new(1280,11,-774)
        spawns.RW.Divs.ShadowsTSZ.Position = Vector3.new(1280,11,-774)
        spawns.RW.Divs.ClawsTSZ.Position = Vector3.new(1280,11,-774)
        spawns.RW.Divs.EyesTSZ.Position = Vector3.new(1280,11,-774)
        spawns.RW.Divs.HuntTSZ.Position = Vector3.new(1280,11,-774)
    else
        TSZGate.Position = Vector3.new(-549.706,-0.65,675.529)
        local cavePart = f("RWTSZCapWall")
        cavePart.Position = Vector3.new(1242,15,-670)
        spawns.RW.RWTSZ.Position = Vector3.new(-579,-3.7,697)
        spawns.RW.Divs.ShadowsTSZ.Position = Vector3.new(-580.96,-3.7,649.67)
        spawns.RW.Divs.ClawsTSZ.Position = Vector3.new(-594.94,-3.7,649.67)
        spawns.RW.Divs.EyesTSZ.Position = Vector3.new(-572.94,-3.7,649.67)
        spawns.RW.Divs.HuntTSZ.Position = Vector3.new(-587.96,-3.7,649.67)
    end
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
    updateSpawns()
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
    for _, player in pairs(getPlayers()) do
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
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Distress",
            Time = time,
            Message = "EA sent a Distress Signal. Points: " .. capzones.EA.capPoints .. " | Hostiles: " .. capzones.EA.hostilesInCap .. " | Friendlies: " .. capzones.EA.friendliesInCap
        })
        capzones.EA.oldAlarms.distress = true
    end
    if capzones.EA.capPoints == 0 and not capzones.EA.oldAlarms.recapped then
        -- if EA cap points are at 0 and it isnt an old alarm then
        announce("[COMMAND]: The Entity Area has been taken back by the Corporation.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 4913624102")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Recapped",
            Time = time,
            Message = "EA was recapped. Points: " .. capzones.EA.capPoints .. " | Hostiles: " .. capzones.EA.hostilesInCap .. " | Friendlies: " .. capzones.EA.friendliesInCap
        })
        capzones.EA.oldAlarms.recapped = true
    end
    if capzones.EA.capPoints >= 1 and not capzones.EA.oldAlarms.underAttack then
        -- if EA cap points are above 1 and it isnt an old alarm then
        announce("[COMMAND]: The Entity Area is under attack.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144640726")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Under Attack",
            Time = time,
            Message = "EA is under attack. Points: " .. capzones.EA.capPoints .. " | Hostiles: " .. capzones.EA.hostilesInCap .. " | Friendlies: " .. capzones.EA.friendliesInCap
        })
        capzones.EA.oldAlarms.underAttack = true
    end
-- TSZ
    if capzones.TSZ.capPoints == 200 and not capzones.TSZ.oldAlarms.distress then
        -- if TSZ cap points are above 200 and it isnt an old alarm then
        announce("[COMMAND]: A distress signal has been received coming from the Test Subject Zone.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144649529")
        runCommand("delay 20 riot M9,l2 60")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Distress",
            Time = time,
            Message = "TSZ sent a Distress Signal. Points: " .. capzones.TSZ.capPoints .. " | Hostiles: " .. capzones.TSZ.hostilesInCap .. " | Friendlies: " .. capzones.TSZ.friendliesInCap
        })
        capzones.TSZ.oldAlarms.distress = true
    end
    if capzones.TSZ.capPoints == 0 and not capzones.TSZ.oldAlarms.recapped then
        -- if TSZ cap points are at 0 and it isnt an old alarm then
        announce("[COMMAND]: The Test Subject Zone has been taken back by the Corporation.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 4913624102")
        runCommand("delay 20 riot end")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Recapped",
            Time = time,
            Message = "TSZ was recapped. Points: " .. capzones.TSZ.capPoints .. " | Hostiles: " .. capzones.TSZ.hostilesInCap .. " | Friendlies: " .. capzones.TSZ.friendliesInCap
        })
        capzones.TSZ.oldAlarms.recapped = true
    end
    if capzones.TSZ.capPoints >= 1 and not capzones.TSZ.oldAlarms.underAttack then
        -- if TSZ cap points are above 1 and it isnt an old alarm then
        announce("[COMMAND]: The Test Subject Zone is under attack.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144640726")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Under Attack",
            Time = time,
            Message = "TSZ is under attack. Points: " .. capzones.TSZ.capPoints .. " | Hostiles: " .. capzones.TSZ.hostilesInCap .. " | Friendlies: " .. capzones.TSZ.friendliesInCap
        })
        capzones.TSZ.oldAlarms.underAttack = true
    end
-- S1
    if capzones.S1.capPoints == 200 and not capzones.S1.oldAlarms.distress then
        -- if S1 cap points is above 200 and it isnt an old alarm then
        announce("[COMMAND]: A distress signal has been recieved from Sector 1.",true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144649529")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Distress",
            Time = time,
            Message = "Sector 1 sent a Distress Signal. Points: " .. capzones.S1.capPoints .. " | Hostiles: " .. capzones.S1.hostilesInCap .. " | Friendlies: " .. capzones.S1.friendliesInCap
        })
        capzones.S1.oldAlarms.distress = true
    end
    if capzones.S1.capPoints == 0 and not capzones.S1.oldAlarms.recapped then
        -- if S1 cap points are at 0 and it isnt an old alarm then
        announce("[COMMAND]: Sector 1 has been taken back by the Corporation.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 4913624102")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Recapped",
            Time = time,
            Message = "Sector 1 was recapped. Points: " .. capzones.S1.capPoints .. " | Hostiles: " .. capzones.S1.hostilesInCap .. " | Friendlies: " .. capzones.S1.friendliesInCap
        })
        capzones.S1.oldAlarms.recapped = true
    end
    if capzones.S1.capPoints >= 1 and not capzones.S1.oldAlarms.underAttack then
        -- if S1 cap points are above 1 and it isnt an old alarm then
        announce("[COMMAND]: Sector 1 is under attack.", true)
        runCommand("play 9144625303")
        runCommand("delay 5.8 play 9144640726")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Under Attack",
            Time = time,
            Message = "Sector 1 is under attack. Points: " .. capzones.S1.capPoints .. " | Hostiles: " .. capzones.S1.hostilesInCap .. " | Friendlies: " .. capzones.S1.friendliesInCap
        })
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
            print(player .. " Paused Caps")
            return
            elseif pauseCaps then
            pauseCaps = false
            announce(player, "Caps have been unpaused")
            print(player .. " Unpaused Caps")
            return
            end
        end
    end
end)

local function checkHost()
    for _, player in pairs(getPlayers()) do
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
    -- Reset spawns
    updateSpawns()
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
        if not hostIngameAlert.ingame then
        print("Host Ingame")
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        signal("cDebug",{
            Action = "Host Joined",
            Time = time,
            Message = "The Host, " .. hostName .. " has joined."
        })
        hostIngameAlert.ingame = true
        end
    elseif not hostIngame then
        resetCaps()
        if not hostIngameAlert.outOfGame then
        local time = os.date("[%Y-%m-%d %H:%M:%S]")
        print("Host Not Ingame")
        signal("cDebug",{
            Action = "Host Left",
            Time = time,
            Message = "The Host, " .. hostName .. " has left."
        })
        hostIngameAlert.outOfGame = true
        end
        task.wait(5)
    end
end
