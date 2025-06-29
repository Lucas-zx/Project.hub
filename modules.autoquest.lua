return function(Config)
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer

    local function tweenTo(cf)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local tween = TweenService:Create(hrp, TweenInfo.new(1.2), {CFrame = cf})
            tween:Play()
            tween.Completed:Wait()
        end
    end

    local function getQuestNPC()
        local level = LocalPlayer.Data.Level.Value
        local list = {
            {min = 0, max = 15, quest = "BanditQuest1", pos = CFrame.new(1060, 17, 1548)},
            {min = 16, max = 30, quest = "JungleQuest", pos = CFrame.new(-1600, 40, 150)},
            {min = 31, max = 60, quest = "GorillaQuest", pos = CFrame.new(-1230, 50, 450)},
            {min = 61, max = 90, quest = "BuggyQuest1", pos = CFrame.new(-1150, 15, 3650)},
            -- continue expandindo conforme o level
        }
        for _, npc in ipairs(list) do
            if level >= npc.min and level <= npc.max then
                return npc.quest, npc.pos
            end
        end
        return nil, nil
    end

    spawn(function()
        while wait(1) do
            if Config.AutoQuest then
                local questName, pos = getQuestNPC()
                if questName and pos then
                    pcall(function()
                        tweenTo(pos)
                        wait(0.5)
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:find("Quest") then
                                fireclickdetector(v)
                                break
                            end
                        end
                    end)
                end
            end
        end
    end)
end