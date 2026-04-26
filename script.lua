local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local Fly, Noclip, Speed = false, false, 50
local BV, BG = Instance.new("BodyVelocity"), Instance.new("BodyGyro")
BV.MaxForce, BG.MaxTorque = Vector3.new(1e9,1e9,1e9), Vector3.new(1e9,1e9,1e9)

(ResetOnSpawn = false keeps it on screen after death)
local SG = Instance.new("ScreenGui", game.CoreGui)
SG.Name = "DeltaUltimate"
SG.ResetOnSpawn = false 

local Frame = Instance.new("Frame", SG)
Frame.Size, Frame.Position = UDim2.new(0, 130, 0, 115), UDim2.new(0.5, -65, 0.2, 0)
Frame.BackgroundColor3, Frame.Active, Frame.Draggable = Color3.fromRGB(15,15,15), true, true

local function CreateBtn(name, pos, color)
    local b = Instance.new("TextButton", Frame)
    b.Size, b.Position, b.Text, b.BackgroundColor3 = UDim2.new(1,-10,0,30), pos, name, color
    b.TextColor3, b.Font = Color3.new(1,1,1), Enum.Font.SourceSansBold
    return b
end

local FlyBtn = CreateBtn("FLY: OFF", UDim2.new(0,5,0,5), Color3.fromRGB(60,20,20))
local NocBtn = CreateBtn("NOCLIP: OFF", UDim2.new(0,5,0,40), Color3.fromRGB(60,20,20))
local SpdBtn = CreateBtn("SPEED: 50", UDim2.new(0,5,0,75), Color3.fromRGB(20,20,60))

FlyBtn.MouseButton1Click:Connect(function()
    Fly = not Fly
    FlyBtn.Text = Fly and "FLY: ON" or "FLY: OFF"
    FlyBtn.BackgroundColor3 = Fly and Color3.fromRGB(20,60,20) or Color3.fromRGB(60,20,20)
end)

NocBtn.MouseButton1Click:Connect(function()
    Noclip = not Noclip
    NocBtn.Text = Noclip and "NOCLIP: ON" or "NOCLIP: OFF"
    NocBtn.BackgroundColor3 = Noclip and Color3.fromRGB(20,60,20) or Color3.fromRGB(60,20,20)
end)

SpdBtn.MouseButton1Click:Connect(function()
    Speed = (Speed == 50 and 150) or (Speed == 150 and 400) or 50
    SpdBtn.Text = "SPEED: "..Speed
end)

RunService.Stepped:Connect(function()
    local Char = Player.Character
    local Root = Char and Char:FindFirstChild("HumanoidRootPart")
    
    if Fly and Root then
        BV.Parent, BG.Parent = Root, Root
        BV.Velocity = workspace.CurrentCamera.CFrame.LookVector * Speed
        BG.CFrame = workspace.CurrentCamera.CFrame
    else
        BV.Parent, BG.Parent = nil, nil
    end

    if Noclip and Char then
        for _, part in pairs(Char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

print("Delta Ultimate Script Loaded - Persistent after death")
