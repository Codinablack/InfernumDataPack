DPS = DPS or {}

function Player.displayDPS(self)
	self:say(string.format("Your DPS is: %s", DPS[self:getGuid()].damage / 5), TALKTYPE_MONSTER_SAY, false, self)
end

local function callback(cid, guid)
	local player = Player(cid)
	if player then
		if DPS[guid].damage == 0 then
			DPS[guid] = nil
			return
		end
		player:displayDPS()
		DPS[guid].damage = 0
		addEvent(callback, 5000, cid, guid)
	end
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not attacker or not attacker:isPlayer() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local damage = primaryDamage + secondaryDamage
	local guid = attacker:getGuid()
	if not DPS[guid] then
		DPS[guid] = {damage = 0, event = addEvent(callback, 5000, attacker:getId(), guid)}
	end
	local dps = DPS[guid]
	dps.damage = dps.damage + damage
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end