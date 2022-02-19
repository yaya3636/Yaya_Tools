Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")
JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
API = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\API.lua")
Notifications = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Notifications.lua").pushsafer:Create({key = "yourPrivateKey", deviceID = 50315})


function move()
    --local ret = API.dofusDB.treasure:GetNextFlagPosition("tonneau", "top", -7, 0)
    --local allArea = API.dofusDB.harverstable:GetHarvestablePosition(303)
    --local sArea = API.dofusDB.harverstable:GetHaverstablePositionInSubArea(303, 103)
    --Utils:Dump(NOTIFICATIONS)
    Notifications:SendNotification({title = "BOT", msg = "Alerte modérateur !"})
    --Utils:Print(Utils:LenghtOfTable(ret))
end