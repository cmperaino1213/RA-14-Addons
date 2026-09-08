-- made by cmperaino1213 :heart:
-- Capzone system 2
-- pain

local pauseCaps = false
local capActive = true

local EACap = f("EACapTest")
local S1Cap = ""
local TSZCap = ""

local capzones = {
    S1 = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        pos1 = Vector3.new(0, 0, 0),
        pos2 = Vector3.new(0, 0, 0)
    },
    EA = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        pos1 = Vector3.new(1887, -86, -183),
        pos2 = Vector3.new(1813, -105, -108)
    }, 
    TSZ = {
        capActive = false,
        capPoints = 0,
        capChange = 0,
        hostilesInCap = 0,
        friendliesInCap = 0,
        pos1 = Vector3.new(0, 0, 0),
        pos2 = Vector3.new(0, 0, 0)
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

local inCap = {
    EA = {
        names = {

        }
    },
    TSZ = {
        names = {
            
        }
    },
    S1 = {
        names = {
            
        }
    }
}

local function clamp(var,min,max)
    if var > max then
    var = max
    end
    if var < min then
    var = min
    end
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

local function checkInCap(player,capzone)
print("anywhere")
local playerPos = getPlayerPosition(player)
print("hi")
    if capzone == "EACap" then
        print("hi2")
        if playerPos >= capzones.EA.pos2.X and playerPos <= capzones.EA.pos1.X then
            capActive = true
            table.insert(inCap.EA.names)
        else
            return
        end
    end
end

local function updateInCap(capzone)

end

local function startCap(player,affiliation,cap)
    print("there")
    if cap == "EACap" then
        checkInCap(player,cap)
    end
end

local function updateCap(capzone)

end

-- touch cap "zone" part -> checkTeam -> startCap -> checkInCap -> updateCap -> updateInCap -> updateCap (repeat last two)


while true do
local player = ""
local capTouched = false
EACap.Touched:Connect(function(Player)
    print("here")
    player = Player
end)
if capTouched then
    local auth,affiliation = checkTeam(player)
    if auth == true then
        startCap(player,affiliation,"EACap")
    end
end
if not capActive then
end
player = ""
capTouched = false
end