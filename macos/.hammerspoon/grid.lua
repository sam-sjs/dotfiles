local grid = {}

grid.WIDTH = 24
grid.HEIGHT = 12

-- Helper to create a grid rectangle
local function rect(x, y, w, h)
    return { x = x, y = y, w = w, h = h }
end

-- Horizontal Position Generators
function grid.left(fraction) return rect(0, 0, grid.WIDTH * fraction, grid.HEIGHT) end
function grid.right(fraction) return rect(grid.WIDTH * (1 - fraction), 0, grid.WIDTH * fraction, grid.HEIGHT) end
function grid.midH(fraction) return rect(grid.WIDTH * (1 - fraction) / 2, 0, grid.WIDTH * fraction, grid.HEIGHT) end

-- Vertical Position Generators (Splitting screen horizontally)
function grid.top(fraction) return rect(0, 0, grid.WIDTH, grid.HEIGHT * fraction) end
function grid.bot(fraction) return rect(0, grid.HEIGHT * (1 - fraction), grid.WIDTH, grid.HEIGHT * fraction) end

-- Common Presets (Re-creating existing functionality more cleanly)
grid.presets = {
    full = rect(0, 0, grid.WIDTH, grid.HEIGHT),
    
    -- Halves
    leftHalf = grid.left(1/2),
    rightHalf = grid.right(1/2),
    midHalf = grid.midH(1/2),
    
    -- Quarters
    leftQuarter = grid.left(1/4),
    rightQuarter = grid.right(1/4),
    topLeftQuarter = rect(0, 0, grid.WIDTH / 2, grid.HEIGHT / 2),
    topRightQuarter = rect(grid.WIDTH / 2, 0, grid.WIDTH / 2, grid.HEIGHT / 2),
    botLeftQuarter = rect(0, grid.HEIGHT / 2, grid.WIDTH / 2, grid.HEIGHT / 2),
    botRightQuarter = rect(grid.WIDTH / 2, grid.HEIGHT / 2, grid.WIDTH / 2, grid.HEIGHT / 2),
    
    -- Thirds & Sixths
    leftThird = grid.left(1/3),
    midThird = grid.midH(1/3),
    rightThird = grid.right(1/3),
    leftTwoThirds = grid.left(2/3),
    midTwoThirds = grid.midH(2/3),
    rightTwoThirds = grid.right(2/3),
    
    -- More specific presets for the existing hotkeys
    topLeftSixth = rect(0, 0, grid.WIDTH / 3, grid.HEIGHT / 2),
    topMidSixth = rect(grid.WIDTH / 3, 0, grid.WIDTH / 3, grid.HEIGHT / 2),
    topRightSixth = rect(grid.WIDTH * 2 / 3, 0, grid.WIDTH / 3, grid.HEIGHT / 2),
    botLeftSixth = rect(0, grid.HEIGHT / 2, grid.WIDTH / 3, grid.HEIGHT / 2),
    botMidSixth = rect(grid.WIDTH / 3, grid.HEIGHT / 2, grid.WIDTH / 3, grid.HEIGHT / 2),
    botRightSixth = rect(grid.WIDTH * 2 / 3, grid.HEIGHT / 2, grid.WIDTH / 3, grid.HEIGHT / 2),
    
    -- Two Sixths (effectively 1/3 height, 2/3 width)
    topLeftTwoSixths = rect(0, 0, grid.WIDTH * 2 / 3, grid.HEIGHT / 2),
    topMidTwoSixths = rect(grid.WIDTH / 6, 0, grid.WIDTH * 2 / 3, grid.HEIGHT / 2),
    topRightTwoSixths = rect(grid.WIDTH / 3, 0, grid.WIDTH * 2 / 3, grid.HEIGHT / 2),
    botLeftTwoSixths = rect(0, grid.HEIGHT / 2, grid.WIDTH * 2 / 3, grid.HEIGHT / 2),
    botMidTwoSixths = rect(grid.WIDTH / 6, grid.HEIGHT / 2, grid.WIDTH * 2 / 3, grid.HEIGHT / 2),
    botRightTwoSixths = rect(grid.WIDTH / 3, grid.HEIGHT / 2, grid.WIDTH * 2 / 3, grid.HEIGHT / 2),

    -- Eighths
    topLeftEighth = rect(0, 0, grid.WIDTH / 4, grid.HEIGHT / 2),
    topRightEighth = rect(grid.WIDTH * 3 / 4, 0, grid.WIDTH / 4, grid.HEIGHT / 2),
    botLeftEighth = rect(0, grid.HEIGHT / 2, grid.WIDTH / 4, grid.HEIGHT / 2),
    botRightEighth = rect(grid.WIDTH * 3 / 4, grid.HEIGHT / 2, grid.WIDTH / 4, grid.HEIGHT / 2)
}

return grid
