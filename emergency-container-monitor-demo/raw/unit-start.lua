-- describe your containers, e.g. their location
local c1Name = "Lobby"
local c2Name = "Bridge"
local c3Name = "Core Room"
local c4Name = "Atmo Tanks"

-- use item class, not item name, case sensitive!
local demands = {
    CalciumScrap=500,
    LithiumScrap=200,
    CobaltScrap=50,
}

-- do not modify below

c1.acquireStorage()
c2.acquireStorage()
c3.acquireStorage()
c4.acquireStorage()

containerReadyCounter = 0
c1Resp = nil
c2Resp = nil
c3Resp = nil
c4Resp = nil


local function makeDeltaList()
    local result = {}
    for k,v in pairs(demands) do
        result[k] = v
    end
    return result
end

local function missingItemsToHTML(data)
    local result = ""
    for k, v in pairs(data) do
        if v > 0 then
            result = result .. string.format("%s: %d<br>", k, v)
        end
    end
    
    -- i don't know what 'single responsibility' is mate
    local class = "ok"
    if result ~= "" then
        class = "nok"
        result = "Missing items!<br>" .. result
    end
    if result == "" then
        result = "All OK!<br>"
    end
    return result, class
    
end

local function computeDeltaList(resp)
    deltaList = makeDeltaList()
    local data = json.decode(resp)
    
    for i,item in ipairs(data) do
        local itemClass = item["class"]
        local itemQuanity = item["quantity"]
        
        for demandClass, demandQuantity in pairs(demands) do
            if itemClass == demandClass then
                deltaList[itemClass] = demandQuantity - itemQuanity
            end
        end
    end
    
    return deltaList
end

function generateApplyHTML()
    local c1Items, c1Class = missingItemsToHTML(computeDeltaList(c1Resp))
    local c2Items, c2Class = missingItemsToHTML(computeDeltaList(c2Resp))
    local c3Items, c3Class = missingItemsToHTML(computeDeltaList(c3Resp))
    local c4Items, c4Class = missingItemsToHTML(computeDeltaList(c4Resp))
    
    local c1String = string.format("<td class='%s'>Container A - %s<br>%s</td>", c1Class, c1Name, c1Items)
    local c2String = string.format("<td class='%s'>Container B - %s<br>%s</td>", c2Class, c2Name, c2Items)
    local c3String = string.format("<td class='%s'>Container C - %s<br>%s</td>", c3Class, c3Name, c3Items)
    local c4String = string.format("<td class='%s'>Container D - %s<br>%s</td>", c4Class, c4Name, c4Items)
    
    screen.setHTML([[
    <style type="text/css">
        table {
            border-collapse: collapse;
            border-spacing: 0;
            border: 4px solid grey;
            text-transform: uppercase;
            width: 100%;
            height: 100%;
        }

        tr,
        td,
        th {
            border: 2px solid white;
            vertical-align: center;
            text-align: center;
            font-size: 150%;
            font-family: monospace;
        }

        .ok {
            background-color: green;
            color: white;
            text-transform: none;
            font-family: monospace;
            text-transform: none;
            font-weight: bold;
        }

        .nok {
            background-color: red;
            color: white;
            font-family: monospace;
            text-transform: none;
            font-weight: bold;
        }
    </style>
    ]] .. string.format([[
    <table>
        <tbody>
            <tr>
                %s %s
            </tr>
            <tr>
                %s %s
            </tr>
        </tbody>
    </table>
    ]], c1String, c2String, c3String, c4String))
end