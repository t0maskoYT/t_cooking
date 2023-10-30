ESX.RegisterServerCallback('my_cooking:checkIngredients', function(source, cb, recipeId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local recipe = Config.recipes[recipeId]
    local hasIngredients = CheckIngredients(xPlayer, recipe.ingredients)

    cb(hasIngredients)
end)

RegisterServerEvent("my_cooking:giveFood")
AddEventHandler("my_cooking:giveFood", function(recipeId, cookingTime)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local recipe = Config.recipes[recipeId]

    if recipe then
        xPlayer.addInventoryItem(recipe.item, 1)

    else

    end
end)

RegisterServerEvent("my_cooking:startCooking")
AddEventHandler("my_cooking:startCooking", function(recipeId, cookingTime)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local recipe = Config.recipes[recipeId]
    
    local hasIngredients = CheckIngredients(xPlayer, recipe.ingredients)
    
    if hasIngredients then
        TriggerClientEvent("my_cooking:showCookingAnimation", _source)
        Citizen.Wait(cookingTime)
        TriggerClientEvent("my_cooking:checkIngredients", _source)
        TriggerClientEvent("my_cooking:finishCooking", _source, recipe.name)
    end
end)


function CheckIngredients(xPlayer, ingredients)
    local recipe = Config.recipes[recipeName]

    

    for k, v in pairs(ingredients) do
        local item = xPlayer.getInventoryItem(k)
        if not item or item.count < v then
            return false
        end
    end
    
    for k, v in pairs(ingredients) do
        xPlayer.removeInventoryItem(k, v)
    end
    
    return true
end


RegisterServerEvent("my_cooking:sellOrder")
AddEventHandler("my_cooking:sellOrder", function(orderText)
    local xPlayer = ESX.GetPlayerFromId(source)
    local doneorder = xPlayer.getInventoryItem(orderText)
    local pay = math.random(Config.Salary1, Config.Salary2)
    if doneorder.count >= 1 then
        xPlayer.removeInventoryItem(orderText, 1)
        xPlayer.addMoney(pay)
        TriggerClientEvent("tg_cooking:client:delete", source)
    else
        TriggerClientEvent('esx:showNotification', source, '~r~You dont have right food!')
    end

end)