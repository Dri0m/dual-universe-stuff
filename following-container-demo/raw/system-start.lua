pitchInput = 0 -- 1, 0, -1
rollInput = 0 -- 1, 0, -1
yawInput = 0 -- 1, 0, -1
followPlayer = false
yawPID = pid.new(1, 0, 5)
--altPID = pid.new(0, 15, 0)
brakeInput = 0

playerDistanceFollow = 100 --export: The construct will start following when player is this far (in meters, > playerDistanceIdle + 1.0)
playerDistanceIdle = 20 --export: The construct will stop following when player is this close (in meters, > 1.0)
hoverHeightFollow = 30 --export: How high does the construct hovers when following
hoverHeightIdle = 4 --export: How high does the construct hovers when idle
targetHeight = hoverHeightIdle
currentHeight = 0