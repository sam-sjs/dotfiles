-- Mappings.
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- Causing issues on load
--  vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}


-- Servers
require('lspconfig')['dhall_lsp_server'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['hls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['sumneko_lua'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim', 'awesome', 'root', 'client', 'screen'},
            },
        },
    },
}

require('lspconfig')['bashls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['cmake'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['rnix'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
