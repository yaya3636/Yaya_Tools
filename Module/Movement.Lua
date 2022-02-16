Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")
Movement = {}

Movement.havenbagMap = {

    { map = 165153537, path = "left" },

    --Mine Ebbernard

    { map = 29622275, path = "450" },
    { map = 29622272, path = "450" },
    { map = 29622531, path = "450" },
    { map = 29622534, path = "424" },

    -- Mine manganese ile dragoeuf

    { map = 86246410, path = "431" },

    -- Mine Bwork

    { map = 104860165, path = "444" },
    { map = 104859139, path = "444" },
    { map = 104860169, path = "263" },
    { map = 104861193, path = "254" },
    { map = 104859145, path = "457" },
    { map = 104858121, path = "507" },
    { map = 104861189, path = "451" },
    { map = 104862213, path = "376" },
    { map = 104858119, path = "207" },

    { map = 104861191, path = "457" },
    { map = 104860167, path = "478" },
    { map = 104859143, path = "543" },
    { map = 104862215, path = "472" },


    -- Mine Maksage

    { map = 57017861, path = "270" },
    { map = 56886787, path = "396" },
    { map = 56885763, path = "436" },
    { map = 57016837, path = "401" },
    { map = 57016835, path = "409" },
    { map = 57017859, path = "395" },

    -- Malle au tresor

    { map = 128452097, path = "504" },
    { map = 128451073, door = "549" },

    -- Zone astrub

    { map = 188745734, path = "bottom" },

    -- Territoire des porco

    { map = 72619524, path = "left" },
}

Movement.teleported = false

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

function Movement:HavenBag()
    local canHaven = true
    for _, v in pairs(self.havenbagMap) do
        if map:currentMapId() == v.map then
            canHaven = false
            if v.door then
                map:door(tonumber(v.door))
            elseif v.path then
                map:changeMap(v.path)
            end
            global:delay(1000)
        end
    end

    if map:currentMap() ~= "0,0" and canHaven then
        map:changeMap('havenbag')
    end
end

function Movement:UseZaap(mapIdDest, zaapExcepted)
        local source = 3

        if map:currentMap() ~= "0,0" then
            source = 0
        end

        local closestZaap = map:closestZaapV2(mapIdDest, zaapExcepted)

        if closestZaap == 0 then
            Utils:Print("Aucun zaap trouvée pour la map (" .. mapIdDest .. ")", "error")
            global:leaveDialog()
            map:changeMap('havenbag')
            return false
        else
            self.teleported = true
            map:toZaap(closestZaap, source)
            global:leaveDialog()
            return false
        end
end

function Movement:HavenBagTP(dest, message, forbiddenZaap)
    if self.teleported == nil then
        self.teleported = true
    end

    if not self.teleported then
        self:HavenBag()
        if type(message) == "string" then
            Utils:Print(message, "Move")
        end
        self.teleported = Movement:UseZaap(dest, forbiddenZaap)
        global:delay(1000)
    end

end

return Movement