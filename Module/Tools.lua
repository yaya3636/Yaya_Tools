Tools = {}

Tools.zone = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Zone.lua")
Tools.monsters = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Monsters.lua")
Tools.craft = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Craft.lua")
Tools.utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")
Tools.graph = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Graph.lua")
Tools.movement = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Movement.lua")
Tools.JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua").new()
Tools.packet = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Packet.lua")

return Tools