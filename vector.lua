module("Vector", package.seeall)
attr = {
	x = 0,
	y = 0,
}
deriveClass(Vector)

function init(self, x, y)
	self:x(x or attr.x)
	self:y(y or attr.y)
end
