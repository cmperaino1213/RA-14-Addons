-- made by cmperaino1213 :heart:
-- simple broom giver, can be changed to any tool
local function getBroom(player)
  if hasTool(player, "Broom") then
-- If the player already has the broom tool, then remove it from the player and stop the function.
	removeTool(player,"Broom")
    return
  else
-- Otherwise, give the player the broom tool then stop the function.
	giveTool(player,"Broom")
    return
  end
end

event("interaction", function(Data)
  local player = Data.Value[1]
-- Player who interacted with the part
  local interaction = Data.Value[2]
-- What part was interacted with

if interaction == "broomGiver" then
-- If the interaction was with the broom giver then run the getBroom function,
-- Use the player variable for the functions first value
	getBroom(player)
    end
end)