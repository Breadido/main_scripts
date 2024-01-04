
-- MY SCRIPTING SKILLZ IS BAD :<

-- Shits Stuffz
getgenv().settings = {
    AlwaysClicking = false,
	ClickingMode = "MouseButton1Click",
	AttackNearestEnemiez = false,
	SelectedEnemiez = nil,
	AttackSelectedEnemiez = false,
	TeleportSpeed = 50,
}

local enemiez = {}
for i, v in pairs(workspace._ENEMIES[game:GetService("Players").LocalPlayer:GetAttribute("CurrentArea")]:GetChildren()) do
	if table.find(enemiez, v.Name) then
		-- do nothing yes absolutely do nothing
	else
		table.insert(enemiez, v.Name)
	end
end 
local GetClosestBitches = (newcclosure(function()
    local distance = 9e9
	local bitches
    for i,v in pairs(workspace._ENEMIES[game:GetService("Players").LocalPlayer:GetAttribute("CurrentArea")]:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            if mag < distance then
                distance = mag
                bitches = v
            end
        end
    end
    return bitches
end))
local GetClosestBitches2 = (newcclosure(function() -- for attack selected enemiez
    local distance = 9e9
	local bitches
    for i,v in pairs(workspace._ENEMIES[game:GetService("Players").LocalPlayer:GetAttribute("CurrentArea")]:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.Name == settings.SelectedEnemiez then
            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            if mag < distance then
                distance = mag
                bitches = v
            end
        end
    end
    return bitches
end))
local KillClosestBitches = (newcclosure(function()
	local args = {[1] = {[1] = {[1] = "\3",[2] = "Click",[3] = "Execute",[4] = GetClosestBitches()}}}
	game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))	
end))
local KillClosestBitches2 = (newcclosure(function()
	local args = {[1] = {[1] = {[1] = "\3",[2] = "Click",[3] = "Execute",[4] = GetClosestBitches2()}}}
	game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))	
end))
local FireSignalButtonClick = (newcclosure(function() firesignal(game:GetService("Players").LocalPlayer.PlayerGui._SIDE.Buttons["3"].Frame.Click.MouseButton1Click) end))
local RemoteEventClick = (newcclosure(function() 
	local args = {[1] = {[1] = {[1] = "\3",[2] = "Click",[3] = "Execute"}}} 
	game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args)) 
end))

-- Ui
local dexed = loadstring(game:HttpGet('https://raw.githubusercontent.com/Breadido/Dexed/main/source.lua'))()
local ui = dexed.SetupUI("Anime Soul X Simulator | Made By Breadido | Discord: breadido")
local page = ui.CreatePage("Main")

page.CreateDropdown("Select Enemies", enemiez,function(a)
	settings.SelectedEnemiez = a
end)
page.CreateSlider("Teleport Speed", 50, 400, function(a)
	settings.TeleportSpeed = tonumber(a)
end)
settings.TeleportSpeed = 50 -- default
page.CreateToggle("Attack Selected Enemies", function(a)
	settings.AttackSelectedEnemiez = a
end)

page.CreateToggle("Attack Auras", function(a)
	settings.AttackNearestEnemiez = a
end)

page.CreateDropdown("Clicking Mode", {"MouseButton1Click","RemoteEventClick"},function(a)
	settings.ClickingMode = a
end)

page.CreateToggle("Always Clicking", function(a)
	settings.AlwaysClicking = a
end)

-- Loops
game:GetService("RunService").Heartbeat:connect(function()
	if settings.AlwaysClicking then
		if settings.ClickingMode == "MouseButton1Click" then
			FireSignalButtonClick()
		else
			RemoteEventClick()
		end
	end
end)
game:GetService("RunService").Heartbeat:connect(function()
	if settings.AttackNearestEnemiez then
		KillClosestBitches()
	end
end)
game:GetService("RunService").Heartbeat:connect(function()
	if settings.AttackSelectedEnemiez then
		local GetTime = (GetClosestBitches2().PrimaryPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / settings.TeleportSpeed
		print(GetTime)
		local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(GetClosestt().PrimaryPart.CFrame.Position)})
		Tween:Play()	
		KillClosestBitches2()
	end
end)
