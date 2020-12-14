system.print("hi")
-- defitions
lightsMode = "idle"

lights = {l1, l2, l3, l4, l5, l6, l7, l8, l9, l10}

function updateLights(r, g, b)
    for i = 1, #lights do
        if lights[i] ~= nil then
            lights[i].setRGBColor(r, g, b)
        end
    end
end

function activateLights()
    for i = 1, #lights do
        if lights[i] ~= nil then
            lights[i].activate()
        end
    end
end

function deactivateLights()
    for i = 1, #lights do
        if lights[i] ~= nil then
            lights[i].deactivate()
        end
    end
end


-- https://stackoverflow.com/a/14733008
function HSVtoRGB(h, s, v)
    local r, g, b
    
    h = math.floor(h)
    s = math.floor(s)
    v = math.floor(v)

    if s <= 0 then
        r = v
        g = v
        b = v
        return r, g, b
    end

    local region = math.floor(h / 43)
    local remainder = math.floor((h - (region*43)) * 6)
    
    local p = (v * (255 - s)) >> 8
    local q = (v * (255 - ((s * remainder) >> 8))) >> 8
    local t = (v * (255 - ((s * (255 - remainder)) >> 8))) >> 8
    
    if region == 0 then
        r = v
        g = t
        b = p
    elseif region == 1 then
        r = q
        g = v
        b = p
    elseif region == 2 then
        r = p
        g = v
        b = t
    elseif region == 3 then
        r = p
        g = q
        b = v
    elseif region == 4 then
        r = t
        g = p
        b = v
    else
        r = v
        g = p
        b = q
    end
    
    return r, g, b
end

