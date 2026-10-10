-- Made by cmperaino1213 :heart:
-- Based off TimorousShadow's Bridge
-- More signalRecieved 's can be added'

local function sendWebhook(content,WEBHOOK)
    http(WEBHOOK, "post", { ["Content-Type"] = "application/json" }, jsonEncode({
        -- Tells jsonEncode to encode the info
        content = content
    }))
end
local function sendEmbed(content,webhook)
    -- for enbeds, requires json encoding before this point
    http(webhook,"post",{["Content-Type"] = "application/json"},content)
end

signalReceived("joinlogs",  function(Data)
-- What the player did
local Action = Data.Action
-- Player
local Player = Data.Player
-- Time of sent
local Time = Data.Time
local content = ""
-- Webhook to send to
local Webhook = "https://discord.com/api/webhooks/1470183942035603601/po461XMcDKgX5Q9DpKhHIUtic_dTpzBvKgQtqkgkuR28hZQYJ-AEoK92Ysrrjn7nFNjS"


    if Action == "Joined" then
        -- If the action was joined, then send a webhook.
    content = Time .. " [JOINED] " .. Player
    sendWebhook(content,Webhook)
    elseif Action == "Left" then
    -- If the action was left, then send a webhook.
    content = Time .. " [LEFT] " .. Player
    sendWebhook(content,Webhook)
    elseif Action == "Log" then
    -- If the action was log, then send a webhook.
    content = Time .. "  [INFO] Join/Leavelog Started"
    sendWebhook(content,Webhook)
    end
end)

signalReceived("chatlogs",  function(Data)
local Action = Data.Action
local Time = Data.Time
local Message = Data.Message

local Webhook = "https://discord.com/api/webhooks/1470183998201401539/j58_UlHX6-JL86AiQMo0MvCiXBm_gDsu4copNRv9mBdwv7k6YDpy3JWjwLzNcWw2lKY3"

    if Action == "Log" then
    Message = Time .. "  [INFO] Chatlogger started"
    sendWebhook(Message, Webhook)
    elseif Action == "Chatted" then
        sendWebhook(Message,Webhook)
    elseif Action == "Command" then
        local cmdwebh = "https://discord.com/api/webhooks/1407482584329359460/_7btgQE_lDS5BSJ7ym-ile2EgjlEmv6vXVrqxji41QuSU53j9GOMmlo3GJu01AQwQ3fT"
        sendWebhook(Message,cmdwebh)
    end
end)

signalReceived("VIPLog", function(Data)
local Action = Data.Action
local Message = Data.Message
local player = Data.Player
local rank = Data.Rank
local team = Data.Team

local webhook = "https://discord.com/api/webhooks/1406592924237697186/KIeb9qkve6T78-vbnNptRXR_cv3lRHOvsGQks_JaeMvkb6b9dXOZ9G05YGZca8w19Zcq"
    local pl = {
		embeds = {
			{
				title = player .. " - " .. rank,
				color = 0xa31f15,
				fields = {
					{name = "", value = player .. " has deployed into RA-14 on " .. team .. " ." , inline = true},
				},
			},
		},
	}
local body = jsonEncode(pl)   
    if Action == "Log" then
    sendEmbed(body,webhook)
    end
end)

signalReceived("cDebug", function(Data)
local Action = Data.Action
local Time = Data.Time
local Message = Data.Message
local Webhook = "https://discord.com/api/webhooks/1558611649701609502/rXN9Kdhd5l0EaPWw5ckVWJcdmmcvbL2L37Jd0N2UWOihPu-97FTiaFLhXvG8LQNJV1JB"

    if Action == "Log" then
    Message = Time .. "  [INFO] Chatlogger started"
    sendWebhook(Message, Webhook)
    elseif Action == "Command" then
    sendWebhook(Message, Webhook)    
    else
    sendWebhook(Time .. " " .. Message, Webhook)
    end
end)
