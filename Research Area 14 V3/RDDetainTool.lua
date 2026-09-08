-- made by cmperaino1213 :heart:
-- RD Detain tool, locked to SRO+ or LE+ (depends on team)
-- liaison employee = 2, SRO = 6
local info = {
    RD = {
        groupID = 33123254,
        rankID = ""
    },
    TLA = {
        groupID = 33123451,
        rankID = ""
    }
}

local function updateInfo(player,groupID)
local RD = info.RD
local TLA = info.TLA
-- local variables for me, less typing later
    if groupID == RD.groupID then
    RD.rankID = getPlayerRankInGroup(player,RD.groupID)
        if RD.rankID >= 8 then
            return true
        else
            return false
        end
    end
    if groupID == TLA.groupID then
    TLA.rankID = getPlayerRankInGroup(player,TLA.groupID)
        if TLA.rankID >= 2 then
            return true
        else
            return false
        end
    end
end

local function getDetain(player)
  if hasTool(player, "Detain") then
-- If the player already has the broom tool, then remove it from the player and stop the function.
	removeTool(player,"Detain")
    return
  else
-- Otherwise, give the player the broom tool then stop the function.
	giveTool(player,"Detain")
    return
  end
end

event("interaction", function(Data)
  local player = Data.Value[1]
-- Player who interacted with the part
  local interaction = Data.Value[2]
-- What part was interacted with
local teamName, teamColor = getTeam(player)

    if interaction == "RDDetainGiver" then
-- If the interaction was with the RD Detain giver then
        if teamName == "Regulations Department" then
        -- If the player is on RD then run the updateInfo function with the RD group ID
            -- Use the player for the functions first value,info.RD.groupID for the second value
            local authorized = updateInfo(player,info.RD.groupID)
            if authorized then
            -- Use the player for the functions first value
	            getDetain(player)
            end
        elseif teamName == "Liaison Ancillary" then
                    -- If the player is on TLA then run the updateInfo function with the TLA group ID
            -- Use the player for the functions first value,info.TLA.groupID for the second value
            local authorized = updateInfo(player,info.TLA.groupID)
            if authorized then
            -- Use the player for the functions first value
	            getDetain(player)
            end
        end
    end
end)