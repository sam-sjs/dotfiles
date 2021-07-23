local hyper = {"cmd", "alt", "ctrl"}
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
    fWindow = hs.window.focusedWindow()
    fWindowCell = hs.grid.get(fWindow)
    shrinkWestWindows(fWindow)
    if fWindowCell.x >= 1 then
        hs.grid.adjustWindow(function(frame)
            frame.x = frame.x - 1
            frame.w = frame.w + 1
        end, fWindow)
    else
        hs.grid.adjustWindow(function(frame)
            frame.x = 0
            frame.w = frame.w + frame.x
        end, fWindow)
    end
end

function expandWindowNorth()
    fWindow = hs.window.focusedWindow()
    fWindowCell = hs.grid.get(fWindow)
    shrinkNorthWindows(fWindow)
    if fWindowCell.y >= 1 then
        hs.grid.adjustWindow(function(frame)
            frame.y = frame.y - 1
            frame.h = frame.h + 1
        end, fWindow)
    else
        hs.grid.adjustWindow(function(frame)
            frame.y = 0
            frame.h = frame.h + frame.y
        end, fWindow)
    end
end

function expandWindowEast()
    fWindow = hs.window.focusedWindow()
    fWindowCell = hs.grid.get(fWindow)
    screenGrid = hs.grid.getGridFrame(fWindow:screen())
    shrinkEastWindows(fWindow)
    if fWindowCell.x + fWindowCell.w <= screenGrid.w - 1 then
        hs.grid.adjustWindow(function(frame)
            frame.w = frame.w + 1
        end, fWindow)
    else
        hs.grid.adjustWindow(function(frame)
            frame.w = screenGrid.w - frame.x
        end, fWindow)
    end
end

function expandWindowSouth()
    fWindow = hs.window.focusedWindow()
    fWindowCell = hs.grid.get(fWindow)
    screenGrid = hs.grid.getGridFrame(fWindow:screen())
    shrinkSouthWindows(fWindow)
    if fWindowCell.y + fWindowCell.h <= screenGrid.h - 1 then
        hs.grid.adjustWindow(function(frame)
            frame.h = frame.h + 1
        end, fWindow)
    else
        hs.grid.adjustWindow(function(frame)
            frame.h = screenGrid.h - frame.y
        end, fWindow)
    end
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


hs.hotkey.bind(hyper, "J", function()
    moveFocusedWindow({gridPosition.leftThird, gridPosition.leftTwoThirds})
end)

hs.hotkey.bind(hyper, "K", function()
    moveFocusedWindow({gridPosition.midThird, gridPosition.midTwoThirds, gridPosition.midHalf})
end)

hs.hotkey.bind(hyper, "L", function()
    moveFocusedWindow({gridPosition.rightThird, gridPosition.rightTwoThirds})
end)

hs.hotkey.bind(hyper, "U", function()
    moveFocusedWindow({gridPosition.topLeftSixth, gridPosition.topLeftTwoSixths})
end)

hs.hotkey.bind(hyper, "I", function()
    moveFocusedWindow({gridPosition.topMidSixth, gridPosition.topMidTwoSixths})
end)

hs.hotkey.bind(hyper, "O", function()
    moveFocusedWindow({gridPosition.topRightSixth, gridPosition.topRightTwoSixths})
end)

hs.hotkey.bind(hyper, "M", function()
    moveFocusedWindow({gridPosition.bottomLeftSixth, gridPosition.bottomLeftTwoSixths})
end)

hs.hotkey.bind(hyper, ",", function()
    moveFocusedWindow({gridPosition.bottomMidSixth, gridPosition.bottomMidTwoSixths})
end)

hs.hotkey.bind(hyper, ".", function()
    moveFocusedWindow({gridPosition.bottomRightSixth, gridPosition.bottomRightTwoSixths})
end)

hs.hotkey.bind(hyper, "Y", function()
    moveFocusedWindow({gridPosition.topLeftQuarter, gridPosition.topLeftEighth})
end)

hs.hotkey.bind(hyper, "P", function()
    moveFocusedWindow({gridPosition.topRightQuarter, gridPosition.topRightEighth})
end)

hs.hotkey.bind(hyper, "N", function()
    moveFocusedWindow({gridPosition.bottomLeftQuarter, gridPosition.bottomLeftEighth})
end)

hs.hotkey.bind(hyper, "/", function()
    moveFocusedWindow({gridPosition.bottomRightQuarter, gridPosition.bottomRightEighth})
end)

hs.hotkey.bind(hyper, "H", function()
    moveFocusedWindow({gridPosition.leftHalf, gridPosition.leftQuarter})
end)

hs.hotkey.bind(hyper, ";", function()
    moveFocusedWindow({gridPosition.rightHalf, gridPosition.rightQuarter})
end)

hs.hotkey.bind(hyper, "left", function()
    expandWindowWest()
end)

hs.hotkey.bind(hyper, "right", function()
    expandWindowEast()
end)

hs.hotkey.bind(hyper, "up", function()
    expandWindowNorth()
end)

hs.hotkey.bind(hyper, "down", function()
    expandWindowSouth()
end)
