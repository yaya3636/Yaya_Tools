
const express = require("express")
const app = express()
const fs = require("fs")
const axios = require("axios")
const morgan = require("morgan")
const bodyParser = require("body-parser")

const urlDofusDB = "https://api.dofusdb.fr/"
var PORT = 0

try {
    const data = fs.readFileSync(__dirname + '/ConfigAPI.json', 'utf8')
    var jsonOBJ = JSON.parse(data)
    PORT = jsonOBJ.port
} catch (err) {
    console.error(err)
}

// API

app.use(morgan("dev"))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended : false }))


app.get("/startedAPI", (req, res) => {
    res.status(200).send('sucess')
})

// DofusDB

// Chasse aux trésor

app.post("/hunt/nextFlagPosition", async (req, res) => {
    //console.log(req.body.posX + "," + req.body.posY + " : " + req.body.dir)
    var data = await GetHuntFlagData(req.body.dir, req.body.posX, req.body.posY)
    //console.log(data)

    data = Sort(data, (a, b) => {
        if (IsStringEquals(req.body.dir, "Right")) {
            return a.posX < b.posX
        } else if (IsStringEquals(req.body.dir, "Left")) {
            return a.posX > b.posX
        } else if (IsStringEquals(req.body.dir, "Top")) {
            return a.posY > b.posY
        } else if (IsStringEquals(req.body.dir, "Bottom")) {
            return a.posY < b.posY
        }     
    })

    //console.log(data)

    var ret = SortPos(data, req.body.flagName)


    if (ret) {
        res.status(200).json(Success(ret))
    } else {
        res.status(404).json(Error("Indice non trouvée, pos : [" + req.body.posX + "," + req.body.posY + "] dir : " + req.body.dir + " indice : " + req.body.flagName))
    }
})

app.listen(PORT, () => {
    console.log("Le serveur a démarré sur le port : " + PORT)
})


// Function hunt

function SortPos(d, flagName) {
    for (var i = 0; i < d.length - 1; i++) {
        var equal = false
        var flg = ""
        d[i].clue.forEach(e => {
            //console.log(flagName + " : " + e)
            if (IsStringEquals(flagName, e)) {
                //console.log("equal")
                equal = true
                flg = e
            }
        })    
        if (equal) {
            return {
                posX: d[i].posX,
                posY: d[i].posY,
                flagName: flg
            }
        }
    }
    return null
}

async function GetHuntFlagData(dir, posX, posY) {
    var total = 10
    var data = new Map()
    var ret = []


    for (let i = 0; i < Math.ceil(total / 10); i++) {
        var skip = ""
        if (i > 0) {
            skip = "&$skip=" + i * 10
        }
        //console.log(urlDofusDB + GetHuntURL(dir, posX, posY) + skip)

        await axios.get(urlDofusDB + GetHuntURL(dir, posX, posY) + skip)
        .then(function (response) {
            total = response.data.total
            response.data.data.forEach(element => {
                const key = element.x + "," + element.y
                if (!data.has(key)) {
                    data.set(key, { 
                        posX: element.x,
                        posY: element.y,
                        clue: [element.clue.name.fr]
                    })
                } else {
                    var map = data.get(key)
                    if (!map.clue.includes(element.clue.name.fr)) {
                        map.clue.push(element.clue.name.fr)
                        data.set(key, map)
                    }
                }

            })
        })
        .catch((response) => {
            console.log(response)
        })

    }

    data.forEach(e => {
        ret.push(e)
    })

    return ret
}

function GetHuntURL(dir, posX, posY) {
    if ( IsStringEquals(dir, "Right") ) {
        return "map-clue?$sort[name.fr]=1&y=" + posY + "&x[$gt]=" + posX + "&x[$lte]=" + (parseInt(posX) + 10) + "&lang=fr"
    } else if ( IsStringEquals(dir, "Left")) {
        return "map-clue?$sort[name.fr]=1&y=" + posY + "&x[$lt]=" + posX + "&x[$gte]=" + (parseInt(posX) - 10) + "&lang=fr"
    } else if ( IsStringEquals(dir, "Top")) {
        return "map-clue?$sort[name.fr]=1&x=" + posX + "&y[$lt]=" + posY + "&y[$gte]=" + (parseInt(posY) - 10) + "&lang=fr"
    } else if ( IsStringEquals(dir, "Bottom")) {
        return "map-clue?$sort[name.fr]=1&x=" + posX + "&y[$gt]=" + posY + "&y[$lte]=" + (parseInt(posY) + 10) + "&lang=fr"
    }
}

function IsStringEquals(str1, str2) {
    return new String(str1).valueOf().toLowerCase().normalize("NFC") == String(str2).valueOf().toLowerCase().normalize("NFC")
}

// Function API

function Sort(array, fn) {
    var numArray = array
    for (var i = 0; i < numArray.length - 1; i++) {
        var min = i;
        for (var j = i + 1; j < numArray.length; j++) {
            if (fn(numArray[j], numArray[min])) {
                min = j
            }
        }
        if (min != i) {
            var target = numArray[i]
            numArray[i] = numArray[min]
            numArray[min] = target
        }
    }
    return numArray
}

function Success(result) {
    return {
        status: "success",
        result: result
    }
}

function Error(message) {
    return {
        status: "error",
        message: message
    }
}