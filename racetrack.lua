

require "frogcolorloader"
require "frog"
require "class"

Racetrack = class()

-- _init, load, draw, update(dt), keypressed, keyreleased, mousepressed, mousereleased, resize, (drawUnder, updateUnder)

function Racetrack:_init(args)
	-- this is for the draw stack
	self.drawUnder = false
	self.updateUnder = false


	self.frogColorLoader = FrogColorLoader()
	self.testFrog = Frog(self.frogColorLoader:makeRandomFrog())

	self.frogs = {}
end

function Racetrack:load()
	-- run when the screen is given control
	love.graphics.setBackgroundColor(100,100,100)
end

function Racetrack:leave()
	-- run when the screen no longer has control
end

function Racetrack:draw()
	-- self.testFrog:draw()
	for k, f in pairs(self.frogs) do
		f:draw()
	end
end

function Racetrack:update(dt)
	-- self.testFrog:update(dt)
	for k, f in pairs(self.frogs) do
		f:update(dt)
	end
end

function Racetrack:resize(w, h)
	--
end

function Racetrack:keypressed(key, unicode)
	--
end

function Racetrack:keyreleased(key, unicode)
	--
end

function Racetrack:mousepressed(x, y, button)
	--
	-- self.frogColorLoader:randomizeFrog(self.testFrog)
	-- self.testFrog.x = x
	-- self.testFrog.y = y
	self.frogs[#self.frogs+1] = Frog(self.frogColorLoader:makeRandomFrog())
	self.frogs[#self.frogs].x = x
	self.frogs[#self.frogs].y = y
end

function Racetrack:mousereleased(x, y, button)
	--
end