boardID = 1 --export: Board ID, should be unique
lights = {L1, L2, L3, L4, L5, L6, L7, L8, L9}

function updateLights(light, r, g, b)
    for i = 1, #lights do
        if light == i or light == 0 then
            if lights[i] ~= nil then
                lights[i].setRGBColor(r, g, b)
            end
        end
    end
end

function activateLights(light)
    for i = 1, #lights do
        if light == i or light == 0 then
            if lights[i] ~= nil then
                lights[i].activate()
            end
        end
    end
end

function deactivateLights(light)
    for i = 1, #lights do
        if light == i or light == 0 then
            if lights[i] ~= nil then
                lights[i].deactivate()
            end
        end
    end
end