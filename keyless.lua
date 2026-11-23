local creatorId = game.CreatorId
local communityCreators = {

}

local url = communityCreators[creatorId]
if url then
    print("[Nemesis] Game supported! Loading keyless script...")
    loadstring(game:HttpGet(url))()
else
    warn("[Nemesis] Unsupported game (creator " .. tostring(creatorId) .. ").")
end
