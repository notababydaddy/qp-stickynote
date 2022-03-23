-- FX Information --
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

-- Resource Information --
name         'qpstickynote'
author       'qpr'
version      '1.0.1'
repository   'https://github.com/ohqpr/qpstickynote'
description  'Sticky notepad'

-- Manifest --
dependencies {
  'es_extended',
  'ox_inventory'
}

ui_page       'html/index.html'
shared_script '@es_extended/imports.lua'
client_script 'client.lua'
server_script 'server.lua

files {
 'html/**'
}
