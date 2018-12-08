function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    local lookType = tonumber(param)
    local playerOutfit = player:getOutfit()
    playerOutfit.lookType = lookType
    player:setOutfit(playerOutfit)
    return false
end
