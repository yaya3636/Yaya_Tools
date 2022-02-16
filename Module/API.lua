JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

API = {}

API.localAPI = {}

API.localAPI.isStarted = false
API.localAPI.nbTryStartAPI = 0
API.localAPI.restartAPI = false
API.localAPI.localPort = JSON:decode(Utils:ReadFile(global:getCurrentDirectory() .. "\\YAYA\\LocalAPI\\ConfigAPI.json")).port
API.localAPI.localURL = "http://localhost:" .. API.localAPI.localPort .. "/"

API.dofusDB = {}
API.dofusDB.apiUrl = "https://api.dofusdb.fr/"

API.dofusDB.harverstable = {}

API.dofusDB.treasure = {}

-- LocalAPI

function API.localAPI:StartAPI()
    if not self.isStarted then
        if self.nbTryStartAPI == 0 then
            Utils:Print("Vérification de l'API", "API")
            Utils:Print("Penser a installer NodeJS sur votre PC", "API")
        end

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
            global:delay(5000)
            self:StartAPI()
            if self.nbTryStartAPI < 3 then
                Utils:Print("L'API a été lancée", "API")
                self.isStarted = true
                self.restartAPI = false
            end
        else
            if self.nbTryStartAPI < 3 then
                Utils:Print("L'API et déja exécuter", "API")
                self.isStarted = true
                self.restartAPI = false
            end
        end

    end
end

function API.localAPI:PostRequest(url, data)
    if self.isStarted then
        local result = JSON:decode(developer:postRequest(self.localURL .. url, data))

        if result == nil then
            if not self.restartAPI then
                Utils:Print("Result non définie, vérification de l'API", "API")
                self.isStarted = false
                self.nbTryStartAPI = 0
                self.restartAPI = true
                self:StartAPI()
                return self:PostRequest(url, data)
            end
            return nil
        else
            if result.status == "error" then
                Utils:Print(result.message, "API")
                return nil
            elseif result.status == "success" then
                return result.result
            end
        end
    else
        Utils:Print("L'API n'est pas exécuter, installer NodeJS et ne pas fermer l'invite de commande !", "API")
        return nil
    end
end

-- Harvestable

function API.dofusDB.harverstable:GetHarvestablePosition(gatherId)
    local ret = {}

    local function sortData(data)
        local function sortQuantity(qty)
            local t = {}
            for _, v in pairs(qty) do
                local ctrQty = {}
                ctrQty.gatherId = v.item
                ctrQty.quantity = v.quantity
                table.insert(t, ctrQty)
            end
            return t
        end
        for _, v in pairs(data) do
            local ctrMap = {}
            ctrMap.mapId = v.id
            ctrMap.posX = v.pos.posX
            ctrMap.posY = v.pos.posY
            ctrMap.subAreaId = v.pos.subAreaId
            ctrMap.worldMap = v.pos.worldMap
            ctrMap.harvestableElement = sortQuantity(v.quantities)
            if ret[tostring(ctrMap.subAreaId)] == nil then ret[tostring(ctrMap.subAreaId)] = {} end
            table.insert(ret[tostring(ctrMap.subAreaId)], ctrMap)
        end
    end
    local jsonDecode = JSON:decode(developer:getRequest(API.dofusDB.apiUrl .. self:GetURL(gatherId) .. "&$skip=0&lang=fr"))

    local total = jsonDecode.total

    sortData(jsonDecode.data)

    for i = 1, math.ceil(total / 10) do
        sortData(JSON:decode(developer:getRequest(API.dofusDB.apiUrl .. self:GetURL(gatherId) .. "&$skip=" .. i * 10 .."&lang=fr")).data)
    end

    return ret
end

function API.dofusDB.harverstable:GetHaverstablePositionInSubArea(gatherId, subAreaId)
    return self:GetHarvestablePosition(gatherId)[tostring(subAreaId)]
end

function API.dofusDB.harverstable:GetURL(gatherId)
    return "recoltable?resources[$in][]=" .. gatherId
end

-- Treasure

function API.dofusDB.treasure:GetNextFlagPosition(nextFlagName, nextFlagDirection)
    API.localAPI:StartAPI()
    local currentMap = map:currentMap()
    local x, y = string.sub(currentMap, 0, string.find(currentMap, ",") - 1), string.sub(currentMap, string.find(currentMap, ",") + 1, -1)
    return API.localAPI:PostRequest("hunt/nextFlagPosition", "posX=" .. x .. "&posY=" .. y .. "&dir=" .. nextFlagDirection .. "&flagName=" .. nextFlagName)
end

return API