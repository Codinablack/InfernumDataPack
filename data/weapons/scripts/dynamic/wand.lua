local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

function onGetFormulaValues(player, level, magicLevel)
	local weapon = player:getWeapon()
	if weapon then
		local tier = weapon:getTier()
		if tier then
			local ml_mod = tier * 0.7
			local base = tier ^ 2
			local min = (level / 2) + (magicLevel * (ml_mod / 2)) + (base / 2)
			local max = level + (magicLevel * ml_mod) + base
			player:addManaSpent(tier ^ 4)
			return -min, -max
		end
	end
	print('Error: onGetFormulaValues, no weapon tier')
	return 0, 0
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onUseWeapon(player, variant)
	return combat:execute(player, variant)
end