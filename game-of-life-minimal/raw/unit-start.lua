-- game of life implementation written by Dri0m

local cellsColumns = 40
local cellsRows = 23

local stepDuration = 0.2
local initialAlive = 0.5

local backgroundColor = "rgb(0,0,0)"
local cellColor = "rgb(255,255,255)"

-- do not modify below

local screenWidth = 1920
local screenHeight = 1080
local cellWidth = math.floor(screenWidth/cellsColumns)
local cellHeight = math.floor(screenHeight/cellsRows)

local svg_bgr_rect = [[<rect x=0 y=0 width="100%" height="100%" fill="]] .. backgroundColor .. [["/>]]
local svg_cell = [[<use x=%s y=%s xlink:href="#cell"/>]]
local defs = [[<defs>]] .. string.format([[<rect id="cell" width=%s height=%s fill="%s"/>]], cellWidth, cellHeight, cellColor) ..[[</defs>]]


-- utils --

local function randomBool()
    if math.random() < initialAlive then
        return true
    end
    return false
end

-----------

-- simulation --

local function generateRandomWorld(width, height)
    local result = {}
    for x=1, width do
        local column = {}
        for y=1, height do
            table.insert(column, randomBool())
        end
        table.insert(result, column)
    end
    return result
end

local function getNeighbour(data, nx, ny)
    if nx < 1 or nx > cellsColumns or ny < 1 or ny > cellsRows then
        return false
    end
    return data[nx][ny]
end

local function countLivingNeighbours(data, x, y)
    local counter = 0
    if getNeighbour(data, x-1, y-1) then
        counter = counter + 1
    end
    if getNeighbour(data, x, y-1) then
        counter = counter + 1
    end
    if getNeighbour(data, x+1, y-1) then
        counter = counter + 1
    end
    if getNeighbour(data, x-1, y) then
        counter = counter + 1
    end
    if getNeighbour(data, x+1, y) then
        counter = counter + 1
    end
    if getNeighbour(data, x-1, y+1) then
        counter = counter + 1
    end
    if getNeighbour(data, x, y+1) then
        counter = counter + 1
    end
    if getNeighbour(data, x+1, y+1) then
        counter = counter + 1
    end
    return counter
end

function DoStep(data)
    local result = {}
    for x=1, cellsColumns do
        local column = {}
        for y=1, cellsRows do
            local neighbours = countLivingNeighbours(data, x, y)
            if data[x][y] and (neighbours == 2 or neighbours == 3) then
                table.insert(column, true)
            elseif not data[x][y] and neighbours == 3 then
                table.insert(column, true)
            else
                table.insert(column, false)
            end
        end
        table.insert(result, column)
    end
    return result
end

----------------

-- rendering --

local function FormatCell(x, y)
    return string.format(svg_cell, math.floor((x-1)*cellWidth), math.floor((y-1)*cellHeight))
end

function WorldToSVG(data)
    local svg = svg_bgr_rect .. defs
    for x=1, cellsColumns do
        for y=1, cellsRows do
            if data[x][y] then
            	svg = svg .. FormatCell(x, y, data[x][y])
            end
        end
    end
    return svg
end

---------------

World = generateRandomWorld(cellsColumns, cellsRows)
unit.setTimer("step", stepDuration)