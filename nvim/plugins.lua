return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'joshdick/onedark.vim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
    vim.keymap.set('n', '<Leader><Space>', ':Files<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<Leader>a', ':Buffers<CR>', { silent = true, noremap = true })
  use 'neovim/nvim-lspconfig'
  use 'vmchale/dhall-vim'
end)
