local gradientSVG = [[
    <svg class="bootstrap" viewBox="0 0 1920 1080" style="width:100%; height:100%" preserveAspectRatio="none">
        <defs>
            <linearGradient id="rainbow">
                <stop offset="0%" stop-color="#ff0000" />
                <stop offset="17%" stop-color="#ffff00" />
                <stop offset="34%" stop-color="#00ff00" />
                <stop offset="50%" stop-color="#00ffff" />
                <stop offset="66%" stop-color="#0000ff" />
                <stop offset="82%" stop-color="#ff00ff" />
                <stop offset="100%" stop-color="#ff0000" />
            </linearGradient>
            <linearGradient id="black" gradientTransform="rotate(90)">
                <stop offset="0.5" stop-color="black" stop-opacity="0" />
                <stop offset="1" stop-color="black" stop-opacity="1" />
            </linearGradient>
            <linearGradient id="white" gradientTransform="rotate(90)">
                <stop offset="0" stop-color="white" stop-opacity="1" />
                <stop offset="0.5" stop-color="white" stop-opacity="0" />
            </linearGradient>
        </defs>
        <rect width="100%" height="100%" fill="url(#rainbow)" />
        <rect width="100%" height="100%" fill="url(#black)" />
        <rect width="100%" height="100%" fill="url(#white)" />
    </svg>
]]

screen.setHTML(gradientSVG)

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