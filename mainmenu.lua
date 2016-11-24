

require "class"

MainMenu = class()

-- _init, load, draw, update(dt), keypressed, keyreleased, mousepressed, mousereleased, resize, (drawUnder, updateUnder)

function MainMenu:_init(args)
	-- this is for the draw stack
	self.drawUnder = false
	self.updateUnder = false
end

function MainMenu:load()
	-- run when the screen is given control
end

function MainMenu:leave()
	-- run when the screen no longer has control
end

function MainMenu:draw()
	--
end

function MainMenu:update(dt)
	--
end

function MainMenu:resize(w, h)
	--
end

function MainMenu:keypressed(key, unicode)
	--
end

function MainMenu:keyreleased(key, unicode)
	--
end

function MainMenu:mousepressed(x, y, button)
	--
end

function MainMenu:mousereleased(x, y, button)
	--
end