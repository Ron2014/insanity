module("Vector", package.seeall)
attr = {
	x = 0,
	y = 0,
}
deriveClass(Vector)

function random(minRange, maxRange)
	local x = math.random(minRange, maxRange)
	local y = math.random(minRange, maxRange)
	return Vector(x, y)
end

function init(self, x, y)
	self:x(x or attr.x)
	self:y(y or attr.y)
end

function mod(self)
	local x = self:x()
	local y = self:y()
	return math.pow(x*x + y*y, 0.5)
end

mt.__sub = function(self, other)
	return Vector(self:x() - other:x(), self:y() - other:y())
end
