-- client.lua
local carDealerCoords = vector3(-56.49, -1096.58, 26.42)
local carDealerPed = nil

CreateThread(function()
    RequestModel(`a_m_m_business_01`)
    while not HasModelLoaded(`a_m_m_business_01`) do
        Wait(500)
    end
-- client.lua
local hospitalPedCoords = vector3(310.0, -592.0, 43.3)

CreateThread(function()
    RequestModel(`s_m_m_doctor_01`)
    while not HasModelLoaded(`s_m_m_doctor_01`) do
        Wait(500)
    end

    local doctorPed = CreatePed(4, `s_m_m_doctor_01`, hospitalPedCoords, 90.0, false, true)
    SetEntityInvincible(doctorPed, true)
    FreezeEntityPosition(doctorPed, true)
    SetBlockingOfNonTemporaryEvents(doctorPed, true)

    exports['qb-target']:AddTargetEntity(doctorPed, {
        options = {
            {
                type = "client",
                event = "hospital:healPlayer",
                icon = "fas fa-plus",
                label = "Fatti curare"
            }
        },
        distance = 2.0
    })
end)
-- client.lua
exports['qb-target']:AddTargetEntity(policePed, {
    options = {
        {
            type = "server",
            event = "npc:policeInteract",
            icon = "fas fa-user-shield",
            label = "Parla con l'agente"
        }
    },
    distance = 2.0
})
        
RegisterNetEvent("hospital:healPlayer", function()
    SetEntityHealth(PlayerPedId(), 200)
    QBCore.Functions.Notify("Il medico ti ha curato!", "success")
end)
    carDealerPed = CreatePed(4, `a_m_m_business_01`, carDealerCoords, 71.0, false, true)
    SetEntityInvincible(carDealerPed, true)
    FreezeEntityPosition(carDealerPed, true)
    SetBlockingOfNonTemporaryEvents(carDealerPed, true)
end)

-- Interazione
RegisterCommand("buycar", function()
    TriggerServerEvent("mycardealer:buyCar", "sultan")
end)
