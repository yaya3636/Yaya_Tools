API = {}

API.dofusDB = {}
API.dofusDB.apiUrl = "https://api.dofusdb.fr"


function API.dofusDB:GetHarvestablePosition(gatherId)
    local ret = {}

    local function sortData(data)
        for _, v in pairs(data) do
            local map = {}
            map.mapId = v.id
            map.posX = v.pos.posX
            map.posY = v.pos.posY
            map.subAreaId = v.pos.subAreaId
            map.worldMap = v.pos.worldMap
            map.harvestableElement = v.quantities
            table.insert(ret, map)
        end
    end

    local jsonString = developer:getRequest(self.apiUrl .. "/recoltable?resources[$in][]=" .. gatherId .. "&$skip=0&lang=fr")
    local jsonDecode = JSON.decode(jsonString)
    local total = jsonDecode.total

    sortData(jsonDecode.data)

    for i = 1, math.ceil(total / 10) do
        jsonString = developer:getRequest(self.apiUrl .. "/recoltable?resources[$in][]=" .. gatherId .. "&$skip=" .. i * 10 .."&lang=fr")
        jsonDecode = JSON.decode(jsonString)
        sortData(jsonDecode.data)
    end

    return ret
end

return API