local Main = {}
local tp = require("component").transposer
local config = require("conf.config")
local event = require("event")

local inputSide = config.inputSide
local outputSide = config.outputSide
local items = config.items

function Main.start()
    local interval = config.checkInterval or 0.5
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
    local outputSlot = tp.getStackInSlot(outputSide, 1)
    if outputSlot and outputSlot.size > 0 then
        return
    end
    local allStack = tp.getAllStacks(inputSide)
    if not allStack then
        return
    end

    for i, v in pairs(allStack.getAll()) do
        local item = items[v.label]
        if item then
            if item.amount <= v.size then
                tp.transferItem(inputSide, outputSide, Main.getNumber(item, v), i + 1, 1)
                break
            end
        end
    end
end

function Main.getNumber(item, stackItem)
    if item.disableMaxOutput then
        return item.amount
    end
    local mod = stackItem.size % item.amount
    if mod > 0 then
        return stackItem.size - mod
    end
    return stackItem.size
end

Main.start()
