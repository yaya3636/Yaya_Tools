Utils =  {}

function Utils:Equal(str1, str2)
    if str1 == nil then
        str1 = ""
    end
    if str2 == nil then
        str2 = ""
    end
    return string.lower(tostring(str1)) == string.lower(tostring(str2))
end

function Utils:Print(msg, header, msgType)
    local prefabStr = ""

    msg = tostring(msg)

    if header ~= nil then
        prefabStr = "["..string.upper(header).."] "..msg
    else
        prefabStr = msg
    end

    if msgType == nil then
        global:printSuccess(prefabStr)
    elseif string.lower(msgType) == "warn" then
        global:printMessage("[WARNING]["..header.."] "..msg)
    elseif string.lower(msgType) == "error" then
        global:printError("[ERROR]["..header.."] "..msg)
    end
end

function Utils:Dump(tbl)
    local function dmp(t, l, k)
        if type(t) == "table" then
            self:Print(string.format ("% s% s:", string.rep ("", l * 2 ), tostring (k)))
            for key, v in pairs(t) do
                dmp(v, l + 1, key)
            end
        else
            self:Print(string.format ("% s% s:% s", string.rep ( "", l * 2), tostring (k), tostring (t)))
        end
    end

    dmp(tbl, 1, "root")
end

function Utils:GetTableValue(index, tbl)
    local i = 1
    for _, v in pairs(tbl) do
        if index == i then
            return v
        end
        i = i + 1
    end
end

function Utils:LenghtOfTable(tbl)
    if tbl ~= nil then
        local ret = 0

        for _, _ in pairs(tbl) do
            ret = ret + 1
        end

        return ret
    else
        return 0
    end
end

function Utils:ShuffleTbl(tbl)
    local ret = tbl

    for i = #ret, 2, -1 do
        local j = global:random(1, i)
        ret[i], ret[j] = ret[j], ret[i]
    end

    return ret
end

function Utils:GenerateDateTime(format)
    local dateTimeTable = os.date('*t')
    local ret

    if format == "h" then
        ret = dateTimeTable.hour
    elseif format == "m" then
        ret = dateTimeTable.min
    elseif format == "s" then
        ret = dateTimeTable.sec
    elseif format == "hm" then
        ret = { hour = dateTimeTable.hour, min = dateTimeTable.min }
    elseif format == "ms" then
        ret = { min = dateTimeTable.min, sec = dateTimeTable.sec }
    elseif format == "hms" then
        ret = { hour = dateTimeTable.hour, min = dateTimeTable.min, sec = dateTimeTable.sec }
    end

    if ret == nil then 
        Utils:Print("Erreur format", "GenerateDateTime", "error")
    else
        return ret
    end
end

function Utils:ReadFile(path)
    if self:FileExists(path) then
        local file = io.open(path, "rb") -- r read mode and b binary mode
        if not file then return nil end
        local content = file:read "*a" -- *a or *all reads the whole file
        file:close()
        return content
    end
    return nil
end

function Utils:FileExists(path)
    local f=io.open(path,"r")
    if f~=nil then io.close(f) return true else return false end
 end

return Utils