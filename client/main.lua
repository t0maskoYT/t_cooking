local attachedStand = false
local standObject = nil
local showingTextAndMarker = false
local inprocess = false
local showOrder = false
local randomText = false
local order = ""
local anti_e = true
local anti_e2 = true
local anti_g = false
local anti_h = false
local deletetext = false

Citizen.CreateThread(function()

end)

Citizen.CreateThread(function()
    SpawnChef()
    
    while true do
        Citizen.Wait(0)

                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local distanceToStand = 0.0

                
                if attachedStand then
                    local standCoords = GetEntityCoords(standObject)
                    distanceToStand = #(playerCoords - standCoords)

                    if distanceToStand > 5.0 then
                        DetachStand()
                    end
                end

                -- local markerDistance = #(playerCoords - vector3(Config.Marker.x, Config.Marker.y, Config.Marker.z))
                --     if markerDistance < 5.0 then
                --         if anti_e2 == true then
                --             DrawText3D(Config.Marker.x, Config.Marker.y, Config.Marker.z, "[E] Serve")
                            

                        
                --         if anti_e == true then

                --             if IsControlJustPressed(0, 38) then -- 38 it's key for E
                --                 anti_e = false
                --                 anti_e2 = false
                --                 if not attachedStand then
                --                     if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Job then
                                        
                --                         DrawTextAndMarkerIfClose()
                --                         SpawnPed()
                                        
                --                         order = Config.Orders[math.random(#Config.Orders)].text
                --                         orderText = order
                --                         randomText = true
                                        
                                        
                --                     else
                --                         ESX.ShowNotification("You don't have permission for this!")
                --                     end
                --                 end
                --             end
                        
                --         end
                --         end
                -- end

               -- local cookDistance = #(playerCoords - vector3(Config.Cook.x, Config.Cook.y, Config.Cook.z))

                -- if cookDistance < 5.0 then
                --     DrawText3D(Config.Cook.x, Config.Cook.y, Config.Cook.z, "[E] Cook")

                --     if IsControlJustPressed(0, 38) then
                --         if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Job then
                --             FoodMenu()
                --         else
                --             ESX.ShowNotification("You can't cook here!")
                --         end
                --     end
                -- end              
                
                -- local recepiesDistance = #(playerCoords - vector3(Config.chefNpc.x, Config.chefNpc.y, Config.chefNpc.z))

                -- if recepiesDistance < 5.0 then
                --     DrawText3D(Config.chefNpc.x, Config.chefNpc.y, Config.chefNpc.z, "[E] Recepies")
                --     if IsControlJustPressed(0, 38) then
                --         RecepiesMenu()
                --     end
                -- end

    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showOrder == true then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.Npc.x, Config.Npc.y, Config.Npc.z)

            if distance < 3.0 then
                if anti_h == false then
                    if IsControlJustPressed(0, 74) then
                        ESX.Progressbar("Selling...", 2000,{
                            FreezePlayer = true, 
                            animation ={
                                type = "Scenario",
                                Scenario = "WORLD_HUMAN_DRUG_DEALER_HARD", 
                            }
                        })
                        TriggerServerEvent("my_cooking:sellOrder", orderText)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('tg_cooking:client:delete')
AddEventHandler('tg_cooking:client:delete', function()
    deleteentity()
end)

function deleteentity()
    DeleteEntity(dealPed)
    deletetext = true
    showOrder = true
    inprocess = false
    anti_e2 = true
    anti_e = true
    anti_h = true
end
--------------------
------FUNCTION------
--------------------



function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


function FoodMenu()
    local elements = {}

    for k, v in pairs(Config.recipes) do
        table.insert(elements, {label = v.name, value = k})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cooking_menu',
        {
            title = "Select food for cook",
            align = 'right',
            elements = elements
        },
        function(data, menu)
            local recipeId = data.current.value
            StartCookingProcess(recipeId)
            menu.close()
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function RecepiesMenu(source, args, rawCommand)
    local elements = {
        {label = "HotDog"},
        {label = "Hamburger"},
        {label = "Pizza"},
        {label = "Tortilla"},
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cooking_menu',
        {
            title = "Select food for show recipe",
            align = 'right',
            elements = elements
        },
        function(data, menu)
            if data.current.label == "HotDog" then
                ESX.ShowNotification("Recipe for HotDog: 1x roll, 1x sausage")
                menu.close()
            elseif data.current.label == "Hamburger" then
                ESX.ShowNotification("Recipe for Hamburger: 2x bun, 1x cucumber, 1x beef, 1x tomato")
                menu.close()
            elseif data.current.label == "Pizza" then
                ESX.ShowNotification("Recipe for Pizza: 1x dought, 3x tomato, 1x cheese, 2x ham, 1x mozzarela")
                menu.close()
            elseif data.current.label == "Tortilla" then
                ESX.ShowNotification("Recipe for Tortilla: 1x pita, 3x tomato, 2x salad, 2x onion, 1x sauce")
                menu.close()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )

end


function StartCookingProcess(recipeId)
    ESX.TriggerServerCallback('my_cooking:checkIngredients', function(hasIngredients)
        if hasIngredients then
            ESX.ShowNotification("Cook has started. Wait until the food is ready.")

            local cookingTime = Config.cookingTime
            ESX.Progressbar("Cooking...", Config.cookingTime,{
                FreezePlayer = true, 
                animation ={
                    type = "Scenario",
                    Scenario = "PROP_HUMAN_BBQ", 
                }
            })

            ESX.ShowNotification("Food is already done. You can take it.")
            TriggerServerEvent('my_cooking:giveFood', recipeId)
        else
            ESX.ShowNotification("You don't have enough ingredients for this this.")
        end
    end, recipeId)
end

------------------------
-------SPAWN-NPC--------
------------------------

function SpawnPed()

    if inprocess == false then 
        local peds = {
            { type=4, model=Config.modelPed}
        }

        local playerCoords = GetEntityCoords(playerPed)
    
        for k, v in pairs(peds) do
            local hash = GetHashKey(v.model)
            RequestModel(hash)

            while not HasModelLoaded(hash) do
                Citizen.Wait(1)
            end

            --- SPAWN NPC---
            dealPed = CreatePed(v.type, hash, Config.Npc.x, Config.Npc.y, Config.Npc.z -1, Config.NpcHeading, true, true)

            SetEntityInvincible(dealPed, true)
            SetEntityAsMissionEntity(dealPed, true)
            SetBlockingOfNonTemporaryEvents(dealPed, true)
            FreezeEntityPosition(dealPed, true)

            
            ESX.ShowNotification("The customer wants to order food!")
            Citizen.Wait(2000)
            SetNewWaypoint(Config.Npc.x, Config.Npc.y)
        end
    else
        ESX.ShowNotification("You have an unserved customer!")
    end
    inprocess = true
    anti_g = true
end
function SpawnChef()
    local peds = {
        { type=4, model=Config.chefModelPed}
    }

    local playerCoords = GetEntityCoords(playerPed)

    for k, v in pairs(peds) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        --- SPAWN NPC---
        chefPed = CreatePed(v.type, hash, Config.chefNpc.x, Config.chefNpc.y, Config.chefNpc.z -1, Config.chefNpcHeading, true, true)

        SetEntityInvincible(chefPed, true)
        SetEntityAsMissionEntity(chefPed, true)
        SetBlockingOfNonTemporaryEvents(chefPed, true)
        FreezeEntityPosition(chefPed, true)
    end
end

function DrawOrder()
    Citizen.CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.Npc.x, Config.Npc.y, Config.Npc.z)    
            if deletetext == false then
                if distance < 7.0 then
                    if not randomText then

                        if showOrder == true then

                            order = Config.Orders[math.random(#Config.Orders)].text
                            orderText = order
                            randomText = true

                            DrawText3D(Config.Npc.x, Config.Npc.y, Config.Npc.z + 0.5, order)
                            DrawText3D(Config.Npc.x, Config.Npc.y, Config.Npc.z + 0.35, "[H] Complete Order")

                        end
                    else
                        DrawText3D(Config.Npc.x, Config.Npc.y, Config.Npc.z + 0.5, order)
                        DrawText3D(Config.Npc.x, Config.Npc.y, Config.Npc.z + 0.35, "[H] Complete Order")
                    end
                else
                    if showOrder then
                        showOrder = false
                        
                    end
                end
            end
            Citizen.Wait(0)
        end
    end)
end

------------------------
-------SPAWN-TXT--------
------------------------

function DrawTextAndMarkerIfClose()
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0) 

                    if inprocess == true then 
                                local playerCoords = GetEntityCoords(PlayerPedId())
                                local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.Npc.x, Config.Npc.y, Config.Npc.z)
                            
                                if distance < 7.0 then
                                    if not showingTextAndMarker then
                                        showingTextAndMarker = true
                                    end
                                    if anti_g == true then
                                        DrawText3D(Config.Npc.x, Config.Npc.y, Config.Npc.z + 1.1, "[G]")
                                    else

                                    end
                                    DrawMarker(3, Config.Npc.x, Config.Npc.y, Config.Npc.z + 1.3, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, false, 2, true, nil, nil, false)
                                
                                    if IsControlJustPressed(0, 47) then
                                        showOrder = true
                                        deletetext = false
                                        DrawOrder()
                                        anti_g = false
                                        anti_h = false
                                        
                                    end

                                else
                                    if showingTextAndMarker then
                                        showingTextAndMarker = false
                                    end
                                end
                        
                        else

                        end
                    
            end
    end)
end
------------------------
-------OX TARGET--------
------------------------

AddEventHandler('start', function ()
    DrawTextAndMarkerIfClose()
    SpawnPed()
end)

AddEventHandler('cookstart', function()
    FoodMenu()
end)

AddEventHandler('recepieso', function ()
    RecepiesMenu()    
end)


exports.ox_target:addBoxZone({ 
    coords = vector3(128.967041, -1054.101074, 22.944336),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'job_start',
            event = 'start',
            icon = 'fa-solid fa-cube',
            label = 'Start job',
        }
    }
})



exports.ox_target:addBoxZone({ 
    coords = vector3(143.169235, -1056.553833, 22.944336),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'Cooking',
            event = 'cookstart',
            icon = 'fa-solid fa-cube',
            label = 'Cook',
        }
    }
})

exports.ox_target:addBoxZone({ 
    coords = vector3(149.2682, -1055.1135, 22.9602),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'Recepies',
            event = 'recepieso',
            icon = 'fa-solid fa-cube',
            label = 'Show me Recepies',
        }
    }
})
