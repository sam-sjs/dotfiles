local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'joshdick/onedark.vim'
  use 'nanotech/jellybeans.vim'
  use 'jnurmine/Zenburn'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
    vim.keymap.set('n', '<Leader><Space>', ':Files<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Leader>a', ':Buffers<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Leader>g', ':Rg<CR>', { silent = true, noremap = true })
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'vmchale/dhall-vim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    require('nvim-treesitter.configs').setup{
      ensure_installed = { 'haskell', 'lua', 'bash', 'go', 'cmake', 'cpp', 'nix', 'yaml', 'dockerfile', 'rust'},
      highlight = { enable = true }}
  use {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end}
  use {'kylechui/nvim-surround', tag = '*', config = function()
    require('nvim-surround').setup({}) end}
  use 'tpope/vim-fugitive'
    vim.keymap.set('n', '<Leader>g', '<Space>g', { silent = true, noremap = false })
    vim.keymap.set('n', '<Space>gd', ':Gdiff<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Space>gst', ':Git<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Space>gb', ':Git blame<CR>', { silent = true, noremap = true })

    if packer_bootstrap then
      require('packer').sync()
    end
end)
