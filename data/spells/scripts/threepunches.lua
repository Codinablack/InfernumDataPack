local paralyze_speed = 100
local paralyze_length = 20000 -- 20 seconds

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.03) + 7
	local max = (player:getLevel() / 5) + (skill * attack * 0.05) + 11
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local extraDmg = Combat()
extraDmg:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
extraDmg:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
extraDmg:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, paralyze_length)
condition:setFormula(-1, paralyze_speed, -1, paralyze_speed)
extraDmg:addCondition(condition)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.03) + 7
	local max = (player:getLevel() / 5) + (skill * attack * 0.05) + 11
	return -min * 3, -max * 3
end

extraDmg:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local config = {
	time = 200, -- 200ms between each punch
	max_punches = 3
}

local bleed = {
	damage = {min = 1, max = 100},
	time = 1000,
	rounds = 10
}

local function punch(cid, variant, i, j)
	local creature = Creature(cid)
	if creature then
		if i < j then
			combat:execute(creature, variant)
			addEvent(punch, config.time, cid, variant, i + 1, j)
		else
			extraDmg:execute(creature, variant)
			creature:addDamageCondition(Creature(variant:getNumber()), CONDITION_BLEEDING, DAMAGELIST_VARYING_DAMAGE, bleed.damage, bleed.time, bleed.rounds)
		end
	end
end

function onCastSpell(creature, variant, isHotkey)
	punch(creature:getId(), variant, 1, config.max_punches)
    return true
end