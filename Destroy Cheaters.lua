local FANG_KEYBIND = "X"

getgenv().Fang1 = true 
local NewCFrame = CFrame.new
local LocalFang = game.Players.LocalPlayer
local InputService = game:GetService("UserInputService")
local Runfang = game:GetService("RunService")

local Fang2; 
Runfang.heartbeat:Connect(function()
    if LocalFang.Character then 
        local FangChar = LocalFang.Character.HumanoidRootPart
        local Offset = FangChar.CFrame * NewCFrame(9e9, 0/0, math.huge)
        
        if getgenv().Fang1 then 
            Fang2 = FangChar.CFrame
            FangChar.CFrame = Offset
            Runfang.RenderStepped:Wait()
            FangChar.CFrame = Fang2
        end 
    end 
end)

InputService.InputBegan:Connect(function(sigma)
    if sigma.KeyCode == Enum.KeyCode[FANG_KEYBIND] then 
        getgenv().Fang1 = not getgenv().Fang1
        
        if not Fang1 then 
            LocalFang.Character.HumanoidRootPart.CFrame = Fang2
            -- 
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Destroy Cheaters";
                Text = "Disabled";
            })
        else 
            Fang2 = nil 
            -- 
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Destroy Cheaters";
                Text = "Enabled";
            })
        end 
    end 
end)    

local FangHook
FangHook = hookmetamethod(game, "__index", newcclosure(function(self, key)
    if not checkcaller() then
        if key == "CFrame" and getgenv().Fang1 and LocalFang.Character and LocalFang.Character:FindFirstChild("HumanoidRootPart") and LocalFang.Character:FindFirstChild("Humanoid") and LocalFang.Character:FindFirstChild("Humanoid").Health > 0 then
            if self == LocalFang.Character.HumanoidRootPart and Fang2 ~= nil then
                return Fang2
            end
        end
    end
    -- 
    return FangHook(self, key)
end))
