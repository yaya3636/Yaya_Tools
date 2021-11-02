Movement = {}

Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Movement.RoadLoaded = false

Movement.RZNextMapId = -1

Movement.GoToAstrub = false

function Movement:LoadRoad(mapIdDest)
    if Utils:Equal(map:currentArea(), "Incarnam") then
        if not Utils:Equal(Zone:GetAreaName(Zone:GetAreaIdByMapId(mapIdDest)), "Incarnam") then
            self.GoToAstrub = true
            self:GoAstrub()
        end
    end

    if self.GoToAstrub and map:currentMapId() == 192416776 then
        self.GoToAstrub = false
        global:leaveDialog()
    end

    local currentMapId = map:currentMapId()
    if currentMapId ~= mapIdDest then
        if not map:loadMove(mapIdDest) then
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

            self.RZNextMapId = tblMapId[global:random(1, Utils:LenghtOfTable(tblMapId))]

            if not map:loadMove(self.RZNextMapId) then
                Utils:Print("Impossible de charger un chemin jusqu'a la mapId : ("..self.RZNextMapId..") changement de map avant re tentative", "RoadZone", "warn")
            end
        end

        self:MoveNext()

        Utils:Print("Apres MoveNext", "RoadZone")
        self.RZNextMapId = -1
        self:RoadZone(tblMapId)
    else
        Utils:Print("Table nil", "RoadZone", "error")
    end
end

function Movement:InMapChecker(tbl)
    for _, v in pairs(tbl) do
        if map:currentMapId() == v then
            return true
        end
    end
    return false
end

function Movement:GoAstrub()
    if Utils:Equal(map:currentArea(), "Incarnam") then
        Movement:LoadRoad(153880835)
        local possibleIdReply = {
            36982,
            36980
        }

        if map:currentMapId() == 153880835 then
            npc:npc(4398, 3)
            global:delay(1000)
            if map:currentMapId() == 153880835 then
                npc:reply(36982)
                npc:reply(36980)    
            end
        else
            Movement:MoveNext()
        end
    end
end

Movement.WorkshopInfo = {
    ["Bricoleur"] = {
        ["Astrub"] = { mapId = 192940038, singleWorkshopJob = true, workshopId = {516170,  515689} }
    },
    ["Mineur"] = {
        ["Astrub"] = { mapId = 192939010, workshopId = {
            ["Fondre"] = {
                515660,
                515666
            },
            ["Polir"] = {
                515702
            }
        }}
    },

}




return Movement