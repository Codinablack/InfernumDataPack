local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.06) + 13
	local max = (player:getLevel() / 5) + (skill * attack * 0.14) + 34
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local effects = {
	{min = 1, max = 76},
	{158, 167, 168, 169, 170}
}

local bleed = {
	damage = {min = 1, max = 100},
	time = 1000,
	rounds = 10
}

function onUseWeapon(player, variant)
	local target = player:getTarget()
	if target then
		local effect_t = effects[math.random(#effects)]
		local effect = effect_t.min and math.random(effect_t.min, effect_t.max) or effect_t[math.random(#effect_t)]
		target:getPosition():sendMagicEffect(effect)
		player:addDamageCondition(target, CONDITION_BLEEDING, DAMAGELIST_VARYING_DAMAGE, bleed.damage, bleed.time, bleed.rounds)
	end
	return combat:execute(player, variant)
end

-- data/lib/core/constants.lua
-- add: DAMAGELIST_VARYING_DAMAGE = 4

-- data/lib/core/creature.lua
--[[ add or replace:

function Creature:addDamageCondition(target, type, list, damage, period, rounds)
	if _G["type"](damage) == "number" and damage <= 0 or not target or target:isImmune(type) then
		return false
	end

	local condition = Condition(type)
	condition:setParameter(CONDITION_PARAM_OWNER, self:getId())
	condition:setParameter(CONDITION_PARAM_DELAYED, true)

	if list == DAMAGELIST_EXPONENTIAL_DAMAGE then
		local exponent, value = -10, 0
		while value < damage do
			value = math.floor(10 * math.pow(1.2, exponent) + 0.5)
			condition:addDamage(1, period or 4000, -value)

			if value >= damage then
				local permille = math.random(10, 1200) / 1000
				condition:addDamage(1, period or 4000, -math.max(1, math.floor(value * permille + 0.5)))
			else
				exponent = exponent + 1
			end
		end
	elseif list == DAMAGELIST_LOGARITHMIC_DAMAGE then
		local n, value = 0, damage
		while value > 0 do
			value = math.floor(damage * math.pow(2.718281828459, -0.05 * n) + 0.5)
			if value ~= 0 then
				condition:addDamage(1, period or 4000, -value)
				n = n + 1
			end
		end
	elseif list == DAMAGELIST_VARYING_PERIOD then
		for _ = 1, rounds do
			condition:addDamage(1, math.random(period[1], period[2]) * 1000, -damage)
		end
	elseif list == DAMAGELIST_CONSTANT_PERIOD then
		condition:addDamage(rounds, period * 1000, -damage)
	elseif list == DAMAGELIST_VARYING_DAMAGE then
		for _ = 1, rounds do
			condition:addDamage(1, period, -math.random(damage.min, damage.max))
		end
	end

	target:addCondition(condition)
	return true
end

]]