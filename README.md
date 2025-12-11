-- Winui https://footagesus.github.io/WindUI-Docs/

getgenv().AutoMine = false
getgenv().SelectRocks = ""
getgenv().TweenSpeed = 50


local RocksTable = {}

int = function()
    for _,v in pairs(require(game:GetService("ReplicatedStorage").Shared.Data.Rock)) do
        table.insert(RocksTable,_)
    end
end

-- // Service
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character
local RootPart = Char.HumanoidRootPart

-- // Tween
Tween = function(Target,Speed)
    local Dis = (Target.Position - RootPart.Position).Magnitude
    TweenService:Create(RootPart,TweenInfo.new(Dis/Speed,Enum.EasingStyle.Linear),
    {CFrame = Target}
    ):Play()
end

-- // remote
Pickaxe = function()
    game:GetService("ReplicatedStorage").Shared.Packages.Knit.Services.ToolService.RF.ToolActivated:InvokeServer("Pickaxe")
end

-- // Noclip

noclip = function()
    for _,v in pairs(Char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end

-- // parttaiteen

local Taiteen = workspace:FindFirstChild("TaiTeen")

if not Taiteen then
    taitenn = Instance.new("Part")
    taitenn.Name = "taiteen"
    taitenn.Parent = workspace
    taitenn.Anchored = true
    taitenn.Transparency = 1
    taitenn.Size = Vector3.new(30,0.5,30)
end

UpdateTaiTeen = function()
    if taitenn and RootPart then
        taitenn.CFrame = RootPart.CFrame * CFrame.new(0,-3,0)
    end
end


-- // LOOP
task.spawn(function()
    while task.wait() do
        if getgenv().AutoMine then
for _,Rocks in pairs(workspace.Rocks:GetChildren()) do
    if not getgenv().AutoMine then break end
    for _,part in pairs(Rocks:GetChildren()) do
        if part:IsA "Part" and part.Name == "SpawnLocation" then
            local Model = part:FindFirstChildOfClass("Model")
                if Model and Model.Parent then
                    if table.find(RocksTable,Model.Name) then
                repeat task.wait()

                    if not getgenv().AutoMine then
                        workspace.Camera.CameraSubject = RootPart
                        break
                    end


                    local HP = tonumber(Model:GetAttribute("Health"))
                    if HP <= 0 or not Model.Parent then break end

                        Tween(Model.Hitbox.CFrame * CFrame.new(0,-4 ,0),getgenv().TweenSpeed)
                        Pickaxe()
                        noclip()
                        UpdateTaiTeen()

                    if (Model.Hitbox.Position - RootPart.Position).Magnitude <= 6 then
                        workspace.Camera.CameraSubject = Model.Hitbox
                    else
                         workspace.Camera.CameraSubject = RootPart
                    end
                        until not Model.Parent or HP <= 0 or not getgenv().AutoMine 
                            end
                        end
                    end
                end
            end
        end
    end
end)








-- // UI
int()

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "NEWHUB",
    Icon = "door-open",
    Author = "by NEW HUB",

    OpenButton = {
        Title = "Open Example UI",
        Icon = "monitor",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 2,
        Color = ColorSequence.new( 
            Color3.fromHex("FF0F7B"), 
            Color3.fromHex("F89B29")
        ),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    }

})
local Tab = Window:Tab({
    Title = "Main",
    Icon = "bird",
    Locked = false,
})

Tab:Select()

local Dropdown = Tab:Dropdown({
    Title = "เลือกหิน",
    Desc = "",
    Values = RocksTable,
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(v) 
        getgenv().SelectRocks = v
    end
})

local Toggle = Tab:Toggle({
    Title = "ฟามหิน",
    Desc = "",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(v) 
        getgenv().AutoMine = v
    end
})

local Slider = Tab:Slider({
    Title = "ปรับความเร็ว",
    Desc = "",

    Step = 1,
    Value = {
        Min = 1,
        Max = 50,
        Default = getgenv().TweenSpeed,
    },
    Callback = function(v)
        getgenv().TweenSpeed = v
    end
})
