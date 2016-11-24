

require "class"

FrogColorLoader = class()

function FrogColorLoader:_init()
	self.prefix = "images/"
	self.spriteSize = 32*4
	self.imageOffset = self.spriteSize/2
	self.baseCoat = love.graphics.newImage(self.prefix.."frog 1 base coat.png")
	self.outline = love.graphics.newImage(self.prefix.."frog outline 1.png")

	self.baseCoat:setFilter("nearest", "linear")
	self.outline:setFilter("nearest", "linear")

	-- this is where I put the decoration file names
	local flourishes = {"frog stripe 1.png", "frog legs 1.png", "frog head 1.png", "frog arms 1.png",
						"frog horizontal stripes 1.png", "frog stark 1.png"}

	self.flourishes = {}
	for k, v in pairs(flourishes) do
		self.flourishes[#self.flourishes+1] = love.graphics.newImage(self.prefix..v)
		self.flourishes[#self.flourishes]:setFilter("nearest", "linear")
	end
	self:makeQuads()
end

function FrogColorLoader:makeQuads()
	self.quads = {}
	for y = 0, self.baseCoat:getWidth()-1, self.spriteSize do
		for x = 0, self.baseCoat:getHeight()-1, self.spriteSize do
			table.insert(self.quads, love.graphics.newQuad(x, y+1, self.spriteSize-1, self.spriteSize-1,
    self.baseCoat:getWidth(), self.baseCoat:getHeight()))
		end
	end
end


function FrogColorLoader:makeRandomFrog(numLayers)
	if not numLayers then
		numLayers = math.random(0, 3)
	end
	if numLayers > #self.flourishes then
		-- you can't make that many layers, so don't bother.
		numLayers = #self.flourishes
	end
	local outImages = {self.baseCoat}
	local outColors = {{math.random(0, 255), math.random(0, 255), math.random(0, 255)}}
	for i = 1, numLayers, 1 do
		outImages[#outImages + 1] = self.flourishes[math.random(#self.flourishes)]
		outColors[#outColors + 1] = {math.random(0, 255), math.random(0, 255), math.random(0, 255)}
	end
	outImages[#outImages + 1] = self.outline
	outColors[#outColors + 1] = {255, 255, 255} -- may as well set the color to white to make life easy on the next thing to draw.
	return {outImages, outColors, self.quads, self.imageOffset}
end

function FrogColorLoader:makeBasicFrog()
	local outImages = {self.baseCoat, self.outline}
	local outColors = {{math.random(0, 255), math.random(0, 255), math.random(0, 255)}, {255, 255, 255}}
	return {outImages, outColors, self.quads, self.imageOffset}
end

function FrogColorLoader:randomizeFrog(frog)
	local t = self:makeRandomFrog(math.random(0, 4))
	frog.drawTable = t
	frog.imageTable = t[1]
	frog.colorTable = t[2]
	frog.quads = t[3]
	frog.imageOffset = t[4]
end