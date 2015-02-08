module("Player", package.seeall)
attr = {
	radius = 20,
	damping = 1,
}
singletonClass(Player, Sprite)

-- static
function getItemByFixture(fixture)
	return Player()
end

-- collision
-- Player <> Enemy 
-- Player <> Boder

function init(self, ...)
	self:radius(self.attr.radius)
	self:damping(self.attr.damping)
	self:name("player")

	local scene = Scene()
	local screenWidth = scene:screenWidth()
	local screenHeight = scene:screenHeight()
	local pos = Vector(screenWidth*0.5, screenHeight*0.5)
	local body = Sprite.init(self, pos, Color(255, 0, 0, 255), "dynamic")

	local meter = love.physics.getMeter()
	body:setLinearDamping(self:damping() * meter)

	local shape = love.physics.newCircleShape(self:radius())
	local fixture = love.physics.newFixture(body, shape)
	fixture:setFilterData(Collider.Category.Player, Collider.Mask.Player, Collider.Group.Player)
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
	love.graphics.circle("fill", body:getX(), body:getY(), shape:getRadius())

--	print("player linear velocity:", body:getLinearVelocity(), fixture:getFriction())
--	print(string.format("player pos(%f,%f)", body:getX(), body:getY()))
end

function endContact(self, b, contact)
	if Enemy:check(b) then
		local controller = Controller()
		controller:gameOver()
	end
end

function beginContact(self, b, contact)
--	print("score.beginContact", debug.traceback())
	if Score:check(b) then
		b:getScore()
	end
end
