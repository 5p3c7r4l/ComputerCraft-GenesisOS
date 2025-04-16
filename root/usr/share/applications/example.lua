---------------------------------------------------
-- CREATE YOUR ENVIRONNEMENT ----------------------
---------------------------------------------------

local example = {}
example.prototype = {}

---------------------------------------------------
-- MAKE ALL YOUR METHODS AND ATTRIBUTES -----------
---------------------------------------------------

-- MENDATORY METHODS AND ATTRIBUTES --

example.prototype.parameters = {}
example.prototype.parameters.name = "app name"
example.prototype.parameters.path = "path/to/app" -- no .lua at the end --

-- OPTIONAL METHODS AND ATTRIBUTES --

example.prototype.env = {}

example.prototype.env.myattribute = {} -- new attribute

example.prototype.env.mymethode = function() -- new method
end

---------------------------------------------------
-- SHOULD BE AT THE BOTTOM ------------------------
---------------------------------------------------

example.mt = {}

example.new = function(env) setmetatable(env, example.mt) end -- creates a new object

example.mt.__index = function(table, key) -- uses the correct method/attribute
    return example.prototype[key]
end
