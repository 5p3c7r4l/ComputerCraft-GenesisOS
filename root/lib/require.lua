local r = require "cc.require"
local env = setmetatable({}, {__index = _ENV})
env.require, env.package = r.make(env."/")
return env
