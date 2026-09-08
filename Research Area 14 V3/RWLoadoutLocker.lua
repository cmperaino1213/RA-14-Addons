-- made by cmperaino1213 :heart:
-- RW Loadout Locker


local playerData = {}

local loadouts = {
    -- Group ID
    group = 33850667,
    -- E1+ Loadout; default loadout
E1 = {
    loadoutID = 0,
    minRank = 0,
    maxRank = 255,
    tools = {
        tool1 = "SW-762",
    }
},
-- E6+ Loadout
E6 = {
    loadoutID = 1,
    minRank = 7,
    maxRank = 255,
    tools = {
        tool1 = "BP-77",
    }
}
}

local function updateLoadout(player)
-- gets the SC group rank
local groupRank = getPlayerRankInGroup(player,loadouts.group)
-- gets the Monarch group rank
local MCRank = getPlayerRankInGroup(player,32586058)
local loadout = ""
-- if statement slop that converts selectedLoadout into loadout, and prevents unauthed ranks from getting higher loadouts
    if playerData[player].selectedLoadout == 0 then
        loadout = loadouts.E1
        return loadouts.E1
    elseif playerData[player].selectedLoadout == 1 then
        if groupRank >= loadouts.E6.minRank and groupRank <= loadouts.E6.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.E6
    else
        playerData[player].selectedLoadout = 2
        end
    elseif playerData[player].selectedLoadout == 2 then
        playerData[player].selectedLoadout = 0
    return loadouts.E1
    end
end


local function giveLoadout(player,loadout)
    -- if they dont have tool1 for their loadout then give it
    if not hasTool(player, loadout.tools.tool1) then
        giveTool(player, loadout.tools.tool1)
    end
    -- if they dont have tool2 for their loadout then give it
    if not hasTool(player, loadout.tools.tool2) then
        giveTool(player, loadout.tools.tool2)
    end
    -- if they dont have tool3 for their loadout then give it
    if not hasTool(player, loadout.tools.tool3) then
        giveTool(player, loadout.tools.tool3)
    end
    -- if selected loadout is 0, remove all irrelevant tools
    if playerData[player].selectedLoadout == 0 then
        removeTool(player, loadouts.E6.tools.tool1)
    end
    -- if selected loadout is 1, remove all irrelevant tools
    if playerData[player].selectedLoadout == 1 then
        removeTool(player, loadouts.E1.tools.tool1)
    end
end

event("interaction", function(data)
    -- the player
local player = data.Value[1]
-- the interaction
local interaction = data.Value[2]
-- checks the players team
local teamName = getTeam(player)

-- if the player interacts with the SCLoadoutLockerPart and are on SC then
    if interaction == "RWLoadoutLocker" and teamName == "The Red Wolves" then
        if playerData[player] == nil then 
            playerData[player] = {
            selectedLoadout = 0,
            choice = ""
        }
        end
        -- cycle +1 through loadouts
    playerData[player].selectedLoadout = playerData[player].selectedLoadout + 1
    -- update loadouts
    playerData[player].choice = updateLoadout(player)
    -- give loadouts
    giveLoadout(player,playerData[player].choice)
    end
end)

event("spawned",function(data)
    -- the player
local player = data.Value
-- checks team
local teamName = getTeam(player)

-- if player is on SC then wait 1 second and give them the loadout
    if teamName == "The Red Wolves" then
    task.wait(1)
        if playerData[player] ~= nil then
        giveLoadout(player,playerData[player].choice)
        end
    end
end)