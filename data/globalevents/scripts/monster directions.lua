function Monster.getTeleportDirection(self)
	for dir = 0, 3 do
		local pos = self:getPosition():setDirectionOffset(dir)
		local tile = Tile(pos)
		if tile and tile:getItemById(1387) then
			return dir
		end
	end
end

function onStartup()
	local specs = Game.getSpectators(Position(862, 992, 7), false, false, 30, 30, 30, 30)
	for _, monster in ipairs(specs) do
		monster:setDirection(monster:getTeleportDirection())
	end
end