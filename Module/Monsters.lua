Monsters = {}

JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Monsters.MonstersPath = global:getCurrentDirectory() .. "\\YAYA\\Monsters\\monsters.json"
Monsters.MonstersFilesPath = global:getCurrentDirectory() .. "\\YAYA\\Monsters\\MonstersFilesById\\"

function Monsters:GetMonsterName(idMonster)
    local monsterInfo = JSON.decode(Utils:ReadFile(self.MonstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.monsterName
    end
    return nil
end

function Monsters:GetFavoriteSubArea(idMonster)
    local monsterInfo = JSON.decode(Utils:ReadFile(self.MonstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.favoriteSubArea
    end
    return nil
end

function Monsters:GetMonsterDrops(idMonster)
    local monsterInfo = JSON.decode(Utils:ReadFile(self.MonstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.drops
    end
    return nil
end

function Monsters:GetMonsterSubArea(idMonster)
    local monsterInfo = JSON.decode(Utils:ReadFile(self.MonstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.subAreas
    end
    return nil
end

function Monsters:GetMonsterIdByDropId(dropId)
    local ret = {}

    local allMonster = JSON.decode(Utils:ReadFile(self.MonstersPath))

    if allMonster then
        for _, monster in pairs(allMonster) do
            for _, drop in pairs(monster.drops) do
                if drop.dropId == dropId then
                    table.insert(ret, monster.monsterId)
                    break
                end
            end

        end
    end
    return ret
end

return Monsters