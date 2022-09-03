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
opt.timeoutlen = 450

-- Colourscheme
opt.termguicolors = true
cmd [[colorscheme onedark]]


-- Mappings
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { silent = true, noremap = true })
vim.keymap.set('n', 'Y', 'y$', { silent = true, noremap = true })
-- vim-fugitive would be nice for git once you figure out how to use all the
-- commands properly - it looks like airblade/git-gutter might be useful too.


--Plug 'williamboman/mason.nvim'
--Plug 'williamboman/mason-lspconfig.nvim'
--Plug 'neovim/nvim-lspconfig'
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
--Plug 'knubie/vim-kitty-navigator', { 'do': 'cp ./*.py ~/.config/kitty/' }
--Plug 'neovimhaskell/haskell-vim'
--Plug 'vmchale/dhall-vim'
--Plug 'LnL7/vim-nix'
--Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
--call plug#end()
--
--if plug_install
--    PlugInstall --sync
--endif
--unlet plug_install
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
--require('mason').setup()
--require('mason-lspconfig').setup({
--    ensure_installed = lsps
--})
--
---- Mappings.
---- See `:help vim.diagnostic.*` for documentation on any of the below functions
--local opts = { noremap=true, silent=true }
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
--
---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
--local on_attach = function(client, bufnr)
--  -- Enable completion triggered by <c-x><c-o>
--  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--  -- Mappings.
--  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  local bufopts = { noremap=true, silent=true, buffer=bufnr }
--  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--  vim.keymap.set('n', '<leader>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, bufopts)
--  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
--  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
--  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
--  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
--end
--
--local lsp_flags = {
--  -- This is the default in Nvim 0.7+
--  debounce_text_changes = 150,
--}
--
--for _, lsp in ipairs(lsps) do
--    require('lspconfig')[lsp].setup{
--        on_attach = on_attach,
--        flags = lsp_flags,
--    }
--end
--EOF
--
-- 
--" Auto expanding
--inoremap (; (<CR>);<C-c>O
--inoremap (, (<CR>),<C-c>O
--inoremap {; {<CR>};<C-c>O
--inoremap {, {<CR>},<C-c>O
--inoremap [; [<CR>];<C-c>O
--inoremap [, [<CR>],<C-c>O
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
--
--"lua <<EOF
--"-- Mappings.
--"-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--"local opts = { noremap=true, silent=true }
--"vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--"vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--"vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--"vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
--"
--"-- Use an on_attach function to only map the following keys
--"-- after the language server attaches to the current buffer
--"local on_attach = function(client, bufnr)
--"  -- Enable completion triggered by <c-x><c-o>
--"  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--"
--"  -- Mappings.
--"  -- See `:help vim.lsp.*` for documentation on any of the below functions
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--"  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--"end
--"
--"-- Use a loop to conveniently call 'setup' on multiple servers and
--"-- map buffer local keybindings when the language server attaches
--"local servers = { 'hls' }
--"for _, lsp in pairs(servers) do
--"  require('lspconfig')[lsp].setup {
--"    on_attach = on_attach,
--"    flags = {
--"      -- This will be the default in neovim 0.7+
--"      debounce_text_changes = 150,
--"    }
--"  }
--"end
--"EOF
--
--"sumneko lua config
--"lua <<EOF
--"local sumneko_root_path = "/Users/sam/.config/nvim/lua-language-server"
--"local sumneko_binary = "/Users/sam/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
--"
--"require 'lspconfig'.sumneko_lua.setup {
--"    cmd = { sumneko_binary, "-E", sumneko_root_path.."/main.lua" },
--"    settings = {
--"        Lua = {
--"            runtime = {
--"                version = 'LuaJIT',
--"                path = vim.split(package.path, ';')
--"            },
--"            diagnostics = {
--"                globals = {'vim'}
--"            },
--"            workspace = {
--"                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
--"            }
--"        }
--"    }
--"}
--"EOF
