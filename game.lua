


require "racetrack"
require "class"

Game = class()

-- _init, load, draw, update(dt), keypressed, keyreleased, mousepressed, mousereleased, resize, (drawUnder, updateUnder)

function Game:_init(args)
	-- this is for the draw stack
	self.drawUnder = false
	self.updateUnder = false
	self.drawFPS = false
	self.screenStack = {}
	math.randomseed(os.time())

	self.racetrack = Racetrack()

	self:addToScreenStack(self.racetrack)
end

function Game:load()
	-- run when the level is given control
end

function Game:leave()
	-- run when the level no longer has control
end

function Game:draw()
	local thingsToDraw = 1 -- this will become the index of the lowest item to draw
	for i = #self.screenStack, 1, -1 do
		thingsToDraw = i
		if not self.screenStack[i].drawUnder then
			break
		end
	end
	-- this is so that the things earlier in the screen stack get drawn first, so that things like pause menus get drawn on top.
	for i = thingsToDraw, #self.screenStack, 1 do
		self.screenStack[i]:draw()
	end
	if (self.drawFPS) then
		love.graphics.setColor(255, 0, 0)
		love.graphics.print("FPS: "..love.timer.getFPS(), 10, love.graphics.getHeight()-45)
		love.graphics.setColor(255, 255, 255)
	end
end

function Game:update(dt)
	for i = #self.screenStack, 1, -1 do
		self.screenStack[i]:update(dt)
		if self.screenStack[i] and not self.screenStack[i].updateUnder then
			break
		end
	end
end

function Game:popScreenStack()
	self.screenStack[#self.screenStack]:leave()
	self.screenStack[#self.screenStack] = nil
	self.screenStack[#self.screenStack]:load()
end

function Game:addToScreenStack(newScreen)
	if self.screenStack[#self.screenStack] ~= nil then
		self.screenStack[#self.screenStack]:leave()
	end
	self.screenStack[#self.screenStack+1] = newScreen
	newScreen:load()
end

function Game:resize(w, h)
	for i = 1, #self.screenStack, 1 do
		self.screenStack[i]:resize(w, h)
	end
end

function Game:keypressed(key, unicode)
	self.screenStack[#self.screenStack]:keypressed(key, unicode)
end

function Game:keyreleased(key, unicode)
	self.screenStack[#self.screenStack]:keyreleased(key, unicode)
end

function Game:mousepressed(x, y, button)
	self.screenStack[#self.screenStack]:mousepressed(x, y, button)
end

function Game:mousereleased(x, y, button)
	self.screenStack[#self.screenStack]:mousereleased(x, y, button)
end

function Game:quit()
	--
end