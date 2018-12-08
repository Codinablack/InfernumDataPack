local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetFormulaValues(player, skill, attack, factor)
	local skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = (skill / 2) * attack * 0.03
	local max = (skill / 2) * attack * 0.05
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function execute(cid, variant, i, j)
	local player = Player(cid)
	if not player then
		return
	end
	if i >= j then
		return
	end
	combat:execute(player, variant)
	addEvent(execute, 200, cid, variant, i + 1, j)
end

function onCastSpell(creature, variant)
	execute(creature, variant, 1, 5)
	return true
end