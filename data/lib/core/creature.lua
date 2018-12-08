function Creature.getClosestFreePosition(self, position, extended)
	local usePosition = Position(position)
	local tiles = { Tile(usePosition) }
	local length = extended and 2 or 1

	local tile
	for y = -length, length do
		for x = -length, length do
			if x ~= 0 or y ~= 0 then
				usePosition.x = position.x + x
				usePosition.y = position.y + y

				tile = Tile(usePosition)
				if tile then
					tiles[#tiles + 1] = tile
				end
			end
		end
	end

	for i = 1, #tiles do
		tile = tiles[i]
		if tile:getCreatureCount() == 0 and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then
			return tile:getPosition()
		end
	end
	return Position()
end

function Creature.getPlayer(self)
	return self:isPlayer() and self or nil
end

function Creature.isItem(self)
	return false
end

function Creature.isMonster(self)
	return false
end

function Creature.isNpc(self)
	return false
end

function Creature.isPlayer(self)
	return false
end

function Creature.isTile(self)
	return false
end

function Creature.isSummon(self)
	return self:getMaster()
end

squareEvents = squareEvents or {}

local function sendSquare(cid, color, sec, targetId)
	local creature = Creature(cid)
	if not creature then
		return false
	end
	if sec > 0 or sec == -1 then
		local pos = creature:getPosition()
		local msg = NetworkMessage()
		msg:addByte(0x93)
		msg:addU32(cid)
		msg:addByte(0x01)
		msg:addByte(color)
		local target = Player(targetId)
		if target then
			msg:sendToPlayer(target)
		else
			local spectators = Game.getSpectators(pos, false, true, 7, 7, 6, 6)
			for i = 1, #spectators do
				msg:sendToPlayer(spectators[i])
			end
		end
		squareEvents[cid] = addEvent(sendSquare, 990, cid, color, (sec > 0 and sec - 1 or sec), targetId)
	end
end
 
function Creature.sendSquare(self, color, sec, target)
	stopEvent(self:stopSquare())
	sendSquare(self:getId(), color, sec or -1, target and target:getId())
	return true
end

function Creature.stopSquare(self)
	stopEvent(squareEvents[self:getId()])
end

function Creature.setSpeed(self, speed)
	return self:changeSpeed(-self:getSpeed() + speed)
end

function Creature:addSummon(monster)
	local summon = Monster(monster)
	if not summon then
		return false
	end

	summon:setTarget(nil)
	summon:setFollowCreature(nil)
	summon:setDropLoot(false)
	summon:setSkillLoss(false)
	summon:setMaster(self)

	return true
end

function Creature:removeSummon(monster)
	local summon = Monster(monster)
	if not summon or summon:getMaster() ~= self then
		return false
	end

	summon:setTarget(nil)
	summon:setFollowCreature(nil)
	summon:setDropLoot(true)
	summon:setSkillLoss(true)
	summon:setMaster(nil)

	return true
end

function doAreaCombatDamage(cid, attacker, combatType, position, min, max, effect)
   local creature = Creature(cid)
   if not creature then
       return
   end
   doAreaCombatHealth(attacker, combatType, position, 0, min, max, effect)
end

function Creature:ignite(target, damageType, damage, time, rounds)
	local target_id = target:getId()
	local cid = self:getId()
	local function execute(i)
		local creature = Creature(cid)
		local target = Creature(target_id)
		if i >= rounds or not creature or not target then
			return
		end
		local dmg = type(damage) == "table" and math.random(damage[1], damage[2]) or damage
		doAreaCombatHealth(cid, damageType, target:getPosition(), 0, dmg, dmg)
		addEvent(execute, time, i + 1)
	end
	execute(0)
end

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
