function Game.getMonsterSpectators(position, multifloor, minRangeX, maxRangeX, minRangeY, maxRangeY)
	local ret = {}
	local specs = Game.getSpectators(position, multifloor, false, minRangeX, maxRangeX, minRangeY, maxRangeY)
	if #specs > 0 then
		for i = 1, #specs do
			local creature = specs[i]
			if creature:isMonster() then
				ret[#ret+1] = creature
			end
		end
	end
	return ret
end

function Game.broadcastMessage(message, messageType)
	if messageType == nil then
		messageType = MESSAGE_STATUS_WARNING
	end

	for _, player in ipairs(Game.getPlayers()) do
		player:sendTextMessage(messageType, message)
	end
end

function Game.convertIpToString(ip)

end

function Game.getReverseDirection(direction)
	if direction == WEST then
		return EAST
	elseif direction == EAST then
		return WEST
	elseif direction == NORTH then
		return SOUTH
	elseif direction == SOUTH then
		return NORTH
	elseif direction == NORTHWEST then
		return SOUTHEAST
	elseif direction == NORTHEAST then
		return SOUTHWEST
	elseif direction == SOUTHWEST then
		return NORTHEAST
	elseif direction == SOUTHEAST then
		return NORTHWEST
	end
	return NORTH
end

function Game.getSkillType(weaponType)
	if weaponType == WEAPON_CLUB then
		return SKILL_CLUB
	elseif weaponType == WEAPON_SWORD then
		return SKILL_SWORD
	elseif weaponType == WEAPON_AXE then
		return SKILL_AXE
	elseif weaponType == WEAPON_DISTANCE then
		return SKILL_DISTANCE
	elseif weaponType == WEAPON_SHIELD then
		return SKILL_SHIELD
	end
	return SKILL_FIST
end

if not globalStorageTable then
	globalStorageTable = {}
end

function Game.getStorageValue(key)
	return globalStorageTable[key] or -1
end

function Game.setStorageValue(key, value)
	globalStorageTable[key] = value
end
