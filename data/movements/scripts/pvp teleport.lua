function onStepIn(creature, item, position, fromPosition)
	if item:isTeleport() and item:getDestination() == Position(1000, 1000, 7) and creature:isPzLocked() then
		creature:sendCancelMessage("You may not teleport while skulled.")
		creature:teleportTo(fromPosition, true)
		return false
	end
	return true
end