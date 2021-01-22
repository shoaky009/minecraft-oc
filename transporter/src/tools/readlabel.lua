local config = require("conf.config")
local tp = require("component").transposer

local stacks = tp.getAllStacks(config.inputSide)
for k, v in pairs(stacks.getAll()) do
    if v.label then
        print("slot:" .. k .. " label:" .. v.label)
    end
end
