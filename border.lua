module("Border", package.seeall)
attr = {
	width = true,
	height = true,
}
deriveClass(Border, Sprite)

-- static
function getItemByFixture(fixture)
	local scene = Scene()
	for name, border in pairs(scene:border()) do
		local node = border:fixture()
		if node==fixture then return border end
	end
end

-- collision
-- Border == Boder
-- Border <> Enemy
-- Border <> Player

RectFunc = {
	[Anchor.TopLeft] = function(self)
		local left = 0
		local top = 0

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.Top] = function(self, border)
		if border==nil then border=true end

		local scene = Scene()
		local left = (scene:screenWidth() - self:width()) * 0.5
		local top = (border and -self:height()) or 0

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.TopRight] = function(self)
		local scene = Scene()

		local left = scene:screenWidth() - self:width()
		local top = 0

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.Left] = function(self, border)
		if border==nil then border=true end

		local scene = Scene()

		local left = (border and -self:width()) or 0
		local top = (scene:screenHeight() - self:height()) * 0.5

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.Right] = function(self, border)
		if border==nil then border=true end

		local scene = Scene()

		local left = scene:screenWidth() + ((border and 0) or -self:width())
		local top = (scene:screenHeight() - self:height()) * 0.5

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.BottomLeft] = function(self)
		local scene = Scene()

		local left = 0
		local top = scene:screenHeight() - self:height()

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.Bottom] = function(self, border)
		if border==nil then border=true end

		local scene = Scene()

		local left = (scene:screenWidth() - self:width()) * 0.5
		local top = scene:screenHeight() + ((border and 0) or self:height())

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,

	[Anchor.BottomRight] = function(self)
		local scene = Scene()

		local left = scene:screenWidth() - self:width()
		local top = scene:screenHeight() - self:height()

		local right = left + self:width()
		local bottom = top + self:height()
		return Vector((left + right) * 0.5, (top + bottom) * 0.5)
	end,
}

function init(self, anchor, width, height, ...)
	self:width(width)
	self:height(height)

	local pos = RectFunc[anchor](self)
	local body = Sprite.init(self, pos, Color(255, 255, 255, 255), "static")
	local shape = love.physics.newRectangleShape(width, height)

	local fixture = love.physics.newFixture(body, shape)
	fixture:setFilterData(Collider.Category.Border, Collider.Mask.Border, Collider.Group.Border)
	fixture:setFriction(0)
	fixture:setUserData(self._NAME)
	self:fixture(fixture)
end

function draw(self)
	local color = self:color()
	local red, green, blue, alpha = color:red(), color:green(), color:blue(), color:alpha()
	love.graphics.setColor(red, green, blue, alpha)

	local fixture = self:fixture()
	local body = fixture:getBody()
	local shape = fixture:getShape()
	love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
end

