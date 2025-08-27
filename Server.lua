-- server.lua
local GOOGLE_API_KEY = "AIzaSyClgnNNP-ZYn7KWFtbMhu8OqFpq88mVNw0"

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
RegisterNetEvent("npc:policeInteract", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Qui chiameresti Google Studio AI
    local response = "Buongiorno cittadino, tutto in regola?" -- simulazione
    TriggerClientEvent("QBCore:Notify", src, response, "primary")
end)
