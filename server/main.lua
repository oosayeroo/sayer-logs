local QBCore = exports['qb-core']:GetCoreObject()

local logQueue = {}

function table_contains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

local function PostLogQueue(hook_id)
    if not Config.UseLogQueue then return end
    local queue = logQueue[hook_id]
    if not queue or #queue == 0 then return end

    local firstEntry = queue[1]
    local postData = {
        username = firstEntry.username or Config.ServerName,
        avatar_url = firstEntry.avatar_url,
        embeds = {},
        content = '',
        allowed_mentions = {
            parse = {},
            roles = {},
            users = {}
        }
    }

    for i = 1, #queue do
        table.insert(postData.embeds, queue[i].data[1])

        if queue[i].tag then
            postData.content = postData.content .. queue[i].tag .. ' '
        end

        -- Collect unique roles for allowed_mentions
        if queue[i].allowed_mentions and queue[i].allowed_mentions.roles then
            for _, roleId in ipairs(queue[i].allowed_mentions.roles) do
                if not table_contains(postData.allowed_mentions.roles, roleId) then
                    table.insert(postData.allowed_mentions.roles, roleId)
                end
            end
        end

        if queue[i].allowed_mentions and queue[i].allowed_mentions.parse then
            for _, parseType in ipairs(queue[i].allowed_mentions.parse) do
                if not table_contains(postData.allowed_mentions.parse, parseType) then
                    table.insert(postData.allowed_mentions.parse, parseType)
                end
            end
        end
    end

    postData.content = postData.content ~= '' and postData.content or nil

    PerformHttpRequest(queue[1].webhook, function() end, 'POST', json.encode(postData), {
        ['Content-Type'] = 'application/json'
    })

    logQueue[hook_id] = {}
end

function CreateLog(hook_id, data)
    TriggerEvent('sayer-logs:CreateLog', hook_id, data)
end
exports('CreateLog', CreateLog)

RegisterNetEvent('sayer-logs:CreateLog', function(hook_id, data)
    local colour = type(data.colour) == "number" and data.colour or Config.Colours[data.colour] or Config.Colours['default']
    local title = data.title or Config.DefaultTitle
    local message = data.message or 'No message provided.'
    local tagEveryone = data.tagEveryone or false
    local tagRoles = data.tagRoles or {}
    local imageUrl = data.imageUrl and data.imageUrl ~= '' and { ['url'] = data.imageUrl } or nil
    local authorName = data.authorName or Config.DefaultAuthorName
    local authorIcon = data.authorIcon or Config.DefaultAuthorIconUrl
    local fields = data.fields or nil
    local url = data.url or nil
    local thumbnailUrl = data.thumbnailUrl and { ['url'] = data.thumbnailUrl } or nil
    local footerText = data.footerText or os.date('%c')
    local footerIcon = data.footerIcon or nil
    local username = data.username or Config.ServerName
    local avatar_url = data.avatarUrl or nil

    if not Config.Webhooks[hook_id] then
        DebugCode('Invalid webhook_id: [' .. hook_id .. ']')
        return
    end
    local webhook_url = Config.Webhooks[hook_id] ~= '' and Config.Webhooks[hook_id] or Config.Webhooks['default']

    -- 🏷️ Build tag mentions
    local mentionContent = ''
    local allowedRoles = {}

    if tagEveryone then
        mentionContent = '@everyone'
    end

    for _, roleKey in ipairs(tagRoles) do
        local roleId = Config.TaggableRoles[roleKey]
        if roleId then
            mentionContent = mentionContent .. '<@&' .. roleId .. '> '
            table.insert(allowedRoles, roleId)
        else
            DebugCode('Invalid tagRole: ' .. tostring(roleKey))
        end
    end

    local allowed_mentions = {
        parse = {},
        roles = allowedRoles,
        users = {}
    }

    if tagEveryone then
        table.insert(allowed_mentions.parse, "everyone")
    end

    local embedData = {
        {
            ['title'] = title,
            ['color'] = colour,
            ['description'] = message,
            ['fields'] = fields,
            ['url'] = url,
            ['thumbnail'] = thumbnailUrl,
            ['image'] = imageUrl,
            ['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            ['author'] = {
                ['name'] = authorName,
                ['icon_url'] = authorIcon,
            },
            ['footer'] = {
                ['text'] = footerText,
                ['icon_url'] = footerIcon,
            },
        }
    }

    if Config.UseLogQueue then
        if not logQueue[hook_id] then logQueue[hook_id] = {} end

        table.insert(logQueue[hook_id], {
            webhook = webhook_url,
            data = embedData,
            tag = mentionContent,
            username = username,
            avatar_url = avatar_url,
            allowed_mentions = allowed_mentions
        })

        if #logQueue[hook_id] >= Config.LogQueueLimit then
            PostLogQueue(hook_id)
        end
    else
        local postData = {
            username = username,
            avatar_url = avatar_url,
            embeds = embedData,
            content = mentionContent ~= '' and mentionContent or nil,
            allowed_mentions = allowed_mentions
        }

        PerformHttpRequest(webhook_url, function() end, 'POST', json.encode(postData), {
            ['Content-Type'] = 'application/json'
        })
    end
end)

if Config.UseLogQueue then
    CreateThread(function()
        local timer = 0
        while true do
            Wait(1000)
            timer = timer + 1

            if timer >= Config.FlushInterval then
                timer = 0
                for hookId in pairs(logQueue) do
                    PostLogQueue(hookId)
                end
            end
        end
    end)
end

QBCore.Commands.Add('hook_test', 'Send a test webhook', {}, false, function()
    TriggerEvent('sayer-logs:CreateLog', 'default', {
        title = "Test taggin roles",
        message = "Staff and Mods, please check this out!",
        colour = "red",
        tagRoles = { "staff", "mod" }
    })
end, 'god')



function DebugCode(msg)
    if Config.DebugCode then
        print(msg)
    end
end