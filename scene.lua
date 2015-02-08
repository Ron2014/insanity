module("Scene", package.seeall)
attr = {
	world = {
		meter = 64,
	--	gravity = 9.81,
		gravity = 0,
	},

	screenWidth = 512,
	screenHeight = 512,

	border = {
		left = {Anchor.Left, 16, "screenHeight"},
		top = {Anchor.Top, "screenWidth", 16},
		right = {Anchor.Right, 16, "screenHeight"},
		bottom = {Anchor.Bottom, "screenWidth", 16},
	},

	enemy = {
		topLeft = {Anchor.TopLeft, 64, 64},
		topRight = {Anchor.TopRight, 64, 64},
		bottomLeft = {Anchor.BottomLeft, 150, 40},
		bottomRight = {Anchor.BottomRight, 100, 80},
	},
}

singletonClass(Scene)

function init(self, ...)
	love.physics.setMeter(attr.world.meter)

	local world = love.physics.newWorld(0, attr.world.gravity * attr.world.meter, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	self:world(world)

	self:resolution(attr.screenWidth, attr.screenHeight)
end

function resolution(self, width, height)
	local width = width or attr.screenWidth
	local height = height or attr.screenHeight

	self:screenWidth(width)
	self:screenHeight(height)

	love.window.setMode(width, height)
end

function initBorder(self)
	local border = {}
	for name, args in pairs(attr.border) do
		local anchor, width, height = unpack(args)
		if type(width)=="string" then width = self[width](self) end
		if type(height)=="string" then height = self[height](self) end

		local node = Border(anchor, width, height)
		node:name(name)
		border[name] = node
	end
	self:border(border)
end

function initEnemy(self)
	local enemy = {}
	for name, args in pairs(attr.enemy) do
		local node = Enemy(unpack(args))
		node:name(name)
		enemy[name] = node
	end
	self:enemy(enemy)
end

function resetEnemy(self)
	local enemy = {}
	for name, enemy in pairs(self:enemy()) do
		enemy:reset()
	end
end

function speedUp(self, value)
	if value%10~=9 then return end
	for name, enemy in pairs(self:enemy()) do
		local fixture = enemy:fixture()
		local body = fixture:getBody()
		local x, y = body:getLinearVelocity()
		body:setLinearVelocity(x*1.1, y*1.1)
	end
end

function startEnemy(self)
	local enemy = {}
	local meter = love.physics.getMeter()
	for name, enemy in pairs(self:enemy()) do
		local fixture = enemy:fixture()
		local body = fixture:getBody()
		body:setLinearVelocity(100, 90)
	end

	local score = Score()
	score:reset()
end

function draw(self)
	for _, v in pairs(self:border()) do
		v:draw()
	end

	for _, v in pairs(self:enemy()) do
		v:draw()
	end

	local player = Player()
	player:draw()

	local score = Score()
	score:draw()
end

function update(self, dt)
	local world = self:world()
	world:update(dt)

	local controller = Controller()
	controller:update(dt)

	local score = Score()
	score:update(dt)
end

function beginContact(a, b, contact)
	local atype = a:getUserData()
	local btype = b:getUserData()

	local clsA = _G[atype]
	local clsB = _G[btype]

	local objA = clsA.getItemByFixture(a)
	local objB = clsB.getItemByFixture(b)
	objA:beginContact(objB, contact)
end

function endContact(a, b, contact)
	local atype = a:getUserData()
	local btype = b:getUserData()

	local clsA = _G[atype]
	local clsB = _G[btype]

	local objA = clsA.getItemByFixture(a)
	local objB = clsB.getItemByFixture(b)
	objA:endContact(objB, contact)
end

function preSolve(a, b, contact)
	local atype = a:getUserData()
	local btype = b:getUserData()

	local clsA = _G[atype]
	local clsB = _G[btype]

	local objA = clsA.getItemByFixture(a)
	local objB = clsB.getItemByFixture(b)
	objA:preSolve(objB, contact)
end

function postSolve(a, b, contact, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
	local atype = a:getUserData()
	local btype = b:getUserData()

	local clsA = _G[atype]
	local clsB = _G[btype]

	local objA = clsA.getItemByFixture(a)
	local objB = clsB.getItemByFixture(b)
	objA:postSolve(objB, contact, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end
