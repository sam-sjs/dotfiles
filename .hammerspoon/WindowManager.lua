hyper = {"cmd", "alt", "ctrl", "shift"}

local screen = hs.screen.mainScreen():frame()

local screenPosition = {
    leftThird = {
        x = screen.x, y = screen.y, w = screen.w / 3, h = screen.h
    },
    midThird = {
        x = screen.w / 3, y = screen.y, w = screen.w / 3, h = screen.h
    },
    rightThird = {
        x = screen.w * 2 / 3, y = screen.y, w = screen.w / 3, h = screen.h
    },
    leftTwoThird = {
        x = screen.x, y = screen.y, w = screen.w * 2 / 3, h = screen.h
    },
    midTwoThird = {
        x = screen.w / 6, y = screen.y, w = screen.w * 2 / 3, h = screen.h
    },
    rightTwoThird = {
        x = screen.w / 3, y = screen.y, w = screen.w * 2 / 3, h = screen.h
    },
    topLeftSixth = {
        x = screen.x, y = screen.y, w = screen.w / 3, h = screen.h / 2
    }, 
    topMidSixth = {
        x = screen.w / 3, y = screen.y, w = screen.w / 3, h = screen.h / 2
    }, 
    topRightSixth = {
        x = screen.w * 2 / 3, y = screen.y, w = screen.w / 3, h = screen.h / 2
    }, 
}

function isEqual(frame1, frame2)
    return frame1.x == frame2.x and frame1.y == frame2.y and
           frame1.w == frame2.w and frame1.h == frame2.h
end

function moveFocusedWindow(position, altPosition)
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    if isEqual(frame, position) then
        window:setFrame(altPosition)
    else
        window:setFrame(position)
    end
end

hs.hotkey.bind(hyper, "J", function()
    moveFocusedWindow(screenPosition.leftThird, screenPosition.leftTwoThird)
end)

hs.hotkey.bind(hyper, "K", function()
    moveFocusedWindow(screenPosition.midThird, screenPosition.midTwoThird)
end)

hs.hotkey.bind(hyper, "L", function()
    moveFocusedWindow(screenPosition.rightThird, screenPosition.rightTwoThird)
end)

--hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "J", function()
--    local win = hs.window.focusedWindow()
--    local frame = win:frame()
--    local screen = win:screen():frame()
--
--    if frame.w == screen.w / 3 and frame.x == screen.x then
--        frame.w = screen.w * 2 / 3
--    else
--        frame.w = screen.w / 3
--    end
--
--    frame.x = screen.x
--    frame.y = screen.y
--    frame.h = screen.h
--    win:setFrame(frame)
--end)
--
--hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "K", function()
--    local win = hs.window.focusedWindow()
--    local frame = win:frame()
--    local screen = win:screen():frame()
--
--    if frame.w == screen.w / 3 and frame.x == screen.w / 3 then
--        frame.w = screen.w * 2 / 3
--        frame.x = screen.w * 1 / 6
--    else
--        frame.w = screen.w / 3
--        frame.x = screen.w * 1 / 3
--    end
--
--    frame.y = screen.y
--    frame.h = screen.h
--    win:setFrame(frame)
--end)
--
--hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "L", function()
--    local win = hs.window.focusedWindow()
--    local frame = win:frame()
--    local screen = win:screen():frame()
--
--    if frame.w == screen.w / 3 and frame.x == screen.w * 2 / 3 then
--        frame.w = screen.w * 2 / 3
--        frame.x = screen.w / 3
--    else
--        frame.w = screen.w / 3
--        frame.x = screen.w * 2 / 3
--    end
--     
--    frame.y = screen.y
--    frame.h = screen.h
--    win:setFrame(frame)
--end)
