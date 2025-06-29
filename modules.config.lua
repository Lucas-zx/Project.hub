return function(Config)
    local HttpService = game:GetService("HttpService")
    local fileName = "luxus_config.json"

    -- Auto salvar a cada 5 segundos
    spawn(function()
        while wait(5) do
            if writefile then
                local ok, data = pcall(function()
                    return HttpService:JSONEncode(Config)
                end)
                if ok then
                    writefile(fileName, data)
                end
            end
        end
    end)
end