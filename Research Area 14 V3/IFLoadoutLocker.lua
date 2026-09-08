-- made by cmperaino1213 :heart:
-- IF Loadout Locker
-- this one was also a pain to make i hate it


local playerData = {}

local loadouts = {
    -- Group ID
    group = 33089542,
    -- Cadet+ Loadout
C = {
    minRank = 0,
    maxRank = 255,
    tools = {
        tool1 = "KV-45",
        tool2 = "BR-762",
        tool3 = "M9",
    }
},
-- Lance Corporal+ Loadout
LC = {
    minRank = 5,
    maxRank = 255,
    tools = {
        tool1 = "XM250",
        tool2 = "BR-762",
        tool3 = "M9",
    }
},
-- Sergeant+ Loadout
SGT = {
    minRank = 7,
    maxRank = 255,
    tools = {
        tool1 = "KV-45",
        tool2 = "AA-12",
        tool3 = "Pistol",
    }
},
-- Lieutenant+ Loadout
LT = {
    minRank = 9,
    maxRank = 255,
    tools = {
        tool1 = "XM250",
        tool2 = "M110",
        tool3 = "Pistol",
    }
}
}

local function updateLoadout(player)
-- gets the IF group rank
local groupRank = getPlayerRankInGroup(player,loadouts.group)
-- gets the Monarch group rank
local MCRank = getPlayerRankInGroup(player,32586058)
local loadout = ""
-- if statement slop that converts selectedLoadout into loadout, and prevents unauthed ranks from getting higher loadouts
    if playerData[player].selectedLoadout == 0 then
        loadout = loadouts.C
        return loadouts.C
    elseif playerData[player].selectedLoadout == 1 then
        if groupRank >= loadouts.LC.minRank and groupRank <= loadouts.LC.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.LC
    else
        playerData[player].selectedLoadout = 4
        end
    elseif playerData[player].selectedLoadout == 2 then
        if groupRank >= loadouts.SGT.minRank and groupRank <= loadouts.SGT.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.SGT
    else
        playerData[player].selectedLoadout = 4
        end
    elseif playerData[player].selectedLoadout == 3 then
        if groupRank >= loadouts.LT.minRank and groupRank <= loadouts.LT.maxRank or player == "NovaCorpSSUH" or MCRank >= 8 then
    return loadouts.LT
    else
        playerData[player].selectedLoadout = 4
        end
    elseif playerData[player].selectedLoadout >= 4 then
        playerData[player].selectedLoadout = 0
    return loadouts.C
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
        removeTool(player, loadouts.SGT.tools.tool2)
        removeTool(player, loadouts.LT.tools.tool1)
        removeTool(player, loadouts.LT.tools.tool2)
        removeTool(player, loadouts.LT.tools.tool3)
    end
    -- if selected loadout is 1, remove all irrelevant tools
    if playerData[player].selectedLoadout == 1 then
        removeTool(player, loadouts.C.tools.tool1)
        removeTool(player, loadouts.SGT.tools.tool2)
        removeTool(player, loadouts.LT.tools.tool2)
        removeTool(player, loadouts.LT.tools.tool3)
    end
    -- if selected loadout is 2, remove all irrelevant tools
    if playerData[player].selectedLoadout == 2 then
        removeTool(player, loadouts.C.tools.tool2)
        removeTool(player, loadouts.C.tools.tool3)
        removeTool(player, loadouts.LT.tools.tool1)
        removeTool(player, loadouts.LT.tools.tool2)
    end
    -- if selected loadout is 3, remove all irrelevant tools
    if playerData[player].selectedLoadout == 3 then
        removeTool(player, loadouts.C.tools.tool1)
        removeTool(player, loadouts.C.tools.tool2)
        removeTool(player, loadouts.C.tools.tool3)
        removeTool(player, loadouts.SGT.tools.tool2)
    end
end

event("interaction", function(data)
    -- the player
local player = data.Value[1]
-- the interaction
local interaction = data.Value[2]
-- checks the players team
local teamName = getTeam(player)

-- if the player interacts with the SCLoadoutLockerPart and are on IF then
    if interaction == "SCLoadoutLockerPart" or interaction == "IFLoadoutLockerPart" then
        if teamName == "Iron Fist" then
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
    end
end)

event("spawned",function(data)
    -- the player
local player = data.Value
-- checks team
local teamName = getTeam(player)

-- if player is on IF then wait 1 second and give them the loadout
    if teamName == "Iron Fist" then
    task.wait(1)
        if playerData[player] ~= nil then
        giveLoadout(player,playerData[player].choice)
        end
    end
end)