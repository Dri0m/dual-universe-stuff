local pitchSpeedFactor = 2
local yawSpeedFactor = 2 
local rollSpeedFactor = 2 


local torqueFactor = 4 -- Force factor applied to reach rotationSpeed<br>(higher value may be unstable)<br>Valid values: Superior or equal to 0.01                             
local brakeFactor = 3
local followPitch = 45 -- Construct tilts forward in order to mvoe forward, this is constant atm

-- validate params
playerDistanceFollow = math.max(playerDistanceFollow, playerDistanceIdle + 1)
playerDistanceIdle = math.max(playerDistanceIdle, 1)

-- Axis
local worldVertical = vec3(core.getWorldVertical()) -- along gravity
local constructUp = vec3(core.getConstructWorldOrientationUp())
local constructForward = vec3(core.getConstructWorldOrientationForward())
local constructRight = vec3(core.getConstructWorldOrientationRight())
local constructVelocity = vec3(core.getWorldVelocity())
local constructVelocityDir = vec3(core.getWorldVelocity()):normalize()
local currentRollDeg = getRoll(worldVertical, constructForward, constructRight)
local currentRollDegAbs = math.abs(currentRollDeg)
local currentRollDegSign = utils.sign(currentRollDeg)
local playerRelativePosition = vec3(unit.getMasterPlayerRelativePosition())

-- turn towards player
local flatForward = constructForward:project_on_plane(worldVertical)
local flatPlayerPos = playerRelativePosition:project_on_plane(worldVertical)
local playerCross = vec3(flatForward:normalize()):cross(flatPlayerPos:normalize())
playerCross.z = playerCross.z --/ 3.15
yawInput = math.abs(playerCross.z) * utils.sign(playerCross.z) * utils.sign(-worldVertical.z) --cross.z * powerModifier + utils.sign(cross.z) * powerUnModifier

-- follow player
local playerDistance = vec3:new(0,0,0):dist(flatPlayerPos)
if playerDistance > playerDistanceFollow then
    followPlayer = true
elseif playerDistance < playerDistanceIdle then
    followPlayer = false
end
    
    
local pitch = gyro.getPitch()
if followPlayer then
    targetHeight = hoverHeightFollow
    -- TODO use PID maybe
    --altPID:inject(hoverHeightFollow)
    --Nav.axisCommandManager:setTargetGroundAltitude(altPID:get())
    pitch = pitch + followPitch -- hack: modify gyro's output to trick the ship into stabilizing in a specific direction
else
    targetHeight = hoverHeightIdle
    -- TODO use PID maybe
    --altPID:inject(hoverHeightIdle)
    --Nav.axisCommandManager:setTargetGroundAltitude(altPID:get())
end

if targetHeight - currentHeight > 0.0001 then
    currentHeight = currentHeight + 0.05
elseif currentHeight - targetHeight > 0.0001 then
    currentHeight = currentHeight - 0.05
end
Nav.axisCommandManager:setTargetGroundAltitude(currentHeight)

-- adjust pitch
pitchInput = (math.abs(pitch) / 180) * utils.sign(-pitch) --(-pitch / 180) * powerModifier + utils.sign(-pitch) * powerUnModifier

-- stabilize roll
local roll = gyro.getRoll()
rollInput = (math.abs(roll) / 180) * utils.sign(roll) --(roll / 180) * powerModifier + utils.sign(roll) * powerUnModifier

-- Rotation
local constructAngularVelocity = vec3(core.getWorldAngularVelocity())

-- final inputs
local finalPitchInput = pitchInput
local finalRollInput = rollInput

yawPID:inject(yawInput)
local finalYawInput = yawPID:get()

local targetAngularVelocity = finalPitchInput * pitchSpeedFactor * constructRight 
+ finalRollInput * rollSpeedFactor * constructForward
+ finalYawInput * yawSpeedFactor * constructUp

-- Rotation
local angularAcceleration = torqueFactor * (targetAngularVelocity - constructAngularVelocity)
local airAcceleration = vec3(core.getWorldAirFrictionAngularAcceleration())
angularAcceleration = angularAcceleration - airAcceleration -- Try to compensate air friction                                            
Nav:setEngineTorqueCommand('torque', angularAcceleration, true)

-- braking
local flatVelocity = constructVelocity:project_on_plane(worldVertical)
local flatWPalyerPos = vec3(system.getPlayerWorldPos(unit.getMasterPlayerId())):project_on_plane(worldVertical)
local playerVelocityAngle = flatVelocity:angle_between(flatPlayerPos)

if flatVelocity:len() > 5 then
    brakeInput = playerVelocityAngle / 3.142
else
    brakeInput = brakeInput * 0.1
end

if followPlayer then
    Nav:setEngineForceCommand('brake', -constructVelocity * brakeInput * brakeFactor)
else
    Nav:setEngineForceCommand('brake', -constructVelocityDir * 1000)
end