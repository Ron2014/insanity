module("Enemy", package.seeall)
deriveClass(Enemy, Border)

-- static
function getItemByFixture(fixture)
	local scene = Scene()
	for name, enemy in pairs(scene:enemy()) do
		local node = enemy:fixture()
		if node==fixture then return enemy end
	end
end

function init(self, anchor, width, height, ...)
	self:width(width)
	self:height(height)

	local pos = RectFunc[anchor](self, false)
	local body = Sprite.init(self, pos, Color(255, 255, 0, 255), "dynamic")
	local shape = love.physics.newRectangleShape(width, height)

	local fixture = love.physics.newFixture(body, shape)
	fixture:setFilterData(Collider.Category.Enemy, Collider.Mask.Enemy, Collider.Group.Enemy)
	fixture:setRestitution(1.0)
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

--	print("enemy linear velocity:", self:name(), body:getLinearVelocity(), fixture:getFriction())
--	print(string.format("Enemy pos(%f,%f)", body:getX(), body:getY()))
end

function endContact(self, b, contact)
	if Player:check(b) then
		local controller = Controller()
		controller:gameOver()
	end
end
