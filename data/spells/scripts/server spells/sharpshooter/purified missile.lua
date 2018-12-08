local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)

local area = {
	{0, 1, 0},
	{1, 3, 1},
	{0, 1, 0}
}

combat:setArea(createCombatArea(area))

function onGetFormulaValues(player, skill, attack, factor)
	local skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = skill * attack * 0.05 + 35
	local max = skill * attack * 0.07 + 45
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end