local board = tonumber(message:sub(1, 2))
local light = tonumber(message:sub(4, 4))
local r = tonumber(message:sub(6, 8))
local g = tonumber(message:sub(10, 12))
local b = tonumber(message:sub(14, 16))

if board == boardID or board == 0 then
	updateLights(light, r, g, b)
end