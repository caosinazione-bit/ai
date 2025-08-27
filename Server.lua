-- server.lua
RegisterNetEvent("npc:policeInteract", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Qui chiameresti Google Studio AI
    local response = "Buongiorno cittadino, tutto in regola?" -- simulazione
    TriggerClientEvent("QBCore:Notify", src, response, "primary")
end)
