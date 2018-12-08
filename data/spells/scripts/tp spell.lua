local BLUE_FLAME = 1397
local STORAGE_KEY = 77261

countdownEvents = countdownEvents or {}

function removeFlame(position)
	local tile = Tile(position)
	if tile then
		local flame = tile:getItemById(BLUE_FLAME)
		if flame then
			flame:remove()
		end
	end
end

function countdown(cid, position, i, j)
	local player = Player(cid)
	if not player then
		return
	end
	if i < j then
		local seconds = j - i
		player:sendCancelMessage(string.format("Time left: %s second%s", seconds, (seconds > 1 and "s" or "")))
		countdownEvents[cid] = {id = addEvent(countdown, 1000, cid, position, i+1, j), position = position}
	else
		removeFlame(position)
		player:teleportTo(position)
		player:setStorageValue(STORAGE_KEY, -1)
	end
end

function onCastSpell(creature, variant)
	local player = Player(creature)
	if not player then
		return false
	end
	local cid = player:getId()
	local position = player:getPosition()
	local storage = player:getStorageValue(STORAGE_KEY)
	if storage == -1 then
		Game.createItem(BLUE_FLAME, -1, position)
		countdown(cid, position, 1, 6)
		player:setStorageValue(STORAGE_KEY, 1)
	elseif storage == 1 then
		local event = countdownEvents[cid]
		if event then
			stopEvent(event.id)
			teleportBack(player, event.position)
		end
		player:setStorageValue(STORAGE_KEY, -1)
	end
	return true
end