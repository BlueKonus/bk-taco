ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('bk-taco:buyItem')
AddEventHandler('bk-taco:buyItem', function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
        print(price)
        if (xPlayer.getMoney() - price) >= price then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(item, 1)
        end
    end
end)