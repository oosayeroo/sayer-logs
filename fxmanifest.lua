fx_version 'cerulean'
game 'gta5'
author 'oosayeroo'
description 'sayer-logs'
version '1.0.0'
lua54 'yes'

shared_scripts{
    '@ox_lib/init.lua',
}

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}
