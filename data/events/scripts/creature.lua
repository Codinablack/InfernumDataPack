local outfits = {130}

function Creature:onChangeOutfit(outfit)
	if table.contains(outfits, outfit.lookType) and outfit.lookMount ~= 0 then
		outfit.lookMount = 0
		self:setOutfit(outfit)
		return false
	end
	return true
end

function Creature:onAreaCombat(tile, isAggressive)
	return RETURNVALUE_NOERROR
end

function Creature:onTargetCombat(target)
	
	return RETURNVALUE_NOERROR
end
