Orb = {}

GLOBAL_ORBS = {}
POSITION_ORBS = {}

ORBTYPE_GOLD = 1
ORBTYPE_ITEMS = 2
ORBTYPE_EXPERIENCE = 3

ORB_SPAWNCHANCE = 100

local ORB_EFFECTS = {
	[ORBTYPE_GOLD] = CONST_ME_HOLYDAMAGE,
	[ORBTYPE_ITEMS] = CONST_ME_CRAPS,
	[ORBTYPE_EXPERIENCE] = CONST_ME_PURPLEENERGY
}

function Position.serialize(self)
	return string.format("%d,%d,%d", self.x, self.y, self.z)
end

function Position.getOrbs(self)
	return POSITION_ORBS[self:serialize()]
end

function Position.getOrbCount(self)
	local i = 0
	for k, v in pairs(self:getOrbs()) do
		i = i + 1
	end
	return i
end

function Player.getOrbs(self)
	return GLOBAL_ORBS[self:getGuid()]
end

function table.add(t, key, v)
	if not t[key] then
		t[key] = {v}
		return 1
	end
	for i = 1, table.maxn(t[key]) + 1 do
		if t[key][i] == nil then
			t[key][i] = v
			return i
		end
	end
end

setmetatable(Orb, {
	__call = function(self, owner, position, value, orbType)
		if not owner or math.random(100) > ORB_SPAWNCHANCE then
			return
		end
		local orb = {
			orbType = orbType,
			value = value,
			owner = owner,
			ownerGuid = owner:getGuid(),
			position = position,
			decayTime = os.mtime() + 10000,
			magicEffect = ORB_EFFECTS[orbType],
			ownerName = owner:getName()
		}
		setmetatable(orb, {__index = Orb})
		orb.globalKey = table.add(GLOBAL_ORBS, owner:getGuid(), orb)
		orb.positionKey = table.add(POSITION_ORBS, position:serialize(), orb)
		local tile = Tile(position)
		if tile then
			tile:getGround():setActionId(2018)
		end
		orb:tick()
		return orb
	end
})

function Orb.siphon(self)
	local effects = {
		{0, 1, 0},
		{1, -1, 1},
		{0, 1, 0},
	}
	if self.orbType == ORBTYPE_GOLD then
		self.owner:say("* GOLD *", TALKTYPE_MONSTER_SAY)
		for i, currency in ipairs(self.value) do
			self.owner:addItem(currency.id, math.random(currency.count[1], currency.count[2]))
		end
	elseif self.orbType == ORBTYPE_ITEMS then
		self.owner:say("* ITEMS *", TALKTYPE_MONSTER_SAY)
		for i, item in ipairs(self.value) do
			self.owner:addItem(item, 1)
		end
	elseif self.orbType == ORBTYPE_EXPERIENCE then
		self.owner:say("* EXP *", TALKTYPE_MONSTER_SAY)
		self.owner:addExperience(self.value)
	end
	self:delete()
	local positions = self.position:generateEffectPositions(effects, {})
	executeChunks(CONST_ANI_SUDDENDEATH, positions, {swapPositions = true}, 0)
end

function Orb.tick(self)
	if os.mtime() < self.decayTime then
		self.position:sendMagicEffect(self.magicEffect, self.owner)
		self.position:sendMagicEffect(CONST_ME_TUTORIALSQUARE, self.owner)
		self.event = addEvent(Orb.tick, 1000, self)
	else
		self:delete()
	end
end

function Orb.delete(self)
	GLOBAL_ORBS[self.ownerGuid][self.globalKey] = nil
	POSITION_ORBS[self.position:serialize()][self.positionKey] = nil
	if self.position:getOrbCount() == 0 then
		local tile = Tile(self.position)
		if tile then
			tile:getGround():removeAttribute(ITEM_ATTRIBUTE_ACTIONID)
		end
	end
	stopEvent(self.event)
end