require "define"
require "class"

require "color"
require "vector"

require "controller"
require "scene"
require "sprite"
require "border"
require "player"
require "enemy"
require "score"

function love.load()
	local scene = Scene()
	scene:initBorder()
	scene:initEnemy()
end

function love.update(dt)
	local scene = Scene()
	scene:update(dt)
end

function love.draw()
	local scene = Scene()
	scene:draw()
end

function love.keypressed(key, isRepeat)
	local controller = Controller()
	controller:keypressed(key, isRepeat)
end
