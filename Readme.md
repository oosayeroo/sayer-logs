# Sayer Logs System

A flexible and visually rich logging system for FiveM servers. Supports embedded Discord messages with tagging, role mentions, custom avatars, and queued batching for performance.

Below are example usages of how to create logs using this system.

# example event using all features
```lua
TriggerEvent('sayer-logs:CreateLog', 'admin_action', { -- 'admin_action' refers to a webhook key defined in your Config.Webhooks table
    -- Core Visual Info
    title = "🚨 Admin Action: Ban Issued",
    message = "**Admin** `Suzanne` has permanently banned player `JohnDoe` for exploiting bugs.",
    colour = "purple",

    -- Embed Fields
    fields = {
        { name = "Admin", value = "Suzanne", inline = true },
        { name = "Player", value = "JohnDoe", inline = true },
        { name = "Reason", value = "Exploiting a duplication bug.", inline = false },
        { name = "Duration", value = "Permanent", inline = true },
        { name = "Date", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true },
    },

    -- Tagging
    tagEveryone = true,
    tagRoles = { "staff", "mod" },

    -- Embed Author
    authorName = "Outback Admin Logs",
    authorIcon = "https://i.imgur.com/Rx0zjWA.png",

    -- Media
    imageUrl = "https://i.imgur.com/yW2W9SC.png", -- Example punishment graphic
    thumbnailUrl = "https://i.imgur.com/oZpuhsN.png", -- Admin icon or alert symbol

    -- External link (optional)
    url = "https://admin.outbackzombies.com/player/JohnDoe",

    -- Footer
    footerText = "Outback | Admin Monitoring System",
    footerIcon = "https://i.imgur.com/BwP6DyN.png",

    -- Webhook display info
    username = "PunishBot",
    avatarUrl = "https://i.imgur.com/EO89v9B.png"
})

```




# example event using only required fields
```lua
TriggerEvent('sayer-logs:CreateLog', 'default', {
    title = "Player Joined", -- The title of the log
    message = "**Player** `JohnDoe` has joined the server.", -- The message content
    colour = "green", -- The colour of the embed
})
```




# example export using all features
```lua
-- From any script that has access to this export
local logData = {
    -- Core Visual Info
    title = "🚨 Admin Action: Ban Issued",
    message = "**Admin** `Suzanne` has permanently banned player `JohnDoe` for exploiting bugs.",
    colour = "purple",

    -- Embed Fields
    fields = {
        { name = "Admin", value = "Suzanne", inline = true },
        { name = "Player", value = "JohnDoe", inline = true },
        { name = "Reason", value = "Exploiting a duplication bug.", inline = false },
        { name = "Duration", value = "Permanent", inline = true },
        { name = "Date", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true },
    },

    -- Tagging
    tagEveryone = true,
    tagRoles = { "staff", "mod" },

    -- Embed Author
    authorName = "Outback Admin Logs",
    authorIcon = "https://i.imgur.com/Rx0zjWA.png",

    -- Media
    imageUrl = "https://i.imgur.com/yW2W9SC.png", -- Example punishment graphic
    thumbnailUrl = "https://i.imgur.com/oZpuhsN.png", -- Admin icon or alert symbol

    -- External link (optional)
    url = "https://admin.outbackzombies.com/player/JohnDoe",

    -- Footer
    footerText = "Outback | Admin Monitoring System",
    footerIcon = "https://i.imgur.com/BwP6DyN.png",

    -- Webhook display info
    username = "PunishBot",
    avatarUrl = "https://i.imgur.com/EO89v9B.png"
}

-- Trigger the event using the export
exports['sayer-logs']:CreateLog('death', logData)
```



# example export with slight integration (ONLY EXAMPLE)
```lua
-- In your kill tracking script
local victim = "JohnDoe"
local killer = "JaneDoe"
local weapon = "Sniper Rifle"

-- Prepare data for the log
local logData = {
    title = "Player Killed",
    message = "**Player** `" .. victim .. "` was killed by `" .. killer .. "` using a `" .. weapon .. "`.",
    colour = "red",
    fields = {
        { name = "Killer", value = killer, inline = true },
        { name = "Weapon", value = weapon, inline = true },
    },
    tagEveryone = false,
    username = "Killbot",
    avatarUrl = "https://i.imgur.com/F7do6Tt.png"
}

-- Call the CreateLog export to trigger logging
exports['sayer-logs']:CreateLog('death', logData)
```