local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()local Window = OrionLib:MakeWindow({Name = "NEW HUB", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})Tab:AddButton({
	Name = "speed hack",
	Callback = function()
local RunService = game:getService("Run Service")
local Players = game:getService("Players")
 
_G.WalkSpeed = 30
 
local Speed = _G.WalkSpeed
 
RunService.RenderStepped:connect(function()
    local Plr = Players.LocalPlayer
    local Char = Plr.Character
    local Hum = Char.Humanoid
 
    if Plr and Char and Hum then
        Hum.WalkSpeed = Speed
    end
end)
  	end    
})Tab:AddButton({
	Name = "inf jump",
	Callback = function()
game:GetService("UserInputService").JumpRequest:connect(function()
        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")       
    end)
  	end    
})Tab:AddButton({
	Name = "fly",
	Callback = function()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
  	end
})Tab:AddButton({
	Name = "super zoom",
	Callback = function()
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
 
local function GetUnanchoredParts()
local Parts = {}
for _,v in pairs(workspace:GetDescendants()) do
if v:IsA("BasePart") and not v.Anchored then
table.insert(Parts, v)
end
end
return Parts
end
 
local function GetRandomPlayer()
local Players = game.Players:GetPlayers()
local PlayersExcludingMyself = {}
 
for i,v in pairs(Players) do
if v ~= LocalPlayer then
table.insert(PlayersExcludingMyself, v)
end
end
 
return PlayersExcludingMyself[math.random(1,#PlayersExcludingMyself)]
end
 
RunService.Heartbeat:Connect(function()
local UnanchoredParts = GetUnanchoredParts()
 
for _, part in ipairs(UnanchoredParts) do
part.Velocity = Vector3.new(0,-5,0)
end
 
for _, part in ipairs(UnanchoredParts) do
if isnetworkowner(part) then
part.CFrame = GetRandomPlayer().Character.PrimaryPart.CFrame
end
end
end)
  	end 
})Tab:AddButton({
	Name = "ESP",
	Callback = function()
      	while wait() do
     pcall(function()
       for i,v in pairs(game.Players:GetChildren()) do
            if not v.Character.Head:FindFirstChild("ESP") then
                local BillboardGui = Instance.new("BillboardGui")
                local TextLabel = Instance.new("TextLabel")
                BillboardGui.Parent = v.Character.Head
                BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                BillboardGui.Active = true
                BillboardGui.Name = "ESP"
                BillboardGui.AlwaysOnTop = true
                BillboardGui.LightInfluence = 1.000
                BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                TextLabel.Parent = BillboardGui
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.Size = UDim2.new(0, 200, 0, 50)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.Text = v.Name
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextScaled = true
                TextLabel.TextSize = 14.000
                TextLabel.TextStrokeTransparency = 0.000
                TextLabel.TextWrapped = true
            end
        end
    end) 
end
  	end    
})
