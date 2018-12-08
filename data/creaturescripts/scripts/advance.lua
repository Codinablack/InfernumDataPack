local effectlist = {
	[{1}] = {[WEAPON_WAND] = CONST_ANI_ENERGY},
	[{2}] = {[WEAPON_WAND] = CONST_ANI_SMALLICE},
	[{3, 4}] = {[WEAPON_DISTANCE] = CONST_ANI_SMALLHOLY},
	[{5, 6}] = {[WEAPON_AXE] = CONST_ANI_WHIRLWINDAXE, [WEAPON_SWORD] = CONST_ANI_WHIRLWINDSWORD, [WEAPON_CLUB] = CONST_ANI_WHIRLWINDCLUB}
}

local milestones = {
	[15] = {},
	[25] = {},
	[35] = {},
	[50] = {},
	[80] = {},
	[100] = {}
}

function onAdvance(player, skill, oldLevel, newLevel)
	local eff = {
		{0, 2, 0},
		{1, -1, 3},
		{0, 4,  0}
	}
	local effects = player:getPosition():generateEffectPositions(eff, {})
	local weapon = player:getWeapon()
	local vocId = player:getVocation():getId()
	local v = nil
	for k, val in pairs(effectlist) do
		if table.contains(k, vocId) then
			v = val
			break
		end
	end
	local effect = CONST_ANI_SNOWBALL
	if v and weapon then
		effect = v[weapon:getType():getWeaponType()] or CONST_ANI_SNOWBALL
	end
	for i = 1, 3 do
		addEvent(executeEffects, i * 150, effect, effects, {continuous = true, fullLoop = true}, 50)
	end
	return true
end