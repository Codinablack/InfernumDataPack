function onSay(player, words, param)
	local params = param:split(",")
	enqueue(params[1], params[2]:trim())
	return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Enqueued: ".. words .. " ".. param) and false
end