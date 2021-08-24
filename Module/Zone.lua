Zone = {}

JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Zone.SubAreaPath = global:getCurrentDirectory() .. "\\YAYA\\SubArea\\"
Zone.AreaPath = global:getCurrentDirectory() .. "\\YAYA\\Area\\"

function Zone:GetAreaMapid(areaId)
    local areaInfo = JSON.decode(Utils:ReadFile(self.AreaPath .. areaId .. ".json"))

    local mapId = {}

    for _, v in pairs(areaInfo.subArea) do
        local tmpMapId = self:GetSubAreaMapId(v)

        for _, j in pairs(tmpMapId) do
            table.insert(mapId, j)
        end
    end

    return mapId
end

function Zone:GetAreaName(areaId)
    local areaInfo = JSON.decode(Utils:ReadFile(self.AreaPath .. areaId .. ".json"))

    return areaInfo.areaName
end

function Zone:GetSubArea(areaId)
    local areaInfo = JSON.decode(Utils:ReadFile(self.AreaPath .. areaId .. ".json"))

    return areaInfo.subArea
end

function Zone:GetSubAreaMapId(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    return subAreaInfo.mapIds
end

function Zone:GetSubAreaMonsters(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    return subAreaInfo.monsters
end

function Zone:GetSubAreaName(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    return subAreaInfo.subAreaName
end

function Zone:GetArea(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))
    return subAreaInfo.areaId
end

return Zone