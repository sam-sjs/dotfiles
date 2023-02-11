local g = vim.g
local cmd = vim.cmd

g.mapleader = ' '

require('plugins')
require('language-servers')

-- Settings
local opt = vim.opt
opt.hidden = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.lazyredraw = true
opt.timeoutlen = 1000

-- Colourscheme
opt.termguicolors = true
cmd [[colorscheme onedark]]


-- Mappings
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { silent = true, noremap = true })
vim.keymap.set('n', 'Y', 'y$', { silent = true, noremap = true })

-- vim-fugitive would be nice for git once you figure out how to use all the
-- commands properly - it looks like airblade/git-gutter might be useful too.


--Plug 'SirVer/ultisnips'
--    nnoremap <leader>se :UltiSnipsEdit<CR>
--    let g:UltiSnipsSnippetsDir='~/.config/nvim/plugins/vim-snippets/UltiSnips'
--    let g:UltiSnipsEditSplit='horizontal'
--    let g:UltiSnipsExpandTrigger='<tab>'
--    let g:UltiSnipsListSnippets='<c-l>'
--    let g:UltiSnipsJumpForwardTrigger='<c-j>'
--    let g:UltiSnipsJumpBackwardTrigger='<c-k>'
--Plug 'honza/vim-snippets'
--Plug 'preservim/nerdtree'
--    nnoremap <F3> :NERDTreeToggle<CR>
--Plug 'LnL7/vim-nix'
--Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
--call plug#end()
--
--lua << EOF
--local lsps = {
--    'bashls',
--    'dhall_lsp_server',
--    'dockerls',
--    'gopls',
--    'hls',
--    'html',
--    'tsserver',
--    'yamlls'
--}
--
--" Statusline
--set laststatus=2
--let g:currentmode={
--    \ 'n' : 'NORMAL',
--    \ 'v' : 'VISUAL',
--    \ 'V' : 'V-Line',
--    \ "\<C-V>" : 'V-Block',
--    \ 'i' : 'INSERT',
--    \ 'R' : 'R ',
--    \ 'Rv' : 'V-Replace',
--    \ 'c' : 'Command',
--    \ 't' : 'Terminal'
--    \}
--
--set statusline=
--set statusline+=%<      " wrap to here
--"set statusline+=\ %{toupper(g:currentmode[mode()])}
--set statusline+=%f      " show relative file path
--set statusline+=\       " space
--set statusline+=%h      " show help flag
--set statusline+=%m      " show modified flag
--set statusline+=%r      " show readonly flag
--set statusline+=%=      " expand whitespace evenly
--set statusline+=%y      " show filetype
--set statusline+=\       " space
--set statusline+=%l      " show line number
--set statusline+=,       " literal comma
--set statusline+=%c      " show column number
