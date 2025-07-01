-- Chazai Egg Hatch with inventory bag visual dupe support
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- Egg Types with Pets
local EggPets = {
	["Common Egg"] = {"Bunny", "Dog", "Golden Lab"},
	["Uncommon Egg"] = {"Black Bunny", "Chicken", "Cat", "Deer"},
	["Rare Egg"] = {"Orange Tabby", "Pig", "Rooster", "Monkey"},
	["Legendary Egg"] = {"Cow", "Silver Monkey", "Sea Otter", "Turtle", "Polar Bear"},
	["Mythical Egg"] = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
	["Bug Egg"] = {"Snail", "Giant Ant", "Caterpillar", "Dragonfly"},
	["Bee Egg"] = {"Bee", "Honey Bee", "Bear Bee", "Petal Bee", "Queen Bee"},
	["Anti Bee Egg"] = {"Wasp", "Tarantula Hawk", "Moth", "Butterfly", "Disco Bee"},
	["Oasis Egg"] = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"},
	["Night Egg"] = {"Mole", "Frog", "Echo Frog", "Nightowl", "Raccoon"}
}

-- GUI Setup
local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0, 250, 0, 50)
label.Position = UDim2.new(0.5, -125, 0, 10)
label.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
label.Text = "✅ Chazai Egg Hatch Loaded"
label.TextColor3 = Color3.new(0, 0, 0)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true

local MainFrame = Instance.new("Frame", gui)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Name = "ChrolloPetspawnXEgg esp"
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "ChrolloPetspawnXEgg esp"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local EggTab = Instance.new("TextButton", MainFrame)
EggTab.Text = "Egg Predictor"
EggTab.Size = UDim2.new(0.5, 0, 0, 30)
EggTab.Position = UDim2.new(0, 0, 0, 30)
EggTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
EggTab.TextColor3 = Color3.new(1, 1, 1)

local PetTab = Instance.new("TextButton", MainFrame)
PetTab.Text = "Pet Spawner"
PetTab.Size = UDim2.new(0.5, 0, 0, 30)
PetTab.Position = UDim2.new(0.5, 0, 0, 30)
PetTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PetTab.TextColor3 = Color3.new(1, 1, 1)

-- Panels
local EggPanel = Instance.new("Frame", MainFrame)
EggPanel.Size = UDim2.new(1, 0, 1, -60)
EggPanel.Position = UDim2.new(0, 0, 0, 60)
EggPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
EggPanel.Visible = true

local PetPanel = Instance.new("Frame", MainFrame)
PetPanel.Size = UDim2.new(1, 0, 1, -60)
PetPanel.Position = UDim2.new(0, 0, 0, 60)
PetPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PetPanel.Visible = false

-- Egg Info
local EggStatus = Instance.new("TextLabel", EggPanel)
EggStatus.Size = UDim2.new(1, -10, 0, 50)
EggStatus.Position = UDim2.new(0, 5, 0, 5)
EggStatus.BackgroundTransparency = 1
EggStatus.TextColor3 = Color3.new(1, 1, 1)
EggStatus.Font = Enum.Font.SourceSans
EggStatus.TextSize = 18
EggStatus.TextWrapped = true
EggStatus.Text = "No Egg Detected"

-- Pet Spawner Inputs
local PetDropdown = Instance.new("TextButton", PetPanel)
PetDropdown.Size = UDim2.new(1, -20, 0, 30)
PetDropdown.Position = UDim2.new(0, 10, 0, 10)
PetDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PetDropdown.TextColor3 = Color3.new(1, 1, 1)
PetDropdown.Text = "Select Pet"

local PetList = {"Queen Bee", "Fennec Fox", "Raccoon", "Butterfly", "Mimic Octopus", "Disco Bee"}
local DropdownFrame = Instance.new("Frame", PetDropdown)
DropdownFrame.Size = UDim2.new(1, 0, 0, 100)
DropdownFrame.Position = UDim2.new(0, 0, 1, 0)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DropdownFrame.Visible = false
DropdownFrame.ClipsDescendants = true

local UIListLayout = Instance.new("UIListLayout", DropdownFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

for _, petName in ipairs(PetList) do
	local Option = Instance.new("TextButton", DropdownFrame)
	Option.Size = UDim2.new(1, 0, 0, 20)
	Option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Option.TextColor3 = Color3.new(1, 1, 1)
	Option.Text = petName
	Option.MouseButton1Click:Connect(function()
		PetDropdown.Text = petName
		DropdownFrame.Visible = false
	end)
end

PetDropdown.MouseButton1Click:Connect(function()
	DropdownFrame.Visible = not DropdownFrame.Visible
end)

local AgeInput = Instance.new("TextBox", PetPanel)
AgeInput.PlaceholderText = "Age"
AgeInput.Size = UDim2.new(1, -20, 0, 30)
AgeInput.Position = UDim2.new(0, 10, 0, 50)
AgeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AgeInput.TextColor3 = Color3.new(1, 1, 1)

local WeightInput = Instance.new("TextBox", PetPanel)
WeightInput.PlaceholderText = "Weight"
WeightInput.Size = UDim2.new(1, -20, 0, 30)
WeightInput.Position = UDim2.new(0, 10, 0, 90)
WeightInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
WeightInput.TextColor3 = Color3.new(1, 1, 1)

local SpawnButton = Instance.new("TextButton", PetPanel)
SpawnButton.Text = "Spawn Pet"
SpawnButton.Size = UDim2.new(1, -20, 0, 30)
SpawnButton.Position = UDim2.new(0, 10, 0, 130)
SpawnButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpawnButton.TextColor3 = Color3.new(1, 1, 1)

local SuccessLabel = Instance.new("TextLabel", PetPanel)
SuccessLabel.Size = UDim2.new(1, -20, 0, 20)
SuccessLabel.Position = UDim2.new(0, 10, 0, 170)
SuccessLabel.BackgroundTransparency = 1
SuccessLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
SuccessLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
SuccessLabel.TextStrokeTransparency = 0
SuccessLabel.Font = Enum.Font.SourceSansBold
SuccessLabel.Text = ""
SuccessLabel.TextSize = 16

SpawnButton.MouseButton1Click:Connect(function()
	local pet = PetDropdown.Text
	local age = AgeInput.Text
	local weight = WeightInput.Text
	if pet and pet ~= "Select Pet" then
		local petModel = Instance.new("TextLabel", Player.PlayerGui.Inventory or gui) -- simulate pet
		petModel.Text = pet .. " | Age: " .. age .. " | Weight: " .. weight .. "kg"
		petModel.Size = UDim2.new(0, 200, 0, 25)
		petModel.TextColor3 = Color3.fromRGB(255, 255, 255)
		petModel.BackgroundTransparency = 1
		SuccessLabel.Text = "✅ Successfully duplicated!"
		task.delay(2, function()
			SuccessLabel.Text = ""
		end)
	end
end)

-- Tab Switching
EggTab.MouseButton1Click:Connect(function()
	EggPanel.Visible = true
	PetPanel.Visible = false
end)

PetTab.MouseButton1Click:Connect(function()
	EggPanel.Visible = false
	PetPanel.Visible = true
end)

-- Egg Detection
local function detectEgg()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find("egg") then
			for eggType, pets in pairs(EggPets) do
				if obj.Name:lower():find(eggType:lower():gsub(" ", "")) then
					local chosen = pets[math.random(1, #pets)]
					EggStatus.Text = "🎯 Detected: " .. eggType .. " → Predicted Pet: " .. chosen
					return
				end
		end
	end
	EggStatus.Text = "No Egg Detected"
end

RunService.RenderStepped:Connect(detectEgg)
