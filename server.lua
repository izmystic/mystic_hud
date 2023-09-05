local peacetime = Config.Peacetime

lib.addCommand('aop', {
    help = 'sets aop',
    params = {
        {
            name = 'location',
            help = 'location for aop'
        }
    },
    restricted = 'group.staff'
}, function(source, args, raw)
    aop = raw:sub(4)
    TriggerClientEvent('setAOP', -1, aop)
    TriggerClientEvent('ox_lib:notify', -1, { description = ('AOP has been set to %s'):format(aop), type = 'inform' })
end)

lib.addCommand('pt', {
    help = 'toggles peacetime',
    restricted = 'group.staff'
}, function(source, args, raw)
    if not peacetime then
        peacetime = true
        TriggerClientEvent('togglePT', -1, peacetime)
        TriggerClientEvent('ox_lib:notify', -1, { description = 'Peacetime is now enabled', type = 'success' })
    elseif peacetime then
        peacetime = false
        TriggerClientEvent('togglePT', -1, peacetime)
        TriggerClientEvent('ox_lib:notify', -1, { description = 'Peacetime is now disabled', type = 'error' })
    end
end)
