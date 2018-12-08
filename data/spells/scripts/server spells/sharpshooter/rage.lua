local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
condition:setTicks(15000)

function resetAttackspeed(cid, ms)
	local player = Player(cid)
	if not player then
		return
	end
	player:setAttackSpeed(ms)
end

function onCastSpell(creature, variant)
	local player = Player(creature)
	if not player then
		return false
	end
	player:addCondition(condition)
	local base = player:getAttackSpeed()
	player:setAttackSpeed(600)
	addEvent(resetAttackspeed, 15000, player:getId(), base)
	return combat:execute(creature, variant)
end