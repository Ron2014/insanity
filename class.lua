function makeAttr(cls, attr)
	for k, _ in pairs(attr) do
		local func = function(self, val)
			local inner = string.format("%s__", k)
			if val~=nil then self[inner] = val end
			return self[inner]
		end
		rawset(cls, k, func)
	end
end

function deriveClass(child, parent)
	child.mt = child.mt or { __index = child }

	local mt = {}
	mt.__index = parent or _G
	mt.__call = function(cls, ...)
		return cls:new(...)
	end
	setmetatable(child, mt)

	child.new = child.new or function(cls, ...)
		local instance = {}
		setmetatable(instance, cls.mt)
		instance:init(...)
		return instance
	end

	child.check = function(cls, instance)
		if type(instance)=="table" then return getmetatable(instance)==cls.mt
		elseif type(instance)=="string" then return cls.__NAME==instance end
		return false
	end

	child.log = child.log or function(result, name, val, level)
		local t = type(val)
		if t=="table" then
			for i=1,level do result = result .. "\t" end
			result = result .. tostring(name) .. " = {\n"

			for k, v in sortpairs(val) do
				result = child.log(result, k, v, level+1)
			end

			for i=1,level do result = result .. "\t" end
			result = result .. "}\n"

		elseif t~="function" then
			for i=1,level do result = result .. "\t" end
			result = result .. name .. " = " .. tostring(val) .. "\n"
		end
		return result
	end
	child.mt.__tostring = function(self)
		local result = ""
		return child.log(result, child._NAME, self, 0)
	end

	local attr = child.attr or {}
	makeAttr(child, attr)
end

function singletonClass(child, parent)
	-- make inherit
	deriveClass(child, parent)

	child.getInstance = child.getInstance or function(cls, ...)
		local instance = rawget(cls, "instance__")

		if instance then
			assert(cls:check(instance), string.format("instance type error: %s", type(instance)))
			local args = {...}
			if #args>0 then instance:init(...) end
		else
			instance = cls:new(...)
			rawset(cls, "instance__", instance)
		end

		return instance
	end

	local mt = getmetatable(child)
	mt.__call = function(cls, ...)
		return cls:getInstance(...)
	end
end
