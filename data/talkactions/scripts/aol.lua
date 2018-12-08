--Waves
AREA_WAVE4 = {
	{1, 1, 1, 1, 1},
	{0, 1, 1, 1, 0},
	{0, 1, 1, 1, 0},
	{0, 0, 3, 0, 0}
}

AREA_SQUAREWAVE5 = {
	{1, 1, 1},
	{1, 1, 1},
	{1, 1, 1},
	{0, 1, 0},
	{0, 3, 0}
}

AREA_WAVE5 = {
	{0, 1, 1, 1, 0},
	{1, 1, 1, 1, 1},
	{0, 1, 1, 1, 0},
	{0, 0, 1, 0, 0},
	{0, 0, 3, 0, 0}
}

--Diagonal waves
AREADIAGONAL_WAVE4 = {
	{0, 0, 0, 0, 1, 0},
	{0, 0, 0, 1, 1, 0},
	{0, 0, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 0},
	{0, 0, 0, 0, 0, 3}
}

AREADIAGONAL_SQUAREWAVE5 = {
	{1, 1, 1, 0, 0},
	{1, 1, 1, 0, 0},
	{1, 1, 1, 0, 0},
	{0, 0, 0, 1, 0},
	{0, 0, 0, 0, 3}
}

AREADIAGONAL_WAVE5 = {
	{0, 0, 0, 0, 1, 0},
	{0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 0, 0},
	{1, 0, 0, 0, 1, 0},
	{0, 0, 0, 0, 0, 3}
}

--Beams
AREA_BEAM1 = {
	{3}
}

AREA_BEAM5 = {
	{1},
	{1},
	{1},
	{1},
	{1},
	{3}
}

AREA_BEAM7 = {
	{1},
	{1},
	{1},
	{1},
	{1},
	{1},
	{1},
	{3}
}

--Diagonal Beams
AREADIAGONAL_BEAM5 = {
	{1, 0, 0, 0, 0, 0},
	{0, 1, 0, 0, 0, 0},
	{0, 0, 1, 0, 0, 0},
	{0, 0, 0, 1, 0, 0},
	{0, 0, 0, 0, 1, 0},
	{0, 0, 0, 0, 0, 3}
}

AREADIAGONAL_BEAM7 = {
	{1, 0, 0, 0, 0, 0, 0, 0},
	{0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 1, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0},
	{0, 0, 0, 0, 0, 0, 0, 3}
}

--Circles
AREA_CIRCLE2X2 = {
	{0, 1, 1, 1, 0},
	{1, 1, 1, 1, 1},
	{1, 1, 3, 1, 1},
	{1, 1, 1, 1, 1},
	{0, 1, 1, 1, 0}
}

AREA_CIRCLE3X3 = {
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 3, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0}
}

-- Crosses
AREA_CROSS1X1 = {
	{0, 1, 0},
	{1, 3, 1},
	{0, 1, 0}
}

AREA_CROSS5X5 = {
	{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
}

AREA_CROSS6X6 = {
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0}
}

--Squares
AREA_SQUARE1X1 = {
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
}

-- Walls
AREA_WALLFIELD = {
	{1, 1, 3, 1, 1}
}

AREADIAGONAL_WALLFIELD = {
	{0, 0, 0, 0, 1},
	{0, 0, 0, 1, 1},
	{0, 1, 3, 1, 0},
	{1, 1, 0, 0, 0},
	{1, 0, 0, 0, 0},
}



