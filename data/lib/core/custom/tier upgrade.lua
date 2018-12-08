local tiers = {
	-- Helmets
	{2457, 2490, 11302, 2491, 2506, 2471, 2493, 9778, 25410, 18403, 15408},
	-- Armors
	{2463, 2476, 11301, 2487, 2492, 2466, 2494, 9776, 15406, 18404, 15407},
	-- Legs
	{2647, 2477, 11304, 2488, 2469, 2470, 2495, 9777, 15412, 18405, 15409},
	-- Boots
	{2643, 5462, 11303, 2195, 3982, 2646, 9932, 26133, 11240, 18406, 15410},
	-- Swords
	{22398, 7383, 11307, 7390, 7405, 7391, 8931, 22403, 6528, 18450, 12649},
	-- Axes
	{2441, 2430, 2415, 7456, 2454, 7389, 8925, 22409, 8924, 18451, 15404},
	-- Clubs
	{2417, 2422, 2434, 7423, 7422, 7437, 2421, 15647, 7427, 7428, 22415},
	-- Bows
	{2456, 8855, 8856, 7438, 8857, 22418, 8854, 15643, 18454, 21696, 25522},
	-- Crossbows
	{2455, 8849, 8852, 22419, 21690, 8851, 8853, 15644, 16111, 18453, 25523},
	-- Wands
	{2190, 8922, 2191, 2187, 7958, 8921, 18409, 13760, 18390, 25422, 13880},
	-- Rods
	{2186, 7424, 7451, 2184, 8912, 7410, 7429, 12648, 18412, 7409, 13872},
	-- Spellbooks
	{2175, 8904, 8903, 8901, 18401, 8900, 8902, 8918, 16112, 22422, 22424},
	-- Shields
	{2515, 2529, 6433, 2519, 2522, 2517, 2520, 2523, 15413, 18410, 25546},
	-- Rings
	{2216, 2206, 2203, 2210, 2205, 2179, 7697, 13825, 6301, 18528, 21693},
}

function Item.getTier(self)
	for _, idList in pairs(tiers) do
		for k, v in pairs(idList) do
			if v == self:getId() then
				return k
			end
		end
	end
end

function Player.giveTier(self, tier)
	local bp = self:addItem(1988)
	for _, v in ipairs(tiers) do
		bp:addItem(v[math.min(11,tier)], 1)
	end
end

g_tiers = {}
for _, category in pairs(tiers) do
	for _, id in pairs(category) do
		g_tiers[id] = true
	end
end

function Item.isUpgradable(self)
	return g_tiers[self:getId()] or false
end

function Player.attemptUpgrade(self, item)
	local id = item:getId()
	for _, category in pairs(tiers) do
		local index = table.indexOf(category, id)
		if index then
			if index == #category then
				self:sendTextMessage(MESSAGE_STATUS_SMALL, "This item cannot be upgraded any further.")
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false 
			elseif self:getItemCount(id) >= 3 then
				self:removeItem(id, 3)
				self:addItem(category[index + 1], 1)
				self:sendTextMessage(MESSAGE_STATUS_SMALL, "You have successfully upgraded this item.")
				self:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				return true
			end
		end
	end
	self:sendTextMessage(MESSAGE_STATUS_SMALL, "You do not have the required items to upgrade this item.")
	return false
end