-- Put this file in the same folder as your phone UI:
-- /interactives/sprout_chat_handshake.lua
--
-- Server script: ServerScriptService/SproutChatServer.lua
-- Client script: StarterPlayerScripts/SproutChatClient.lua

-- SERVER SCRIPT
--[[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HANDSHAKE_KEY = "sprouts sexy gui"

local event = ReplicatedStorage:FindFirstChild("SproutChatEvent") or Instance.new("RemoteEvent")
event.Name = "SproutChatEvent"
event.Parent = ReplicatedStorage

event.OnServerEvent:Connect(function(player, payload)
    if not payload or type(payload) ~= "table" then
        return
    end

    if payload.type == "handshake" then
        if payload.key == HANDSHAKE_KEY then
            event:FireClient(player, {
                type = "handshake_ok",
                key = HANDSHAKE_KEY,
                player = player.Name
            })
        else
            event:FireClient(player, {
                type = "handshake_failed",
                reason = "invalid key"
            })
        end
        return
    end

    if payload.type == "message" then
        if payload.auth ~= HANDSHAKE_KEY then
            return
        end

        local text = tostring(payload.text or "")
        if text == "" then return end

        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            event:FireClient(otherPlayer, {
                type = "chat",
                sender = player.Name,
                text = text
            })
        end
    end
end)
--]]

-- CLIENT SCRIPT
--[[
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local HANDSHAKE_KEY = "sprouts sexy gui"

local event = ReplicatedStorage:WaitForChild("SproutChatEvent")
local gui = Instance.new("ScreenGui")
gui.Name = "SproutChatUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, -210, 0.7, -130)
frame.BackgroundColor3 = Color3.fromRGB(18, 20, 24)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Sprout Chat"
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local chatLog = Instance.new("TextLabel")
chatLog.Size = UDim2.new(1, -20, 1, -100)
chatLog.Position = UDim2.new(0, 10, 0, 40)
chatLog.BackgroundColor3 = Color3.fromRGB(28, 32, 36)
chatLog.BorderSizePixel = 0
chatLog.Text = "Awaiting handshake...\n"
chatLog.TextWrapped = true
chatLog.TextXAlignment = Enum.TextXAlignment.Left
chatLog.TextYAlignment = Enum.TextYAlignment.Top
chatLog.TextColor3 = Color3.fromRGB(230, 230, 230)
chatLog.Font = Enum.Font.Gotham
chatLog.TextSize = 14
chatLog.Parent = frame

local field = Instance.new("TextBox")
field.Size = UDim2.new(1, -100, 0, 34)
field.Position = UDim2.new(0, 10, 1, -44)
field.BackgroundColor3 = Color3.fromRGB(44, 48, 54)
field.Text = ""
field.PlaceholderText = "Type message..."
field.TextColor3 = Color3.fromRGB(255, 255, 255)
field.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
field.BorderSizePixel = 0
field.Font = Enum.Font.Gotham
field.TextSize = 14
field.Parent = frame

local fieldCorner = Instance.new("UICorner")
fieldCorner.CornerRadius = UDim.new(0, 10)
fieldCorner.Parent = field

local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(0, 70, 0, 34)
sendBtn.Position = UDim2.new(1, -80, 1, -44)
sendBtn.BackgroundColor3 = Color3.fromRGB(79, 156, 101)
sendBtn.Text = "Send"
sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendBtn.Font = Enum.Font.GothamBold
sendBtn.TextSize = 14
sendBtn.BorderSizePixel = 0
sendBtn.Parent = frame

local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 10)
sendCorner.Parent = sendBtn

local handshakeComplete = false

local function appendLog(text)
    chatLog.Text = chatLog.Text .. text .. "\n"
end

local function sendHandshake()
    event:FireServer({
        type = "handshake",
        key = HANDSHAKE_KEY
    })
end

local function sendChatMessage(text)
    if not handshakeComplete then
        appendLog("Handshake not complete.")
        return
    end

    event:FireServer({
        type = "message",
        text = text,
        auth = HANDSHAKE_KEY
    })
end

event.OnClientEvent:Connect(function(payload)
    if payload.type == "handshake_ok" then
        handshakeComplete = true
        appendLog("Handshake accepted by server.")
        return
    end

    if payload.type == "handshake_failed" then
        appendLog("Handshake failed: " .. tostring(payload.reason or "unknown"))
        return
    end

    if payload.type == "chat" then
        appendLog(payload.sender .. ": " .. payload.text)
    end
end)

sendBtn.MouseButton1Click:Connect(function()
    local text = field.Text
    if text == "" then return end

    field.Text = ""
    sendChatMessage(text)
end)

field.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = field.Text
        if text == "" then return end

        field.Text = ""
        sendChatMessage(text)
    end
end)

sendHandshake()
--]]

-- This uses the shared key:
-- "sprouts sexy gui"
--
-- To connect with trusted scripts, both the GUI and the script must use the exact same key.
-- If the key does not match, the connection is rejected.
