syncTable = {}
count = 0

AddEventHandler('playerDropped', function(reason)
    if Config.DisplayId and not Config.DisplayName then
        playerInfo = 'Player: ~w~'..source
    elseif not Config.DisplayId and Config.DisplayName then
        playerInfo = 'Player: ~w~'..GetPlayerName(source)
    else
        playerInfo = 'Player: ~w~'..source..' | '..GetPlayerName(source)
    end
    
    local args = {
        ['coords'] = GetEntityCoords(GetPlayerPed(source)),
        ['text'] = Config.color..''..playerInfo..'\n'..Config.color..'Reason: ~w~'..reason..'\n'..Config.color..'Time ago: ~w~ %s'
    }
    count = count + 1
    syncTable[count] = args,
    Wait(1)
    TriggerClientEvent('DisconnectSync', -1, syncTable)
    Wait(Config.delay * 1000)
    syncTable[count] = nil
    TriggerClientEvent('DisconnectSync', -1, syncTable)
end)

AddEventHandler("playerJoining", function(source, oldID)
    TriggerClientEvent('DisconnectSync', -1, syncTable)
end)