local creatorId = game.CreatorId
local communityCreators = {
    [115196901]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/throw-a-seed.lua?v=2367dbae93b9',
    [718067209]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/warnetopia-internet-cafe.lua?v=b4731210b0cc',
    [299349841]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/prison-tycoon.lua?v=ab68d9785913',
    [755214094]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/voxel-wars.lua?v=a7f942e65111',
    [1018019223]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/revolver-arena.lua?v=ba5a2dc5bf08',
    [3385385]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/clans-hypershot.lua?v=4b63116e9e61',
}
local url = communityCreators[creatorId]
if not url then
    warn("[Nemesis] Unsupported game (creator " .. tostring(creatorId) .. ").")
    return
end
local ok, source = pcall(function() return game:HttpGet(url) end)
local fn = ok and type(source) == "string" and #source > 0 and loadstring(source)
local okC, C = pcall(function() return loadstring(game:HttpGet("https://www.nemesishub.xyz/console.lua"))() end)
local bar = (okC and type(C) == "table" and C.bar) and C.bar("Nemesis Keyless") or nil
if not fn then
    if bar then bar.fail("Could not load the script") else warn("[Nemesis] Could not load the keyless script.") end
    return
end
if bar then bar.done() else print("[Nemesis] Keyless script loaded.") end
fn()
