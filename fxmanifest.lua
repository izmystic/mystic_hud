fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}
client_script 'client.lua'
server_script 'server.lua'

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/fonts/*.woff2',
    'html/fonts/*.woff',
    'html/fonts/*.ttf',
}
