local worldVertical = vec3(core.getWorldVertical()) -- along gravity
local playerRelativePosition = vec3(unit.getMasterPlayerRelativePosition())


local flatPlayerDepth = playerRelativePosition:project_on(-worldVertical):len()
local flatPlayerPosV = playerRelativePosition:project_on_plane(worldVertical)
local infoStr = "DEPTH: " .. string.format("%4.1f", flatPlayerDepth) .. "m"
local depthStr = "DIST: " .. string.format("%4.1f", vec3:new(0,0,0):dist(flatPlayerPosV)) .. "m"
local statusStr = ""
if followPlayer then
    statusStr = "STATUS: MOVING"
else
    statusStr = "STATUS: IDLE"
end
    
system.print(infoStr .. ", " .. depthStr .. ", " .. statusStr)