-- Get player helper
local function GetPlayer(src)
    local Framework = exports['rpa-lib']:GetFramework()
    if Framework then
        return Framework.Functions.GetPlayer(src)
    end
    return nil
end

-- Check if player is new (no saved skin)
RegisterNetEvent('rpa-appearance:server:checkNewPlayer', function()
    local src = source
    local player = GetPlayer(src)
    local fwName = exports['rpa-lib']:GetFrameworkName()
    
    if not player then return end
    
    local citizenid = player.PlayerData.citizenid
    local isNew = false
    
    -- Check based on framework
    if fwName == 'qb-core' or fwName == 'qbox' then
        -- QB-Core stores skin in playerskins table or in PlayerData.charinfo
        -- Check if player has appearance data in metadata or charinfo
        local charInfo = player.PlayerData.charinfo
        
        -- Simple check: if cid is empty or specific metadata flag
        if not charInfo or not charInfo.firstname or charInfo.firstname == '' then
            isNew = true
        else
            -- Also check database for saved skin
            MySQL.query('SELECT skin FROM playerskins WHERE citizenid = ?', { citizenid }, function(result)
                if not result or #result == 0 then
                    TriggerClientEvent('rpa-appearance:client:openForNewPlayer', src, true)
                else
                    TriggerClientEvent('rpa-appearance:client:openForNewPlayer', src, false)
                end
            end)
            return -- Early return, callback handles response
        end
    end
    
    TriggerClientEvent('rpa-appearance:client:openForNewPlayer', src, isNew)
end)

RegisterNetEvent('rpa-appearance:server:saveSkin', function(appearance)
    local src = source
    local player = GetPlayer(src)
    local fwName = exports['rpa-lib']:GetFrameworkName()
    
    if not player then return end
    
    local citizenid = player.PlayerData.citizenid
    
    -- Save to DB based on framework
    if fwName == 'qb-core' or fwName == 'qbox' then
        -- Use INSERT ... ON DUPLICATE KEY UPDATE for upsert
        MySQL.query('INSERT INTO playerskins (citizenid, skin) VALUES (?, ?) ON DUPLICATE KEY UPDATE skin = VALUES(skin)', {
            citizenid,
            json.encode(appearance)
        }, function(result)
            if result then
                exports['rpa-lib']:Notify(src, "Appearance saved", "success")
            end
        end)
    end
end)
