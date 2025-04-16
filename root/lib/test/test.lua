--local r = require("cc.require")
--local env = setmetatable({},{__index = _ENV})
--env.require, env.package = r.make(env, "/") 

--shell.setPath("root/lib/programs")
local deskPath = fs.find("/root/usr/share/applications/desk*")

for i, e in pairs(deskPath) do
    print(deskPath[i])
end

return nil
