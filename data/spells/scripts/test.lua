local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_THUNDER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)

local area = {
	{1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1},
	{1, 1, 2, 1, 1},
	{1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1},
}

combat:setArea(createCombatArea(area))

function onTargetCombat(creature, target)
	local left = target:getSlotItem(CONST_SLOT_LEFT)
	local right = target:getSlotItem(CONST_SLOT_RIGHT)
	if left and left:getType():getWeaponType() == WEAPON_SHIELD or right and right:getType():getWeaponType() == WEAPON_SHIELD then
		local level = target:getSkillLevel(SKILL_SHIELD)
		target:addSkillTries(SKILL_SHIELD, level * 5)
	end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCombat")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
