local window_manager = require('window_manager')

-- Automatic reloading of hammerspoon config on change
local function reloadConfig(files)
    local   doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME").."/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
