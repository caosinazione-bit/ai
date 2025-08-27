-- client.lua
local carDealerCoords = vector3(-56.49, -1096.58, 26.42)
local carDealerPed = nil

CreateThread(function()
    RequestModel(`a_m_m_business_01`)
    while not HasModelLoaded(`a_m_m_business_01`) do
        Wait(500)
    end

    carDealerPed = CreatePed(4, `a_m_m_business_01`, carDealerCoords, 71.0, false, true)
    SetEntityInvincible(carDealerPed, true)
    FreezeEntityPosition(carDealerPed, true)
    SetBlockingOfNonTemporaryEvents(carDealerPed, true)
end)

-- Interazione
RegisterCommand("buycar", function()
    TriggerServerEvent("mycardealer:buyCar", "sultan")
end)
