local slotBits = {
	[CONST_SLOT_HEAD] = SLOTP_HEAD,
	[CONST_SLOT_NECKLACE] = SLOTP_NECKLACE,
	[CONST_SLOT_BACKPACK] = SLOTP_BACKPACK,
	[CONST_SLOT_ARMOR] = SLOTP_ARMOR,
	[CONST_SLOT_RIGHT] = SLOTP_RIGHT,
	[CONST_SLOT_LEFT] = SLOTP_LEFT,
	[CONST_SLOT_LEGS] = SLOTP_LEGS,
	[CONST_SLOT_FEET] = SLOTP_FEET,
	[CONST_SLOT_RING] = SLOTP_RING,
	[CONST_SLOT_AMMO] = SLOTP_AMMO
}

function ItemType.usesSlot(self, slot)
	return bit.band(self:getSlotPosition(), slotBits[slot] or 0) ~= 0
end

function ItemType.isWeapon(self)
	local weptype = self:getWeaponType()
	return weptype ~= WEAPON_NONE and weptype ~= WEAPON_AMMO and weptype ~= WEAPON_SHIELD
end

function ItemType.isShield(self)
	return self:getWeaponType() == WEAPON_SHIELD
end

function ItemType.isArmor(self)
	for slot = 1, 10 do
		if slot ~= CONST_SLOT_LEFT and slot ~= CONST_SLOT_RIGHT then
			if self:usesSlot(slot) then
				return true
			end
		end
	end
	return false
end