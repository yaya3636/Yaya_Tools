Monsters = {}

JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Monsters.MonstersFilesPath = global:getCurrentDirectory() .. "\\YAYA\\Data\\Monsters\\MonstersFilesById\\"

Monsters.NonModifiedMonstersLoaded = false

Monsters.NonModifiedMonsters = {}
Monsters.ModifiedMonsters = JSON.decode(Utils:ReadFile(global:getCurrentDirectory() .. "\\YAYA\\Data\\Monsters\\monsters.json"))


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
    for _, monster in pairs(self.ModifiedMonsters) do
        for _, drop in pairs(monster.drops) do
            if drop.dropId == dropId then
                table.insert(ret, monster.monsterId)
                break
            end
        end

    end
    return ret
end

function Monsters:GetMonstersInfoByGrade(idMonster, grade)
    if not self.NonModifiedMonstersLoaded then
        Utils:Print("Veuillez patientez quelque instants chargement des données !", "Info")
        self.NonModifiedMonsters = JSON.decode(Utils:ReadFile(global:getCurrentDirectory() .. "\\YAYA\\Data\\Monsters\\NoModifiedMonsters.json"))
        self.NonModifiedMonstersLoaded = true
    end
    
    for _, v in pairs(self.NonModifiedMonsters) do
        if Utils:Equal(v.id, idMonster) then
            return v.grades[grade]
        end
    end

    return nil
end

return Monsters