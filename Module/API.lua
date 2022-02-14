JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

API = {}

API.localAPI = {}

API.localAPI.nbTryStartAPI = 0
API.localAPI.localPort = JSON:decode(Utils:ReadFile(global:getCurrentDirectory() .. "\\YAYA\\LocalAPI\\ConfigAPI.json")).port
API.localAPI.localURL = "http://localhost:" .. API.localAPI.localPort .. "/"

API.dofusDB = {}
API.dofusDB.apiUrl = "https://api.dofusdb.fr/"

API.dofusDB.harverstable = {}

API.dofusDB.treasure = {}

-- LocalAPI

function API.localAPI:StartAPI()
    self.nbTryStartAPI = self.nbTryStartAPI + 1

    if self.nbTryStartAPI > 2 then
        Utils:Print("Impossible de lancer l'API vérifier les pré-requis", "API")
        return
    end

    if developer:getRequest(API.localAPI.localURL .. "startedAPI") ~= "sucess" then
        if self.nbTryStartAPI == 1 then
            Utils:Print("L'API n'est pas exécuter, exécution du serveur", "API")
        end
        Utils:ExecuteWinCMD("start " .. global:getCurrentDirectory() .. "\\YAYA\\LocalAPI\\install.bat " .. global:getCurrentDirectory() .. "\\YAYA\\LocalAPI", true)
        Utils:ExecuteWinCMD("start node " .. global:getCurrentDirectory() .. "\\YAYA\\LocalAPI\\app.js")
        global:delay(10000)
        self:StartAPI()
        if self.nbTryStartAPI < 3 then
            Utils:Print("L'API a été lancée", "API")
        end
    else
        if self.nbTryStartAPI < 3 then
            Utils:Print("L'API et déja exécuter", "API")
        end
    end
end

function API.localAPI:PostRequest(url, data)
    local result = JSON:decode(developer:postRequest(self.localURL .. url, data))
    if result.status == "success" then
        return result.result
    elseif result.status == "error" then
        Utils:Print(result.message, "API")
        return nil
    else
        Utils:Print("Result non définie", "API")
        return nil
    end
end

-- Harvestable

function API.dofusDB.harverstable:GetHarvestablePosition(gatherId)
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

    local jsonString = developer:getRequest(API.dofusDB.apiUrl .. self:GetURL(gatherId) .. "&$skip=0&lang=fr")
    local jsonDecode = JSON:decode(jsonString)
    local total = jsonDecode.total

    sortData(jsonDecode.data)

    for i = 1, math.ceil(total / 10) do
        jsonString = developer:getRequest(API.dofusDB.apiUrl .. self:GetURL(gatherId) .. "&$skip=" .. i * 10 .."&lang=fr")
        jsonDecode = JSON:decode(jsonString)
        sortData(jsonDecode.data)
    end

    return ret
end

function API.dofusDB.harverstable:GetHaverstablePositionInSubArea(gatherId, subAreaId)
    local ret = {}
    local mapContainsRes = self:GetHarvestablePosition(gatherId)

    for _, vMap in pairs(mapContainsRes) do
        if vMap.subAreaId == subAreaId then
            table.insert(ret, vMap)
        end
    end

    return ret
end

function API.dofusDB.harverstable:GetURL(gatherId)
    return "recoltable?resources[$in][]=" .. gatherId
end

-- Treasure

function API.dofusDB.treasure:GetNextFlagPosition(nextFlagName, nextFlagDirection)
    local currentMap = map:currentMap()
    local x, y = string.sub(currentMap, 0, string.find(currentMap, ",") - 1), string.sub(currentMap, string.find(currentMap, ",") + 1, -1)
    return API.localAPI:PostRequest("hunt/nextFlagPosition", "posX=" .. x .. "&posY=" .. y .. "&dir=" .. nextFlagDirection .. "&flagName=" .. nextFlagName)
end

Utils:Print("Vérification de l'API", "API")
Utils:Print("Penser a installer NodeJS sur votre PC", "API")
API.localAPI:StartAPI()

return API