local creatorId = game.CreatorId
local communityCreators = {
    [1018019223]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/revolver-arena.lua?v=ba5a2dc5bf08',
    [3385385]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/clans-hypershot.lua?v=4b63116e9e61',
}

local url = communityCreators[creatorId]
if url then
    print("[Nemesis] Game supported! Loading keyless script...")
    loadstring(game:HttpGet(url))()
else
    warn("[Nemesis] Unsupported game (creator " .. tostring(creatorId) .. ").")
end
