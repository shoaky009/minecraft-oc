local shell = require "shell"
local default_repo = "https://gitee.com/sh0aky/transporter/raw"
local default_branch = "master"
local template = "wget %s/%s"

local args, _ = shell.parse(...)
local repo;
local branch;
if type(args) == "table" then
    repo = args[1] or default_repo
    branch = args[2] or default_branch
else
    repo = default_repo
    branch = default_branch
end

shell.execute("rm -rf ./transporter")
shell.execute("mkdir transporter")
local pwd = shell.getWorkingDirectory()
local dir = pwd .. "/transporter"
shell.setWorkingDirectory(dir)
local prefix = string.format(template, repo, branch)
shell.execute(prefix .. "/src/main.lua")

shell.execute("mkdir conf")
shell.execute(prefix .. "/src/conf/config.lua "  .. dir .. "/conf/config.lua")
shell.execute(prefix .. "/src/tools/readlabel.lua "  .. dir .. "/tools/readlabel.lua")

print("installed successfully! plz read https://github.com/shoaky009/transporter/blob/master/README.md, and edit conf/config.lua make it work")
