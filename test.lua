Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")
JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
API = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\API.lua")

function move()
    local ret = API.dofusDB.treasure:GetNextFlagPosition("Rondin de bois", "right")
    Utils:Dump(ret)
end