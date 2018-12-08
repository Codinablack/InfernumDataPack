function onStepIn(creature, item, position, fromPosition)
	local monster = Monster(creature)
	if monster then
		monster:teleportTo(fromPosition)
		return false
	end
	return true
end