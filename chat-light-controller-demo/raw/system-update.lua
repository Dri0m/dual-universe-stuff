-- obtain delta
local dt = system.getActionUpdateDeltaTime()

-- set light color if holding lmb
if lightsMode == "idle" then
    updateLights(255, 255, 255)
elseif lightsMode == "alert" then
    animationCounter = animationCounter + dt * 300
    animationCounter = animationCounter % 255
    r, g, b = HSVtoRGB(0, 255, animationCounter)
    updateLights(r, g, b)
elseif lightsMode == "disco" then
    animationCounter = animationCounter + dt * 100
    animationCounter = animationCounter % 255
    r, g, b = HSVtoRGB(animationCounter, 255, 255)
    updateLights(r, g, b)
elseif lightsMode == "super disco" then
    animationCounter = animationCounter + dt * 300
    animationCounter = animationCounter % 255
    r, g, b = HSVtoRGB(animationCounter, 255, 255)
    updateLights(r, g, b)
elseif lightsMode == "hyper disco" then
    animationCounter = animationCounter + dt * 500
    animationCounter = animationCounter % 255
    r, g, b = HSVtoRGB(animationCounter, 255, 255)
    updateLights(r, g, b)
end