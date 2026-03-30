local HttpService = game:GetService("HttpService")
local OldPostAsync
OldPostAsync = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if self == HttpService and (method == "PostAsync" or method == "Request") then
        local url = args[1]
        if string.find(string.lower(url), "discord") or string.find(string.lower(url), "webhook") then return nil end
    end
    return OldPostAsync(self, ...)
end)

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

local function safeTeleport(targetCFrame)
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    hum.PlatformStand = true 
    local bv = Instance.new("BodyVelocity", root)
    bv.Velocity = Vector3.new(0,0,0); bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    local t = TweenService:Create(root, TweenInfo.new((targetCFrame.Position - root.Position).Magnitude/350, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    t:Play(); t.Completed:Connect(function() bv:Destroy(); hum.PlatformStand = false end)
end

local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "NewHub_Zick"; ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150); MainFrame.Size = UDim2.new(0, 500, 0, 320)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Logo = Instance.new("TextLabel", MainFrame)
Logo.Text = "NEW HUB"; Logo.TextColor3 = Color3.fromRGB(255, 0, 0); Logo.TextSize = 22; Logo.Font = Enum.Font.GothamBold
Logo.Position = UDim2.new(0, 15, 0, 10); Logo.Size = UDim2.new(0, 120, 0, 30); Logo.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(1, -35, 0, 5); CloseBtn.Text = "×"; CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0); CloseBtn.BackgroundTransparency = 1; CloseBtn.TextSize = 35
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local LeftNav = Instance.new("Frame", MainFrame)
LeftNav.BackgroundColor3 = Color3.fromRGB(30, 30, 30); LeftNav.Position = UDim2.new(0, 10, 0, 50); LeftNav.Size = UDim2.new(0, 120, 1, -60)
Instance.new("UICorner", LeftNav).CornerRadius = UDim.new(0, 8)
local NavList = Instance.new("UIListLayout", LeftNav); NavList.Padding = UDim.new(0, 8); NavList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local RightContent = Instance.new("ScrollingFrame", MainFrame)
RightContent.Position = UDim2.new(0, 140, 0, 50); RightContent.Size = UDim2.new(1, -150, 1, -60); RightContent.BackgroundTransparency = 1; 
RightContent.ScrollBarThickness = 4; RightContent.CanvasSize = UDim2.new(0, 0, 2.5, 0) -- เพิ่มเลข 2.5 เพื่อให้เลื่อนได้ยาวขึ้น
Instance.new("UIListLayout", RightContent).Padding = UDim.new(0, 8)

local function createMenuBtn(name)
    local btn = Instance.new("TextButton", LeftNav); btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btn.Text = name; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local TeleportBtn = createMenuBtn("Teleport")
local MiscBtn = createMenuBtn("Misc")
local FashionBtn = createMenuBtn("Fashions")

local function ClearPage()
    for _, child in pairs(RightContent:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
end

TeleportBtn.MouseButton1Click:Connect(function()
    ClearPage()
    local function addTBtn(txt, color, cf)
        local b = Instance.new("TextButton", RightContent); b.Text = txt; b.Size = UDim2.new(1,-15,0,35); b.BackgroundColor3 = color; b.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() safeTeleport(cf) end)
    end
    
    -- พิกัดชุดเดิม (ไม่เปลี่ยนแปลง)
    addTBtn("เรเบล", Color3.fromRGB(150, 0, 0), CFrame.new(-5070.75, 13.43, -209.1)) 
    addTBtn("แอปเปิ้ล", Color3.fromRGB(255, 50, 50), CFrame.new(8555.93, 197.55, -290.86)) 
    addTBtn("หมู", Color3.fromRGB(255, 150, 150), CFrame.new(9368.67, 185.56, -1126.09)) 
    addTBtn("ฟามไม้", Color3.fromRGB(130, 130, 0), CFrame.new(6696.58, 66.34, -1299.93))
    addTBtn("วัว", Color3.fromRGB(120, 120, 120), CFrame.new(8927.35, 150.91, -720.07)) 
    addTBtn("เลี้ยงไก่", Color3.fromRGB(255, 180, 0), CFrame.new(9203.88, 152.08, -473.19))
    addTBtn("สัปรด", Color3.fromRGB(200, 200, 0), CFrame.new(10313.61, 217.96, -1163.1)) 
    addTBtn("สตอรเบอรี่", Color3.fromRGB(255, 80, 80), CFrame.new(8508.14, 161.76, -2139.67))
    addTBtn("ร้านเชฟ", Color3.fromRGB(0, 120, 255), CFrame.new(1023.25, 138.15, 1360.01)) 
    addTBtn("โรงบาล", Color3.fromRGB(200, 200, 200), CFrame.new(-44.44, 5.36, -210.36)) 
    addTBtn("ตลาดโลก", Color3.fromRGB(0, 180, 100), CFrame.new(-1337.78, 4.55, 836.38))
    addTBtn("งัดร้านล่าง", Color3.fromRGB(80, 80, 80), CFrame.new(-2163.58, 7.46, -778.64))
    addTBtn("งัดร้านบน", Color3.fromRGB(80, 80, 80), CFrame.new(3241.02, 20.08, -1769.46))
    addTBtn("เหล็ก", Color3.fromRGB(60, 60, 60), CFrame.new(2031.1, 31.75, -9197.83)) 
    addTBtn("เหมือง", Color3.fromRGB(40, 40, 40), CFrame.new(-1016.09, -4.74, -9765.07)) 
    addTBtn("จุดเกิด", Color3.fromRGB(50, 50, 50), CFrame.new(-1242.51, 34.63, -165.95))
    addTBtn("ร้านขายรถ", Color3.fromRGB(150, 150, 0), CFrame.new(-1024.48, 9.43, 347.54))
end)

MiscBtn.MouseButton1Click:Connect(function()
    ClearPage()
    local b = Instance.new("TextButton", RightContent); b.Text = "Load Infinite Yield"; b.Size = UDim2.new(1,-15,0,40); b.BackgroundColor3 = Color3.fromRGB(255, 0, 0); b.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
end)

FashionBtn.MouseButton1Click:Connect(function()
    ClearPage()
    local b = Instance.new("TextButton", RightContent); b.Text = "ไฟสีแดงลุกรอบตัว"; b.Size = UDim2.new(1,-15,0,40); b.BackgroundColor3 = Color3.fromRGB(255,0,0); b.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        local hrp = player.Character:WaitForChild("HumanoidRootPart")
        if hrp:FindFirstChild("ZickFire") then hrp.ZickFire:Destroy() end
        local fire = Instance.new("ParticleEmitter", hrp); fire.Name = "ZickFire"; fire.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)); fire.Rate = 50
    end)
end)

local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
