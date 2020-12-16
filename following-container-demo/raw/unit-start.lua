system.print("Following Container Example by Dri0m (_Dri0m)")

-- Nav setup
Nav = Navigator.new(system, core, unit)
Nav.axisCommandManager:setupCustomTargetSpeedRanges(axisCommandId.longitudinal, {1000, 5000, 10000, 20000, 30000})
Nav.axisCommandManager:setTargetGroundAltitude(2)

unit.setTimer("infoPrinter", 1.0)