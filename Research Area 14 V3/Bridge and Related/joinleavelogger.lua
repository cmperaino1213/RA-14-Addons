-- Made by cmperaino1213 :heart:
-- Based off TimorousShadow's Join/Leave logger

event("joined",function(Data)
local Player = Data.Value
signal("joinlogs",{
    Action = "Joined",
    Player = Player,
    Time = os.date("[%Y-%m-%d %H:%M:%S]")
})
end)

task.wait(1)
signal("joinlogs",{
    Action = "Log",
    Time = os.date("[%Y-%m-%d %H:%M:%S]")
})

event("left",function(Data)
local Player = Data.Value

signal("joinlogs",{
    Action = "Left",
    Player = Player,
    Time = os.date("[%Y-%m-%d %H:%M:%S]")
})
-- if all hell breaks loose then readd Player = nil
end)