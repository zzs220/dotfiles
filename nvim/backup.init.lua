-- .vimrc
local o = vim.opt
o.number = true
o.autoindent = true
o.smartindent = true
o.expandtab = true
o.tabstop = 4
o.softtabstop = -1
o.shiftwidth = 4
o.mouse = ''
o.hlsearch = false
o.incsearch = true
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle float<CR>", { noremap = true })

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'nvim-treesitter/nvim-treesitter',  build = ":TSUpdate" },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'jiangmiao/auto-pairs' },
    { 'L3MON4D3/LuaSnip' },
    -- Colorschemes
    { 'folke/tokyonight.nvim' },
    { 'navarasu/onedark.nvim' },
    --{'rose-pine/neovim'},
    -- neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            --"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'numToStr/Comment.nvim'},
    {'kylechui/nvim-surround'},
})
-- Treesitter configs
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
---
-- LSP setup
---
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
       lsp_zero.default_setup,
        lua_ls = function()
            -- (Optional) configure lua language server
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and "; " or ":") .. vim.env.PATH
---
-- Autocompletion config
---
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<tab>'] = cmp_action.tab_complete(),
        -- ['<S-tab>'] = cmp_action.select_prev_or_fallback(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>ft', ':Telescope<CR>', {})
-- nvim-surround
require('nvim-surround').setup()
-- nvim-ufo FOLDING
-- Appearances
vim.opt.termguicolors = true
require('onedark').setup {
    style = 'darker'
}

vim.api.nvim_set_keymap("n", "<leader>ct", ":lua Transparent()<CR>", { noremap = true })
function Transparent()
    require("onedark").setup({
        transparent = true
    })
    vim.cmd.colorscheme('onedark')
    require("onedark").setup({
        transparent = false
    })
end

vim.api.nvim_set_keymap("n", "<leader>cs", ":lua Switch_color()<CR>", { noremap = true })
Colors = {
    "onedark",
    "tokyonight-night"
}
Selected_color = 1
function Switch_color()
    Selected_color = Selected_color + 1
    vim.cmd.colorscheme(Colors[Selected_color % #Colors + 1])
end

--Scripts
function SetTab(number)
    vim.opt.tabstop = number
    vim.opt.shiftwidth = number
end

  if vim.env.DISPLAY=='' then
      vim.cmd.colorscheme('elflord')
  else
      Switch_color()
      Transparent()
  end
-- Switch_color()
