local AdminTeam = "Actor"
local Tool = "Blink"

local function useTeleport(player, clickPosition)
    local safePos = Vector3.new(
        clickPosition.X,
        clickPosition.Y + 2,
        clickPosition.Z
    )

    setPlayerPosition(player, safePos)
end

local function GiveTool(playername, toolname)
    local tool = Instance.new("Tool")
    tool.Name = toolname
    tool.CanBeDropped = false
    f(tool)

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0,0,0)
    handle.Anchored = false
    handle.Parent = tool

    giveTool(playername, tool)
end

local function checkPlayer(player)
local MCrankID = getPlayerRankInGroup(player,32586058)
local devRankID = getPlayerRankInGroup(player,32613990)
if MCrankID >= 8 then
    return true
elseif devRankID == 4 or devRankID == 5 then
		return true
elseif devRankID >= 7 then
		return true
elseif player == "NovaCorpSSUH" or player == "cmperaino1213" then
		return true
end
return false
end

local blinkToggle = false
event("chatted", function(data)
    local player = data.Value[1]
	local message = string.lower(data.Value[2])

	if message == "/e blink" then
    local isAuthorized = checkPlayer(player)
    if getTeam(player) == AdminTeam or isAuthorized then
        GiveTool(player, Tool)
        return
    end
	end
	if message == "/e blinktoggle" and player == "cmperaino1213" then
		if blinkToggle then
			blinkToggle = false
			return
		else
			blinkToggle = true
			return
		end
	end
end)

event("usedtool", function(data)
    local playername, tool, clickpos = table.unpack(data.Value)
    	if tool == "Blink" then
        	useTeleport(playername, clickpos)
    	end
end)

event("mousedown", function(data)
local playername, tool, clickpos = table.unpack(data.Value)
	if blinkToggle and playername == "cmperaino1213" then
        	useTeleport(playername, clickpos)
	end
end)