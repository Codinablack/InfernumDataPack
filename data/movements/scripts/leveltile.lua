local action_ids = {
	[ActionId.LevelTile500] = 500, -- 500 level to pass
	[ActionId.LevelTile1000] = 1000 -- 1000 level to pass
}

function onStepIn(creature, item, position, fromPosition)
	local player = Player(creature)
	if not player then
		return true
	end
	local aid = action_ids[item:getActionId()]
	if aid then
		if player:getLevel() < aid then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You may not pass until you are level ".. aid)
			player:teleportTo(fromPosition, true)
			return false
		end
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Welcome to the level ".. aid .. " zone.")
		position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
	return true
end