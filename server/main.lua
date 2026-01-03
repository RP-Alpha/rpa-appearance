RegisterNetEvent('rpa-appearance:server:saveSkin', function(appearance)
    local src = source
    local player = exports['rpa-lib']:GetFramework().Functions.GetPlayer(src)
    
    -- Save to DB (Framework specific usually)
    -- Implementing direct SQL or Framework helper
    if exports['rpa-lib']:GetFrameworkName() == 'qb-core' then
         MySQL.Async.execute('UPDATE playerskins SET skin = ? WHERE citizenid = ?', {
             json.encode(appearance),
             player.PlayerData.citizenid
         })
    end
end)
