-- made by cmperaino1213 :heart:
-- SC Loadout Locker
-- this one was also a pain to make i hate it

local playerData = {}

local loadouts = {
    -- Group ID
    group = 33089530,
    -- Recruit+ Loadout
R = {
    minRank = 0,
    maxRank = 255,
    tools = {
        tool1 = "APC556 PDW",
        tool2 = "",
        tool3 = "",
    }
},
-- Guard+ Loadout
G = {
    minRank = 3,
    maxRank = 255,
    tools = {
        tool1 = "M16A4",
        tool2 = "",
        tool3 = "Detain",
    }
},
-- Senior Guard+ Loadout
SG = {
    minRank = 5,
    maxRank = 255,
    tools = {
        tool1 = "M16A4",
        tool2 = "Spas - 12",
        tool3 = "Detain",
    }
},
-- Security Supervisor+ Loadout
SS = {
    minRank = 8,
    maxRank = 255,
    tools = {
        tool1 = "M4",
        tool2 = "Spas - 12",
        tool3 = "Detain",
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
        loadout = loadouts.R
        return loadouts.R
    elseif playerData[player].selectedLoadout == 1 then
        if groupRank >= loadouts.G.minRank and groupRank <= loadouts.G.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.G
    else
        playerData[player].selectedLoadout = 4
        end
    elseif playerData[player].selectedLoadout == 2 then
        if groupRank >= loadouts.SG.minRank and groupRank <= loadouts.SG.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.SG
    else
        playerData[player].selectedLoadout = 4
        end
    elseif playerData[player].selectedLoadout == 3 then
        if groupRank >= loadouts.SS.minRank and groupRank <= loadouts.SS.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.SS
    else
        playerData[player].selectedLoadout = 4
        end
    elseif playerData[player].selectedLoadout >= 4 then
        playerData[player].selectedLoadout = 0
    return loadouts.R
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
        removeTool(player, loadouts.G.tools.tool1)
        removeTool(player, loadouts.SS.tools.tool1)
        removeTool(player, loadouts.SS.tools.tool2)
        removeTool(player, loadouts.SS.tools.tool3)
    end
    -- if selected loadout is 1, remove all irrelevant tools
    if playerData[player].selectedLoadout == 1 then
        removeTool(player, loadouts.R.tools.tool1)
        removeTool(player, loadouts.SS.tools.tool1)
        removeTool(player, loadouts.SS.tools.tool2)
    end
    -- if selected loadout is 2, remove all irrelevant tools
    if playerData[player].selectedLoadout == 2 then
        removeTool(player, loadouts.R.tools.tool1)
        removeTool(player, loadouts.SS.tools.tool1)
    end
    -- if selected loadout is 3, remove all irrelevant tools
    if playerData[player].selectedLoadout == 3 then
        removeTool(player, loadouts.R.tools.tool1)
        removeTool(player, loadouts.G.tools.tool1)
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
    if interaction == "SCLoadoutLockerPart" and teamName == "Security Corps" then
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
    if teamName == "Security Corps" then
    task.wait(1)
        if playerData[player] ~= nil then
        giveLoadout(player,playerData[player].choice)
        end
    end
end)