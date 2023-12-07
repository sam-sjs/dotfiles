local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua:vim:lsp:omnifunc'

      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<Leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({'n', 'v'}, '<Leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<Leader>f', function ()
        vim.lsp.buf.format { async = true }
    end, opts)
  end
})

-- Servers
require('lspconfig')['dhall_lsp_server'].setup{
    capabilities = capabilities,
}

require('lspconfig')['hls'].setup{
    capabilities = capabilities,
}

require('lspconfig')['gopls'].setup{
    capabilities = capabilities,
}

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
  capabilities = capabilities,
}

require('lspconfig')['bashls'].setup{
    capabilities = capabilities,
}

require('lspconfig')['cmake'].setup{
    capabilities = capabilities,
}

require('lspconfig')['clangd'].setup{
    capabilities = capabilities,
}

require('lspconfig')['rnix'].setup{
    capabilities = capabilities,
}

require('lspconfig')['rust_analyzer'].setup{
    capabilities = capabilities,
}
