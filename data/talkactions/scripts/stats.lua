-- <talkaction words="!stats" script="stats.lua"/>
local function tab(n)
	return ("    "):rep(n)
end

local healthCondition = Condition(CONDITION_ATTRIBUTES)
healthCondition:setTicks(-1)
healthCondition:setParameter(CONDITION_PARAM_SUBID, 1)

_G["STATSYSTEM"] = {
	["vitality"] = {
		stat = 5,
		max_points = 15,
		storage = Storage.StatVitalityStorage,
		choiceMsg = "Vitality: [%d / %d]",
		infoMsg = tab(9) .."+5%% bonus regen per point\nYou have a total bonus %s%% bonus regen with [%d / %d] vitality.",
		successMsg = "You now have a total bonus of %s%% bonus regen with [%d / %d] vitality.",
	},
	["test"] = {
		stat = 5,
		max_points = 15,
		storage = Storage.StatTestStorage,
		choiceMsg = "Test: [%d / %d]",
		infoMsg = tab(9) .."+5 bonus regen per point\nYou have a total bonus %s bonus regen with [%d / %d] test.",
		successMsg = "You now have a total bonus of %s bonus regen with [%d / %d] test.",
	},
}

local choices = {
	[1] = STATSYSTEM.vitality,
	[2] = STATSYSTEM.test
}

function Player.addStatPoints(self, points)
	local cur = self:getStorageValue(Storage.StatSpendStorage)
	self:setStorageValue(Storage.StatSpendStorage, cur == -1 and points or cur + points)
end

function Player.getStatValue(self, stat)
	stat = stat:lower()
	local s = self:getStorageValue(STATSYSTEM[stat].storage)
	if s == -1 then
		return 0
	end
	local v = STATSYSTEM[stat]
	return s * (type(v.stat) == "table" and v.stat[self:getVocation():getId()] or v.stat)
end

local function createWindow(player)
	local points = player:getStorageValue(Storage.StatSpendStorage)
	points = points == -1 and 0 or points
	local window = ModalWindow {title = "Stats", message = "Points available: [".. points .."]"}
	window:addButton("Info", 
		function(button, choice)
			choice = choices[choice.id]
			local total = player:getStorageValue(choice.storage)
			local vocId = player:getVocation():getId()
			local infoMsg = type(choice.infoMsg) == "table" and choice.infoMsg[vocId] or choice.infoMsg
			local bonus = total * (type(choice.stat) == "table" and choice.stat[vocId] or choice.stat)
			total = total == -1 and 0 or total
			bonus = bonus < 0 and 0 or bonus
			player:popupFYI(string.format(infoMsg, bonus, total, choice.max_points))
			window:sendToPlayer(player)
		end
	)
	window:addButton("Spend", 
		function(button, choice)
			if points == 0 then
				return player:popupFYI("Insufficient points to spend.")
			end
			choice = choices[choice.id]
			local total = player:getStorageValue(choice.storage)
			local newValue = total == -1 and 1 or total + 1
			if total >= choice.max_points then
				return player:popupFYI("You already have the maximum amount of points for this stat.")
			end
			player:setStorageValue(Storage.StatSpendStorage, points - 1)
			player:setStorageValue(choice.storage, newValue)
			local vocId = player:getVocation():getId()
			local successMsg = type(choice.successMsg) == "table" and choice.successMsg[vocId] or choice.successMsg
			local bonus = newValue * (type(choice.stat) == "table" and choice.stat[vocId] or choice.stat)
			bonus = bonus < 0 and 0 or bonus
			player:popupFYI(string.format(successMsg, bonus, newValue, choice.max_points))
			for i = 1, #choices do
				local v = choices[i]
				local total = player:getStorageValue(v.storage)
				total = total == -1 and 0 or total
				window:addChoice(string.format(v.choiceMsg, total, v.max_points))
			end
			if choice.func then
				choice.func(player, newValue)
			end
			local window = createWindow(player)
			window:sendToPlayer(player)
		end
	)
	window:setDefaultEnterButton("Spend")
	window:addButton("Cancel", 
		function(button, choice)
			
		end
	)
	window:setDefaultEscapeButton("Cancel")
	for i = 1, #choices do
		local v = choices[i]
		local total = player:getStorageValue(v.storage)
		total = total == -1 and 0 or total
		window:addChoice(string.format(v.choiceMsg, total, v.max_points))
	end
	return window
end

function onSay(player, words, param)
	local window = createWindow(player)
	window:sendToPlayer(player)
	return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, words) and false
end