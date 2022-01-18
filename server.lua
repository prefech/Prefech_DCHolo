syncTable = {}
countTable = {}
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
    syncTable[count] = args
    Wait(1)
    TriggerClientEvent('DisconnectSync', -1, syncTable)
end)

CreateThread(function()
    while true do
        Wait(1000)
        for k,v in pairs(syncTable) do
            if countTable[k] then
                if countTable[k] >= Config.delay then
                    countTable[k] = nil
                    syncTable[k] = nil
                else
                    countTable[k] = countTable[k] + 1
                end
            else
                countTable[k] = 0
            end
        end
    end
end)