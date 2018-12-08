local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local base_cost = 500
local storage_value = 88267
local function getNextCost(player)
	local count = player:getStorageValue(storage_value)
	local cost = base_cost
	while count > 0 do
		cost = cost * 2
		count = count - 1
	end
	return cost
end

local function increasePoint(player, id)
	local count = player:getStorageValue(storage_value)
	player:setStorageValue(storage_value, count > 0 and count + 1 or 1)
end

local messages = {"magic damage", "magic resistance", "total mana"}
local enums = {BONUS_MAGICDAMAGE, BONUS_MAGICRESISTANCE, BONUS_TOTALMANA}

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local talkstate = npcHandler.topic[cid] or 0

	if msgcontains(msg, "powers") then
		selfSay("I can currently offer you an increase in {magic damage}, {magic resistance}, and {total mana}. What would you be interested in?", cid)
	else
		for i = 1, #messages do
			if msgcontains(msg, messages[i]) then
				selfSay("I can upgrade your ".. messages[i] .." for a fee of ".. getNextCost(player) .." gold coins. Do you accept?", cid)
				npcHandler.topic[cid] = i
				break
			end
		end
	end

	if talkstate > 0 then
		if msgcontains(msg, "yes") then
			if player:removeMoney(getNextCost(player)) then
				selfSay("Enjoy your invigorated ".. messages[talkstate] ..". Let me know if I may be of service again.", cid)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				increasePoint(player)
				player:setBonus(enums[talkstate], player:getBonus(enums[talkstate]) + 1)
				player:addMana(player:getMaxMana())
			else
				selfSay("Come back when you have more gold.", cid)
			end
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		elseif msgcontains(msg, "no") then
			selfSay("Another time then.", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
