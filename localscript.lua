local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local toolsCheckerEvent = ReplicatedStorage:WaitForChild("ToolsChecker")

task.spawn(function()
    while task.wait(10) do
        local success = pcall(function()
            local toolNames = {}
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") then
                    table.insert(toolNames, item.Name)
                end
            end
            toolsCheckerEvent:FireServer(toolNames)
        end)

        if not success then
            player:Kick("Error scanning tools")
        end
    end
end)
