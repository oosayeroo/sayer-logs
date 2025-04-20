Config = {}

Config.DebugCode = false

Config.ServerName = "Outback Zombies"

--these are fallbacks incase you forget(or dont need to) fill these fields in
Config.DefaultTitle = "Webhook" --just a fallback incase you forget to add a title to the webhook event
Config.DefaultAuthorName = "Outback Zombies"
Config.DefaultAuthorIconUrl = 'https://cdn.discordapp.com/attachments/1194864528186421330/1196330413648531496/outbackk.png?ex=6805dc85&is=68048b05&hm=e4b792342bc32071804da5d4f9f518a58b4a70fa69ed85b73f8cd04662eb5d19&'

Config.UseLogQueue = false --waits until there is a certain amount in the queue before posting them / if false posts them straight away
Config.LogQueueLimit = 5 --if using log queue then waits until this many logs are queued before posting them
Config.FlushInterval = 60 --if using log queue every 60 seconds it flushes the log queue. (helps with performance on both server and discord)

Config.TaggableRoles = { --can add the field tagRoles into the data to tag specific roles
    ['staff'] = '1363510624855916644',
    ['mod'] = '1363510691461337248',
}

Config.Webhooks = { --can have as many webhooks as you like
    ['default'] = 'https://discord.com/api/webhooks/1070875071113080862/oXKGTB1WlxI_QVTPkuIfjUQuaOSWkQkH6vwb7I6gT4vMhZV32c8ItDeJYFSkgvsLsRXy', --do not remove default field. it is used as a fallback incase you misspell a hook_id
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