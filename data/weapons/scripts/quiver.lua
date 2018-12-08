local default_bolt = Combat()
default_bolt:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BOLT)

local default_arrow = Combat()
default_arrow:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ARROW)

----------------------------------- EARTH ARROW -----------------------------------------

local eartharrow_combat = Combat()
eartharrow_combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTHARROW)
eartharrow_combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PLANTATTACK)
eartharrow_combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

function eartharrow_onGetFormulaValues(player, skill, attack, factor)
	return -1, -100
end

eartharrow_combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "eartharrow_onGetFormulaValues")

------------------------------------------------------------------------------------------

------------------------------------ FIRE ARROW ------------------------------------------

local firearrow_combat = Combat()
firearrow_combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FLAMMINGARROW)
firearrow_combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
firearrow_combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function firearrow_onGetFormulaValues(player, skill, attack, factor)
	return -1, -100
end

firearrow_combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "firearrow_onGetFormulaValues")

------------------------------------------------------------------------------------------

------------------------------------- ICE ARROW ------------------------------------------

local icearrow_combat = Combat()
icearrow_combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SHIVERARROW)
icearrow_combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
icearrow_combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)

function icearrow_onGetFormulaValues(player, skill, attack, factor)
	return -1, -100
end

icearrow_combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "icearrow_onGetFormulaValues")

------------------------------------------------------------------------------------------

local cfg = {
	crossbows = {
		ids = {5803, 8849, 8850, 8853, 8852, 8851, 15644, 16111, 18453, 21690, 22419, 22420, 22421},
		combats = {

		}
	},
	bows = {
		ids = {8857, 8855, 8856, 8858, 8854, 13873, 15643, 18454, 21696, 22416, 22417, 22418},
		combats = {
			[7850] = eartharrow_combat,
			[7840] = firearrow_combat,
			[7839] = icearrow_combat
		}
	}
}

function onUseWeapon(player, variant)
	local items = player:getQuiverItems()
	local weapon = player:getWeapon()
	local combats = nil
	if table.contains(cfg.crossbows.ids, weapon:getId()) then
		combats = cfg.crossbows.combats
	elseif table.contains(cfg.bows.ids, weapon:getId()) then
		combats = cfg.bows.combats
	end
	if items then
		if combats then
			for _, item in ipairs(items) do
				local combat = combats[item:getId()]
				if combat then
					return combat:execute(player, variant)
				end
			end
		end
	else
		local weapon = player:getWeapon()
		if weapon then
			if table.contains(cfg.crossbows, weapon:getId()) then
				return default_bolt:execute(player, variant)
			elseif table.contains(cfg.bows, weapon:getId()) then
				return default_arrow:execute(player, variant)
			else
				print("error, no default combat selected, id: ".. weapon:getId())
			end
		end
	end
	print("how the fuck did it get here")
end