function Player.hasHealingBot(self)
	return self:getStorageValue(Storage.HealingBot) == 1
end

function onSay(player, words, param)
	local enabled = player:getStorageValue(Storage.HealingBot) == 1
	if enabled then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Healing bot is now turned off.")
		player:setStorageValue(Storage.HealingBot, -1)
		return true
	end
	player:setStorageValue(Storage.HealingBot, 1)
	player:startupHealbot()
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Healing bot is now turned on.")
	return true
end