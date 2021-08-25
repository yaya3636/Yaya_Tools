Zone = {}

JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Zone.SubAreaPath = global:getCurrentDirectory() .. "\\YAYA\\Data\\SubArea\\"
Zone.AreaPath = global:getCurrentDirectory() .. "\\YAYA\\Data\\Area\\"

function Zone:GetAreaMapId(areaId)
    local areaInfo = JSON.decode(Utils:ReadFile(self.AreaPath .. areaId .. ".json"))

    if areaInfo then
        local mapId = {}

        for _, v in pairs(areaInfo.subArea) do
            local tmpMapId = self:GetSubAreaMapId(v)

            for _, j in pairs(tmpMapId) do
                table.insert(mapId, j)
            end
        end

        return mapId
    end
    return nil
end

function Zone:GetAreaName(areaId)
    local areaInfo = JSON.decode(Utils:ReadFile(self.AreaPath .. areaId .. ".json"))

    if areaInfo then
        return areaInfo.areaName
    end
    return nil
end

function Zone:GetSubArea(areaId)
    local areaInfo = JSON.decode(Utils:ReadFile(self.AreaPath .. areaId .. ".json"))

    if areaInfo then
        return areaInfo.subArea
    end
    return nil
end

function Zone:GetSubAreaMapId(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.mapIds
    end
    return nil
end

function Zone:GetSubAreaMonsters(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.monsters
    end
    return nil
end

function Zone:GetSubAreaName(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.subAreaName
    end
    return nil
end

function Zone:GetArea(subAreaId)
    local subAreaInfo = JSON.decode(Utils:ReadFile(self.SubAreaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.areaId
    end
    return nil
end

return Zone