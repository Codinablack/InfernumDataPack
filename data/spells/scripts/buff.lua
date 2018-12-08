local config = {
	bonus_fist = 70, -- 70%
	bonus_movespeed = 50, -- 50%
	time = 20000, -- 20 seconds
	effect = CONST_ME_MAGIC_GREEN,
	effect_time = 1000
}

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SKILL_FISTPERCENT, 100 + config.bonus_fist)
condition:setParameter(CONDITION_PARAM_TICKS, config.time)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

effects = effects or {}

local function removeSpeed(cid, guid, delta)
	stopEvent(effects[guid])
	local creature = Creature(cid)
	if not creature then
		return
	end
	creature:changeSpeed(-delta)
end

local function effect(cid)
	local creature = Creature(cid)
	if not creature then
		return
	end
	creature:getPosition():sendMagicEffect(config.effect)
	effects[creature:getGuid()] = addEvent(effect, config.effect_time, cid)
end

function onCastSpell(creature, variant, isHotkey)
	local speed = creature:getBaseSpeed()
	local delta = speed * (config.bonus_movespeed / 100)
	addEvent(removeSpeed, config.time, creature:getId(), creature:getGuid(), delta)
	creature:changeSpeed(delta)
	creature:getPosition():sendMagicEffect(config.effect)
	creature:addCondition(condition)
	effect(creature:getId())
	return true
end