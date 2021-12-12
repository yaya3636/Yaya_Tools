Utils =  {}

Utils.cellAray = {}

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

function Utils:Dump(tbl, printDelay)
    printDelay = printDelay or 0

    local function dmp(t, l, k, rep)
        global:delay(printDelay)
        if type(t) == "table" then
            self:Print(string.format("% s% s:", string.rep(rep, l * 3), tostring (k)))
            for key, v in pairs(t) do
                dmp(v, l + 1, key, " ")
            end
        else
            self:Print(string.format("% s% s:% s", string.rep(rep, l * 3), tostring (k), tostring (t)))
        end
    end

    dmp(tbl, 1, "root", "")
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

function Utils:ExistKeyTable(t, key)
    for k, _ in pairs(t) do
        if self:Equal(k, key) then
            return true
        end
    end
    return false
end

function Utils:ShuffleTbl(tbl)
    local ret = tbl

    for i = #ret, 1, -1 do
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
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

function Utils:FileExists(path)
    local f=io.open(path,"r")
    if f~=nil then io.close(f) return true else return false end
end

function Utils:InitCellsArray()
    local startX = 0
    local startY = 0
    local cell = 0
    local axeX = 0
    local axeY = 0

    while (axeX < 20) do
        axeY = 0

        while (axeY < 14) do
            self.cellAray[cell] = {x = startX + axeY, y = startY + axeY}
            cell = cell + 1
            axeY = axeY + 1
        end

        startX = startX + 1
        axeY = 0

        while (axeY < 14) do
            self.cellAray[cell] = {x = startX + axeY, y = startY + axeY}
            cell = cell + 1
            axeY = axeY + 1
        end

        startY = startY - 1
        axeX = axeX + 1
    end
end

function Utils:CellIdToCoord(cellId)
    if Utils:IsCellIdValid(cellId) then
        return self.cellAray[cellId]
    end

    return nil
end

function Utils:CoordToCellId(coord)
	return math.floor((((coord.x - coord.y) * 14) + coord.y) + ((coord.x - coord.y) / 2))
end

function Utils:IsCellIdValid(cellId)
	return (cellId >= 0 and cellId < 560)
end

function Utils:ManhattanDistanceCellId(fromCellId, toCellId)
	local fromCoord = Utils:CellIdToCoord(fromCellId)
	local toCoord = Utils:CellIdToCoord(toCellId)
	if fromCoord ~= nil and toCoord ~= nil then
		return (math.abs(toCoord.x - fromCoord.x) + math.abs(toCoord.y - fromCoord.y))
	end
	return nil
end

function Utils:ManhattanDistanceCoord(fromCoord, toCoord)
	return (math.abs(toCoord.x - fromCoord.x) + math.abs(toCoord.y - fromCoord.y))
end

Utils:InitCellsArray()

return Utils