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

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.03) + 7
	local max = (player:getLevel() / 5) + (skill * attack * 0.05) + 11
	return -min * 2, -max * 2
end

extraDmg:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local config = {
	time = 200, -- 200ms between each cut
	max_cuts = 3
}

local function cut(cid, variant, i, j)
	local creature = Creature(cid)
	if creature then
		if i < j then
			combat:execute(creature, variant)
			addEvent(cut, config.time, cid, variant, i + 1, j)
		else
			extraDmg:execute(creature, variant)
		end
	end
end

function onCastSpell(creature, variant, isHotkey)
	cut(creature:getId(), variant, 1, config.max_cuts)
    return true
end