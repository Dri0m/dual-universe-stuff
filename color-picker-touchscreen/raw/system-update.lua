-- obtain mouse state
local mouseX = screen.getMouseX()
local mouseY = screen.getMouseY()
local mouseState = screen.getMouseState()

-- convert mouse coordinates to HSV
local h = mouseX * 255
local s = 255
local v = 255

if mouseY < 0.5 then
    s = (mouseY*2) * 255
end

if mouseY > 0.5 then
    v = (1 - ((mouseY-0.5)*2)) * 255
end

-- convert HSV to RGB which is what the lights accept
r, g, b = HSVtoRGB(h, s, v)

-- set light color if holding lmb
if mouseState == 1 then
	light.setRGBColor(r,g,b)
end


-- print stuff to console
--system.print(string.format("x: %.1f, y: %.1f, state: %d", mouseX, mouseY, mouseState))
--system.print(string.format("H: %.1f, S: %.1f, V: %.1f", h, s, v))
--system.print(string.format("R: %.1f, G: %.1f, B: %.1f", r, g, b))