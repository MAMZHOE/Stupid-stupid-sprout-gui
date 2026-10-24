local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlipPhoneUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local function makeCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end

local function makeStroke(instance, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.Transparency = 0.15
    stroke.Parent = instance
end

local function newButton(parent, text, size, pos, color, textColor)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = pos
    button.BackgroundColor3 = color
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.TextColor3 = textColor or Color3.fromRGB(255, 255, 255)
    button.AutoButtonColor = false
    button.BorderSizePixel = 0
    button.Parent = parent
    makeCorner(button, 10)
    return button
end

local function createHotbarButton(parent, label, index)
    local button = newButton(parent, label, UDim2.new(0.32, -8, 1, -8), UDim2.new((index - 1) * 0.34, 4, 0, 4), Color3.fromRGB(55, 60, 68), Color3.fromRGB(255, 255, 255))
    button.Name = label
    return button
end

local phone = Instance.new("Frame")
phone.Name = "Phone"
phone.Size = UDim2.fromOffset(340, 560)
phone.Position = UDim2.new(0.5, -170, 0.5, -280)
phone.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
phone.BorderSizePixel = 0
phone.Parent = screenGui
makeCorner(phone, 24)
makeStroke(phone, Color3.fromRGB(80, 85, 90), 2)

local topGlow = Instance.new("Frame")
topGlow.Size = UDim2.new(1, -24, 0, 18)
topGlow.Position = UDim2.new(0, 12, 0, 10)
topGlow.BackgroundColor3 = Color3.fromRGB(52, 58, 66)
topGlow.BorderSizePixel = 0
topGlow.Parent = phone
makeCorner(topGlow, 12)

local statusBar = Instance.new("TextLabel")
statusBar.Size = UDim2.new(1, -30, 0, 18)
statusBar.Position = UDim2.new(0, 15, 0, 12)
statusBar.BackgroundTransparency = 1
statusBar.Text = "9:41"
statusBar.Font = Enum.Font.GothamBold
statusBar.TextColor3 = Color3.fromRGB(245, 245, 245)
statusBar.TextSize = 12
statusBar.TextXAlignment = Enum.TextXAlignment.Right
statusBar.Parent = phone

local hotbar = Instance.new("Frame")
hotbar.Name = "Hotbar"
hotbar.Size = UDim2.new(1, -24, 0, 42)
hotbar.Position = UDim2.new(0, 12, 0, 28)
hotbar.BackgroundColor3 = Color3.fromRGB(45, 48, 55)
hotbar.BorderSizePixel = 0
hotbar.Parent = phone
makeCorner(hotbar, 12)

local creditsButton = createHotbarButton(hotbar, "Credits", 1)
local scriptsButton = createHotbarButton(hotbar, "Scripts", 2)
local chatButton = createHotbarButton(hotbar, "Chat", 3)

local screenArea = Instance.new("Frame")
screenArea.Name = "ScreenArea"
screenArea.Size = UDim2.new(1, -24, 1, -90)
screenArea.Position = UDim2.new(0, 12, 0, 72)
screenArea.BackgroundColor3 = Color3.fromRGB(22, 27, 30)
screenArea.BorderSizePixel = 0
screenArea.Parent = phone
makeCorner(screenArea, 16)

local creditsFrame = Instance.new("ScrollingFrame")
creditsFrame.Name = "CreditsFrame"
creditsFrame.Size = UDim2.new(1, -14, 1, -14)
creditsFrame.Position = UDim2.new(0, 7, 0, 7)
creditsFrame.BackgroundTransparency = 1
creditsFrame.ScrollBarThickness = 4
creditsFrame.BorderSizePixel = 0
creditsFrame.Visible = false
creditsFrame.Parent = screenArea

local creditsText = Instance.new("TextLabel")
creditsText.Size = UDim2.new(1, 0, 1, 0)
creditsText.BackgroundTransparency = 1
creditsText.Text = "Credits\n\nMamzhoe\nLucretia\nWeird little phone UI\nBuilt for mobile + desktop\n\nThanks for the vibes."
creditsText.TextWrapped = true
creditsText.Font = Enum.Font.Gotham
creditsText.TextSize = 16
creditsText.TextColor3 = Color3.fromRGB(220, 240, 255)
creditsText.TextXAlignment = Enum.TextXAlignment.Left
creditsText.TextYAlignment = Enum.TextYAlignment.Top
creditsText.Parent = creditsFrame

local scriptsFrame = Instance.new("ScrollingFrame")
scriptsFrame.Name = "ScriptsFrame"
scriptsFrame.Size = UDim2.new(1, -14, 1, -14)
scriptsFrame.Position = UDim2.new(0, 7, 0, 7)
scriptsFrame.BackgroundTransparency = 1
scriptsFrame.ScrollBarThickness = 4
scriptsFrame.BorderSizePixel = 0
scriptsFrame.Visible = false
scriptsFrame.Parent = screenArea

local scriptList = {
    "Chat Hook",
    "other scripts"
}

local scriptButtons = {}
for i, name in ipairs(scriptList) do
    local scriptBtn = newButton(scriptsFrame, name, UDim2.new(1, -10, 0, 36), UDim2.new(0, 5, 0, (i - 1) * 42), Color3.fromRGB(56, 66, 74), Color3.fromRGB(255, 255, 255))
    scriptBtn.Name = "Boxten Sex GUI by Team Noxious_" .. name
    scriptBtn.TextXAlignment = Enum.TextXAlignment.Left
    scriptBtn.TextTransparency = 0
    scriptBtn.TextPadding = Vector2.new(12, 0)
    scriptBtn.Parent = scriptsFrame
    table.insert(scriptButtons, scriptBtn)
end
local otherScriptsLinks = {
    {
        Name = "Boxten Sex GUI by Team Noxious",
        Link = "loadstring(game:HttpGet("https://raw.githubusercontent.com/Team-Noxious/Roblox/refs/heads/main/Loader.lua"))({load = "Boxten Sex GUI"})"
    },
    {
        Name = "Good Riddance",
        Link = "getgenv().element_load_delay = 0.1 -- seconds
getgenv().extensionload = false -- put to true if you would like to automatically load all your installed extensions
loadstring(game:HttpGet("https://raw.githubusercontent.com/riddance-club/script/refs/heads/main/loader.lua"))()"
    }
}

local linkStatus = Instance.new("TextLabel")
linkStatus.Name = "LinkStatus"
linkStatus.Size = UDim2.new(1, -20, 0, 20)
linkStatus.Position = UDim2.new(0, 10, 1, -28)
linkStatus.BackgroundTransparency = 1
linkStatus.Text = ""
linkStatus.TextColor3 = Color3.fromRGB(120, 220, 140)
linkStatus.Font = Enum.Font.Gotham
linkStatus.TextSize = 12
linkStatus.Parent = scriptsFrame

local linkSectionTitle = Instance.new("TextLabel")
linkSectionTitle.Name = "OtherScriptsTitle"
linkSectionTitle.Size = UDim2.new(1, -20, 0, 20)
linkSectionTitle.Position = UDim2.new(0, 10, 0, 10)
linkSectionTitle.BackgroundTransparency = 1
linkSectionTitle.Text = "Other Scripts"
linkSectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
linkSectionTitle.Font = Enum.Font.GothamBold
linkSectionTitle.TextSize = 15
linkSectionTitle.Parent = scriptsFrame

local linkStartY = 34

for i, item in ipairs(otherScriptsLinks) do
    local btn = Instance.new("TextButton")
    btn.Name = "Copy_" .. item.Name
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Position = UDim2.new(0, 5, 0, linkStartY + ((i - 1) * 42))
    btn.BackgroundColor3 = Color3.fromRGB(80, 88, 100)
    btn.Text = "Copy: " .. item.Name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = scriptsFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        setclipboard(item.Link)
        linkStatus.Text = "Copied: " .. item.Name
        task.delay(1.5, function()
            linkStatus.Text = ""
        end)
    end)
