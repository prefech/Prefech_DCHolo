syncTable = {}
countTable = {}
RegisterNetEvent('DisconnectSync')
AddEventHandler('DisconnectSync', function(_syncTable)
    syncTable = _syncTable
end)

CreateThread(function()
    while true do
        Wait(1000)
        for k,v in pairs(syncTable) do
            if countTable[k] then
                countTable[k] = countTable[k] + 1
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        isClose = false
        for k,v in pairs(syncTable) do
            if not countTable[k] then countTable[k] = 0 end            
            if GetDistanceBetweenCoords( v.coords.x, v.coords.y, v.coords.z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then                                
                isClose = true
                Draw3DText( v.coords.x, v.coords.y, v.coords.z - 1.400, v.text:format(string.format("%02d:%02d",math.floor(countTable[k] / 60), math.floor(countTable[k] % 60))), 4, 0.075, 0.075)
                if Config.marker then             
                    DrawMarker(0, v.coords.x, v.coords.y, v.coords.z - 0.250, 0, 0, 0, 0, 0, 0, 0.5 ,0.5 ,0.5 ,Config.markerColor.r ,Config.markerColor.g ,Config.markerColor.b ,Config.markerColor.a ,true ,false ,false ,false )
                end
            end
        end
        if not isClose then Wait(1000) end
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end