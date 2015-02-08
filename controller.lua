module("Controller", package.seeall)
attr = {
	step = 64,
	state = State.Ready,
}
singletonClass(Controller)

function init(self, ...)
	self:step(self.attr.step)
	self:state(self.attr.state)
end

function up(self, player, dt)
	local state = self:state()
	if state~=State.Run then return end

	local meter = love.physics.getMeter()
	local step = self:step()
	local fixture = player:fixture()
	local body = fixture:getBody()
	body:applyForce(0, -100 * meter)
end

function down(self, player, dt)
	local state = self:state()
	if state~=State.Run then return end

	local meter = love.physics.getMeter()
	local step = self:step()
	local fixture = player:fixture()
	local body = fixture:getBody()
	body:applyForce(0, 100 * meter)
end

function left(self, player, dt)
	local state = self:state()
	if state~=State.Run then return end

	local meter = love.physics.getMeter()
	local step = self:step()
	local fixture = player:fixture()
	local body = fixture:getBody()
	body:applyForce(-100 * meter, 0)
end

function right(self, player, dt)
	local state = self:state()
	if state~=State.Run then return end

	local meter = love.physics.getMeter()
	local step = self:step()
	local fixture = player:fixture()
	local body = fixture:getBody()
	body:applyForce(100 * meter, 0)
end

keyFunc = {
	w = up,
	up = up,

	s = down,
	down = down,

	a = left,
	left = left,

	d = right,
	right = right,
}

function update(self, dt)
	local player = Player()
	for key, func in pairs(keyFunc) do
		if love.keyboard.isDown(key) then func(self, player, dt) end
	end
end

function gameOver(self)
	local scene = Scene()
	for name, enemy in pairs(scene:enemy()) do
		local fixture = enemy:fixture()
		local body = fixture:getBody()
		body:setLinearVelocity(0, 0)
		body:setAngularVelocity(0)
	end

	self:state(State.Over)
end

function keypressed(self, key, isRepeat)
	if key~=" " then return end
	local state = self:state()
	local player = Player()

	if state==State.Ready then
		local scene = Scene()
		scene:startEnemy()
	
		self:state(State.Run)

	elseif state==State.Run then
		local fixture = player:fixture()
		local body = fixture:getBody()
		body:setLinearVelocity(0, 0)

	elseif state==State.Over then
		local scene = Scene()
		scene:resetEnemy()

		player:reset()

		self:state(State.Ready)
	end
end
