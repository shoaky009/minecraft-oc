local Main = {}
local tp = require("component").transposer
local config = require("conf.config")
local event = require("event")

local inputSide = config.inputSide
local outputSide = config.outputSide
local fixOutSide = config.fixOutputSide
local items = config.items

function Main.start()
    local interval = config.checkInterval or 0.5
    local sourceTimer = event.timer(interval, Main.loop, math.huge)
    local fixInterval = config.fixInterval or 2
    local fixTimer = event.timer(fixInterval, Main.fixInput, math.huge)
    print("started!")
    while true do
        local id, _, x, y = event.pullMultiple("interrupted")
        if id == "interrupted" then
            print("interrupted cancel timer")
            event.cancel(sourceTimer)
            event.cancel(fixTimer)
            break
        end
    end
end

function Main.loop()
    local allStack = tp.getAllStacks(inputSide)
    if not allStack then
        print("no stack info..")
        return
    end

    local outputSlot = Main.getAvailableOutputSlot(tp, outputSide)
    if not outputSlot then
        print("no available outputSlot..")
        return
    end
    for i, v in pairs(allStack.getAll()) do
        local item = items[v.label]
        if item then
            if item.amount <= v.size then
                tp.transferItem(inputSide, outputSide, Main.getNumber(item, v), i + 1, outputSlot)
            end
        end
    end
end

function Main.getAvailableOutputSlot(transposer, side)
    local size = transposer.getInventorySize(side)
    for i = 1, size do
        local stack = transposer.getStackInSlot(side, i)
        if stack == nil then
            return i
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

function Main.fixInput()
    local allStack = tp.getAllStacks(outputSide)
    if not allStack then
        return
    end

    for i, v in pairs(allStack.getAll()) do
        if v then
            local item = items[v.label]
            if item and v.size < 64 and v.size % item.amount > 0 then
                local outputSlot = Main.getAvailableOutputSlot(tp, fixOutSide)
                print("extract " .. v.label .. " size:" .. v.size .. " amount:" .. item.amount)
                tp.transferItem(outputSide, fixOutSide, v.size, i + 1, outputSlot)
            end
        end
    end
end

Main.start()
