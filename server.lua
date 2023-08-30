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
    TriggerClientEvent("chat:addMessage", -1, {
        templateId = 'ccChat',
        multiline = false,
        args = { '#0384FC', 'fa-solid fa-globe', 'AOP', '', 'AOP is now ' .. aop }
    })
    TriggerClientEvent('setAOP', -1, aop)
end)

lib.addCommand('pt', {
    help = 'toggles peacetime',
    restricted = 'group.staff'
}, function(source, args, raw)
    if not peacetime then
        peacetime = true
        TriggerClientEvent('togglePT', -1, peacetime)
        TriggerClientEvent("chat:addMessage", -1, {
            templateId = 'ccChat',
            multiline = false,
            args = { '#0384FC', 'fa-solid fa-globe', 'Peacetime', '', 'Peacetime is now enabled' }
        })
    elseif peacetime then
        peacetime = false
        TriggerClientEvent('togglePT', -1, peacetime)
        TriggerClientEvent("chat:addMessage", -1, {
            templateId = 'ccChat',
            multiline = false,
            args = { '#0384FC', 'fa-solid fa-globe', 'Peacetime', '', 'Peacetime is now disabled' }
        })
    end
end)
