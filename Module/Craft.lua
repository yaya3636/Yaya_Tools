Craft = {}

JSON = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\JSON.lua")
Utils = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Utils.lua")

Craft.CraftPath = global:getCurrentDirectory() .. "\\YAYA\\Data\\Recipes\\"


function Craft:GetCraftInfo(craftId)
    local craftInfo = JSON.decode(Utils:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo
    end
    return nil
end

function Craft:GetJobId(craftId)
    local craftInfo = JSON.decode(Utils:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.jobId
    end
    return nil
end

function Craft:GetSkillId(craftId)
    local craftInfo = JSON.decode(Utils:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.skillId
    end
    return nil
end

function Craft:GetLevel(craftId)
    local craftInfo = JSON.decode(Utils:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.craftLvl
    end
    return nil
end

function Craft:GetTypeId(craftId)
    local craftInfo = JSON.decode(Utils:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.typeId
    end
    return nil
end

function Craft:GetIngredients(craftId)
    local craftInfo = JSON.decode(Utils:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.ingredients
    end
    return nil
end

return Craft