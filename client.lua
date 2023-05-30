local function getDirection(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        return 'N'
    elseif (heading >= 45 and heading < 135) then
        return 'W'
    elseif (heading >= 135 and heading < 225) then
        return 'S'
    elseif (heading >= 225 and heading < 315) then
        return 'E'
    end
end

CreateThread(function()
    while true do
        Wait(500)
        local player = cache.ped
        local coords = GetEntityCoords(player)
        SendNUIMessage({
            action = "updateHud",
            direction = getDirection(GetEntityHeading(player)),
            street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)),
            postal = exports['nearest-postal']:getPostal(),
            aop = 'Blaine County',
            peacetime = 'Disabled'
        })
    end
end)
