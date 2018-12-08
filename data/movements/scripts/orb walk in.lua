function onStepIn(creature, item, position, fromPosition)
	local player = Player(creature)
	if not player then
		return true
	end
	local playerOrbs = player:getOrbs()
	if playerOrbs and #playerOrbs > 0 then
		for i, orb in ipairs(playerOrbs) do
			if orb.position == position then
				orb:siphon()
			end
		end
	end
	return true
end