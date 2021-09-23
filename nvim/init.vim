" vim-fugitive would be nice for git once you figure out how to use all the
" commands properly - it looks like airblade/git-gutter might be useful too.

let g:mapleader="\<Space>"

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
    nnoremap <silent> <leader><space> :Files<CR>
    nnoremap <silent> <leader>a :Buffers<CR>
Plug 'joshdick/onedark.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'SirVer/ultisnips'
    nnoremap <leader>se :UltiSnipsEdit<CR>
    let g:UltiSnipsSnippetsDir='~/.config/nvim/plugins/vim-snippets/UltiSnips'
    let g:UltiSnipsEditSplit='horizontal'
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsListSnippets='<c-l>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>'
Plug 'honza/vim-snippets'
call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

lua <<EOF
require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
EOF

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
 
" Personalised settings
set hidden			    " Possibility to have more than one unsaved buffers.
set number              " Show line numbering
"set relativenumber      " Use relative numbering instead of absolute
set tabstop=4			" Width of a tab
set shiftwidth=4		" Amount of whitespace to add or remove
set softtabstop=4		" Fine tunes whitespace inserted
set expandtab			" Insert spaces instead of tabs
set lazyredraw
colorscheme flattened_light

" Key mappings
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap Y y$
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Auto expanding
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" Treesitter modules
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "typescript", "tsx", "bash", "python", "c",
                         "lua", "c_sharp", "html", "css", "dockerfile", "yaml" },
	highlight = { enable = true }
}
EOF

" Statusline
set laststatus=2
let g:currentmode={
    \ 'n' : 'NORMAL',
    \ 'v' : 'VISUAL',
    \ 'V' : 'V-Line',
    \ "\<C-V>" : 'V-Block',
    \ 'i' : 'INSERT',
    \ 'R' : 'R ',
    \ 'Rv' : 'V-Replace',
    \ 'c' : 'Command',
    \ 't' : 'Terminal'
    \}

set statusline=
set statusline+=%<      " wrap to here
"set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%f      " show relative file path
set statusline+=\       " space
set statusline+=%h      " show help flag
set statusline+=%m      " show modified flag
set statusline+=%r      " show readonly flag
set statusline+=%=      " expand whitespace evenly
set statusline+=%y      " show filetype
set statusline+=\       " space
set statusline+=%l      " show line number
set statusline+=,       " literal comma
set statusline+=%c      " show column number
