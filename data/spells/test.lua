local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onTargetCombat(creature, target)
	print(123)
	creature:say("test", TALKTYPE_MONSTER_SAY)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCombat")

function onCastSpell(creature, variant)
	print(1111)
	return combat:execute(creature, variant)
end
