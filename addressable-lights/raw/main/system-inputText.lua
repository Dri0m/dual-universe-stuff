local boardID = tonumber(text:sub(1,2))
local lightID = tonumber(text:sub(4,4))
local r = tonumber(text:sub(6,8))
local g = tonumber(text:sub(10,12))
local b = tonumber(text:sub(14,16))

sendRGB(boardID, lightID, r, g,  b)