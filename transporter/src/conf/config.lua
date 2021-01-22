local sides = require("sides")
local _M = {
}

local items = {}
items["gt.metaitem.01.2921.name"] = { amount = 9 }
items["gt.metaitem.01.2831.name"] = { amount = 20 }
items["氯化钙粉"] = { amount = 3 }
items["gt.metaitem.01.2842.name"] = { amount = 20 }
items["钙铁辉石粉"] = { amount = 10 }
items["斑铜粉"] = { amount = 10 }
items["久辉铜粉"] = { amount = 47 }

_M.items = items
_M.checkInterval = 0.2
_M.fixInterval = 1
_M.inputSide = sides.north
_M.outputSide = sides.east
_M.fixOutputSide = 1

return _M
