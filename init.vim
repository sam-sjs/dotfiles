" Auto install vim-plug plugin manager if not installed

" Key mappings
:nnoremap <silent> <F3> :nohlsearch<CR>

" Install vim-plug if not installed
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

" List plugins to be loaded
call plug#begin('~/.config/nvim/plugins')
Plug 'knubie/vim-kitty-navigator'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

" Themeing
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme onedark
set title
let &titlestring='%t - nvim'
 
" Personalised settings
set hidden			" Possibility to have more than one unsaved buffers.
set nu rnu			" Line numbering - relative numbering
set tabstop=4			" Width of a tab
set shiftwidth=4		" Amount of whitespace to add or remove
set softtabstop=4		" Fine tunes whitespace inserted
set expandtab			" Insert spaces instead of tabs



" Treesitter modules
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "typescript", "tsx", "bash", "python", "c",
                         "lua", "c_sharp", "html", "css" },
	highlight = { enable = true }
}
EOF
