lib.addCommand('aop', {
    help = 'sets aop',
    params = {
        {
            name = 'location',
            help = 'location for aop'
        }
    },
    restricted = true
}, function(source, args, raw)
    Config.AOP = raw:sub(4)
    TriggerEvent('mystic_hud:server:setAOP')
    TriggerClientEvent('ox_lib:notify', -1, { description = ('AOP has been set to %s'):format(Config.AOP), type = 'inform' })
end)

lib.addCommand('pt', {
    help = 'toggles peacetime',
    restricted = true
}, function(source, args, raw)
    if not Config.Peacetime then
        Config.Peacetime = true
        TriggerEvent('mystic_hud:server:togglePT')
        TriggerClientEvent('ox_lib:notify', -1, { description = 'Peacetime is now enabled', type = 'success' })
    elseif Config.Peacetime then
        Config.Peacetime = false
        TriggerEvent('mystic_hud:server:togglePT')
        TriggerClientEvent('ox_lib:notify', -1, { description = 'Peacetime is now disabled', type = 'error' })
    end
end)


RegisterServerEvent('mystic_hud:server:setAOP', function()
    TriggerClientEvent('mystic_hud:client:sendAOP', -1, Config.AOP)
end)

RegisterServerEvent('mystic_hud:server:togglePT', function()
    TriggerClientEvent('mystic_hud:client:sendPT', -1, Config.Peacetime)
end)