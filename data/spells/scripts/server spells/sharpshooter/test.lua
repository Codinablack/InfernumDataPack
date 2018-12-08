local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetFormulaValues(player, skill, attack, factor)
	local skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = skill * attack * 0.04
	local max = skill * attack * 0.06
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local function exec(cid, i, j)
	local eff = {
		{0, 2, 0},
		{1, -1, 3},
		{0, 4,  0}
	}
	local creature = Creature(cid)
	if i >= j or not creature then
		return
	end
	local effects = creature:getPosition():generateEffectPositions(eff)
	executeEffects(CONST_ANI_ETHEREALSPEAR, effects, {continuous = true, fullLoop = true}, 50)
	local target = creature:getTarget()
	if target then
		combat:execute(creature, Variant(target:getId()))
	end
	addEvent(exec, 150, cid, i+1, j)
end

function onCastSpell(creature, variant)
	exec(creature:getId(), 1, 20)
	return combat:execute(creature, variant)
end