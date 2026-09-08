-- made by cmperaino1213 :heart:
-- ED morph locker

local morphs = {
    trainee = " EDTrainee",
    low = " EDLow",
    mid = " EDMid",
    fore = " EDFore",
    high = " EDHigh",
    chairman = " EDChairman"
}

local function giveMorph(player, rankID)
    -- [LOGIC]
    -- if rankID is less than or equal to 1 then (includes guests)
if rankID <= 1 then
    -- give them the trainee morph
runCommand("morph " .. player .. morphs.trainee)
elseif rankID == 2 or rankID == 3 then
    -- elseif the rankID is 2 or 3 then
        -- give the low rank morph
    runCommand("morph " .. player .. morphs.low)
elseif rankID >= 4 and rankID <= 7 then
    -- elseif the rankID is greater than or equal to 4 and less than or equal to 7 then
        -- give the middle rank morph
    runCommand("morph " .. player .. morphs.mid)
elseif rankID == 8 then
    -- elseif the rankID is 8
        -- give the foreperson morph
    runCommand("morph " .. player .. morphs.fore)
elseif rankID >= 9 and rankID <= 253 then
    -- elseif the rankID is greater than or equal to 9 and less than or equal to 253 then
        -- give the high rank morph
    runCommand("morph " .. player .. morphs.high)
elseif rankID == 254 then
    -- elseif the rankID is 254 then
        -- give the chairman morph
    runCommand("morph " .. player .. morphs.chairman)
    end
end

event("interaction", function(Data)
local player = Data.Value[1]
local interaction = Data.Value[2]
local teamName, teamColor = getTeam(player)

if interaction == "EDMorphLocker" and teamName == "Engineering Department" then
-- checks if the player interacted with the EDMorphLocker part and is on the Engineering Department team
    -- gets the rankID for the player
    local rankID = getPlayerRankInGroup(player,32586482)
    -- the event then tells the giveMorph function who the player is and the rankID
    giveMorph(player, rankID)
    end
end)