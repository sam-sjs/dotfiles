local grid = {}

grid.HEIGHT = 12
grid.WIDTH = 24

-- Horizontal positions
grid.LEFT = 0
grid.CENTER = 1
grid.RIGHT = 2
--grid.FULL = grid.LEFT

-- Vertical positions
grid.TOP = 0
grid.BOTTOM = 1
grid.NA = grid.TOP

-- Sizes
grid.FULL = 1
grid.HALF = 2
grid.THIRD = 3
grid.TWO_THIRDS = 3/2

function grid.get_position(vpos, vsize, hpos, hsize)
    local width = grid.WIDTH / hsize
    local height = grid.HEIGHT / vsize
    return {
        x = hpos * width,
        y = vpos * height,
        w = width,
        h = height
    }
end

--local gridPosition = {
--    leftHalf = { x = 0, y = 0, w = gridwidth / 2, h = gridheight },
--    leftQuarter = { x = 0, y = 0, w = gridwidth / 4, h = gridheight },
--    leftThird = { x = 0, y = 0, w = gridwidth / 3, h = gridheight },
--    leftTwoThirds = { x = 0, y = 0, w = gridwidth * 2 / 3, h = gridheight },
--    midHalf = { x = gridwidth / 4, y = 0, w = gridwidth / 2, h = gridheight },
--    midThird = { x = gridwidth / 3, y = 0, w = gridwidth / 3, h = gridheight },
--    midTwoThirds = { x = gridwidth / 6, y = 0, w = gridwidth * 2 / 3, h = gridheight },
--    rightHalf = { x = gridwidth / 2, y = 0, w = gridwidth / 2, h = gridheight },
--    rightQuarter = { x = gridwidth * 3 / 4, y = 0, w = gridwidth / 4, h = gridheight },
--    rightThird = { x = gridwidth * 2 / 3, y = 0, w = gridwidth / 3, h = gridheight },
--    rightTwoThirds = { x = gridwidth / 3, y = 0, w = gridwidth * 2 / 3, h = gridheight },
--    topLeftSixth = { x = 0, y = 0, w = gridwidth / 3, h = gridheight / 2 },
--    topLeftTwoSixths = { x = 0, y = 0, w = gridwidth * 2 / 3, h = gridheight / 2 },
--    topMidSixth = { x = gridwidth / 3, y = 0, w = gridwidth / 3, h = gridheight / 2 },
--    topMidTwoSixths = { x = gridwidth / 6, y = 0, w = gridwidth * 2 / 3, h = gridheight / 2 },
--    topRightSixth = { x = gridwidth * 2 / 3, y = 0, w = gridwidth / 3, h = gridheight / 2 },
--    topRightTwoSixths = { x = gridwidth / 3, y = 0, w = gridwidth * 2 / 3, h = gridheight / 2 },
--    botLeftSixth = { x = 0, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
--    botLeftTwoSixths = { x = 0, y = gridheight / 2, w = gridwidth * 2 / 3, h = gridheight / 2 },
--    botMidSixth = { x = gridwidth / 3, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
--    botMidTwoSixths = { x = gridwidth / 6, y = gridheight / 2, w = gridwidth * 2 / 3, h = gridheight / 2 },
--    botRightSixth = { x = gridwidth * 2 / 3, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
--    botRightTwoSixths = { x = gridwidth / 3, y = gridheight / 2, w = gridwidth * 2 / 3, h = gridheight / 2 },
--    topLeftQuarter = { x = 0, y = 0, w = gridwidth / 2, h = gridheight / 2 },
--    topRightQuarter = { x = gridwidth / 2, y = 0, w = gridwidth / 2, h = gridheight / 2 },
--    botLeftQuarter = { x = 0, y = gridheight / 2, w = gridwidth / 2, h = gridheight / 2 },
--    botRightQuarter = { x = gridwidth / 2, y = gridheight / 2, w = gridwidth / 2, h = gridheight / 2 },
--    topLeftEighth = { x = 0, y = 0, w = gridwidth / 4, h = gridheight / 2 },
--    topRightEighth = { x = gridwidth * 3 / 4, y = 0, w = gridwidth / 4, h = gridheight / 2 },
--    botLeftEighth = { x = 0, y = gridheight / 2, w = gridwidth / 4, h = gridheight / 2 },
--    botRightEighth = { x = gridwidth * 3 / 4, y = gridheight / 2, w = gridwidth / 3, h = gridheight / 2 },
--    innerFull = { x = 0, y = 0, w = gridwidth, h = gridheight }
--}

return grid
