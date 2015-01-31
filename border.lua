module("Border", package.seeall)
attr = {
	anchor = Anchor.Bottom,
	thickness = 16,
}
deriveClass(Border, Sprite)

RectFunc = {
	[Anchor.Left] = function(self)
		local thickness = self:thickness()
		local scene = Scene()

		local left = -thickness
		local top = 0
		local right = 0
		local bottom = scene:screenHeight()

		return left, top, right, bottom
	end,

	[Anchor.Top] = function(self)
		local thickness = self:thickness()
		local scene = Scene()

		local left = 0
		local top = -thickness
		local right = scene:screenWidth()
		local bottom = 0

		return left, top, right, bottom
	end,

	[Anchor.Right] = function(self)
		local thickness = self:thickness()
		local scene = Scene()

		local left = scene:screenWidth()
		local top = 0
		local right = scene:screenWidth() + thickness
		local bottom = scene:screenHeight()

		return left, top, right, bottom
	end,

	[Anchor.Bottom] = function(self)
		local thickness = self:thickness()
		local scene = Scene()

		local left = 0
		local top = scene:screenHeight()
		local right = scene:screenWidth()
		local bottom = scene:screenHeight() + thickness

		return left, top, right, bottom
	end,
}

function init(self, anchor, ...)
	self:anchor(anchor or attr.anchor)
	self:thickness(attr.thickness)

	local left, top, right, bottom = RectFunc[anchor](self)
	Sprite.init(self, Vector(left, top))
end

