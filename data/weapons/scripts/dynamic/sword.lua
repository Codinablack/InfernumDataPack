local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

function onGetFormulaValues(player, skill, attack, factor)
	skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local level = player:getLevel()
	local weapon = player:getWeapon()
	if weapon then
		local tier = weapon:getTier()
		if tier then
			local mod = tier * 0.5
			local base = math.logn(tier^(tier*2), 2)
			local min = (level / 2) + (skill * (mod / 2)) + (base / 2)
			local max = level + (skill * mod) + base
			return -min, -max
		end
	end
	print('Error: onGetFormulaValues, no weapon tier')
	return 0, 0
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onUseWeapon(player, variant)
	return combat:execute(player, variant)
end