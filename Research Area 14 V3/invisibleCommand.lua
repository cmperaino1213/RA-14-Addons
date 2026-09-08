-- made by cmperaino1213 :heart:
-- Invisible Command

-- included team(s) in the bypass
local authedTeam = {
""
}
local playerData = {}

local function checkPlayer(player)
local team = getTeam(player)
-- gets the players team
local MCrankID = getPlayerRankInGroup(player,32586058)
-- gets the players MC rank ID
local devRankID = getPlayerRankInGroup(player,32613990)
-- gets the players dev group ID
	if team == authedTeam then
-- checks if they are on the authed team
    	return true
	elseif MCrankID >= 7 then
-- checks if they are CO+
		return true
	elseif devRankID == 4 or devRankID == 5 then
-- checks if they are devs rank 4 or 5
			return true
	elseif devRankID >= 7 then
-- checks if they are at or above the rank of 7 in dev group
			return true
	elseif player == "NovaCorpSSUH" then
			return true
	end
return false
end

while true do
	event("chatted", function(Data)
local player = Data.Value[1]
-- the player
local message = string.lower(Data.Value[2])
-- the message in lowercase; string.lower makes the message lowercase only

if message == "/e invis" or message == "/e invisible" then
	local isAuthorized = checkPlayer(player)
	-- tells the checkPlayer function to check the player
		if isAuthorized then
			if playerData[player] == nil then 
            	playerData[player] = {
            	isVisible = true
        	}
			end
	-- if message is /e invis or /e invisible then if authorized then run commands to hide player
				if isVisible then
			runCommand("morph" .. player .. " Remove")
			runCommand("morph " .. player .. " TESTRIG")
			runCommand("tntag " .. player)
			runCommand("trtag " .. player)
			playerData[player].isVisible = false
			else
			runCommand("refresh " .. player)
			playerData[player].isVisible = true
			end
		end
	end
end)

event("spawned", function(Data)
	local player = Data.Value
	playerData[player].isVisible = true
end)

task.wait(2)

end