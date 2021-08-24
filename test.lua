Zone = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Zone.lua")
Monsters = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Monsters.lua")
Movement = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Movement.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

function move()
    local subAreaId = Monsters:GetFavoriteSubArea(980)
    local tblMapId = Zone:GetSubAreaMapId(subAreaId)

    if Movement:InMapChecker(tblMapId) then
        map:fight()
    end
    Movement:RoadZone(tblMapId)
end