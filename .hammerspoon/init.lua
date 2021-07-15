win = hs.window.focusedWindow()
frame = win:frame()
screen = win:screen()
max = screen:frame()

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "J", function()
    if frame.w == max.w / 3 and frame.x == max.x then
        frame.w = max.w * 2 / 3
    else
        frame.w = max.w / 3
    end

    frame.x = max.x
    frame.y = max.y
    frame.h = max.h
    win:setFrame(frame) end)


hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "K", function()
    if frame.w == max.w / 3 and frame.x == max.w / 3 then
        frame.w = max.w * 2 / 3
        frame.x = max.w * 1 / 6
    else
        frame.w = max.w / 3
        frame.x = max.w * 1 / 3
    end

    frame.y = max.y
    frame.h = max.h
    win:setFrame(frame)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "L", function()
    if frame.w == max.w / 3 and frame.x == max.w * 2 / 3 then
        frame.w = max.w * 2 / 3
        frame.x = max.w / 3
    else
        frame.w = max.w / 3
        frame.x = max.w * 2 / 3
    end
     
    frame.y = max.y
    frame.h = max.h
    win:setFrame(frame)
end)
