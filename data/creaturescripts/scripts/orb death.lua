local orbTypes = {
	[{1, 10}] = {
		[ORBTYPE_GOLD] = {
			{id = 2152, count = {5, 15}},
			{id = 2148, count = {1, 100}}
		},
		[ORBTYPE_ITEMS] = {2509},
	}
}

function onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified)
	local player = killer:getPlayer()
	if not player then
		return true
	end
	local pos = creature:getPosition()
	local start = os.mtime()
	while true do
		-- avoid infinite loop, use creature position for orb
		if os.mtime() - start >= 50 then
			break
		end
		local testPos = pos + Position(math.random(-3, 3), math.random(-3, 3), 0)
		local tile = Tile(testPos)
		if tile and tile:isWalkable() and player:getPathTo(testPos) and not tile:hasTeleport() then
			pos = testPos
			break
		end
	end
	local monsterLevel = creature:getLevel()
	local orbType = math.random(1, 3)
	for levels, orbList in pairs(orbTypes) do
		if monsterLevel >= levels[1] and monsterLevel <= levels[2] then
			if orbType == ORBTYPE_EXPERIENCE then
				Orb(player, pos, creature:getType():getExperience() * 5, orbType)
			else
				Orb(player, pos, orbList[orbType], orbType)
			end
		end
	end
	return true
end