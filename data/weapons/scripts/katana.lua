local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.06) + 13
	local max = (player:getLevel() / 5) + (skill * attack * 0.14) + 34
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local config = {
	time = 50, -- 50ms between each strike
	strikes = 2
}

local function katana(cid, variant, i, j)
	local creature = Creature(cid)
	if creature then
		if i <= j then
			combat:execute(creature, variant)
			addEvent(katana, config.time, cid, variant, i + 1, j)
		end
	end
end

function onUseWeapon(player, variant)
	local target = player:getTarget()
	if math.random(1, 100) <= 100 then
		player:say("Critical!", TALKTYPE_MONSTER_SAY)
		target:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
		katana(player:getId(), variant, 1, config.strikes)
		return true
	end
	return combat:execute(player, variant)
end