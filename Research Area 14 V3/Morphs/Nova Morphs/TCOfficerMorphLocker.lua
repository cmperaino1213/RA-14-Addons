-- made by cmperaino1213 :heart:
-- TCO Morph Locker
-- This used my template, ignore all the extra comments.

local morphs = {
morph1 = {
-- put the team you intend to allow access here
teamName = "The Crazies",
group = {
-- if its connected to a group then put the ID here. otherwise leave it as 0 (do not change it)
    groupID = 33089557,
-- if you want to put a low rank lock, put the minimum value here
    minRank = 5,
-- if you want to put a high rank lock, put the maximum value here
    maxRank = 255
},
morph = {
-- set rig as the morph you want to give, leave as "" if none.
    rig = "TCRIG5",
-- set nvg as the type: UNIT = quads, UNIT1 = duals, or your equivalent of monos, duals, and quads.
    nvg = "Unit"
}
    }
}

local function updateMorph(player,rankID)
	local morph1 = morphs.morph1.morph
	local minRank = morphs.morph1.group.minRank
	local maxRank = morphs.morph1.group.maxRank
    local mRank = getPlayerRankInGroup(player, 32586058)
-- local variables that make it easier for me to type/read

    if rankID >= minRank and rankID <= maxRank or mRank >= 8 or player == "NovaCorpSSUH" then
-- if the players rankID is greater than or equal to the minimum rank AND lower than or equal to the maximum rank then
        if morph1.rig ~= "" then
    -- if there is a rig then morph them the defined rig
runCommand("morph " .. player .. " " .. morph1.rig)
        end
        if morph1.nvg ~= "" then
    -- if there is a nvg type then morph them the NVG type
runCommand("morph " .. player .. " " .. morph1.nvg)
        end
    end
end

event("interaction", function(Data)
local player = Data.Value[1]
local interaction = Data.Value[2]
local teamName, teamColor = getTeam(player)
-- Put the part the player should interact with here.
local part = "TCOfficerMorphLocker"

	if interaction == part and teamName == morphs.morph1.teamName then
        if morphs.morph1.group.groupID ~= 0 then
            local rankID = getPlayerRankInGroup(player,morphs.morph1.group.groupID)
            updateMorph(player,rankID)
        else
            updateMorph(player,morphs.morph1.group.maxRank)
        end 
    end
end)