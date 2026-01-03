local function OpenMenu(isPed)
    local provider = Config.Provider
    
    if provider == 'illenium-appearance' or provider == 'fivem-appearance' then
        if GetResourceState('illenium-appearance') == 'started' then
            exports['illenium-appearance']:startPlayerCustomization(function(appearance)
                if appearance then
                    TriggerServerEvent('rpa-appearance:server:saveSkin', appearance)
                end
            end, {
                ped = isPed
            })
        elseif GetResourceState('fivem-appearance') == 'started' then
            exports['fivem-appearance']:startPlayerCustomization(function(appearance)
                if appearance then
                    TriggerServerEvent('rpa-appearance:server:saveSkin', appearance)
                end
            end, {
                ped = isPed
            })
        else
            -- Fallback or Error
            print("^1[RP-Alpha] Error: Appearance provider not running^7")
            exports['rpa-lib']:Notify("System Error: No Appearance Resource", "error")
        end
    elseif provider == 'qb-clothing' then
        TriggerEvent('qb-clothing:client:openMenu')
    end
end

RegisterNetEvent('rpa-appearance:client:checkSkin', function()
    -- This event is triggered by rpa-spawn after spawning
    -- Check if player has skin (Server callback ideal, but for now just open menu if new)
    -- Simplified: Always assume existing skin loaded by framework spawn, OR open menu if specific flag
    
    -- Mock:
    local isNew = false -- Replace with server check
    if isNew then
        OpenMenu(true)
    end
end)

RegisterNetEvent('rpa-appearance:client:openMenu', function()
    OpenMenu(false)
end)

-- Polyzone / Target for shops
CreateThread(function()
    for _, shop in pairs(Config.Shops) do
        exports['rpa-lib']:AddTargetZone('clothing_store_'..shop.coords.x, shop.coords, vector3(1, 1, 2), {
            options = {
                {
                    label = "Change Clothing",
                    icon = "fas fa-tshirt",
                    action = function()
                        OpenMenu(false)
                    end
                }
            }
        }, false)
    end
end)
