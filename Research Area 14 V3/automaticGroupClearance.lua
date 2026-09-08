-- Made by cmperaino1213 :heart:
-- Automatic Group Clearance
-- This was pain to make if this breaks i might cry

local MCRank = "0"

local blacklistedTeams = {
    "Security Corps",
    "Iron Fist",
    "The Crazies",
    "The Armed Gentlemen",
    "Nothing To See Here",
    "Tactical Intervention Unit",
    "Class - D",
    "Department of Operations",
    "The Red Wolves",
    "The Wolves Claws", 
    "The Wolves Eyes",
    "The Wolves Hunt",
    "The Wolves Shadows"
}
local departments = {
    "Engineering Department",
    "Regulations Department",
    "Liaison Ancillary",
    "Innovation Department"
}

local function checkAuth(player)
local teamName = getTeam(player)

    for _, team in pairs(blacklistedTeams) do
        if team == teamName and team ~= "Class - D" then
        return false, true, teamName
        elseif teamName == "Class - D"
then
            return false,false
        end
    end
    for _, department in pairs(departments) do
        if department == teamName then
            return true, true, teamName
        end
    end
    return true, false, teamName
end

local function giveCard(player)
MCRank = getPlayerRankInGroup(player, 32586058)
local SCRank = getPlayerRankInGroup(player,33089530)
-- gets their monarch rank
local authed, departmental, teamName = checkAuth(player)
-- checks if they are authorized, departmental, and what the team name is

    if authed then
        -- if they are authorized then
        if MCRank == 3 and not departmental then
            -- if they are CD and not on a departmental team then give them a L0 card
                giveTool(player, "L0 Keycard")
        elseif MCRank == 3 and departmental and teamName ~= "Regulations Department" and teamName ~= "Liaison Ancillary" then
            -- elseif they are CD and on a departmental team and not on RD and TLA then give them a L1 card
                giveTool(player, "L1 Keycard")
        elseif MCRank == 4 and teamName ~= "Regulations Department" and teamName ~= "Liaison Ancillary" then
            -- elseif they are CC and not on RD and TLA then give them a L1 card
                giveTool(player, "L1 Keycard")
        elseif MCRank <= 4 and MCRank >= 3 and teamName == "Regulations Department" then
            -- elseif they are CD-CC and on RD then give them a L2 card
                giveTool(player, "L2 Keycard")
        elseif MCRank <= 4 and MCRank >= 3 and teamName == "Liaison Ancillary" then
            -- elseif they are CD-CC and on TLA then give them a L2 card
                giveTool(player, "L2 Keycard")
        elseif MCRank == 5 then
            -- elseif they are CB then give them a L2 card
                giveTool(player, "L2 Keycard")
        elseif MCRank == 6 then
            -- elseif they are CA then give them a L3 card
                giveTool(player, "L3 Keycard")
        elseif MCRank == 7 then
            -- elseif they are CO then give them a L4 card
                giveTool(player, "L4 Keycard")
        elseif MCRank >= 8 then
            -- elseif they are CX+ then give them an O5 card
                giveTool(player, "O5 Keycard")
        end
    elseif not authed and departmental then
    -- if they arent authed and are departmental then
        if teamName == "Security Corps" then
            -- if they are on SC or RW then
            if MCRank < 7 and SCRank >= 8 then
                -- if they are CA then give them a L3 card
                giveTool(player, "L3 Keycard")
            elseif MCRank == 7 then
                -- elseif they are CO then give them a L4 card
                giveTool(player, "L4 Keycard")
            elseif MCRank >= 8 then
                -- elseif they are CX+ then give them an O5 card
                giveTool(player, "O5 Keycard")
            end
            if MCRank > 6 or SCRank >= 8 then
            -- if they are CA+ then remove the L2 Keycard
				task.wait(1)
                removeTool(player, "L2 Keycard")
            end
            elseif teamName == "The Red Wolves" then
            -- if they are on SC or RW then
            if MCRank == 5 then
                -- if they are CB then give them a L2 card
                giveTool(player, "L2 Keycard")
            elseif MCRank == 6 then
                -- elseif they are CA then give them a L3 card
                giveTool(player, "L3 Keycard")
            elseif MCRank == 7 then
                -- elseif they are CO then give them a L4 card
                giveTool(player, "L4 Keycard")
            elseif MCRank >= 8 then
                -- elseif they are CX+ then give them an O5 card
                giveTool(player, "O5 Keycard")
            end
            if MCRank > 4 then
            -- if they are CB+ then remove the L1 Keycard
				task.wait(1)
                removeTool(player, "L1 Keycard")
            end
         elseif teamName == "Iron Fist" or teamName == "The Crazies" or teamName == "The Armed Gentlemen" or teamName == "Tactical Intervention Unit" then
            -- elseif they are on IF or TC or TAG or TIU then
            if MCRank == 7 then
            -- if they are a CO then give them a L4 card
                giveTool(player, "L4 Keycard")
            elseif MCRank >= 8 then
            -- elseif they are a CX+ then give them an O5 card
                giveTool(player, "O5 Keycard")
            end
            if MCRank > 6 then
            -- if they are CO+ then remove the L3 Keycard
				task.wait(1)
                removeTool(player, "L3 Keycard")
            end
        elseif teamName == "The Wolves Claws" or teamName == "The Wolves Hunt" or teamName == "The Wolves Shadows" or teamName == "The Wolves Eyes" then
            -- elseif they are on the wolves claws or the wolves hunt or the wolve sshadows or the wolves eyes then
            if MCRank == 6 then
            -- if they are CA then give them a L3 card
                giveTool(player, "L3 Keycard")
            elseif MCRank == 7 then
            -- elseif they are CO then give them a L4 card
                giveTool(player, "L4 Keycard")
            elseif MCRank >= 8 then
            -- elseif they are CX+ then give them an O5 card
                giveTool(player, "O5 Keycard")
            end
            if MCRank > 5 then
            -- if they are CA+ then remove the L2 Keycard
				task.wait(1)
                removeTool(player, "L2 Keycard")
            end
        elseif teamName == "Department of Operations" or teamName == "Nothing To See Here" then
            if MCRank >= 8 then
            -- if they are CX+ then give them an O5 card and remove the L4 card
                giveTool(player, "O5 Keycard")
                removeTool(player, "L4 Keycard")
            end
        end
		return
    end
end

event("spawned", function(Data)
    local player = Data.Value
    giveCard(player)
end)