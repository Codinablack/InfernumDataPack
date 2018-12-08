local items = {
	-- All vocations
	[{1, 2, 3, 4, 5, 6}] = {
		{id = 2457, slot = CONST_SLOT_HEAD},
		{id = 2463, slot = CONST_SLOT_ARMOR},
		{id = 2647, slot = CONST_SLOT_LEGS},
		{id = 2643, slot = CONST_SLOT_FEET},
		{id = 2216, slot = CONST_SLOT_RING},
		{id = 1988, slot = CONST_SLOT_BACKPACK, inside = {
			-- Berserker, Guardian
			[{5, 6}] = {22398, 2441, 2417}
		}}
	},
	-- Pyromancer, Priest
	[{1, 2}] = {
		{id = 2175, slot = CONST_SLOT_RIGHT}
	},
	-- Pyromancer
	[{1}] = {
		{id = 2190, slot = CONST_SLOT_LEFT}
	},
	-- Priest
	[{2}] = {
		{id = 2186, slot = CONST_SLOT_LEFT}
	},
	-- Lightbringer
	[{3}] = {
		{id = 2456, slot = CONST_SLOT_LEFT}
	},
	-- Sharpshooter
	[{4}] = {
		{id = 2455, slot = CONST_SLOT_LEFT}
	},
	-- Berserker, Guardian
	[{5, 6}] = {
		{id = 2515, slot = CONST_SLOT_RIGHT}
	}
}

function onLogin(player)
	if player:getLastLoginSaved() > 0 then
		return true
	end
	local vid = player:getVocation():getId()
	for vocList, itemList in pairs(items) do
		if table.contains(vocList, vid) then
			for _, v in ipairs(itemList) do
				local item = player:addItem(v.id, 1, true, 1, v.slot)
				if v.inside then
					for cVocList, cItemList in pairs(v.inside) do
						if table.contains(cVocList, vid) then
							for _, id in ipairs(cItemList) do
								item:addItem(id)
							end
						end
					end
				end
			end
		end
	end
	return true
end