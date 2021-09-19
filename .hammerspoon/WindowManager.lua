local hyperKey = {"cmd", "alt", "ctrl"}
local gridWidth = 24
local gridHeight = 12
local top = 0
local left = 0
local thirdWidth = gridWidth / 3
local twoThirdsWidth = gridWidth * 2 / 3
local sixthWidth = gridWidth / 6
local halfHeight = gridHeight / 2
local halfWidth = gridWidth / 2
local quarterWidth = gridWidth / 4
local threeQuarterWidth = gridWidth * 3 / 4

hs.grid.setGrid(gridWidth..'x'..gridHeight)
hs.grid.setMargins('0, 0')

local gridPosition = {
    leftHalf = {
        x = left, y = top, w = halfWidth, h = gridHeight
    },
    leftQuarter = {
        x = left, y = top, w = quarterWidth, h = gridHeight
    },
    leftThird = {
        x = left, y = top, w = thirdWidth, h = gridHeight
    },
    leftTwoThirds = {
        x = left, y = top, w = twoThirdsWidth, h = gridHeight
    },
    midHalf = {
        x = quarterWidth, y = top, w = halfWidth, h = gridHeight
    },
    midThird = {
        x = thirdWidth, y = top, w = thirdWidth, h = gridHeight
    },
    midTwoThirds = {
        x = sixthWidth, y = top, w = twoThirdsWidth, h = gridHeight
    },
    rightHalf = {
        x = halfWidth, y = top, w = halfWidth, h = gridHeight
    },
    rightQuarter = {
        x = threeQuarterWidth, y = top, w = quarterWidth, h = gridHeight
    },
    rightThird = {
        x = twoThirdsWidth, y = top, w = thirdWidth, h = gridHeight
    },
    rightTwoThirds = {
        x = thirdWidth, y = top, w = twoThirdsWidth, h = gridHeight
    },
    topLeftSixth = {
        x = left, y = top, w = thirdWidth, h = halfHeight
    },
    topLeftTwoSixths = {
        x = left, y = top, w = twoThirdsWidth, h = halfHeight
    },
    topMidSixth = {
        x = thirdWidth, y = top, w = thirdWidth, h = halfHeight
    },
    topMidTwoSixths = {
        x = sixthWidth, y = top, w = twoThirdsWidth, h = halfHeight
    },
    topRightSixth = {
        x = twoThirdsWidth, y = top, w = thirdWidth, h = halfHeight
    },
    topRightTwoSixths = {
        x = thirdWidth, y = top, w = twoThirdsWidth, h = halfHeight
    },
    bottomLeftSixth = {
        x = left, y = halfHeight, w = thirdWidth, h = halfHeight
    },
    bottomLeftTwoSixths = {
        x = left, y = halfHeight, w = twoThirdsWidth, h = halfHeight
    },
    bottomMidSixth = {
        x = thirdWidth, y = halfHeight, w = thirdWidth, h = halfHeight
    },
    bottomMidTwoSixths = {
        x = sixthWidth, y = halfHeight, w = twoThirdsWidth, h = halfHeight
    },
    bottomRightSixth = {
        x = twoThirdsWidth, y = halfHeight, w = thirdWidth, h = halfHeight
    },
    bottomRightTwoSixths = {
        x = thirdWidth, y = halfHeight, w = twoThirdsWidth, h = halfHeight
    },
    topLeftQuarter = {
        x = left, y = top, w = halfWidth, h = halfHeight
    },
    topRightQuarter = {
        x = halfWidth, y = top, w = halfWidth, h = halfHeight
    },
    bottomLeftQuarter = {
        x = left, y = halfHeight, w = halfWidth, h = halfHeight
    },
    bottomRightQuarter = {
        x = halfWidth, y = halfHeight, w = halfWidth, h = halfHeight
    },
    topLeftEighth = {
        x = left, y = top, w = quarterWidth, h = halfHeight
    },
    topRightEighth = {
        x = threeQuarterWidth, y = top, w = quarterWidth, h = halfHeight
    },
    bottomLeftEighth = {
        x = left, y = halfHeight, w = quarterWidth, h = halfHeight
    },
    bottomRightEighth = {
        x = threeQuarterWidth, y = halfHeight, w = thirdWidth, h = halfHeight
    }
}

function moveFocusedWindow(cellOptions)
    local window = hs.window.focusedWindow()
    local nextCell = getNextCell(window, cellOptions)
    hs.grid.set(window, nextCell)
end

function expandWindowWest()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    clearAdjacentWindows("west")
    hs.grid.set(fwin, generateNewCell(cell.x - 1, cell.y, cell.w + 1, cell.h))
end

function expandWindowNorth()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    clearAdjacentWindows("north")
    hs.grid.set(fwin, generateNewCell(cell.x, cell.y - 1, cell.w, cell.h + 1))
end

function expandWindowEast()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    screen_grid = hs.grid.getGridFrame(fwin:screen())
    clearAdjacentWindows("east")
    hs.grid.set(fwin, generateNewCell(cell.x, cell.y, cell.w + 1, cell.h))
end

function expandWindowSouth()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    screen_grid = hs.grid.getGridFrame(fwin:screen())
    clearAdjacentWindows("south")
    hs.grid.set(fwin, generateNewCell(cell.x, cell.y, cell.w, cell.h + 1))
end

function generateNewCell(x, y, w, h) -- This should take a direction arg and store how to grow
    screen = hs.window.focusedWindow():screen()
    screen_grid = hs.grid.getGridFrame(screen)
    if x < 0 then x = 0 end
    if x + w > screen_grid.w then w = screen_grid.w - x end
    if y < 0 then y = 0 end
    if y + h > screen_grid.h then h = screen_grid.h - y end
    
    return hs.geometry.rect(x, y, w, h)
