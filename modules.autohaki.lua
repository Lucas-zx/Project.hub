return function(Config)
    local VirtualInput = game:GetService("VirtualInputManager")

    spawn(function()
        while wait(1) do
            if Config.AutoHaki then
                pcall(function()
                    -- Ativa o Haki da Observação ou Armamento usando a tecla J
                    VirtualInput:SendKeyEvent(true, "J", false, game)
                    wait(0.2)
                    VirtualInput:SendKeyEvent(false, "J", false, game)
                end)
            end
        end
    end)
end