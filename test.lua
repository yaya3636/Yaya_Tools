Zone = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Zone.lua")
Monsters = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Monsters.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

function move()
    Utils:Print(Zone:GetAreaName(Zone:GetArea(446)))
    Utils:Dump(Monsters:GetMonsterSubArea(36))
    Utils:Dump(Monsters:GetMonsterDrops(36))
    Utils:Dump(Monsters:GetMonsterIdByDropId(2269))
end