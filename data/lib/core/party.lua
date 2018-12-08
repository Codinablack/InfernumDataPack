function Party.getRealMembers(self)
	local members = self:getMembers()
	members[#members + 1] = self:getLeader()
	return members
end

function Party.getVocationAmount(self, vocation)
	local n = 0
	for _, member in ipairs(self:getRealMembers()) do
		if member:getVocation():getId() == vocation then
			n = n + 1
		end
	end
	return n
end