end

local chatFrame = Instance.new("Frame")
chatFrame.Name = "ChatFrame"
chatFrame.Size = UDim2.new(1, -14, 1, -14)
chatFrame.Position = UDim2.new(0, 7, 0, 7)
chatFrame.BackgroundTransparency = 1
chatFrame.Visible = true
chatFrame.Parent = screenArea

local chatLog = Instance.new("TextLabel")
chatLog.Size = UDim2.new(1, 0, 1, -52)
chatLog.Position = UDim2.new(0, 0, 0, 0)
chatLog.BackgroundTransparency = 1
chatLog.Text = "Local chat\n\nType a message below."
chatLog.TextWrapped = true
chatLog.Font = Enum.Font.Gotham
chatLog.TextSize = 15
chatLog.TextColor3 = Color3.fromRGB(235, 245, 255)
chatLog.TextXAlignment = Enum.TextXAlignment.Left
chatLog.TextYAlignment = Enum.TextYAlignment.Top
chatLog.Parent = chatFrame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -68, 0, 34)
inputBox.Position = UDim2.new(0, 0, 1, -38)
inputBox.BackgroundColor3 = Color3.fromRGB(45, 54, 62)
inputBox.Text = ""
inputBox.PlaceholderText = "Type here..."
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.PlaceholderColor3 = Color3.fromRGB(170, 180, 190)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 14
inputBox.ClearTextOnFocus = false
inputBox.BorderSizePixel = 0
inputBox.Parent = chatFrame
makeCorner(inputBox, 10)
makeStroke(inputBox, Color3.fromRGB(90, 100, 110), 1)

