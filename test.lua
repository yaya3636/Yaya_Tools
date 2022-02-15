Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")
JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
API = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\API.lua")

--package.loaded.json = JSON
--global:addInMemory("yaya", "value")
function move()
    --package.loaded.json = JSON
    Utils:Print(global:remember("yaya"))
    --local ret = API.dofusDB.treasure:GetNextFlagPosition("Rondin de bois", "right")
    --Utils:Dump(ret)
end