local SpellList = {
-- Meteor Shower
[1] = {type = COMBAT_FIREDAMAGE, effect = CONST_ME_NONE, distance = CONST_ANI_NONE, area=AREA_CIRCLE2X2},
[2] = {type = COMBAT_FIREDAMAGE, effect = CONST_ME_NONE, distance = CONST_ANI_NONE, area=AREA_CIRCLE3X3},
[3] = {type = COMBAT_FIREDAMAGE, effect = CONST_ME_NONE, distance = CONST_ANI_NONE, area=AREA_CIRCLE3X3},
[4] = {type = COMBAT_FIREDAMAGE, effect = CONST_ME_NONE, distance = CONST_ANI_NONE, area=AREA_CROSS5X5},
[5] = {type = COMBAT_FIREDAMAGE, effect = CONST_ME_NONE, distance = CONST_ANI_NONE, area=AREA_CROSS6X6},
-- Black Hole
[6] = {type = COMBAT_DEATHDAMAGE, effect = CONST_ME_MORTAREA, distance = CONST_ANI_SUDDENDEATH, area=AREA_BEAM1},
[7] = {type = COMBAT_DEATHDAMAGE, effect = CONST_ME_MORTAREA, distance = CONST_ANI_SUDDENDEATH, area=AREA_BEAM1},
[8] = {type = COMBAT_DEATHDAMAGE, effect = CONST_ME_MORTAREA, distance = CONST_ANI_SUDDENDEATH, area=AREA_BEAM1},
[9] = {type = COMBAT_DEATHDAMAGE, effect = CONST_ME_MORTAREA, distance = CONST_ANI_SUDDENDEATH, area=AREA_BEAM1},
[10] = {type = COMBAT_DEATHDAMAGE, effect = CONST_ME_MORTAREA, distance = CONST_ANI_SUDDENDEATH, area=AREA_BEAM1},
-- Nebula
[11] = {type = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT, distance = CONST_ANI_NONE, area=AREA_BEAM1},
[12] = {type = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT, distance = CONST_ANI_NONE, area=AREA_BEAM1},
[13] = {type = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT, distance = CONST_ANI_NONE, area=AREA_BEAM1},
[14] = {type = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT, distance = CONST_ANI_NONE, area=AREA_BEAM1},
[15] = {type = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT, distance = CONST_ANI_NONE, area=AREA_BEAM1},
-- SD
}

petcombat = petcombat or {}
if not next(petcombat) then
	for i = 1, 15 do
	petcombat[i] = Combat()
	petcombat[i]:setParameter(COMBAT_PARAM_TYPE,SpellList[i].type)
	petcombat[i]:setArea(createCombatArea(SpellList[i].area))
	petcombat[i]:setParameter(COMBAT_PARAM_EFFECT,SpellList[i].effect)
	petcombat[i]:setParameter(COMBAT_PARAM_DISTANCEEFFECT,SpellList[i].distance)
	end
end

local function autoattack(player, istargetdead) 
local player = Player(player)
if not player then
	return
end
  -- if player has autoattack enabled
  -- if player has pet and get pet Spell and "get pet Spell damage inside Spell script?" Throw Spell 
--if player:getName() == "God Antolak" then
if player:getStorageValue(666667) == 2 then -- if pet active
 local Spellid = player:getStorageValue(666671) 
 if Spellid >= 1 then
 local PetLevel = player:getStorageValue(666670)
 local pos = player:getPosition()
 --print (SpellList[Spellid][1])
	 local damage = PLAYER_PETDAMAGE_STORAGE_[player:getName()][1]
 	local passivechance = PLAYER_PETDAMAGE_STORAGE_[player:getName()][2]
	local critchance = PLAYER_PETDAMAGE_STORAGE_[player:getName()][3]
	local critdamage = PLAYER_PETDAMAGE_STORAGE_[player:getName()][4]
	--print (petcombat)
	local passivechance2 = math.random(1, 51)
	
 local targets, spectator = Game.getSpectators(pos, false, false, 6,6,6,6)
		for i = 1, #targets do
			local target = targets[i]
			if target:isMonster() and getTilePzInfo(getCreaturePosition(player)) == false and target:isSummon() == nil then
				if isSightClear(player:getPosition(), target:getPosition(), false) then

	local critchance2 = math.random(critchance, 51)
	if critchance2 <= critchance then -- if the spell crits
    damage = math.floor(damage+damage*(critdamage/100))
