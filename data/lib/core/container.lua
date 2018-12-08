function Container.isContainer(self)
	return true
end

function Container.getItems(self)
	local items = {}
	for i = 0, self:getSize() - 1 do
		items[#items + 1] = self:getItem(i)
	end
	return items
end

function Container.getItemById(self, id)
	for i = self:getSize() - 1, 0, -1 do
		local item = self:getItem(i)
		if item:getId() == id then
			return item
		end
	end
end