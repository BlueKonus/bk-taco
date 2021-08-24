ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Fukce 3D Text
function DrawText3Ds(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0120, factor, 0.026, 41, 11, 41, 68)
	end
end

-- Funkce na marker
Citizen.CreateThread(function()
    while true do
        Wait(0)

        local pedCoords = GetEntityCoords(PlayerPedId())
        for i=1, #Config.TacoPos do
            local distance = #(pedCoords - Config.TacoPos[i])
            if distance < 10 then
                DrawMarker(-1, Config.TacoPos[i].x, Config.TacoPos[i].y, Config.TacoPos[i].z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
 
                if distance < 3 then
                    DrawText3Ds(Config.TacoPos[i].x, Config.TacoPos[i].y, Config.TacoPos[i].z, '[~g~E~s~] Automat')    
                    if IsControlJustReleased(0, 38) then
                        openShopMenu()
                    end
                end
                if sleep then
                    Wait(500)
                end
            end
        end
    end
end) 

-- Funkce na otevření nákupního menu
function openShopMenu() 
    local elements = {}

    for i=1, #Config.TacoShop do
        local item = Config.TacoShop[i]
        local itemLabel = string.format('%s - $%s / %sks', item.label, item.price * AMOUNT_TO_BUY, AMOUNT_TO_BUY)
        table.insert(elements, {label = itemLabel, value = item.name, price = item.price})      
        print('Otevrel si menu')
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_menu', {
        title = 'Obchod', 
        align = 'center', 
        elements = elements, 
    }, function(data, menu) 
        menu.close() 
        TriggerServerEvent('bk-taco:buyItem', data.current.value, data.current.price) 
    end, function(data, menu) 
        menu.close() 
    end)
end  





