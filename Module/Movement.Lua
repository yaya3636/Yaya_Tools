Movement = {}

Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Movement.RoadLoaded = false

Movement.RZNextMapId = -1

function Movement:LoadRoad(mapIdDest)
    local currentMapId = map:currentMapId()
    if currentMapId ~= mapIdDest and not self.RoadLoaded then
        if not map:loadRoadToMapId(mapIdDest) then
            Utils:Print("Impossible de charger un chemin jusqu'a la map ("..mapIdDest..")", "LoadRoad")
        else
            self.RoadLoaded = true
        end
    elseif currentMapId == mapIdDest then
        self.RoadLoaded = false
    end
end

function Movement:MoveNext()
    map:moveRoadNext()
end

function Movement:RoadZone(tblMapId)
    if tblMapId ~= nil and Utils:LenghtOfTable(tblMapId) > 0 then
        if map:currentMapId() == self.RZNextMapId or self.RZNextMapId == -1 then
            --Utils:Print("Get next rand roadMapId")

            local maxDist = 0
            local tblMapIdDist = {}

            for _, v in pairs(tblMapId) do
                local dist = map:GetDistance(map:currentMapId(), v)
                local ins = { mapId = v, dist = dist }
                if dist > maxDist then
                    maxDist = dist
                end
                --Print("Dist : "..dist)
                table.insert(tblMapIdDist, ins)
            end
            --Print("MaxDist : "..maxDist)

            tblMapIdDist = Utils:ShuffleTbl(tblMapIdDist)

            for _, v in pairs(tblMapIdDist) do
                if v.dist >= math.ceil(maxDist / 1.5) then
                    self.RZNextMapId = v.mapId
                    break
                end
            end

            --Utils:Print("Next roadMapId = "..self.RZNextMapId)

            if not map:loadMove(self.RZNextMapId) then
                Utils:Print("Impossible de charger un chemin jusqu'a la mapId : ("..self.RZNextMapId..") changement de map avant re tentative", "RoadZone", "warn")
                --local dir, mapId = Get_RandomNeighbourMapId()
                --map:changeMap(dir)
            end
        end

        self:MoveNext()

        --Utils:Print("Apres MoveNext", "RoadZone")
        self.RZNextMapId = -1
    else
        Utils:Print("Table nil", "RoadZone", "error")
    end
end

return Movement