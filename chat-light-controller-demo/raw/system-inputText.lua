if text == "idle" or text == "alert" or text == "disco" or text == "super disco" or text == "hyper disco" then
    system.print(string.format("setting lights mode to '%s'", text))
    lightsMode = text
    animationCounter = 0
    updateLights(255, 255, 255)
elseif text == "on" then
    system.print("activating lights")
    activateLights()
elseif text == "off" then
    system.print("deactivating lights")
    deactivateLights()
else
    system.print(string.format("unknown command '%s'", text))
end