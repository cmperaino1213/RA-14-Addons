-- Made by cmperaino1213 :heart:
-- Based off TimorousShadow's Chatlogger

task.wait(1)
signal("chatlogs",{
    Action = "Log",
    Time = os.date("[%Y-%m-%d %H:%M:%S]"),
    Message = ""
})

event("chatted", function(data)
    local player = data.Value[1]
    local message = data.Value[2]
    local teamName, teamColor = getTeam(player)
    local MCRank = getPlayerRankInGroup(player, 32586058)
    local devRankID = getPlayerRankInGroup(player,32613990)
    local time = os.date("[%Y-%m-%d %H:%M:%S]")
    local prefix = ""
    local action = "Chatted"

    local lowerMsg = string.lower(message)
    if lowerMsg:sub(1, 2) == "/t" or message:find("%[Team%]") or message:find("%[T%]") then
       prefix = "[T]" 
    elseif lowerMsg:sub(1, 2) == "/w" or message:find("%[To ") or message:find("%[From ") then
        prefix = "[W]"
    elseif lowerMsg:sub(1, 2) == "/e" then
        prefix = "[E]"
        if lowerMsg:sub(4,12) == "pausecaps" or lowerMsg:sub(4,11) == "pausecap" then
            if devRankID == 4 or devRankID == 5 or devRankID >= 7 or MCRank >= 7 then
                action = "Command"
            end
        elseif lowerMsg:sub(4,8) == "blink" then
            if devRankID == 4 or devRankID == 5 or devRankID >= 7 or MCRank >= 8 then
                action = "Command"
            end
        else
            action = "Chatted"
        end
    end

    if action == "Chatted" then
    message = time .. " " .. prefix .. " [" .. teamName .. "] " .. player .. ": " .. message
    else
    message = "** " .. time .. " " .. player .. ": " .. message .. " **"
    end

    signal("chatlogs",{
        Action = action,
        Time = time,
        Message = message
    })
    if action ~= "Chatted" then
        signal("cDebug",{
            Action = action,
            Time = time,
            Message = message
        })
    end
end)
