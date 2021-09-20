local hyperKey = {"cmd", "alt", "ctrl"}
local gridwidth = 24
local gridheight = 12

hs.grid.setGrid(gridwidth..'x'..gridheight)
hs.grid.setMargins('0, 0')

local gridPosition = {
    leftHalf = { x = 0, y = 0, w = gridwidth / 2, h = gridheight },
    leftQuarter = { x = 0, y = 0, w = gridwidth / 4, h = gridheight },
    leftThird = { x = 0, y = 0, w = gridwidth / 3, h = gridheight },
    leftTwoThirds = { x = 0, y = 0, w = gridwidth * 2 / 3, h = gridheight },
    midHalf = { x = gridwidth / 4, y = 0, w = gridwidth / 2, h = gridheight },
    midThird = { x = gridwidth / 3, y = 0, w = gridwidth / 3, h = gridheight },
    midTwoThirds = { x = gridwidth / 6, y = 0, w = gridwidth * 2 / 3, h = gridheight },
    rightHalf = { x = gridwidth / 2, y = 0, w = gridwidth / 2, h = gridheight },
    rightQuarter = { x = gridwidth * 3 / 4, y = 0, w = gridwidth / 4, h = gridheight },
    rightThird = { x = gridwidth * 2 / 3, y = 0, w = gridwidth / 3, h = gridheight },
    rightTwoThirds = { x = gridwidth / 3, y = 0, w = gridwidth * 2 / 3, h = gridheight },
    topLeftSixth = { x = 0, y = 0, w = gridwidth / 3, h = gridheight / 2 },
    topLeftTwoSixths = { x = 0, y = 0, w = gridwidth * 2 / 3, h = gridheight / 2 },
    topMidSixth = { x = gridwidth / 3, y = 0, w = gridwidth / 3, h = gridheight / 2 },
    topMidTwoSixths = { x = gridwidth / 6, y = 0, w = gridwidth * 2 / 3, h = gridheight / 2 },
    topRightSixth = { x = gridwidth * 2 / 3, y = 0, w = gridwidth / 3, h = gridheight / 2 },
    topRightTwoSixths = { x = gridwidth / 3, y = 0, w = gridwidth * 2 / 3, h = gridheight / 2 },
    botLeftSixth = { x = 0, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
    botLeftTwoSixths = { x = 0, y = gridheight / 2, w = gridwidth * 2 / 3, h = gridheight / 2 },
    botMidSixth = { x = gridwidth / 3, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
    botMidTwoSixths = { x = gridwidth / 6, y = gridheight / 2, w = gridwidth * 2 / 3, h = gridheight / 2 },
    botRightSixth = { x = gridwidth * 2 / 3, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
    botRightTwoSixths = { x = gridwidth / 3, y = gridheight / 2, w = gridwidth * 2 / 3, h = gridheight / 2 },
    topLeftQuarter = { x = 0, y = 0, w = gridwidth / 2, h = gridheight / 2 },
    topRightQuarter = { x = gridwidth / 2, y = 0, w = gridwidth / 2, h = gridheight / 2 },
    botLeftQuarter = { x = 0, y = gridheight / 2, w = gridwidth / 2, h = gridheight / 2 },
    botRightQuarter = { x = gridwidth / 2, y = gridheight / 2, w = gridwidth / 2, h = gridheight / 2 },
    topLeftEighth = { x = 0, y = 0, w = gridwidth / 4, h = gridheight / 2 },
    topRightEighth = { x = gridwidth * 3 / 4, y = 0, w = gridwidth / 4, h = gridheight / 2 },
    botLeftEighth = { x = 0, y = gridheight / 2, w = gridwidth / 4, h = gridheight / 2 },
    botRightEighth = { x = gridwidth * 3 / 4, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 }
}

function moveFocusedWindow(cellDimensions)
    local window = hs.window.focusedWindow()
    local newposition = getNewPosition(window, cellDimensions)
    hs.grid.set(window, newposition)
end

function expandWindow(direction)
    fwin = hs.window.focusedWindow()
    cell = hs.grid.get(fwin)
    grow_directions = {
        west = generateCellWithinScreen(cell.x - 1, cell.y, cell.w + 1, cell.h),
        north = generateCellWithinScreen(cell.x, cell.y - 1, cell.w, cell.h + 1),
        east = generateCellWithinScreen(cell.x, cell.y, cell.w + 1, cell.h),
        south = generateCellWithinScreen(cell.x, cell.y, cell.w, cell.h + 1)
    }
    clearAdjacentWindows(direction)
    hs.grid.set(fwin, grow_directions[direction])
end

function generateCellWithinScreen(x, y, w, h)
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
        hs.grid.adjustWindow(function(newcell)
            newcell.h = math.max(focus_cell.y - 1, 1)
        end, adjacent_win)
    end
end

function createSpaceEast(focus_cell, adjacent_win)
    adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.x <= focus_cell.x + focus_cell.w then
        hs.grid.adjustWindow(function(newcell)
            newcell.x = math.max(focus_cell.x + focus_cell.w + 1, newcell.x + 1)
            newcell.w = math.max(newcell.w - 1, 1)
        end, adjacent_win)
    end
end

function createSpaceSouth(focus_cell, adjacent_win)
    adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.y <= focus_cell.y + focus_cell.h then
        hs.grid.adjustWindow(function(newcell)
            newcell.y = math.max(focus_cell.y + focus_cell.h + 1, newcell.y + 1)
            newcell.h = math.max(newcell.h - 1, 1)
        end, adjacent_win)
    end
end

function getNewPosition(window, cellDimensions)
    local currentCell = hs.grid.get(window)
    local nextCell
    for i, cell in ipairs(cellDimensions) do
        if areCellsEqual(currentCell, cellDimensions[i]) then
            nextCell = cellDimensions[i + 1]
        end
    end

    return nextCell or cellDimensions[1]
end

function areCellsEqual(cell1, cell2)
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
    moveFocusedWindow({gridPosition.botLeftSixth, gridPosition.botLeftTwoSixths})
end)

hs.hotkey.bind(hyperKey, ",", function()
    moveFocusedWindow({gridPosition.botMidSixth, gridPosition.botMidTwoSixths})
end)

hs.hotkey.bind(hyperKey, ".", function()
    moveFocusedWindow({gridPosition.botRightSixth, gridPosition.botRightTwoSixths})
end)

hs.hotkey.bind(hyperKey, "Y", function()
    moveFocusedWindow({gridPosition.topLeftQuarter, gridPosition.topLeftEighth})
end)

hs.hotkey.bind(hyperKey, "P", function()
    moveFocusedWindow({gridPosition.topRightQuarter, gridPosition.topRightEighth})
end)

hs.hotkey.bind(hyperKey, "N", function()
    moveFocusedWindow({gridPosition.botLeftQuarter, gridPosition.botLeftEighth})
end)

hs.hotkey.bind(hyperKey, "/", function()
    moveFocusedWindow({gridPosition.botRightQuarter, gridPosition.botRightEighth})
end)

hs.hotkey.bind(hyperKey, "H", function()
    moveFocusedWindow({gridPosition.leftHalf, gridPosition.leftQuarter})
end)

hs.hotkey.bind(hyperKey, ";", function()
    moveFocusedWindow({gridPosition.rightHalf, gridPosition.rightQuarter})
end)

hs.hotkey.bind(hyperKey, "left", function()
    expandWindow("west")
end)

hs.hotkey.bind(hyperKey, "right", function()
    expandWindow("east")
end)

hs.hotkey.bind(hyperKey, "up", function()
    expandWindow("north")
end)

hs.hotkey.bind(hyperKey, "down", function()
    expandWindow("south")
end)
