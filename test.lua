Zone = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Zone.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

function move()
    Utils:Print(Zone:GetAreaName(Zone:GetArea(446)))
    Utils:Dump(Zone:GetSubArea(Zone:GetArea(446)))
end