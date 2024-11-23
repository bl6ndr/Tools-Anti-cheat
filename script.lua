local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local toolsCheckerEvent = ReplicatedStorage:WaitForChild("ToolsChecker")
local playerLastUpdate = {}

local function checkPlayerTools(playerName, toolNamesFromClient)
    local player = Players:FindFirstChild(playerName)
    if not player then return end

    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end

    local serverToolNames = {}
    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(serverToolNames, item.Name)
        end
    end

    table.sort(toolNamesFromClient)
    table.sort(serverToolNames)
    if table.concat(toolNamesFromClient, ",") ~= table.concat(serverToolNames, ",") then
        player:Kick("ANTI-CHEAT DETECTED UNAUTHORIZED TOOLS")
    end
end

toolsCheckerEvent.OnServerEvent:Connect(function(player, playerName, toolNamesFromClient)

    if player.Name == playerName then
        playerLastUpdate[player] = os.time()
        checkPlayerTools(playerName, toolNamesFromClient)
    else
        player:Kick("Invalid player data.")
    end
end)

while task.wait(1) do
    for _, player in ipairs(Players:GetPlayers()) do
        if not playerLastUpdate[player] or (os.time() - playerLastUpdate[player]) > 10 then
            player:Kick("anti-cheat dected something weird...")
        end
    end
end

Players.PlayerRemoving:Connect(function(player)
    playerLastUpdate[player] = nil
end)
