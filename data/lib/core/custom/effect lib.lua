TESTEFFECTS = {
	{0, 0, 0, 4, 0, 0, 0},
	{0, 0, 3, 0, 5, 0, 0},
	{0, 2, 0, 0, 0, 6, 0},
	{1, 0, 0, -1, 0, 0, 7},
	{0, 12, 0, 0, 0, 8, 0},
	{0, 0, 11, 0, 9, 0, 0},
	{0, 0, 0, 10, 0, 0, 0},
}

--[[ PARAMS
	runInReverse - swaps order of execution, highest -> lowest
	fullLoop - runs the spell + an extra iteration for the first effect
]]

function Position.generateEffectPositions(self, effects, params)
	params = params or {}
	local center = {row = nil, column = nil}
	local ids = {}
	for row = 1, #effects do
		local v = effects[row]
		for column = 1, #v do
			local id = v[column]
			if id == -1 then
				center.row = row
				center.column = column
			elseif id > 0 then
				ids[#ids + 1] = {id = id, row = row, column = column}
			end
		end
	end
	table.sort(ids, function(a, b)
		if params.runInReverse then
			return a.id > b.id
		else
			return a.id < b.id
		end
	end)
	if center.row and center.column then
		for i = 1, #ids do
			local offset = Position(0, 0, 0)
			local v = ids[i]
			offset.y = -(center.row - v.row)
			offset.x = -(center.column - v.column)
			ids[i].position = self + offset
		end
	end
	return {
		center = self,
		positions = ids
	}
end

--[[ PARAMS
	swapPositions - swaps center & destination positions
]]

function executeChunks(effect, effects, params, delay)
	params = params or {}
	delay = delay or 0
	local chunks = {}
	if params.fullLoop then
		for i = 1, #effects.positions do
			if effects.positions[i].id == 1 then
				effects.positions[#effects.positions + 1] = effects.positions[i]
			end
		end
	end
	for i = 1, #effects.positions do
		local v = effects.positions[i]
		if not chunks[v.id] then
			chunks[v.id] = {}
		end
		chunks[v.id][#chunks[v.id] + 1] = v.position
	end
	local function runEffectList(list)
		local center = effects.center
		for i = 1, #list do
			local position = list[i]
			if params.continuous then
				center = list[i-1] or list[i]
			end
			if params.swapPositions then
				position = effects.center
				center = list[i]
			end
			center:sendDistanceEffect(position, effect)
		end
	end
	for i = 1, #chunks do
		local list = chunks[i]
		addEvent(runEffectList, delay * (i-1), list)
	end
end

function executeEffects(effect, effects, params, delay)
	params = params or {}
	delay = delay or 0
	if params.fullLoop then
		effects.positions[#effects.positions + 1] = effects.positions[1]
	end
	for i = 1, #effects.positions do
		local center = effects.center
		local position = effects.positions[i].position
		if params.continuous then
			local prev = effects.positions[i-1]
			center = prev and prev.position or position
		end
		if delay > 0 then
			addEvent(Position.sendDistanceEffect, delay * i, center, position, effect)
		else
			center:sendDistanceEffect(position, effect)
		end
	end
end