local Main = {}
local tp = require("component").transposer
local event = require("event")
--输出仓方向
local side = 1
--输出流体方向
local output = 0
local interval = 1

local expectAmount = tp.getTankCapacity(side, 1) / 2

local sourceTimer = event.timer(interval, Main.loop, math.huge)

function Main.loop()
    local currentAmount = tp.getTankLevel(side, 1)
    if currentAmount > expectAmount then
        local tpAmount = currentAmount - expectAmount
        local transferred = 0
        while transferred >= tpAmount do
            local _, amount = tp.transferFluid(side, output, tpAmount)
            transferred = transferred + amount
        end
    end
end

return Main

