QBCore = exports['qb-core']:GetCoreObject()

-- Prendi API Key da server.cfg (più sicuro)
local GOOGLE_API_KEY = GetConvar("GOOGLE_API_KEY", "")

-- Funzione che parla con Google AI Studio (Gemini)
function AskGoogleAI(prompt, cb)
    local url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key="..GOOGLE_API_KEY
    
    local data = {
        contents = {{
            parts = {{
                text = prompt
            }}
        }}
    }

    PerformHttpRequest(url, function(err, text, headers)
        if err == 200 then
            local body = json.decode(text)
            if body and body.candidates and body.candidates[1] then
                cb(body.candidates[1].content.parts[1].text)
            else
                cb("L'agente non risponde...")
            end
        else
            cb("Errore AI: "..tostring(err))
        end
    end, "POST", json.encode(data), {["Content-Type"] = "application/json"})
end

-- Dialogo dinamico AI
RegisterNetEvent("npc:police:dialogue", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local name = Player.PlayerData.charinfo.firstname

    AskGoogleAI("Sei un poliziotto di Los Santos. Rispondi al cittadino "..name.." in tono severo ma gentile.", function(response)
        TriggerClientEvent("QBCore:Notify", src, response, "primary", 7000)
    end)
end)

-- Multa
RegisterNetEvent("npc:police:fine", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(100, 500)

    if Player.Functions.RemoveMoney("cash", amount) then
        TriggerClientEvent("QBCore:Notify", src, "Hai ricevuto una multa di $"..amount, "error")
    else
        TriggerClientEvent("QBCore:Notify", src, "Non hai abbastanza soldi per pagare la multa!", "error")
    end
end)

-- Arresto (teleport cella)
RegisterNetEvent("npc:police:arrest", function()
    local src = source
    local ped = GetPlayerPed(src)

    SetEntityCoords(ped, 175.0, -1000.0, 30.0) -- esempio coordinate cella
    TriggerClientEvent("QBCore:Notify", src, "Sei stato arrestato dall’agente NPC!", "error")
end)
