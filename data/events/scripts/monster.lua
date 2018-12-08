function Monster:onSpawn(position, startup, artificial)
	self:registerEvent("orb death")
	return true
end