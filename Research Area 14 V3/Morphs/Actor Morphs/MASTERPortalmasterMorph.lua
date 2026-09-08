-- made by cmperaino1213 :heart:
-- MASTER Portalmaster Morph (called master because it does all the PM morphs)
-- This used my template, ignore all the extra comments.

local morphs = {
morph1 = {
    -- PORTALMASTER RED
-- put the team you intend to allow access here
teamName = "Actor",
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
    rig = "Nyph",
-- set nvg as the type: UNIT = quads, UNIT1 = duals, or your equivalent of monos, duals, and quads.
    nvg = "TV",
-- set as color you want nvg's
    color = " 0.65 0.05 0.05 "
}
},
morph2 = {
    -- PORTALMASTER PURPLE
teamName = "Actor",
group = {
    groupID = 0,
    minRank = 0,
    maxRank = 255
},
morph = {
    rig = "Nyph1",
    nvg = "TV",
    color = " 0.45 0.05 0.65 "
}
    },
morph3 = {
    -- PORTALMASTER CYAN
teamName = "Actor",
group = {
    groupID = 0,
    minRank = 0,
    maxRank = 255
},
morph = {
    rig = "Nyph4",
    nvg = "TV",
    color = " 0.05 0.65 0.65 "
}
    }
}

local function updateMorph(player,rankID,selectedMorph)
	local morph1 = morphs.morph1.morph
    local morph2 = morphs.morph2.morph
	local morph3 = morphs.morph3.morph
	local minRank = morphs.morph1.group.minRank
	local maxRank = morphs.morph1.group.maxRank
    local morphList = {
        PMR = "PortalmasterPartRed",
        PMP = "PortalmasterPartPurple",
        PMC = "PortalmasterPartCyan",
    }
    local useMorph = ""
-- local variables that make it easier for me to type/read

    if selectedMorph == morphList.PMR then
        useMorph = morph1
    elseif selectedMorph == morphList.PMP then
        useMorph = morph2
    elseif selectedMorph == morphList.PMC then
        useMorph = morph3
    end

    if rankID >= minRank and rankID <= maxRank then
-- if the players rankID is greater than or equal to the minimum rank AND lower than or equal to the maximum rank then
        if useMorph.rig ~= "" then
        -- if there is a rig then morph them the defined rig
        runCommand("morph " .. player .. " " .. useMorph.rig)
        end
        if useMorph.nvg ~= "" then
    -- if there is a nvg type then morph them the NVG type
        runCommand("morph " .. player .. " " .. useMorph.nvg)
        end
runCommand("newnvg " .. player .. " iqnvg color" .. useMorph.color .. "scrambler 1 highlight 3")
end
end

event("interaction", function(Data)
local player = Data.Value[1]
local interaction = Data.Value[2]
local teamName, teamColor = getTeam(player)
-- Put the part the player should interact with here.
local part1 = "PortalmasterPartRed"
local part2 = "PortalmasterPartPurple"
local part3 = "PortalmasterPartCyan"

    if teamName == morphs.morph1.teamName then
        if interaction == part1 or interaction == part2 or interaction == part3 then
            if morphs.morph1.group.groupID ~= 0 then
                local rankID = getPlayerRankInGroup(player,morphs.morph1.group.groupID)
                updateMorph(player,rankID,interaction)
            else
                updateMorph(player,morphs.morph1.group.maxRank,interaction)
            end 
        end
    end
end)