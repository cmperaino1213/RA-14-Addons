-- Made by cmperaino1213 :heart:
-- TAG VIP Logger
-- This was also a pain to make if it breaks again I might cry

-- Variable to prevent spam every time a VIP spawns 

local playerData = {}

local authedTeams = {
-- All the teams that will log
    "Nova Corporation Personnel",
    "Innovation Department",
    "Regulations Department",
    "Liaison Ancillary",
    "Department of Operations",
    "Engineering Department",
    "Security Corps",
    "Tactical Internvention Unit",
    "Iron Fist",
    "The Crazies",
    "The Armed Gentlemen",
    "Nothing To See Here"
}
local blacklistedTeams = {
-- All the teams that will not log; if a VIP gets on one of these teams then back on a VIP team it will log the authed team
    "Class - D",
    "Actor",
    "The Red Wolves",
    "The Wolves Shadows",
    "The Wolves Hunt",
    "The Wolves Eyes",
    "The Wolves Claws"
}

local groupIDs = {
-- Ease of Access group ID's for me
    ID = 32605966,
    RD = 33123254,
    ED = 32586482,
    SC = 33089530,
    DoO = 7852939
}

local function checkVIP(player,MCRank,team)
    if MCRank == 7 then
        -- If the player is a CO then return true and the CO log
        return true, team, "Priority: O"
    elseif MCRank == 8 then
    -- If the player is a CX then return true and the CX log
        return true, team, "Priotity: X"
    elseif MCRank == 254 then
    -- If the player is TA then return true and the TA log
        return true, team, "The Administrator"
    elseif MCRank == 255 then
        -- If the player is the CCh then return true and the CCh log
        return true, team, "Corporate Chairman"
    elseif MCRank < 7 then
        -- If the player is not a CO then
        if team == "Security Corps" or team == "Tactical Intervention Unit" or team == "Iron Fist" or team == "The Crazies" or team == "The Armed Gentlemen" or team == "Nothing To See Here" then
            -- If the player is on any SC team then get their main SC rank
            local depRank = getPlayerRankInGroup(player,groupIDs.SC)
            if depRank >= 11 and depRank <= 12 then
            -- If the player is the Commander or Head Commander then return true and the SC Dir log
                return true, team, "SC Directorate"
            end
        elseif team == "Engineering Department" then
        -- If the player is on ED then get their ED rank
            local depRank = getPlayerRankInGroup(player,groupIDs.ED)
            if depRank >= 11 and depRank <= 253 then
                -- If the player is the Associate Director or Director of Engineering then return true and the ED Dir log
                return true, team, "(ED Directorate)"
            end
        elseif team == "Regulations Department" or team == "Liaison Ancillary" then
        -- If the player is on RD or TLA then get their main RD rank
            local depRank = getPlayerRankInGroup(player,groupIDs.RD)
            if depRank >= 11 and depRank <= 12 then
            -- If the player is the Assistant Director or Director of Regulations then return true and the RD Dir log
                return true, team, "RD Directorate"
            end
        elseif team == "Department of Operations" then
        -- If the player is on DoO then get their DoO rank
            local depRank = getPlayerRankInGroup(player,groupIDs.DoO)
            if depRank >= 7 and depRank <= 8 then
            -- If the player is the Executive Drone or Cardinal Drone then return true and the DoO Dir log
                return true, team, "DoO Directorate"
            end
        elseif team == "Innovation Department" then
            -- If the player is on ID then get their ID rank
            local depRank = getPlayerRankInGroup(player,groupIDs.ID)
            if depRank >= 8 and depRank <= 9 then
            -- If the player is the Deputy Director or Director of Innovation then return true and the ID Dir log
                return true, team, "ID Directorate"
            end
        end
    else
        -- If the player fits NONE of the conditions above, return false and ""
        return false, "", ""
    end
end

local function checkGroups(player)
local MCRank = getPlayerRankInGroup(player, 32586058)
local teamName = getTeam(player)

    for _, team in pairs(authedTeams) do
        if teamName == team and playerData[player].newLog then
            -- If the player is on an authed team then check if they are a VIP
            local VIP, Team, Rank = checkVIP(player,MCRank,teamName)
            if VIP then
                -- If they are a VIP then prevent a new log and return the information
                playerData[player].newLog = false
                return VIP, Team, Rank
            end
        else
            for _, bteam in pairs(blacklistedTeams) do
                -- Checks every blacklisted team
                local VIP, data = checkVIP(player,0,teamName)
                if teamName == bteam or not VIP then
                    -- If the user is on a blacklisted team then allow a newLog
                playerData[player].newLog = true
                -- Return false because it shouldn't send the webhook; doesn't log
                return false, "", ""
                end
            end
        end
    end
end

event("spawned", function(data)
    -- The player
    local player = data.Value
    -- logVIP = true or false, content is what will send in the webhook
    local logVIP, team, rank = checkGroups(player)
    -- adds the player data, preventing spam
    if playerData[player] == nil then 
            playerData[player] = {
            newLog = true
        }
    end

    
    if logVIP then
    signal("VIPLog",{
        Action = "Log", 
        Player = player,
        Team = team,
        Rank = rank
    })
    end
end)