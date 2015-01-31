module("Scene", package.seeall)
attr = {
	world = {
		meter = 64,
		gravity = 9.81,
	},

	border = {
		left = Anchor.Left,
		top = Anchor.Top,
		right = Anchor.Right,
		bottom = Anchor.Bottom,
	},

	player = true,

	screenWidth = 512,
	screenHeight = 512,
}

singletonClass(Scene)

function init(self, ...)
	love.physics.setMeter(attr.world.meter)

	local world = love.physics.newWorld(0, attr.world.gravity * attr.world.meter, true)
	self:world(world)

	self:resolution(attr.screenWidth, attr.screenHeight)
end

function resolution(self, width, height)
	self:screenWidth(width or attr.screenWidth)
	self:screenHeight(height or attr.screenHeight)

	love.window.setMode(self:screenWidth(), self:screenHeight())
end

function initBorder(self)
	local border = {}
	for name, anchor in pairs(attr.border) do
		local node = Border(anchor)
		border[name] = node
	end
	self:border(border)
end

function draw(self)
	for _, v in pairs(self:border()) do
		v:draw()
	end
end
