local paralyze_speed = 50
local paralyze_length = 20000 -- 20 seconds

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ASSASSIN)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, paralyze_length)
condition:setFormula(-1, paralyze_speed, -1, paralyze_speed)
combat:addCondition(condition)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.03) + 7
	local max = (player:getLevel() / 5) + (skill * attack * 0.05) + 11
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local directions = {
	[DIRECTION_NORTH] = DIRECTION_SOUTH,
	[DIRECTION_WEST] = DIRECTION_EAST,
	[DIRECTION_EAST] = DIRECTION_WEST,
	[DIRECTION_SOUTH] = DIRECTION_NORTH
}

function onCastSpell(creature, variant, isHotkey)
	local target = creature:getTarget()
	if target then
		local dir = directions[target:getDirection()]
		local position = target:getPosition():getNextPosition(dir)
		local tile = Tile(position)
		if tile and tile:isWalkable() then
			creature:teleportTo(position)
		else
			creature:sendCancelMessage("Target position is invalid.")
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end
    return combat:execute(creature, variant)
end

--[[ data/lib/core/tile.lua
function Tile.isWalkable(self)
	local ground = tile:getGround()
	if not ground or ground:hasProperty(CONST_PROP_BLOCKSOLID) then
		return false
	end

	local items = tile:getItems()
	for i = 1, tile:getItemCount() do
		local item = items[i]
		local itemType = item:getType()
		if itemType:getType() ~= ITEM_TYPE_MAGICFIELD and not itemType:isMovable() and item:hasProperty(CONST_PROP_BLOCKSOLID) then
			return false
		end
	end
	return true
end
]]