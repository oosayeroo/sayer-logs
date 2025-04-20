Config = {}

Config.DebugCode = false

Config.ServerName = "Your Server Name"

--these are fallbacks incase you forget(or dont need to) fill these fields in
Config.DefaultTitle = "Sayer Logging" --just a fallback incase you forget to add a title to the webhook event
Config.DefaultAuthorName = "Sayer Logs"
Config.DefaultAuthorIconUrl = 'https://cdn.discordapp.com/attachments/1061012675112476672/1310542947581825074/OOSAYEROO_SCRIPTS.png?ex=680614bb&is=6804c33b&hm=8e7780e78b1d028a60bed50a7c126b8a4718afbcf81abb69377611ef7a18d5a7&'

Config.UseLogQueue = false --waits until there is a certain amount in the queue before posting them / if false posts them straight away
Config.LogQueueLimit = 5 --if using log queue then waits until this many logs are queued before posting them
Config.FlushInterval = 60 --if using log queue every 60 seconds it flushes the log queue. (helps with performance on both server and discord)

Config.TaggableRoles = { --can add the field tagRoles into the data to tag specific roles
    ['staff'] = '1363510624855916644',
    ['mod'] = '1363510691461337248',
}

Config.Webhooks = { --can have as many webhooks as you like (place your links)
    ['default'] = 'changeme', --do not remove default field. it is used as a fallback incase you misspell a hook_id
    ['loot'] = '',
    ['death'] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    [''] = '',
    
}

Config.Colours = {
    ['default'] = 16744192,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}