local g = vim.g
local opt = vim.opt

g.mapleader = ' '

-- Settings
opt.hidden = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.lazyredraw = true
opt.timeoutlen = 1000
opt.termguicolors = true

-- Global Mappings
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { silent = true, noremap = true })
vim.keymap.set('n', 'Y', 'y$', { silent = true, noremap = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
opt.rtp:prepend(lazypath)

-- Load plugins and other modules
require("lazy").setup("plugins")
require("completion")
require("language-servers")
