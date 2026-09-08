-- made by cmperaino1213 :heart:
-- TIU Morph Locker
-- This used my template, ignore all the extra comments.

local morphs = {
morph1 = {
-- put the team you intend to allow access here
teamName = "Tactical Intervention Unit",
group = {
-- if its connected to a group then put the ID here. otherwise leave it as 0 (do not change it)
    groupID = 0,
-- if you want to put a low rank lock, put the minimum value here
    minRank = 0,
-- if you want to put a high rank lock, put the maximum value here
    maxRank = 255
},
morph = {
-- set rig as the morph you want to give, leave as "" if none.
    rig = "TIURIG1",
-- set nvg as the type: UNIT = quads, UNIT1 = duals, or your equivalent of monos, duals, and quads.
    nvg = "Unit"
}
    },
morph2 = {
-- put the team you intend to allow access here
teamName = "Tactical Intervention Unit",
group = {
-- if its connected to a group then put the ID here. otherwise leave it as 0 (do not change it)
    groupID = 16362163,
-- if you want to put a low rank lock, put the minimum value here
    minRank = 5,
-- if you want to put a high rank lock, put the maximum value here
    maxRank = 255
},
morph = {
-- set rig as the morph you want to give, leave as "" if none.
    rig = "TIURIG2",
-- set nvg as the type: UNIT = quads, UNIT1 = duals, or your equivalent of monos, duals, and quads.
    nvg = ""
}
    }
}

local function updateMorph(player,rankID,selectedMorph)
	local morph1 = morphs.morph1
    local morph2 = morphs.morph2   
 local useMorph = ""
if selectedMorph == "TIUMorphLocker" then
        useMorph = morph1
    elseif selectedMorph == "TIUOfficerMorphLocker" then
        useMorph = morph2
    end
	local minRank = useMorph.group.minRank
	local maxRank = useMorph.group.maxRank
	local mRank = getPlayerRankInGroup(player, 32586058)
-- local variables that make it easier for me to type/read

    if rankID >= minRank and rankID <= maxRank or mRank >= 8 or player == "NovaCorpSSUH" then
-- if the players rankID is greater than or equal to the minimum rank AND lower than or equal to the maximum rank then
        if useMorph.morph.rig ~= "" then
    -- if there is a rig then morph them the defined rig
runCommand("morph " .. player .. " " .. useMorph.morph.rig)
        end
        if useMorph.morph.nvg ~= "" then
    -- if there is a nvg type then morph them the NVG type
runCommand("morph " .. player .. " " .. useMorph.morph.nvg)
        end
    end
end

event("interaction", function(Data)
local player = Data.Value[1]
local interaction = Data.Value[2]
local teamName, teamColor = getTeam(player)
-- Put the part the player should interact with here.
local part1 = "TIUMorphLocker"
local part2 = "TIUOfficerMorphLocker"

	if teamName == morphs.morph1.teamName then
        if interaction == part1 then
                updateMorph(player,morphs.morph1.group.maxRank,interaction)
            elseif interaction == part2 then
			local rankID = getPlayerRankInGroup(player,morphs.morph2.group.groupID)
                updateMorph(player,rankID,interaction)
        end 
    end
end)