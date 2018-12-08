function Item.getType(self)
	return ItemType(self:getId())
end

function Item.isContainer(self)
	return false
end

function Item.isCreature(self)
	return false
end

function Item.isPlayer(self)
	return false
end

function Item.isTeleport(self)
	return false
end

function Item.isTile(self)
	return false
end

function Item.getArmor(self)
	local armor = self:getAttribute(ITEM_ATTRIBUTE_ARMOR)
	return armor > 0 and armor or self:getType():getArmor()
end

function Item.getDefense(self)
	local defense = self:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
	return defense > 0 and defense or self:getType():getDefense()
end

function Item.getAttack(self)
	local attack = self:getAttribute(ITEM_ATTRIBUTE_ATTACK)
	return attack > 0 and attack or self:getType():getAttack()
end

function Item.setReflection(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_REFLECTION, n)
end

function Item.setEvasion(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_EVASION, n)
end

function Item.setLootBonus(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_LOOTBONUS, n)
end

function Item.setDamageBonus(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_DMGBONUS, n)
end

local combats = {
	[COMBAT_FIREDAMAGE] = ITEM_ATTRIBUTE_RESISTFIRE,
	[COMBAT_DROWNDAMAGE] = ITEM_ATTRIBUTE_RESISTDROWN,
	[COMBAT_ENERGYDAMAGE] = ITEM_ATTRIBUTE_RESISTENERGY,
	[COMBAT_DEATHDAMAGE] = ITEM_ATTRIBUTE_RESISTDEATH,
	[COMBAT_HOLYDAMAGE] = ITEM_ATTRIBUTE_RESISTHOLY,
	[COMBAT_EARTHDAMAGE] = ITEM_ATTRIBUTE_RESISTEARTH,
}

function Item.setResist(self, combat, n)
	return self:setAttribute(combats[combat], n)
end

function Item.setAttackSpeed(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_ATTACKSPEED, n)
end

function Item.setCriticalChance(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_CRITICALCHANCE, n)
end

function Item.setCriticalMultiplier(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_CRITICALMULTIPLIER, n)
end

function Item.setLifeLeech(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_LIFELEECH, n)
end

function Item.setLifeLeechChance(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_LIFELEECHCHANCE, n)
end

function Item.setManaLeech(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_MANALEECH, n)
end

function Item.setManaLeechChance(self, n)
	return self:setAttribute(ITEM_ATTRIBUTE_LIFELEECHCHANCE, n)
end


function Item.getBonusRegen(self)
	local attr = self:getAttribute(ITEM_ATTRIBUTE_BONUSREGEN)
	if attr ~= 0 then
		return attr
	end
	return self:getType():getRegen()
end

--[[
function Item.get(self)
	local x = self:getAttribute(ITEM_ATTRIBUTE_)
	return x > 0 and x or self:getType():getX()
end
]]


function Item.getNameDescription(self)
	if self:getCount() > 1 then
		return self:getCount() .. " " .. self:getType():getPluralName()
	end
	return (self:getType():getArticle() .. " " .. self:getName()):trim()
end