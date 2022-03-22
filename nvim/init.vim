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
Plug 'williamboman/nvim-lsp-installer'
Plug 'SirVer/ultisnips'
    nnoremap <leader>se :UltiSnipsEdit<CR>
    let g:UltiSnipsSnippetsDir='~/.config/nvim/plugins/vim-snippets/UltiSnips'
    let g:UltiSnipsEditSplit='horizontal'
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsListSnippets='<c-l>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
    nnoremap <F3> :NERDTreeToggle<CR>
Plug 'knubie/vim-kitty-navigator', { 'do': 'cp ./*.py ~/.config/kitty/' }
Plug 'neovimhaskell/haskell-vim'
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
 
" Personalised settings
set hidden			    " Possibility to have more than one unsaved buffers.
set number              " Show line numbering
"set relativenumber      " Use relative numbering instead of absolute
set tabstop=4			" Width of a tab
set shiftwidth=4		" Amount of whitespace to add or remove
set softtabstop=4		" Fine tunes whitespace inserted
set expandtab			" Insert spaces instead of tabs
set smartindent
set lazyredraw
set timeoutlen=450
colorscheme flattened_light

" Key mappings
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap Y y$

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
    ensure_installed = 
    {
        "javascript", "typescript", "tsx", "bash", "python", "c", "lua",
        "c_sharp", "html", "css", "dockerfile", "yaml", "java", "json",
        "kotlin", "regex", "vim"
    },
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

"lua <<EOF
"-- Mappings.
"-- See `:help vim.diagnostic.*` for documentation on any of the below functions
"local opts = { noremap=true, silent=true }
"vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
"vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
"vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
"vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
"
"-- Use an on_attach function to only map the following keys
"-- after the language server attaches to the current buffer
"local on_attach = function(client, bufnr)
"  -- Enable completion triggered by <c-x><c-o>
"  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
"
"  -- Mappings.
"  -- See `:help vim.lsp.*` for documentation on any of the below functions
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
"end
"
"-- Use a loop to conveniently call 'setup' on multiple servers and
"-- map buffer local keybindings when the language server attaches
"local servers = { 'hls' }
"for _, lsp in pairs(servers) do
"  require('lspconfig')[lsp].setup {
"    on_attach = on_attach,
"    flags = {
"      -- This will be the default in neovim 0.7+
"      debounce_text_changes = 150,
"    }
"  }
"end
"EOF

"sumneko lua config
"lua <<EOF
"local sumneko_root_path = "/Users/sam/.config/nvim/lua-language-server"
"local sumneko_binary = "/Users/sam/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
"
"require 'lspconfig'.sumneko_lua.setup {
"    cmd = { sumneko_binary, "-E", sumneko_root_path.."/main.lua" },
"    settings = {
"        Lua = {
"            runtime = {
"                version = 'LuaJIT',
"                path = vim.split(package.path, ';')
"            },
"            diagnostics = {
"                globals = {'vim'}
"            },
"            workspace = {
"                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
"            }
"        }
"    }
"}
"EOF
