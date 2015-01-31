module("Sprite", package.seeall)
attr = {
	body = true,
	color = Color(),
}
deriveClass(Sprite)

function init(self, leftTopPos, color, ...)
	local scene = Scene()
	local world = scene:world()
	local body = love.physics.newBody(world, leftTopPos:x(), leftTopPos:y())
	self:body(body)

	self:color(color or attr.color)
end

function draw(self)
	assert(nil, "draw need override")
end

function update(self, t)
	assert(nil, "update need override")
end

