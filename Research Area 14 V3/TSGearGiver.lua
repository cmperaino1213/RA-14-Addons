-- Made by cmperaino1213 :heart:
-- TS Gear Giver

local authedTeams = {
    "Class - D"
}

local function giveTools (player,part)

    if part == "TSOPTools" then
    -- if they interacted with the outpost part then give them the morph gear stuff
    runCommand("hat " .. player .. " vest,visor")
        if not hasTool(player,"AKS-74U") then
        -- if they dont have an AKS-74U then give them one
        runCommand("give " .. player .. " AKS-74U")
        end
        if not hasTool(player,"SMG25") then
        -- if they dont have a SMG25 then give them one
        runCommand("give " .. player .. " SMG25")
        end
        if not hasTool(player,"M9") then
        -- if they dont have a M9 then give them one
        runCommand("give " .. player .. " M9")
        end
        if not hasTool(player,"L2 Keycard") then
        -- if they dont have a L2 Keycard then give them one
        runCommand("give " .. player .. " L2 Keycard")
        end
    elseif part == "TSRWTools" then
    -- if they interacted with the outpost part then give them the morph gear stuff
    runCommand("hat " .. player .. " vest")
    runCommand("newnvg " .. player .. " snvg color 0.05 0.8 0.05")
                if not hasTool(player,"SW-762") then
        -- if they dont have an AKS-74U then give them one
        runCommand("give " .. player .. " SW-762")
        end
        if not hasTool(player,"SMG9X") then
        -- if they dont have a SMG25 then give them one
        runCommand("give " .. player .. " SMG9X")
        end
        if not hasTool(player,"Pistol") then
        -- if they dont have a M9 then give them one
        runCommand("give " .. player .. " Pistol")
        end
        if not hasTool(player,"L2 Keycard") then
        -- if they dont have a L2 Keycard then give them one
        runCommand("give " .. player .. " L2 Keycard")
        end
        if not hasTool(player,"Radio") then
        -- if they dont have a Radio then give them one
        runCommand("give " .. player .. " Radio")
        end
    end
    if hasTool(player,"L0 Keycard") then
    removeTool(player,"L0 Keycard")
    end
end

local function checkAuth(player,teamName)
    for _, team in pairs(authedTeams) do 
        if teamName == team then
            return true
        end
    end
    return false
end

event("interaction", function(Data)
-- The player
local player = Data.Value[1]
-- What they interacted with
local interaction = Data.Value[2]
-- What team they are on
local teamName = getTeam(player)
    
    if interaction == "TSOPTools" or interaction == "TSRWTools" then
    -- If they interact with TSOPTools or TSRWTools then check if they are authed
    local authed = checkAuth(player,teamName)
        if authed then
        -- If they are authed then run the giveTools function
    giveTools(player,interaction)
        end
    end
end)