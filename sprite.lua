module("Sprite", package.seeall)
attr = {
	fixture = true,
	color = Color(),
}
deriveClass(Sprite)

function init(self, leftTopPos, color, ...)
	self:color(color or attr.color)

	local scene = Scene()
	local world = scene:world()
	return love.physics.newBody(world, leftTopPos:x(), leftTopPos:y())
end

function draw(self)
	assert(nil, "draw need override")
end

function update(self, t)
	assert(nil, "update need override")
end

