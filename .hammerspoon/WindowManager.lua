hyper = {"cmd", "alt", "ctrl"}
gridWidth = 24
gridHeight = 12
top = 0
left = 0
thirdWidth = gridWidth / 3
twoThirdsWidth = gridWidth * 2 / 3
sixthWidth = gridWidth / 6
halfHeight = gridHeight / 2
halfWidth = gridWidth / 2
quarterWidth = gridWidth / 2
threeQuarterWidth = gridWidth / 3

hs.grid.setGrid(gridWidth..'x'..gridHeight)
hs.grid.setMargins('0, 0')

local gridPosition = {
    leftThird = {
        x = left, y = top, w = thirdWidth, h = gridHeight
    },
    leftTwoThirds = {
        x = left, y = top, w = twoThirdsWidth, h = gridHeight
    },
    midThird = {
        x = thirdWidth, y = top, w = thirdWidth, h = gridHeight
    },
    midTwoThirds = {
        x = sixthWidth, y = top, w = twoThirdsWidth, h = gridHeight
    },
    midHalf = {
        x = quarterWidth, y = top, w = halfWidth, h = gridHeight
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
        x = thirdWidth, y = top, w = twoThirdsWidth, h = halfHeight
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
        x = twoThirdsWidth, y = halfHeight, w = twoThirdsWidth, h = halfHeight
    },
    topLeftQuarter = {
        x = left, y = top, w = halfWidth, h = halfHeight
    },
    topRightQuarter = {
        x = halfWidth, y = top, w = halfWidth, h = halfHeight
    },
    bottomLeftQuarter = {
        x = left, y = top, w = halfWidth, h = halfHeight
    },
    bottomRightQuarter = {
        x = halfWidth, y = top, w = halfWidth, h = halfHeight
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

function isEqual(cell1, cell2)
    return cell1.x == cell2.x and cell1.y == cell2.y and
           cell1.w == cell2.w and cell1.h == cell2.h
end

function moveFocusedWindow(position, altPosition)
    local window = hs.window.focusedWindow()
    local cell = hs.grid.get(window)
    if isEqual(cell, position) then
        hs.grid.set(window, altPosition)
    else
        hs.grid.set(window, position)
    end
end

hs.hotkey.bind(hyper, "J", function()
    moveFocusedWindow(gridPosition.leftThird, gridPosition.leftTwoThirds)
end)

hs.hotkey.bind(hyper, "K", function()
    moveFocusedWindow(gridPosition.midThird, gridPosition.midTwoThirds)
end)

hs.hotkey.bind(hyper, "L", function()
    moveFocusedWindow(gridPosition.rightThird, gridPosition.rightTwoThirds)
end)

hs.hotkey.bind(hyper, "U", function()
    moveFocusedWindow(gridPosition.topLeftSixth, gridPosition.topLeftTwoSixths)
end)

hs.hotkey.bind(hyper, "I", function()
    moveFocusedWindow(gridPosition.topMidSixth, gridPosition.topMidTwoSixths)
end)

hs.hotkey.bind(hyper, "O", function()
    moveFocusedWindow(gridPosition.topRightSixth, gridPosition.topRightTwoSixths)
end)

hs.hotkey.bind(hyper, "M", function()
    moveFocusedWindow(gridPosition.bottomLeftSixth, gridPosition.bottomLeftTwoSixths)
end)

hs.hotkey.bind(hyper, ",", function()
    moveFocusedWindow(gridPosition.bottomMidSixth, gridPosition.bottomMidTwoSixths)
end)

hs.hotkey.bind(hyper, ".", function()
    moveFocusedWindow(gridPosition.bottomRightSixth, gridPosition.bottomRightTwoSixths)
end)

hs.hotkey.bind(hyper, "Y", function()
    moveFocusedWindow(gridPosition.topLeftQuarter, gridPosition.topLeftEighth)
end)

hs.hotkey.bind(hyper, "P", function()
    moveFocusedWindow(gridPosition.topRightQuarter, gridPosition.topRightEighth)
end)

hs.hotkey.bind(hyper, "N", function()
    moveFocusedWindow(gridPosition.bottomLeftQuarter, gridPosition.bottomLeftEighth)
end)

hs.hotkey.bind(hyper, "/", function()
    moveFocusedWindow(gridPosition.bottomRightQuarter, gridPosition.bottomRightEighth)
end)
