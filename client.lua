local AOP = Config.AOP
local peacetime = Config.Peacetime

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

local function disableControls()
    DisablePlayerFiring(ped, true)     -- weapon firing
    DisableControlAction(0, 24, true)  -- attack
    DisableControlAction(0, 25, true)  -- aim
    DisableControlAction(0, 47, true)  -- weapon
    DisableControlAction(0, 58, true)  -- weapon
    DisableControlAction(1, 37, true)  -- change weapon
    DisableControlAction(0, 140, true) -- melee
    DisableControlAction(0, 141, true) -- melee
    DisableControlAction(0, 142, true) -- melee
    DisableControlAction(0, 143, true) -- melee
    DisableControlAction(0, 263, true) -- melee
    DisableControlAction(0, 264, true) -- melee
    DisableControlAction(0, 257, true) -- melee
end

RegisterNetEvent('setAOP', function(newAOP)
    AOP = newAOP
end)

RegisterNetEvent('togglePT', function(newPeacetime)
    peacetime = newPeacetime
end)

CreateThread(function()
    while true do
        sleep = 500
        local player = cache.ped
        local coords = GetEntityCoords(player)
        SendNUIMessage({
            action = "updateHud",
            direction = getDirection(GetEntityHeading(player)),
            street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)),
            postal = exports['nearest-postal']:getPostal(), -- replacing with internal logic
            aop = AOP,
            peacetime = peacetime
        })
        if peacetime then
            sleep = 1
            disableControls()
        end
        Wait(sleep)
    end
end)
