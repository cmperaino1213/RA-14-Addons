-- made by cmperaino1213 :heart:
-- First attempt at an entity script :D
-- Candy Bowl Entity (no classification yet)

local resetTimer = 60

local playersInteracted = {}
local playerData = {}

local function chooseCandy(player)
local candy = math.random(1, 50)
local currentHealth = getPlayerMaxHealth(player)
local newHealth = currentHealth
local team = getTeam(player)
playerData[player].candyEaten = playerData[player].candyEaten + 1

    if playerData[player].candyEaten >= 12 then
        runCommand("alert " .. player .. " You feel your heart stop...")
        kill(player)
        return
    end
    if team ~= "Actor" then
        if candy >= 1 and candy <= 11 then
        runCommand("alert " .. player .. " Its a rather sour taste, however the pain feels nice. You feel a bit stronger..")
            if currentHealth < 200 then
            newHealth = currentHealth + 25
            else
            newHealth = 200
            end
        setPlayerMaxHealth(player, newHealth)
        end
        if candy >= 12 and candy <= 23 then
        runCommand("alert " .. player .. " Nothing seemed to happen, you just enjoyed a sweet piece of candy.")
        end
        if candy >= 24 and candy <= 27 then
        runCommand("alert " .. player .. " It tasted salty.. did you change?")
        runCommand("scale " .. player .. " 1 1 1 1.25")
        end
        if candy >= 28 and candy <= 29  then
        runCommand("alert " .. player .. " It's got an old candy taste. You feel rather.. musical?")
        runCommand("run stopsounds " .. player .. " & playsound " .. player .. " 9045766377 yes 0.5 ")
        end
        if candy == 30 then
        runCommand("alert " .. player .. " USE YOUR POWER WHILE YOU CAN. YOU MUST. TIME IS LIMITED.")
            if currentHealth < 400 then    
            setPlayerMaxHealth(player, 400)
            heal(player)
            end
        runCommand("run delay 120 maxHealth " .. player .. " 100")
        end
        if candy >= 31 and candy <= 35 then
        runCommand("alert " .. player .. " It tasted bitter.. you look different..")
        runCommand("skin " .. player .. " 140 173 143")
        end
        if candy >= 36 and candy <= 49 then
        runCommand("alert " .. player .. " It tastes like a rotten egg.. you don't feel so great.")
        damage(player, 25)
        end
        if candy >= 50 then
        runCommand("alert " .. player .. " You feel your heart stop.")
        kill(player)
        end
    else
        runCommand("alert " .. player .. " It tastes strange.. almost like something YOU shouldn't be having.")
    end
end

event("interaction", function(data)
local player = data.Value[1]
local part = data.Value[2]

    if part == "candyPart" then
    if playerData[player] == nil then 
            playerData[player] = {
            candyEaten = 0,
            cooldown = 0
        }
    end
    table.insert(playersInteracted, player)
        if playerData[player].cooldown <= 0 then
        chooseCandy(player)
        playerData[player].cooldown = 4
        end
    end
end)

while true do
    resetTimer = resetTimer - 2
    for _, player in pairs(playersInteracted) do
        playerData[player].cooldown = playerData[player].cooldown - 2
        if resetTimer <= 0 then
            playerData[player].candyEaten = 0
            resetTimer = 60
        end
    end
    task.wait(1)
end