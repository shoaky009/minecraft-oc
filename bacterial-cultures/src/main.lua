local Main = {}
local tp = component.proxy(component.list("transposer")())
--输出仓方向
local side = 1
--输出流体方向
local output = 0
local interval = 1

local expectAmount = tp.getTankCapacity(side, 1) / 2

function Main.start()
    while true do
        computer.pullSignal(interval)
        local currentAmount = tp.getTankLevel(side, 1)
        if currentAmount > expectAmount then
            local tpAmount = currentAmount - expectAmount
            local _, amount = tp.transferFluid(side, output, tpAmount)
        end
    end
end

Main.start()
