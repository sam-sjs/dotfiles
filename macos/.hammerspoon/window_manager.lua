local window_manager = {}
local grid = require('grid')
local hyperKey = {"cmd", "alt", "ctrl"}

hs.grid.setGrid(grid.WIDTH..'x'..grid.HEIGHT)
hs.grid.setMargins('0, 0')

-- TODO: remove after testing
local gridwidth = grid.WIDTH
local gridheight = grid.HEIGHT

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
    botRightEighth = { x = gridwidth * 3 / 4, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
    innerFull = { x = 0, y = 0, w = gridwidth, h = gridheight }
}

function window_manager.moveFocusedWindow(cellDimensions)
    local window = hs.window.focusedWindow()
    local newposition = window_manager.getNewPosition(window, cellDimensions)
    hs.grid.set(window, newposition)
end

function window_manager.expandWindow(direction)
    local fwin = hs.window.focusedWindow()
    local cell = hs.grid.get(fwin)
    local grow_directions = {
        west = window_manager.generateCellWithinScreen(cell.x - 1, cell.y, cell.w + 1, cell.h),
        north = window_manager.generateCellWithinScreen(cell.x, cell.y - 1, cell.w, cell.h + 1),
        east = window_manager.generateCellWithinScreen(cell.x, cell.y, cell.w + 1, cell.h),
        south = window_manager.generateCellWithinScreen(cell.x, cell.y, cell.w, cell.h + 1)
    }
    window_manager.clearAdjacentWindows(direction)
    hs.grid.set(fwin, grow_directions[direction])
end

function window_manager.generateCellWithinScreen(x, y, w, h)
    local screen = hs.window.focusedWindow():screen()
    local screen_grid = hs.grid.getGridFrame(screen)
    if x < 0 then x = 0 end
    if x + w > screen_grid.w then w = screen_grid.w - x end
    if y < 0 then y = 0 end
    if y + h > screen_grid.h then h = screen_grid.h - y end
    
    return hs.geometry.rect(x, y, w, h)
end

function window_manager.clearAdjacentWindows(direction)
    local fwin = hs.window.focusedWindow()
    local cell = hs.grid.get(fwin)
    local windata = window_manager.getWindowData(direction)
    for _, win in pairs(windata.windows) do
        windata.shrink(cell, win)
    end
end

function window_manager.getWindowData(direction)
    local fwin = hs.window.focusedWindow()
    local window_data = {
        west = { windows = fwin:windowsToWest(), shrink = window_manager.createSpaceWest },
        north = { windows = fwin:windowsToNorth(), shrink = window_manager.createSpaceNorth },
        east = { windows = fwin:windowsToEast(), shrink = window_manager.createSpaceEast },
        south = { windows = fwin:windowsToSouth(), shrink = window_manager.createSpaceSouth }
    }

    return window_data[direction]
end

function window_manager.createSpaceWest(focus_cell, adjacent_win)
    local adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.x + adjacent_cell.w >= focus_cell.x then
        hs.grid.adjustWindow(function(newcell)
            newcell.w = adjacent_cell.w > 1 and adjacent_cell.w - 1 or 0
        end, adjacent_win)
    end
end

function window_manager.createSpaceNorth(focus_cell, adjacent_win)
    local adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.y + adjacent_cell.h >= focus_cell.y then
        hs.grid.adjustWindow(function(newcell)
            newcell.h = math.max(focus_cell.y - 1, 1)
        end, adjacent_win)
    end
end

function window_manager.createSpaceEast(focus_cell, adjacent_win)
    local adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.x <= focus_cell.x + focus_cell.w then
        hs.grid.adjustWindow(function(newcell)
            newcell.x = math.max(focus_cell.x + focus_cell.w + 1, newcell.x + 1)
            newcell.w = math.max(newcell.w - 1, 1)
        end, adjacent_win)
    end
end

function window_manager.createSpaceSouth(focus_cell, adjacent_win)
    local adjacent_cell = hs.grid.get(adjacent_win)
    if adjacent_cell.y <= focus_cell.y + focus_cell.h then
        hs.grid.adjustWindow(function(newcell)
            newcell.y = math.max(focus_cell.y + focus_cell.h + 1, newcell.y + 1)
            newcell.h = math.max(newcell.h - 1, 1)
        end, adjacent_win)
    end
