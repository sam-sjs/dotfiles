local wm = require('window_manager')
local g = require('grid')
local hyper = {"cmd", "alt", "ctrl"}

-- -----------------------------------------------------------------------------
-- Layout Mapping (Key -> List of Grid Positions to Cycle)
-- -----------------------------------------------------------------------------
local p = g.presets
local layouts = {
    -- Basic Halves/Quarters
    H = { p.leftHalf, p.leftQuarter },
    [";"] = { p.rightHalf, p.rightQuarter },
    
    -- Thirds (Left/Center/Right)
    J = { p.leftThird, p.leftTwoThirds },
    K = { p.midThird, p.midTwoThirds, p.midHalf },
    L = { p.rightThird, p.rightTwoThirds },
    
    -- Top Row (Sixths)
    U = { p.topLeftSixth, p.topLeftTwoSixths },
    I = { p.topMidSixth, p.topMidTwoSixths },
    O = { p.topRightSixth, p.topRightTwoSixths },
    
    -- Bottom Row (Sixths)
    M = { p.botLeftSixth, p.botLeftTwoSixths },
    [","] = { p.botMidSixth, p.botMidTwoSixths },
    ["."] = { p.botRightSixth, p.botRightTwoSixths },
    
    -- Corners (Quarters/Eighths)
    Y = { p.topLeftQuarter, p.topLeftEighth },
    P = { p.topRightQuarter, p.topRightEighth },
    N = { p.botLeftQuarter, p.botLeftEighth },
    ["/"] = { p.botRightQuarter, p.botRightEighth },
    
    -- Fullscreen
    ["return"] = { p.full }
}

-- Bind Layout Cycles
for key, positions in pairs(layouts) do
    hs.hotkey.bind(hyper, key, function() wm.cycleWindow(positions) end)
end

-- -----------------------------------------------------------------------------
-- Window Expansion (Arrow Keys)
-- -----------------------------------------------------------------------------
local arrows = { 
    left = "west", 
    right = "east", 
    up = "north", 
    down = "south" 
}

for key, dir in pairs(arrows) do
    hs.hotkey.bind(hyper, key, function() wm.expandWindow(dir) end)
end

-- -----------------------------------------------------------------------------
-- Auto-Reload Config
-- -----------------------------------------------------------------------------
local function reloadConfig(files)
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            hs.reload()
            return
        end
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon Config Reloaded")
