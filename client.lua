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

AddEventHandler('onClientMapStart', function()
    TriggerServerEvent('mystic_hud:server:setAOP')
    TriggerServerEvent('mystic_hud:server:togglePT')
end)

RegisterNetEvent('mystic_hud:client:sendAOP', function(newAOP)
    Config.AOP = newAOP
end)

RegisterNetEvent('mystic_hud:server:togglePT', function(newPeacetime)
    Config.Peacetime = newPeacetime
end)

CreateThread(function()
    local defaultAspectRatio = 1920 / 1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapXOffset, minimapYOffset = 0, 0
    if aspectRatio > defaultAspectRatio then
        local aspectDifference = defaultAspectRatio - aspectRatio
        minimapXOffset = aspectDifference / 3.6
    end

    SetMinimapComponentPosition("minimap", "L", "B", -0.0045 + minimapXOffset, 0.002 + minimapYOffset, 0.150, 0.188888)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.020 + minimapXOffset, 0.030 + minimapYOffset, 0.111, 0.159)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.03 + minimapXOffset, 0.022 + minimapYOffset, 0.266, 0.237)
    while true do
        sleep = 500
        local player = cache.ped
        local coords = GetEntityCoords(player)
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
        local show = true
        if IsPauseMenuActive() then
            show = false
        end
        SendNUIMessage({
            action = "updateHud",
            show = show,
            direction = getDirection(GetEntityHeading(player)),
            street = street,
            postal = exports['nearest-postal']:getPostal(), -- replacing with internal logic
            aop = Config.AOP,
            peacetime = Config.Peacetime,
            primaryColor = Config.primaryColor,
            secondaryColor = Config.secondaryColor
        })
        if Config.Peacetime then
            sleep = 1
            disableControls()
        end
        Wait(sleep)
    end
end)
