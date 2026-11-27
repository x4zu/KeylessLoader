local creatorId = game.CreatorId
local communityCreators = {
    [1084602234]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/100-miles-down-the-river.lua?v=f21ad01f480c',
    [406621119]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/barber-empire.lua?v=03201b8e34bd',
    [87770135]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/wings-fight.lua?v=9a0f9517475e',
    [115196901]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/throw-a-seed.lua?v=2367dbae93b9',
    [718067209]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/warnetopia-internet-cafe.lua?v=b4731210b0cc',
    [299349841]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/prison-tycoon.lua?v=ab68d9785913',
    [755214094]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/voxel-wars.lua?v=a7f942e65111',
    [1018019223]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/revolver-arena.lua?v=ba5a2dc5bf08',
    [3385385]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/clans-hypershot.lua?v=4b63116e9e61',
}

local function console()
    local ok, C = pcall(function() return loadstring(game:HttpGet("https://www.nemesishub.xyz/console.lua"))() end)
    return ok and type(C) == "table" and C or nil
end

local C = console()
local url = communityCreators[creatorId]
if not url then
    if C then C.line(string.format("[%s]: Unsupported game (creator %s)", C.gameName(), tostring(creatorId)), C.RED) end
    return
end

local bar = C and C.bar(C.gameName()) or nil
local ok, source = pcall(function() return game:HttpGet(url) end)
local fn = ok and type(source) == "string" and #source > 0 and loadstring(source)
if not fn then
    if bar then bar.fail("Could not load the script") end
    return
end
if bar then bar.done() end
fn()
