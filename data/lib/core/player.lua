local foodCondition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)

function Player.feed(self) return true end
function Player.__feed(self, food)
	local condition = self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition then
		condition:setTicks(condition:getTicks() + (food * 1000))
	else
		local vocation = self:getVocation()
		if not vocation then
			return nil
		end

		foodCondition:setTicks(food * 1000)
		foodCondition:setParameter(CONDITION_PARAM_HEALTHGAIN, vocation:getHealthGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_HEALTHTICKS, vocation:getHealthGainTicks() * 1000)
		foodCondition:setParameter(CONDITION_PARAM_MANAGAIN, vocation:getManaGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_MANATICKS, vocation:getManaGainTicks() * 1000)

		self:addCondition(foodCondition)
	end
	return true
end

function Player.getFood(self)
	local condition = self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition then
		return condition:getTicks()
	end
	return 0
end

function Player.getClosestFreePosition(self, position, extended)
	if self:getAccountType() >= ACCOUNT_TYPE_GOD then
		return position
	end
	return Creature.getClosestFreePosition(self, position, extended)
end

function Player.getDepotItems(self, depotId)
	return self:getDepotChest(depotId, true):getItemHoldingCount()
end

function Player.getLossPercent(self)
	local blessings = 0
	local lossPercent = {
		[0] = 100,
		[1] = 70,
		[2] = 45,
		[3] = 25,
		[4] = 10,
		[5] = 0
	}

	for i = 1, 5 do
		if self:hasBlessing(i) then
			blessings = blessings + 1
		end
	end
	return lossPercent[blessings]
end

function Player.isPremium(self)
	return self:getPremiumDays() > 0 or configManager.getBoolean(configKeys.FREE_PREMIUM)
end

function Player.sendCancelMessage(self, message)
	if type(message) == "number" then
		message = Game.getReturnMessage(message)
	end
	return self:sendTextMessage(MESSAGE_STATUS_SMALL, message)
end

function Player.isUsingOtClient(self)
	return self:getClient().os >= CLIENTOS_OTCLIENT_LINUX
end

function Player.sendExtendedOpcode(self, opcode, buffer)
	if not self:isUsingOtClient() then
		return false
	end

	local networkMessage = NetworkMessage()
	networkMessage:addByte(0x32)
	networkMessage:addByte(opcode)
	networkMessage:addString(buffer)
	networkMessage:sendToPlayer(self)
	networkMessage:delete()
	return true
end

function Player.hasFlag(self, flag)
	return self:getGroup():hasFlag(flag)
end

