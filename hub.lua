-- Luxus Hub - Carregador Principal
if not game:IsLoaded() then game.Loaded:Wait() end

-- Salvamento de config
local Config = {
    Enabled = true,
    Translator = true,
    AutoFarm = true,
    AutoQuest = true,
    AutoHaki = true,
    FastAttack = true,
    AutoEquip = true,
    Key = "lucasz",
    Language = "PT"
}

-- Save/Load Config
local HttpService = game:GetService("HttpService")
local fileName = "luxus_config.json"
if isfile(fileName) then
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(fileName))
    end)
    if ok and typeof(data) == "table" then
        for k, v in pairs(data) do Config[k] = v end
    end
end

local function SaveConfig()
    if writefile then
        writefile(fileName, HttpService:JSONEncode(Config))
    end
end

-- GUI de login simples
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LuxusLogin"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "🔐 Digite a senha"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 16

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.9, 0, 0, 30)
input.Position = UDim2.new(0.05, 0, 0.4, 0)
input.PlaceholderText = "Senha padrão: lucasz"
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.TextColor3 = Color3.new(1,1,1)
input.Font = Enum.Font.Gotham
input.TextSize = 14

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0, 30)
button.Position = UDim2.new(0.1, 0, 0.75, 0)
button.Text = "✅ Entrar"
button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 14

button.MouseButton1Click:Connect(function()
    if input.Text == Config.Key then
        SaveConfig()
        gui:Destroy()
        -- Carregar módulos externos
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucas-zx/Script.luxus/main/modules/config.lua"))()(Config)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucas-zx/Script.luxus/main/modules/autoequip.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucas-zx/Script.luxus/main/modules/autofarm.lua"))(Config)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucas-zx/Script.luxus/main/modules/autoquest.lua"))(Config)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucas-zx/Script.luxus/main/modules/autohaki.lua"))(Config)
    else
        label.Text = "❌ Senha inválida!"
        label.TextColor3 = Color3.new(1, 0, 0)
    end
end)