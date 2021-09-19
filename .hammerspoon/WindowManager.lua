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
    shrinkWestWindows(fwin)
    hs.grid.set(fwin, generate_new_cell(cell.x - 1, cell.y, cell.w + 1, cell.h))
end

function expandWindowNorth()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    shrinkNorthWindows(fwin)
    hs.grid.set(fwin, generate_new_cell(cell.x, cell.y - 1, cell.w, cell.h + 1))
end

function expandWindowEast()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    screenGrid = hs.grid.getGridFrame(fwin:screen())
    shrinkEastWindows(fwin)
    hs.grid.set(fwin, generate_new_cell(cell.x, cell.y, cell.w + 1, cell.h))
end

function expandWindowSouth()
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    screenGrid = hs.grid.getGridFrame(fwin:screen())
    shrinkSouthWindows(fwin)
    hs.grid.set(fwin, generate_new_cell(cell.x, cell.y, cell.w, cell.h + 1))
end

function generate_new_cell(x, y, w, h)
    screen = hs.window.focusedWindow():screen()
    screen_grid = hs.grid.getGridFrame(screen)
    if x < 0 then x = 0 end
    if x + w > screen_grid.w then w = screen_grid.w - x end
    if y < 0 then y = 0 end
    if y + h > screen_grid.h then h = screen_grid.h - y end
    
    return hs.geometry.rect(x, y, w, h)
end

function shrinkWestWindows(fWindow)
    westWindows = fWindow:windowsToWest()
    fWindowCell = hs.grid.get(fWindow)
    for i, wWindow in pairs(westWindows) do
        wWindowCell = hs.grid.get(wWindow)
        if wWindowCell.x + wWindowCell.w >= fWindowCell.x then
            hs.grid.adjustWindow(function(frame)
                frame.w = math.max(fWindowCell.x - 1, 1)
            end, wWindow)
        end
    end
end

function shrinkNorthWindows(fWindow)
    northWindows = fWindow:windowsToNorth()
    fWindowCell = hs.grid.get(fWindow)
    for i, nWindow in pairs(northWindows) do
        nWindowCell = hs.grid.get(nWindow)
        if nWindowCell.y + nWindowCell.h >= fWindowCell.y then
            hs.grid.adjustWindow(function(frame)
                frame.h = math.max(fWindowCell.y - 1, 1)
            end, nWindow)
        end
    end
end

function shrinkEastWindows(fWindow)
    eastWindows = fWindow:windowsToEast()
    fWindowCell = hs.grid.get(fWindow)
    for i, eWindow in pairs(eastWindows) do
        eWindowCell = hs.grid.get(eWindow)
        if eWindowCell.x <= fWindowCell.x + fWindowCell.w then
            hs.grid.adjustWindow(function(frame)
                frame.x = math.max(fWindowCell.x + fWindowCell.w + 1, frame.x + 1)
                frame.w = math.max(frame.w - 1, 1)
            end, eWindow)
        end
    end
end

function shrinkSouthWindows(fWindow)
    southWindows = fWindow:windowsToSouth()
    fWindowCell = hs.grid.get(fWindow)
    for i, sWindow in pairs(southWindows) do
        sWindowCell = hs.grid.get(sWindow)
        if sWindowCell.y <= fWindowCell.y + fWindowCell.h then
            hs.grid.adjustWindow(function(frame)
                frame.y = math.max(fWindowCell.y + fWindowCell.h + 1, frame.y + 1)
                frame.h = math.max(frame.h - 1, 1)
            end, sWindow)
        end
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
