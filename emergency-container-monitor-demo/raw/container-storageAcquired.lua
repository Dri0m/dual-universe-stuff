c1Resp = c1.getItemsList()

system.print(string.format("C1: %s", c1Resp))
containerReadyCounter = containerReadyCounter + 1

if containerReadyCounter == 4 then
    generateApplyHTML()
end