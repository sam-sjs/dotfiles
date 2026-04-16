local window_manager = {}
local grid = require('grid')

-- Configure Hammerspoon grid
hs.grid.setGrid(grid.WIDTH .. 'x' .. grid.HEIGHT)
hs.grid.setMargins('0, 0')

-- Cycle focused window through a list of grid positions
function window_manager.cycleWindow(positions)
    local window = hs.window.focusedWindow()
    if not window then return end
    
    local currentCell = hs.grid.get(window)
    local nextCell = positions[1]
    
    for i, cell in ipairs(positions) do
        if window_manager.areCellsEqual(currentCell, cell) then
            nextCell = positions[i + 1] or positions[1]
            break
        end
    end

    hs.grid.set(window, nextCell)
end

-- Expand window in a direction and shrink neighbors to fit
function window_manager.expandWindow(direction)
    local fwin = hs.window.focusedWindow()
    if not fwin then return end
    
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

-- Helper: Ensure cell stays within screen boundaries
function window_manager.generateCellWithinScreen(x, y, w, h)
    local screen = hs.window.focusedWindow():screen()
    local screen_grid = hs.grid.getGridFrame(screen)
    
    local nx = math.max(0, x)
    local ny = math.max(0, y)
    local nw = (nx + w > screen_grid.w) and (screen_grid.w - nx) or w
    local nh = (ny + h > screen_grid.h) and (screen_grid.h - ny) or h
    
    return hs.geometry.rect(nx, ny, nw, nh)
end

-- Helper: Find and shrink windows in the expansion path
function window_manager.clearAdjacentWindows(direction)
    local fwin = hs.window.focusedWindow()
    local cell = hs.grid.get(fwin)
    
    local adj = {
        west  = { windows = fwin:windowsToWest(),  shrink = window_manager.shrinkWest },
        north = { windows = fwin:windowsToNorth(), shrink = window_manager.shrinkNorth },
        east  = { windows = fwin:windowsToEast(),  shrink = window_manager.shrinkEast },
        south = { windows = fwin:windowsToSouth(), shrink = window_manager.shrinkSouth }
    }

    local data = adj[direction]
    if not data then return end
    
    for _, win in pairs(data.windows) do
        data.shrink(cell, win)
    end
end

-- Shrink logic for neighbors
function window_manager.shrinkWest(fcell, awin)
    local acell = hs.grid.get(awin)
    if acell.x + acell.w >= fcell.x then
        hs.grid.adjustWindow(function(c) c.w = math.max(acell.w - 1, 0) end, awin)
    end
end

function window_manager.shrinkNorth(fcell, awin)
    local acell = hs.grid.get(awin)
    if acell.y + acell.h >= fcell.y then
        hs.grid.adjustWindow(function(c) c.h = math.max(fcell.y - 1, 1) end, awin)
    end
end

function window_manager.shrinkEast(fcell, awin)
    local acell = hs.grid.get(awin)
    if acell.x <= fcell.x + fcell.w then
        hs.grid.adjustWindow(function(c) 
            c.x = fcell.x + fcell.w + 1
            c.w = math.max(acell.w - 1, 1)
        end, awin)
    end
end

function window_manager.shrinkSouth(fcell, awin)
    local acell = hs.grid.get(awin)
    if acell.y <= fcell.y + fcell.h then
        hs.grid.adjustWindow(function(c)
            c.y = fcell.y + fcell.h + 1
            c.h = math.max(acell.h - 1, 1)
        end, awin)
    end
end

function window_manager.areCellsEqual(c1, c2)
    return c1.x == c2.x and c1.y == c2.y and c1.w == c2.w and c1.h == c2.h
end

return window_manager
