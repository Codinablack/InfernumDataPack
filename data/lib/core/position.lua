Position.directionOffset = {
    [DIRECTION_NORTH] = {x = 0, y = -1},
    [DIRECTION_EAST] = {x = 1, y = 0},
    [DIRECTION_SOUTH] = {x = 0, y = 1},
    [DIRECTION_WEST] = {x = -1, y = 0},
    [DIRECTION_SOUTHWEST] = {x = -1, y = 1},
    [DIRECTION_SOUTHEAST] = {x = 1, y = 1},
    [DIRECTION_NORTHWEST] = {x = -1, y = -1},
    [DIRECTION_NORTHEAST] = {x = 1, y = -1}
}
 
function Position:setDirectionOffset(dir)
    local tmp = Position.directionOffset[dir]
    if not tmp then
        return self
    end
    return Position(self.x + tmp.x, self.y + tmp.y, self.z)
end

function Position:getNextPosition(direction, steps)
	local offset = Position.directionOffset[direction]
	if offset then
		steps = steps or 1
		self.x = self.x + offset.x * steps
		self.y = self.y + offset.y * steps
	end
	return self
end

function Position:moveUpstairs()
	local isWalkable = function (position)
		local tile = Tile(position)
		if not tile then
			return false
		end

		local ground = tile:getGround()
		if not ground or ground:hasProperty(CONST_PROP_BLOCKSOLID) then
			return false
		end

		local items = tile:getItems()
		for i = 1, tile:getItemCount() do
			local item = items[i]
			local itemType = item:getType()
			if itemType:getType() ~= ITEM_TYPE_MAGICFIELD and not itemType:isMovable() and item:hasProperty(CONST_PROP_BLOCKSOLID) then
				return false
			end
		end
		return true
	end

	local swap = function (lhs, rhs)
		lhs.x, rhs.x = rhs.x, lhs.x
		lhs.y, rhs.y = rhs.y, lhs.y
		lhs.z, rhs.z = rhs.z, lhs.z
	end

	self.z = self.z - 1

	local defaultPosition = self + Position.directionOffset[DIRECTION_SOUTH]
	if not isWalkable(defaultPosition) then
		for direction = DIRECTION_NORTH, DIRECTION_NORTHEAST do
			if direction == DIRECTION_SOUTH then
				direction = DIRECTION_WEST
			end

			local position = self + Position.directionOffset[direction]
			if isWalkable(position) then
				swap(self, position)
				return self
			end
		end
	end
	swap(self, defaultPosition)
	return self
end

function Position.sendMessage(self, message, talktype)
	local specs = Game.getSpectators(self, false, true, 7, 7, 5, 5)
	if #specs > 0 then
		for i = 1, #specs do
			local player = specs[i]
			player:say(message, talktype or TALKTYPE_MONSTER_SAY, false, player, self)
		end
	end
end

local unwalkable = {
    CONST_PROP_IMMOVABLEBLOCKSOLID,
    CONST_PROP_IMMOVABLEBLOCKPATH,
    CONST_PROP_BLOCKSOLID,
    CONST_PROP_BLOCKPATH,
}

local function checkUnwalkable(item)
    for _, prop in ipairs(unwalkable) do
        if item:hasProperty(prop) then
            return true
        end
    end
    return false
end

function Position.isWalkable(self)
    local tile = Tile(self)
    if not tile or tile:hasFlag(TILESTATE_FLOORCHANGE) then
        return false
    end

    if tile:getCreatureCount() > 0 then
    	return false
    end

    local ground = tile:getGround()
    if not ground or ground:hasProperty(CONST_PROP_BLOCKSOLID) or ground:hasProperty(CONST_PROP_IMMOVABLEBLOCKPATH) then
        return false
    end

    local items = tile:getItems()
    for i = 1, tile:getItemCount() do
        local item = items[i]
        local itemType = item:getType()
        if not itemType:isMovable() and checkUnwalkable(item) then
            return false
        end
    end
    return true
end

function Position.print(self)
	print(string.format("Position(%s, %s, %s)", self.x, self.y, self.z))
end