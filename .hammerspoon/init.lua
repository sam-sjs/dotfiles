hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "J", function()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    frame.x = max.x 
    frame.y = max.y
    frame.h = max.h
    if frame.w == max.w then
        frame.w = max.w * 2 / 3 -- not going to 2/3 of the width
    else
        frame.w = max.w / 3
    end
    win:setFrame(frame)
end)


hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "K", function()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    frame.x = max.x --this needs to be 1/3 across the screen 
    frame.y = max.y
    frame.h = max.h
    frame.w = max.w
    win:setFrame(frame)
end)