end
				--if player:getName() == "God Antolak" then
					--Spellid = 11
				--end
				if passivechance2 <= passivechance then --or player:getName() == "God Antolak" then -- if the spell triggered
                if Spellid >= 1 and Spellid <= 5 then -- 1 = random position around the monster
				local monsterpos = target:getPosition()
				local damage = damage/4
				petcombat[Spellid]:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0) -- AOE
				petcombat[Spellid]:execute(player, Variant(monsterpos))
				elseif Spellid >= 6 and Spellid <= 10 then
				local damage = damage*((Spellid-4)/3.5)
				petcombat[Spellid]:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0) -- Single Target
				petcombat[Spellid]:execute(player, Variant(target:getId())) -- damage Spells
				elseif Spellid >= 11 and Spellid <= 15 then
				local damage = damage/2
				local pos2 = target:getPosition()
				pos:sendDistanceEffect(target:getPosition(), CONST_ANI_ENERGYBALL)
				petcombat[Spellid]:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0) -- Chain
				petcombat[Spellid]:execute(player, Variant(target:getId())) -- damage Spells
				local target2, spectator = Game.getSpectators(pos2, false, false, 8,8,8,8)
				local breakchain = Spellid-9
				for i = 1, #target2 do
					if target2[i]:isMonster() and target2[i].uid ~= istargetdead and target2[i]:isSummon() == nil then
						--print(target2[i]:getName())
						if i > 1 then
						if target2[i-1].uid ~= istargetdead and target2[i-1]:isMonster() and target2[i-1]:isSummon() == nil then
					pos2 = target2[i-1]:getPosition()
				end
			end
					local pos3 = target2[i]:getPosition()
					    if isSightClear(pos2, pos3, false) then
							if i > 1 and pos2 then
				           pos2:sendDistanceEffect(pos3, CONST_ANI_ENERGYBALL)
					   end
						   petcombat[Spellid]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_NONE)
				           petcombat[Spellid]:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0) -- Chain
				           petcombat[Spellid]:execute(player, Variant(target2[i]:getId())) -- damage Spells
				           if i >= breakchain then
					           break
				           end
					    end
				    end
			end
		end
		else -- if chance failed. v
			local pos5 = player:getPosition()
			local pos6 = target:getPosition()
			local petcombat2 = Combat()
			if isSightClear(pos5, pos6, false) then
				if Spellid >= 1 and Spellid <= 5 then
					petcombat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
					pos5:sendDistanceEffect(pos6, CONST_ANI_FIRE)
					elseif Spellid >= 6 and Spellid <= 10 then
						petcombat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
						pos5:sendDistanceEffect(pos6, CONST_ANI_SUDDENDEATH)
						elseif Spellid >= 11 and Spellid <= 15 then
							petcombat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
							pos5:sendDistanceEffect(pos6, CONST_ANI_ENERGYBALL)
					end
				petcombat2:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0) -- Normal
				petcombat2:execute(player, Variant(target:getId())) -- damage Spells	--print ("setting target")
			end
	end
break	
end
end
end
end
end

local pos = player:getPosition()
local vocation = player:getVocation()
local vocation = vocation:getName()
if vocation == "Knight" or vocation == "Elite Knight" then
	weaponrangex = 1
	weaponrangey = 1
else
	weaponrangex = 6
	weaponrangey = 4
end
local targets, spectator = Game.getSpectators(pos, false, false, weaponrangex, weaponrangex, weaponrangey, weaponrangey)
		for i = 1, #targets do
			target = targets[i]
			if target:isMonster() and target.uid ~= istargetdead and getTilePzInfo(getCreaturePosition(player)) == false and target:isSummon() == nil then
				if player:getTarget() == nil then
					player:setTarget(target)
					--print ("setting target")
					break
			end
				--print ("setting target")
	end
end
if player:getTarget() ~= nil then
	target = player:getTarget()
	local message =  NetworkMessage()
    message:addByte(0x93);
    message:addU32(target:getId())
    message:addByte(0x01);
    message:addByte(180);  -- 180 color red
 message:sendToPlayer(player, false)
end
--print ("attacked a monster")
--print (player:getName())
--print (target:getName())
if player:getStorageValue(999997) == 2 then
addEvent(autoattack, 1000, player:getId(), target:getId())
pos:sendMagicEffect(CONST_ME_STEPSHORIZONTAL)
end
return
end


function onSay(cid, words, param)
if cid:getStorageValue(999997) == 2 then
cid:setStorageValue(999997, 1)
else
addEvent(autoattack, 500, cid:getId())
cid:setStorageValue(999997, 2)
end
end