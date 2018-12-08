function onSay(player, words, param)
	enqueue("echo", param)
	return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Enqueued 'echo': ".. param) and false
end