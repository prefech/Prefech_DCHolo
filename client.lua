syncTable = {}
count = 0
RegisterNetEvent('DisconnectSync')
AddEventHandler('DisconnectSync', function(_syncTable)
    syncTable = _syncTable
end)

CreateThread(function()
    while true do
        Wait(0)
        local sleep = true
        for k,v in pairs(syncTable) do
            if GetDistanceBetweenCoords( v.coords.x, v.coords.y, v.coords.z, GetEntityCoords(PlayerPedId())) < 10.0 then
                sleep = false
                Draw3DText( v.coords.x, v.coords.y, v.coords.z - 1.400, v.line1, 4, 0.075, 0.075)
                Draw3DText( v.coords.x, v.coords.y, v.coords.z - 1.600, v.line2, 4, 0.075, 0.075)
                Draw3DText( v.coords.x, v.coords.y, v.coords.z - 1.800, v.line3, 4, 0.075, 0.075)		
            end
        end
        if sleep then Wait(1000) end
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
    SetTextColour(250, 250, 250, 255)		-- You can change the text color here
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
