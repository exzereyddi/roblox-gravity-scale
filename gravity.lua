local gravityScales = {0.5, 1, 2}
local defaultGravity = 196.2

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GravityControlGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true
frame.ZIndex = 1
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 30)
label.Position = UDim2.new(0, 0, 0, 0)
label.Text = "Slowmo Control"
label.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.ZIndex = 2
label.Parent = frame

local function updateGravity(gravityScale)
    game.Workspace.Gravity = defaultGravity * gravityScale
end

local buttonHeight = 30
local buttonSpacing = 5
local buttonsYOffset = 35

for i, scale in ipairs(gravityScales) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, buttonHeight)
    button.Position = UDim2.new(0, 5, 0, buttonsYOffset + (i - 1) * (buttonHeight + buttonSpacing))
    button.Text = "Slowmo x" .. scale
    button.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.ZIndex = 3
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        updateGravity(scale)
    end)
end

local function unloadScript()
    screenGui:Destroy()  -- Уничтожаем GUI
    script:Destroy()      -- Уничтожаем сам скрипт
end

local unloadButton = Instance.new("TextButton")
unloadButton.Size = UDim2.new(1, 15, 0, 20) -- Размер кнопки
unloadButton.Position = UDim2.new(0, 200, 0, frame.Size.Y.Offset) -- Позиция под кнопками
unloadButton.Text = "Unload"
unloadButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
unloadButton.TextColor3 = Color3.new(1, 1, 1)
unloadButton.TextScaled = true
unloadButton.Parent = frame

unloadButton.MouseButton1Click:Connect(unloadScript)
local totalButtonHeight = #gravityScales * (buttonHeight + buttonSpacing) - buttonSpacing
local frameHeight = 10 + totalButtonHeight + buttonsYOffset
frame.Size = UDim2.new(0, 200, 0, frameHeight)

local function toggleGUI()
    screenGui.Enabled = not screenGui.Enabled
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Home then
        toggleGUI()
    end
end)