local sendButton = newButton(chatFrame, "Send", UDim2.new(0, 54, 0, 30), UDim2.new(1, -60, 1, -36), Color3.fromRGB(72, 144, 106), Color3.fromRGB(255, 255, 255))

local keyboardMode = 1
local currentTab = "Chat"

local function setTab(tab)
    currentTab = tab
    creditsFrame.Visible = (tab == "Credits")
    scriptsFrame.Visible = (tab == "Scripts")
    chatFrame.Visible = (tab == "Chat")

    creditsButton.BackgroundColor3 = tab == "Credits" and Color3.fromRGB(95, 120, 140) or Color3.fromRGB(55, 60, 68)
    scriptsButton.BackgroundColor3 = tab == "Scripts" and Color3.fromRGB(95, 120, 140) or Color3.fromRGB(55, 60, 68)
    chatButton.BackgroundColor3 = tab == "Chat" and Color3.fromRGB(95, 120, 140) or Color3.fromRGB(55, 60, 68)

    if tab == "Chat" and keyboardMode == 1 then
        task.delay(0.05, function()
            if inputBox and inputBox.Parent then
                inputBox:CaptureFocus()
            end
        end)
    end
end

local function appendChatLine(text)
    local currentText = chatLog.Text
    if currentText == "Local chat\n\nType a message below." then
        chatLog.Text = "You: " .. text
    else
        chatLog.Text = currentText .. "\nYou: " .. text
    end
end

creditsButton.MouseButton1Click:Connect(function()
    setTab("Credits")
end)

scriptsButton.MouseButton1Click:Connect(function()
    setTab("Scripts")
end)

chatButton.MouseButton1Click:Connect(function()
    setTab("Chat")
end)

sendButton.MouseButton1Click:Connect(function()
    if inputBox.Text ~= "" then
        appendChatLine(inputBox.Text)
        inputBox.Text = ""
        inputBox:CaptureFocus()
    end
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and inputBox.Text ~= "" then
        appendChatLine(inputBox.Text)
        inputBox.Text = ""
        task.delay(0.05, function()
            inputBox:CaptureFocus()
        end)
    end
end)

phone.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if currentTab == "Chat" and keyboardMode == 1 then
            task.delay(0.05, function()
                if inputBox and inputBox.Parent then
                    inputBox:CaptureFocus()
                end
            end)
        end
    end
end)

for _, btn in ipairs(scriptButtons) do
    btn.MouseButton1Click:Connect(function()
        appendChatLine("Opened script: " .. btn.Text)
        setTab("Chat")
    end)
end

setTab("Chat")

local draggable = false
local dragOffset = Vector2.new()

phone.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggable = true
        dragOffset = input.Position - phone.AbsolutePosition
    end
end)

phone.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggable = false
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if draggable and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if input.Position then
            local pos = input.Position - dragOffset
            phone.Position = UDim2.new(pos.X / game.Workspace.CurrentCamera.ViewportSize.X, 0, pos.Y / game.Workspace.CurrentCamera.ViewportSize.Y, 0)
        end
    end
end)

local function clampPhone()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    local x = math.clamp(phone.AbsolutePosition.X, 0, viewport.X - phone.AbsoluteSize.X)
    local y = math.clamp(phone.AbsolutePosition.Y, 0, viewport.Y - phone.AbsoluteSize.Y)
    phone.Position = UDim2.new(x / viewport.X, 0, y / viewport.Y, 0)
end

local function updatePhone()
    clampPhone()
end

game:GetService("RunService").RenderStepped:Connect(function()
    updatePhone()
end)

print("Flip phone loaded with draggable screen, hotbar tabs, and keyboard capture.")
