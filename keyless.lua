local creatorId = game.CreatorId
local communityCreators = {
    [3385385]    = 'https://raw.githubusercontent.com/x4zu/KeylessScript/main/scripts/clans-hypershot.lua?v=9aef8f35c81e',
}

local url = communityCreators[creatorId]
if url then
    print("[Nemesis] Game supported! Loading keyless script...")
    loadstring(game:HttpGet(url))()
else
    warn("[Nemesis] Unsupported game (creator " .. tostring(creatorId) .. ").")
end
