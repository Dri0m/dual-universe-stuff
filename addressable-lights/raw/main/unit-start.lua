-- modify or link more counters according to the amount of aux boards you have
function toggleAuxBoards()
    counter1.next()
    counter1.next()
    counter1.next()
end

-- boardID indexed from 1 to 99, however many you configured
-- lightID indexed from 1 to 9, if some lights are missing, the aux boards skip them
-- send boardID=0 to address all boards
-- send lightID=0 to address all lights
function sendRGB(boardID, lightID, r, g, b)
    local data = string.format("%02d|%d|%03d|%03d|%03d", boardID, lightID, math.floor(r), math.floor(g), math.floor(b))
    emitter.send("rgb-SecretCode123", data)
end

toggleAuxBoards()