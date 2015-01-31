module("Color", package.seeall)
attr = {
	red = 0,
	green = 0,
	blue = 0,
	alpha = 0,
}
deriveClass(Color)

function init(self, red, green, blue, alpha)
	self:red(red or attr.red)
	self:green(green or attr.green)
	self:blue(blue or attr.blue)
	self:alpha(alpha or attr.alpha)
end
