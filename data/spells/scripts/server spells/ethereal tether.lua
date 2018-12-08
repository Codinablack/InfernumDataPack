local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetFormulaValues(player, skill, attack, factor)
	local skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = (skill / 3) * attack * 0.03
	local max = (skill / 3) * attack * 0.05
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function pull(targetId, position)
	local target = Monster(targetId)
	if target then
		target:getPosition():sendDistanceEffect(position, CONST_ANI_ETHEREALSPEAR)
		target:teleportTo(position)
	end
end

local cannotPull = {"Angelic Trainer"}

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not table.contains(cannotPull, target:getName()) then
		addEvent(pull, 100, target:getId(), creature:getPosition())
	end
	return combat:execute(creature, variant)
end