end

function clearAdjacentWindows(direction)
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    windata = getWindowData(direction)
    for _, win in pairs(windata.windows) do
        windata.shrink(cell, win)
    end
end

function getWindowData(direction)
    fwin = hs.window.focusedWindow()
    local window_data = {
        west = { windows = fwin:windowsToWest(), shrink = createSpaceWest },
        north = { windows = fwin:windowsToNorth(), shrink = createSpaceNorth },
        east = { windows = fwin:windowsToEast(), shrink = createSpaceEast },
        south = { windows = fwin:windowsToSouth(), shrink = createSpaceSouth }
    }

    return window_data[direction]
end

function createSpaceWest(focus_cell, adjacent_win)
    adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.x + adjacent_cell.w >= focus_cell.x then
        hs.grid.adjustWindow(function(newcell)
            newcell.w = adjacent_cell.w > 1 and adjacent_cell.w - 1 or 0
        end, adjacent_win)
    end
end

function createSpaceNorth(focus_cell, adjacent_win)
    adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.y + adjacent_cell.h >= focus_cell.y then
        hs.grid.adjustWindow(function(frame)
            frame.h = math.max(focus_cell.y - 1, 1)
        end, adjacent_win)
    end
end

function createSpaceEast(focus_cell, adjacent_win)
    adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.x <= focus_cell.x + focus_cell.w then
        hs.grid.adjustWindow(function(frame)
            frame.x = math.max(focus_cell.x + focus_cell.w + 1, frame.x + 1)
            frame.w = math.max(frame.w - 1, 1)
        end, adjacent_win)
    end
end
function createSpaceSouth(focus_cell, adjacent_win)
    adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.y <= focus_cell.y + focus_cell.h then
        hs.grid.adjustWindow(function(frame)
            frame.y = math.max(focus_cell.y + focus_cell.h + 1, frame.y + 1)
            frame.h = math.max(frame.h - 1, 1)
        end, sWindow)
    end
end

function getNextCell(window, cellOptions)
    local currentCell = hs.grid.get(window)
    local nextCell
    for i, cell in ipairs(cellOptions) do
        if isEqual(currentCell, cellOptions[i]) then
            nextCell = cellOptions[i + 1]
        end
    end

    return nextCell or cellOptions[1]
end

function isEqual(cell1, cell2)
    return cell1.x == cell2.x and cell1.y == cell2.y and
           cell1.w == cell2.w and cell1.h == cell2.h
end


hs.hotkey.bind(hyperKey, "J", function()
    moveFocusedWindow({gridPosition.leftThird, gridPosition.leftTwoThirds})
end)

hs.hotkey.bind(hyperKey, "K", function()
    moveFocusedWindow({gridPosition.midThird, gridPosition.midTwoThirds, gridPosition.midHalf})
end)

hs.hotkey.bind(hyperKey, "L", function()
    moveFocusedWindow({gridPosition.rightThird, gridPosition.rightTwoThirds})
end)

hs.hotkey.bind(hyperKey, "U", function()
    moveFocusedWindow({gridPosition.topLeftSixth, gridPosition.topLeftTwoSixths})
end)

hs.hotkey.bind(hyperKey, "I", function()
    moveFocusedWindow({gridPosition.topMidSixth, gridPosition.topMidTwoSixths})
end)

hs.hotkey.bind(hyperKey, "O", function()
    moveFocusedWindow({gridPosition.topRightSixth, gridPosition.topRightTwoSixths})
end)

hs.hotkey.bind(hyperKey, "M", function()
    moveFocusedWindow({gridPosition.bottomLeftSixth, gridPosition.bottomLeftTwoSixths})
end)

hs.hotkey.bind(hyperKey, ",", function()
    moveFocusedWindow({gridPosition.bottomMidSixth, gridPosition.bottomMidTwoSixths})
end)

hs.hotkey.bind(hyperKey, ".", function()
    moveFocusedWindow({gridPosition.bottomRightSixth, gridPosition.bottomRightTwoSixths})
end)

hs.hotkey.bind(hyperKey, "Y", function()
    moveFocusedWindow({gridPosition.topLeftQuarter, gridPosition.topLeftEighth})
end)

hs.hotkey.bind(hyperKey, "P", function()
    moveFocusedWindow({gridPosition.topRightQuarter, gridPosition.topRightEighth})
end)

hs.hotkey.bind(hyperKey, "N", function()
    moveFocusedWindow({gridPosition.bottomLeftQuarter, gridPosition.bottomLeftEighth})
end)

hs.hotkey.bind(hyperKey, "/", function()
    moveFocusedWindow({gridPosition.bottomRightQuarter, gridPosition.bottomRightEighth})
end)

hs.hotkey.bind(hyperKey, "H", function()
    moveFocusedWindow({gridPosition.leftHalf, gridPosition.leftQuarter})
end)

hs.hotkey.bind(hyperKey, ";", function()
    moveFocusedWindow({gridPosition.rightHalf, gridPosition.rightQuarter})
end)

hs.hotkey.bind(hyperKey, "left", function()
    expandWindowWest()
end)

hs.hotkey.bind(hyperKey, "right", function()
    expandWindowEast()
end)

hs.hotkey.bind(hyperKey, "up", function()
    expandWindowNorth()
end)

hs.hotkey.bind(hyperKey, "down", function()
    expandWindowSouth()
end)
