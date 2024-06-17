local requests = http_request or request
local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local player = game.Players.LocalPlayer
local username = player.Name

local function updateGemCount()
    local UIHandler = require(ReplicatedFirst.Classes.Class.UIHandler)
    local gemCount = UIHandler.Inventory.Currencies.Gems

    local url = "http://192.168.0.141:8080/update-gems"
    local data = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ gems = gemCount })
    }

    local response = requests(data)
    if response.Success then
        print("Gem count updated successfully")
    else
        warn("Failed to update gem count:", response.StatusMessage)
    end
end

local function updateUsername()
    local url = "http://192.168.0.141:8080/update-username"
    local data = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ username = username })  -- Ensure username is correctly encoded
    }

    local response = requests(data)
    if response.Success then
        print("Username updated successfully")
    else
        warn("Failed to update username:", response.StatusMessage)
    end
end

local function updateStatus()
    local url = "http://192.168.0.141:8080/update-status"
    local data = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ username = username, status = "online" })
    }

    local response = requests(data)
    if response.Success then
        print("Status updated successfully")
    else
        warn("Failed to update status:", response.StatusMessage)
    end
end

updateGemCount()
updateUsername()
updateStatus()

while wait(60) do
    updateStatus()
end
