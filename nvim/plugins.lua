return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'joshdick/onedark.vim'
  use 'nanotech/jellybeans.vim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
    vim.keymap.set('n', '<Leader><Space>', ':Files<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Leader>a', ':Buffers<CR>', { silent = true, noremap = true })
  use 'neovim/nvim-lspconfig'
  use 'vmchale/dhall-vim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    require('nvim-treesitter.configs').setup{
      ensure_installed = { 'haskell', 'lua', 'bash', 'go', 'cmake' },
      highlight = { enable = true }}
  use {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end}
  use {'kylechui/nvim-surround', tag = '*', config = function()
    require('nvim-surround').setup({}) end}
  use 'tpope/vim-fugitive'
    vim.keymap.set('n', '<Leader>g', '<Space>g', { silent = true, noremap = false })
    vim.keymap.set('n', '<Space>gd', ':Gdiff<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Space>gst', ':Git<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Space>gb', ':Git blame<CR>', { silent = true, noremap = true })
end)
