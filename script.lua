local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local toolsCheckerEvent = ReplicatedStorage:WaitForChild("ToolsChecker")
local playerLastUpdate = {}
local gracePeriod = 15

toolsCheckerEvent.OnServerEvent:Connect(function(player, toolNamesFromClient)
    local success = pcall(function()
        playerLastUpdate[player] = os.time()

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
            player:Kick("ANTI-CHEAT: Unauthorized tools detected.")
        end
    end)

    if not success then
        warn("Error processing tools for " .. player.Name)
    end
end)

task.spawn(function()
    while task.wait(1) do
        for _, player in ipairs(Players:GetPlayers()) do
            local lastUpdate = playerLastUpdate[player]
            if lastUpdate and (os.time() - lastUpdate > gracePeriod) then
                player:Kick("ANTI-CHEAT: No update from client.")
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    playerLastUpdate[player] = nil
end)
