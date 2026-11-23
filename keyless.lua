local creatorId = game.CreatorId
local communityCreators = {
    [115196901]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/throw-a-seed.lua?v=2367dbae93b9',
    [718067209]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/warnetopia-internet-cafe.lua?v=b4731210b0cc',
    [299349841]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/prison-tycoon.lua?v=ab68d9785913',
    [755214094]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/voxel-wars.lua?v=a7f942e65111',
    [1018019223]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/revolver-arena.lua?v=ba5a2dc5bf08',
    [3385385]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/clans-hypershot.lua?v=4b63116e9e61',
}

local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local genv = (getgenv and getgenv()) or _G
genv._console_message_counter = genv._console_message_counter or 3000

local function consolePrint(message, color, image)
    local state = { message = message, color = color, image = image or "", time = os.date("%H:%M:%S") }
    task.spawn(function()
        genv._console_message_counter = genv._console_message_counter + 1
        local umid = tostring(genv._console_message_counter) .. tostring(tick())
        print(umid)
        local index
        for _ = 1, 120 do
            for i, data in ipairs(LogService:GetLogHistory()) do
                if tostring(data.message) == umid then index = i + 1 break end
            end
            if index then break end
            task.wait(0.05)
        end
        if not index then return end
        local conn
        conn = RunService.RenderStepped:Connect(function()
            local ok = pcall(function()
                local master = CoreGui:FindFirstChild("DevConsoleMaster")
                local window = master and master:FindFirstChild("DevConsoleWindow")
                local ui = window and window:FindFirstChild("DevConsoleUI")
                local view = ui and ui:FindFirstChild("MainView")
                local list = view and view:FindFirstChild("ClientLog")
                local row = list and list:FindFirstChild(tostring(index))
                if not row then return end
                local msg, img = row:FindFirstChild("msg"), row:FindFirstChild("image")
                if not msg or not img then return end
                msg.Text = state.time .. " -- " .. state.message
                msg.TextColor3 = state.color
                msg.TextWrapped = true
                img.Image = state.image
                img.ImageColor3 = state.color
            end)
            if not ok then conn:Disconnect() end
        end)
    end)
    return function(newMessage, newColor, newImage)
        state.message = newMessage or state.message
        state.color = newColor or state.color
        state.image = newImage or state.image
    end
end

local NAME = "Nemesis Keyless"
local WHITE, GREEN, RED = Color3.fromRGB(255, 255, 255), Color3.fromRGB(51, 255, 85), Color3.fromRGB(255, 104, 112)
local DONE_IMAGE = "rbxassetid://84271476582826"

local url = communityCreators[creatorId]
if not url then
    consolePrint(string.format("[%s]: Unsupported game (creator %s)", NAME, tostring(creatorId)), RED, "")
    return
end

local startTime = os.clock()
local BAR = 20
local steps = { { 0, "Loading client..." }, { 30, "Connecting to server.." }, { 60, "Finalizing.." } }
local update = consolePrint(string.format("[%s]: [%s] (0%%) - %s", NAME, string.rep(" ", BAR), steps[1][2]), WHITE, "")
local progress, loaded = 0, false
task.spawn(function()
    while progress < 100 do
        if progress >= 69 and loaded then break end
        progress = math.min(progress + math.random(1, 5), loaded and 100 or 95)
        local text = steps[1][2]
        for _, s in ipairs(steps) do if progress >= s[1] then text = s[2] end end
        local filled = math.floor(progress / 100 * BAR)
        update(string.format("[%s]: [%s%s] (%d%%) - %s", NAME, string.rep("#", filled), string.rep(" ", BAR - filled), progress, text))
        local delay = math.random(5, 30) / 100
        if math.random(1, 100) <= 20 then delay = math.random(30, 80) / 100 end
        task.wait(delay)
    end
end)

local ok, source = pcall(function() return game:HttpGet(url) end)
local fn = ok and type(source) == "string" and #source > 0 and loadstring(source)
loaded = true
if not fn then
    progress = 100
    update(string.format("[%s]: [   FAILED    ] - Could not load the script", NAME), RED, "")
    return
end
repeat task.wait(0.05) until progress >= 69
task.wait(0.2)
update(string.format("[%s]: [   SUCCESS   ] - Authenticated in %.10f", NAME, os.clock() - startTime), GREEN, DONE_IMAGE)
fn()
