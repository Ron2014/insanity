module("Sprite", package.seeall)
attr = {
	color = Color(255, 255, 255, 255),
	fixture = true,
	name = true,
	persisting = 0,
	initPos = true,
}
deriveClass(Sprite)

-- static
function getItemByFixture(fixture)
	assert(nil, "getItemByFixture need override")
end

function init(self, initPos, color, state, ...)
	self:color(color or self.attr.color)
	self:persisting(attr.persisting)
	self:initPos(initPos)

	local scene = Scene()
	local world = scene:world()
	return love.physics.newBody(world, initPos:x(), initPos:y(), state)
end

function reset(self)
	local pos = self:initPos()
	local fixture = self:fixture()
	local body = fixture:getBody()
	body:setPosition(pos:x(), pos:y())
	body:setAngle(0)
end

function draw(self)
	assert(nil, "draw need override")
end

function update(self, t)
	assert(nil, "update need override")
end

function beginContact(self, b, contact)
--	local x, y = contact:getNormal()
--	print(self._NAME, self:name(), "begin contact with", b._NAME, b:name(), "at", x, y) 
end

function endContact(self, b, contact)
--	self:persisting(0)
--	print(self._NAME, self:name(), "end contact with", b._NAME, b:name()) 
end

function preSolve(self, b, contact)
--	local persisting = self:persisting()
--	if persisting>0 then
--		print(self._NAME, self:name(), "contact with", b._NAME, b:name(), persisting) 
--	else
--		print(self._NAME, self:name(), "touch with", b._NAME, b:name()) 
--	end
--	
--	persisting = persisting + 1
--	self:persisting(persisting)
end

function postSolve(self, b, contact, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end
