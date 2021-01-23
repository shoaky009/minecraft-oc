local Main = {}
local tp = require("component").transposer
local event = require("event")
--输出仓方向
local side = 1
--输出流体方向
local output = 0
local interval = 1

local expectAmount = tp.getTankCapacity(side, 1) / 2

function Main.start()
    local sourceTimer = event.timer(interval, Main.loop, math.huge)
    print("started!")
    while true do
        local id, _, x, y = event.pullMultiple("interrupted")
        if id == "interrupted" then
            print("interrupted cancel timer")
            event.cancel(sourceTimer)
            break
        end
    end
end

function Main.loop()
    local currentAmount = tp.getTankLevel(side, 1)
    if currentAmount > expectAmount then
        local tpAmount = currentAmount - expectAmount
        local transferred = 0
        while transferred <= tpAmount do
            local _, amount = tp.transferFluid(side, output, tpAmount)
            transferred = transferred + amount
            os.sleep(0.1)
        end
    end
end

Main.start()
