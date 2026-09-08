local targetTeam = "Nothing To See Here"

event("spawned", function(Data)
    local player = Data.Value
    local team = getTeam(player)
    if team == targetTeam then
		runCommand("morph " .. player .. " " .. "NTSHAN")
        runCommand("morph " .. player .. " " .. "Unit")
    end
end)