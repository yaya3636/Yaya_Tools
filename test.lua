Zone = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Zone.lua")
Monsters = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Monsters.lua")
Movement = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Movement.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

function move()
    local subAreaId = Monsters:GetFavoriteSubArea(980)
    Utils:Print(subAreaId)
    local tblMapId = Zone:GetSubAreaMapId(subAreaId)
    Movement:RoadZone(tblMapId)
end