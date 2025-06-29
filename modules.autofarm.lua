return function(Config)
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer

    local function tweenTo(cf)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local tween = TweenService:Create(hrp, TweenInfo.new(1.5), {CFrame = cf})
        tween:Play()
        tween.Completed:Wait()
    end

    local function getTargetNPC()
        local level = LocalPlayer.Data.Level.Value
        local list = {
            {min = 0, max = 15, name = "Bandit"},
            {min = 16, max = 30, name = "Monkey"},
            {min = 31, max = 60, name = "Gorilla"},
            {min = 61, max = 90, name = "Pirate"},
            -- adicione mais se quiser
        }
        for _, npc in ipairs(list) do
            if level >= npc.min and level <= npc.max then
                return npc.name
            end
        end
        return nil
    end

    local function getNearestEnemyByName(name)
        local closest, dist = nil, math.huge
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob.Name:find(name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                local char = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and char then
                    local d = (hrp.Position - char.Position).Magnitude
                    if d < dist then
                        closest = mob
                        dist = d
                    end
                end
            end
        end
        return closest
    end

    spawn(function()
        while wait(0.5) do
            if Config.AutoFarm then
                local targetName = getTargetNPC()
                local enemy = getNearestEnemyByName(targetName)
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    tweenTo(enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
                    repeat
                        pcall(function()
                            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(11)
                            LocalPlayer:FindFirstChild("Backpack"):FindFirstChildOfClass("Tool").Parent = LocalPlayer.Character
                            enemy.Humanoid:TakeDamage(5)
                        end)
                        wait(0.15)
                    until not enemy or enemy.Humanoid.Health <= 0 or not Config.AutoFarm
                end
            end
        end
    end)
end