APPLY_SKILL_MULTIPLIER = true
local addSkillTriesFunc = Player.addSkillTries
function Player.addSkillTries(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addSkillTriesFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

local addManaSpentFunc = Player.addManaSpent
function Player.addManaSpent(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addManaSpentFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

--// custom functions
function getExperienceForLevel(lv)
	return ((50 * lv * lv * lv) - (150 * lv * lv) + (400 * lv)) / 3
end

function Player.addLevel(self, lv)
	local exp = getExperienceForLevel(self:getLevel() + lv) - self:getExperience()
	return self:addExperience(exp)
end

function Player.removeLevel(self, lv)
	local exp = self:getExperience() - getExperienceForLevel(self:getLevel() - lv)
	return self:removeExperience(exp)
end

function Player.getBaseHealth(self)
	local voc = self:getVocation()
	return (self:getLevel() * voc:getHealthGain() + 185)
end

function Player.getBaseMana(self)
	local voc = self:getVocation()
	return (self:getLevel() * voc:getManaGain() + 30)
end

function Player.heal(self)
	self:addHealth(self:getMaxHealth())
	self:addMana(self:getMaxMana())
end

function Player.getHelmet(self)
	return self:getSlotItem(CONST_SLOT_HEAD)
end

function Player.getArmor(self)
	return self:getSlotItem(CONST_SLOT_ARMOR)
end

function Player.getLegs(self)
	return self:getSlotItem(CONST_SLOT_LEGS)
end

function Player.getBoots(self)
	return self:getSlotItem(CONST_SLOT_FEET)
end

function Player.getLeft(self)
	return self:getSlotItem(CONST_SLOT_LEFT)
end

function Player.getRight(self)
	return self:getSlotItem(CONST_SLOT_RIGHT)
end

function Player.getNecklace(self)
	return self:getSlotItem(CONST_SLOT_NECKLACE)
end

function Player.getAmmo(self)
	return self:getSlotItem(CONST_SLOT_AMMO)
end

function Player.getBackpack(self)
	return self:getSlotItem(CONST_SLOT_BACKPACK)
end

function Player.getRing(self)
	return self:getSlotItem(CONST_SLOT_RING)
end

local nonWeapons = {WEAPON_SHIELD, WEAPON_NONE, WEAPON_AMMO}

function Player.getWeapon(self)
	local left = self:getSlotItem(CONST_SLOT_LEFT)
	if left and not table.contains(nonWeapons, left:getType():getWeaponType()) then
		return left
	end
	local right = self:getSlotItem(CONST_SLOT_RIGHT)
	if right and not table.contains(nonWeapons, right:getType():getWeaponType()) then
		return right
	end
	return nil
end

function Player.makeGod(self)
	local guid = self:getGuid()
	local accid = self:getAccountId()
	self:remove()
	db.query("UPDATE `accounts` SET `type` = 5 WHERE `id` = ".. accid)
	db.query("UPDATE `players` SET `group_id` = 3 WHERE `id` = ".. guid)
end

function Player.getBonusRegen(self)
	return self:getEffectiveAbility(ITEM_ABILITY_BONUSREGEN)
end

function Player.regen(self, id)
	if id and not Player(id) then return end
	if self:getGroup():getId() > 1 then
		return
	end
	if self:getHealth() == self:getMaxHealth() and self:getMana() == self:getMaxMana() then
		return addEvent(Player.regen, 3000, self, self:getId())
	end
	local vocation = self:getVocation()
	local healthGain = vocation:getHealthGain() + self:getBonusRegen()
	local manaGain = vocation:getManaGain() + self:getBonusRegen()
	self:addHealth(healthGain)
	self:addMana(manaGain)
	addEvent(Player.regen, 3000, self, self:getId())
end

function Player.getSpellExhaust(self, spell)
	local condition = self:getCondition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, spell:getId())
	if condition then
		return condition:getTicks()
	end
	return -1
end

function Player.getGroupExhaust(self, spell)
	local condition = self:getCondition(CONDITION_SPELLGROUPCOOLDOWN, CONDITIONID_DEFAULT, spell.group)
	if condition then
		return condition:getTicks()
	end
	return -1
end

function Player.hasSpellExhaust(self, spell)
	return self:getSpellExhaust(spell) ~= -1
end

function Player.hasGroupExhaust(self, spell)
	return self:getGroupExhaust(spell) ~= -1
end

function healbot(cid, spell)
	local player = Player(cid)
	if not player or not player:hasHealingBot() then
		return
	end
	local healthPercent = math.floor(player:getHealth() / player:getMaxHealth() * 100)
	if healthPercent <= 95 and not player:hasSpellExhaust(spell) and not player:hasGroupExhaust(spell) then
		player:castSpell(spell)
	end
	addEvent(healbot, spell.cooldown, cid, spell)
end

local spells = {"Exura Vita"}

function Player.startupHealbot(self, id)
	for _, spellname in ipairs(spells) do
		local spell = Spell(spellname)
		if spell then
			if self:getLevel() >= spell.level then
				healbot(self:getId(), spell)
			end
		end 
	end
end


local abilities = {
	{ITEM_ABILITY_FLEXSKILL, "Bonus Skill: "},
	{ITEM_ABILITY_DAMAGEMITIGATION, "Damage Mitigation: ", true},
	{ITEM_ABILITY_BONUSREGEN, "Bonus Regen: "},
	{ITEM_ABILITY_SUPPORTHEALING, "Support Healing: ", true},
	{ITEM_ABILITY_BONUSHEALING, "Bonus Healing: ", true},
	{ITEM_ABILITY_SPEED, "Bonus Speed: "},
	{ITEM_ABILITY_MAGICDAMAGE, "Magic Damage: ", true},
}

function Player.getAbilities(self)
	local s = {}
	for _, v in ipairs(abilities) do
		local val = self:getEffectiveAbility(v[1])
		if val and val > 0 then
			s[#s + 1] = ("[%s +%s%s]"):format(v[2], (v[1] == ITEM_ABILITY_SPEED) and val/2 or val, v[3] and '%' or '')
		end
	end
	return table.concat(s, '\n')
end

function Player.getWeapon(self)
	local weapons = {WEAPON_AXE, WEAPON_CLUB, WEAPON_SWORD, WEAPON_DISTANCE, WEAPON_WAND}
	local left = self:getSlotItem(CONST_SLOT_LEFT)
	if left and table.contains(weapons, left:getType():getWeaponType()) then
		return left
	end
	local right = self:getSlotItem(CONST_SLOT_RIGHT)
	if right and table.contains(weapons, right:getType():getWeaponType()) then
		return right
	end
end