end

function window_manager.getNewPosition(window, cellDimensions)
    local currentCell = hs.grid.get(window)
    local nextCell
    for i, cell in ipairs(cellDimensions) do
        if window_manager.areCellsEqual(currentCell, cellDimensions[i]) then
            nextCell = cellDimensions[i + 1]
        end
    end

    return nextCell or cellDimensions[1]
end

function window_manager.areCellsEqual(cell1, cell2)
    return cell1.x == cell2.x and cell1.y == cell2.y and
           cell1.w == cell2.w and cell1.h == cell2.h
end


hs.hotkey.bind(hyperKey, "J", function()
    window_manager.moveFocusedWindow({
        grid.get_position(grid.NA, grid.FULL, grid.LEFT, grid.THIRD),
        grid.get_position(grid.NA, grid.FULL, grid.LEFT, grid.TWO_THIRDS)
    })
end)

hs.hotkey.bind(hyperKey, "K", function()
    window_manager.moveFocusedWindow({grid.get_position(grid.NA, grid.FULL, grid.CENTER, grid.THIRD), grid.get_position(grid.NA, grid.FULL, grid.CENTER, grid.TWO_THIRDS), gridPosition.midHalf})
end)

hs.hotkey.bind(hyperKey, "L", function()
    window_manager.moveFocusedWindow({gridPosition.rightThird, gridPosition.rightTwoThirds})
end)

hs.hotkey.bind(hyperKey, "U", function()
    window_manager.moveFocusedWindow({gridPosition.topLeftSixth, gridPosition.topLeftTwoSixths})
end)

hs.hotkey.bind(hyperKey, "I", function()
    window_manager.moveFocusedWindow({gridPosition.topMidSixth, gridPosition.topMidTwoSixths})
end)

hs.hotkey.bind(hyperKey, "O", function()
    window_manager.moveFocusedWindow({gridPosition.topRightSixth, gridPosition.topRightTwoSixths})
end)

hs.hotkey.bind(hyperKey, "M", function()
    window_manager.moveFocusedWindow({gridPosition.botLeftSixth, gridPosition.botLeftTwoSixths})
end)

hs.hotkey.bind(hyperKey, ",", function()
    window_manager.moveFocusedWindow({gridPosition.botMidSixth, gridPosition.botMidTwoSixths})
end)

hs.hotkey.bind(hyperKey, ".", function()
    window_manager.moveFocusedWindow({gridPosition.botRightSixth, gridPosition.botRightTwoSixths})
end)

hs.hotkey.bind(hyperKey, "Y", function()
    window_manager.moveFocusedWindow({gridPosition.topLeftQuarter, gridPosition.topLeftEighth})
end)

hs.hotkey.bind(hyperKey, "P", function()
    window_manager.moveFocusedWindow({gridPosition.topRightQuarter, gridPosition.topRightEighth})
end)

hs.hotkey.bind(hyperKey, "N", function()
    window_manager.moveFocusedWindow({gridPosition.botLeftQuarter, gridPosition.botLeftEighth})
end)

hs.hotkey.bind(hyperKey, "/", function()
    window_manager.moveFocusedWindow({gridPosition.botRightQuarter, gridPosition.botRightEighth})
end)

hs.hotkey.bind(hyperKey, "H", function()
    window_manager.moveFocusedWindow({gridPosition.leftHalf, gridPosition.leftQuarter})
end)

hs.hotkey.bind(hyperKey, ";", function()
    window_manager.moveFocusedWindow({gridPosition.rightHalf, gridPosition.rightQuarter})
end)

hs.hotkey.bind(hyperKey, "left", function()
    window_manager.expandWindow("west")
end)

hs.hotkey.bind(hyperKey, "right", function()
    window_manager.expandWindow("east")
end)

hs.hotkey.bind(hyperKey, "up", function()
    window_manager.expandWindow("north")
end)

hs.hotkey.bind(hyperKey, "down", function()
    window_manager.expandWindow("south")
end)

hs.hotkey.bind(hyperKey, "return", function()
    window_manager.moveFocusedWindow({ gridPosition.innerFull })
end)
