require "define"
require "class"

require "color"
require "vector"

require "scene"
require "sprite"
require "border"
require "player"

function love.load()
	local scene = Scene()
	scene:initBorder()
end

function love.update(t)
end

function love.draw()
	local scene = Scene()
	scene:draw()
end
