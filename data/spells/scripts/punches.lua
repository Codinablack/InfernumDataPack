local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 10) + (skill * attack * 0.03) + 7
	local max = (player:getLevel() / 10) + (skill * attack * 0.05) + 11
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local config = {
	time = 200, -- 200ms between each punch
	max_punches = 10
}

local function punch(cid, variant, i, j)
	local creature = Creature(cid)
	if creature then
		if i <= j then
			combat:execute(creature, variant)
			addEvent(punch, config.time, cid, variant, i + 1, j)
		end
	end
end

function onCastSpell(creature, variant, isHotkey)
	punch(creature:getId(), variant, 1, config.max_punches)
    return true
end