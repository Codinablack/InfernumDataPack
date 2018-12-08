function onSay(player, words, param)
	local s = param:split(",")
	local position = player:getPosition()
	local monster = Game.createMonster(s[1], position, false, false, s[2])
	if monster then
		monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end
