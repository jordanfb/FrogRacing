require "class"

Frog = class()


function Frog:_init(drawTable)
	self.drawTable = drawTable
	self.imageTable = drawTable[1]
	self.colorTable = drawTable[2]
	self.quads = drawTable[3]
	self.imageOffset = drawTable[4]
	
	-- self:loadImage("basefrog1white.png", 32*4, 3, 3)
	self.animationFrame = 1
	self.animationTimer = 0
	self.jumpChance = 5
	self.timeUntilJump = math.random()*self.jumpChance
	self.jumping = false
	self.frameTime = .02

	self.jumpSpeed = -100
	self.x = 500
	self.y = 500
end

-- function Frog:loadImage(filename, spriteSize, width, height)
-- 	self.imageSize = spriteSize
-- 	self.image = love.graphics.newImage("images/frog 1 base coat.png")
-- 	self.image:setFilter("nearest", "linear")
-- 	self.imageFrames = {}
-- 	for y = 0, width-1, 1 do
-- 		for x = 0, height-1, 1 do
-- 			table.insert(self.imageFrames, love.graphics.newQuad(x * spriteSize, y * spriteSize+1, spriteSize-1, spriteSize-1,
--     self.image:getWidth(), self.image:getHeight()))
-- 		end
-- 	end
-- end


function Frog:draw()
	for i = 1, #self.imageTable do
		love.graphics.setColor(self.colorTable[i])
		love.graphics.draw(self.imageTable[i], self.quads[self.animationFrame], self.x, self.y, 0, 1, 1, self.imageOffset, self.imageOffset)
	end
	-- love.graphics.print("animation frame "..self.animationFrame, 10, love.graphics.getHeight()-45)
end

function Frog:update(dt)
	self.timeUntilJump = self.timeUntilJump - dt
	if self.timeUntilJump <= 0 and self.jumping == false then
		self.timeUntilJump = -1
		-- jump
		self.jumping = true
	end
	if self.jumping and not self.falling then
		-- do stuff?
		self.animationTimer = self.animationTimer + dt
		if self.animationTimer >= self.frameTime then
			self.animationTimer = self.animationTimer - self.frameTime
			self.animationFrame = self.animationFrame + 1
			if self.animationFrame > #self.quads then
				-- it should be falling then
				self.animationFrame = #self.quads
				self.falling = true
			end
		end
		self.y = self.y + self.jumpSpeed*dt
	end
	if self.falling then
		-- it's the same as jumping, just with subtraction.
		self.animationTimer = self.animationTimer + dt
		if self.animationTimer >= self.frameTime then
			self.animationTimer = self.animationTimer - self.frameTime
			self.animationFrame = self.animationFrame - 1
			if self.animationFrame <= 1 then
				-- it should be falling then
				self.animationFrame = 1
				self.falling = false
				self.jumping = false
				self.timeUntilJump = math.random()*self.jumpChance
			end
		end
		self.y = self.y + self.jumpSpeed*dt
	end
end

