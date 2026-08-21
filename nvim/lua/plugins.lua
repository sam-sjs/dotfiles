return {
    -- Colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "frappe",
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },

    -- Fuzzy Finder
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
        keys = {
            { "<Leader><Space>", ":Files<CR>", silent = true },
            { "<Leader>a", ":Buffers<CR>", silent = true },
            { "<Leader>r", ":Rg<CR>", silent = true },
        }
    },

    -- LSP & Autocompletion Dependencies
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "vmchale/dhall-vim",

    -- Tree-sitter Manager
    {
        "romus204/tree-sitter-manager.nvim",
        config = function()
            require("tree-sitter-manager").setup({
                ensure_installed = { 'lua', 'bash', 'go', 'cpp', 'nix', 'yaml', 'dockerfile', 'rust' },
            })
        end
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- Git Fugitive
    {
        "tpope/vim-fugitive",
        keys = {
            { "<Leader>g", ":Git ", remap = true },
            { "<Leader>gd", ":Gdiff<CR>", silent = true },
            { "<Leader>gst", ":Git<CR>", silent = true },
            { "<Leader>gb", ":Git blame<CR>", silent = true },
        }
    }
}
