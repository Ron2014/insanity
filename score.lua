module("Score", package.seeall)
attr = {
	radius = 20,
	value = 0,
	
	font = true,
	fontColor = Color(255, 255, 255, 255),

	updateNow = true,
}
singletonClass(Score, Sprite)

-- static
function getItemByFixture(fixture)
	return Score()
end

function init(self, ...)
	local radius = self.attr.radius
	self:radius(radius)

	self:value(self.attr.value)
	self:updateNow(false)
	self:name("score")

	local font = love.graphics.newFont("res/Number.ttf", 32)
	self:font(font)
	self:fontColor(self.attr.fontColor)

	local scene = Scene()
	local screenWidth = scene:screenWidth()
	local screenHeight = scene:screenHeight()
	local x = math.random(radius, screenWidth - radius)
	local y = math.random(radius, screenHeight - radius)
	local pos = Vector(x, y)

	local body = Sprite.init(self, pos, Color(0, 255, 0, 255), "static")
	local shape = love.physics.newCircleShape(self:radius())
	local fixture = love.physics.newFixture(body, shape)
	fixture:setFilterData(Collider.Category.Score, Collider.Mask.Score, Collider.Group.Score)
	fixture:setFriction(0)
	fixture:setUserData(self._NAME)
	self:fixture(fixture)
end

function reset(self)
	self:value(0)
	self:updateNow(true)
end

function appear(self)
	local radius = self:radius()
	local scene = Scene()
	local player = Player()

	local screenWidth = scene:screenWidth()
	local screenHeight = scene:screenHeight()

	local x, y, fixture, body = nil, nil, nil, nil

	repeat
		x = math.random(radius, screenWidth - radius)
		y = math.random(radius, screenHeight - radius)
		local pos0 = Vector(x, y)

		fixture = player:fixture()
		body = fixture:getBody()

		local px, py = body:getPosition()
		local pos1 = Vector(px, py)

	until (pos1-pos0):mod()>(radius+player:radius())

	fixture = self:fixture()
	body = fixture:getBody()
	body:setPosition(x, y)

	local scene = Scene()
	scene:speedUp(self:value())
end

function getScore(self)
	local value = self:value()
	value = value + 1
	self:value(value)

	self:updateNow(true)
end

function update(self, dt)
	local updateNow = self:updateNow()
	if not updateNow then return end

	self:appear()
	self:updateNow(false)
end

function draw(self)
	local scene = Scene()
	local screenWidth = scene:screenWidth()
	local strNum = tostring(self:value())
	local font = self:font()
	local strWidth = font:getWidth(strNum)

	local color = self:fontColor()
	local red, green, blue, alpha = color:red(), color:green(), color:blue(), color:alpha()
	love.graphics.setColor(red, green, blue, alpha)

	love.graphics.setFont(font)
	love.graphics.print(strNum, (screenWidth-strWidth) * 0.5, 0)

	local controller = Controller()
	if controller:state()~=State.Run then return end

	color = self:color()
	red, green, blue, alpha = color:red(), color:green(), color:blue(), color:alpha()
	love.graphics.setColor(red, green, blue, alpha)

	local fixture = self:fixture()
	local body = fixture:getBody()
	local shape = fixture:getShape()
	love.graphics.circle("line", body:getX(), body:getY(), shape:getRadius())
end

function beginContact(self, b, contact)
--	print("score.beginContact", debug.traceback())
	if Player:check(b) then
		self:getScore()
	end
end
