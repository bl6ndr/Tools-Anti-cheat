local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local toolsCheckerEvent = ReplicatedStorage:WaitForChild("ToolsChecker")

local function Scanner()
    local toolNames = {}
    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(toolNames, item.Name)
        end
    end
    toolsCheckerEvent:FireServer(player.Name, toolNames)
end

while task.wait(10) do
    Scanner()
end
