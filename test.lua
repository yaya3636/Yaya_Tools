Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")
JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
API = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\API.lua")

function move()
    --local ret = API.dofusDB.treasure:GetNextFlagPosition("Rondin de bois", "right")
    local ret = API.dofusDB.harverstable:GetHaverstablePositionInSubArea(303, 103)
    
    Utils:Dump(ret, 500)
    --Utils:Print(Utils:LenghtOfTable(ret))
end