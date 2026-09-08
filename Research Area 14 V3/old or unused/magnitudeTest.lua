local partPos = Vector3.new(1853, -101, -145)
local distance = Vector3.new(0, 0, 0)
local currentPos = distance

local function magnitude(vectorA, vectorB)
local distanceC = 0
vectorA = math.abs(vectorA) 
vectorB = math.abs(vectorB)
local a = math.round(vectorA)
local b = math.round(vectorB)

if vectorA > vectorB then
    distanceC = a - b
elseif vectorB > vectorA then
    distanceC = b - a
end
print(distanceC)
return distanceC
end

local function getDistance(player, clickposition,partPos)
local vectora = Vector3.new(clickposition.X, clickposition.Y, clickposition.Z)
local vectorb = Vector3.new(partPos.X, partPos.Y, partPos.Z)
local xResult = magnitude(vectora.X, vectorb.X)
local yResult = magnitude(vectora.Y, vectorb.Y)
local zResult = magnitude(vectora.Z, vectorb.Z)
distance = Vector3.new(distance.X + xResult, distance.Y + yResult, distance.Z + zResult)
end

event("mousedown", function(Data)
local player, tool, clickpos = table.unpack(Data.Value)
        getDistance(player, clickpos,partPos)
end)