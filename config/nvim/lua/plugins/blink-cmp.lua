return
{
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config

    event = 'VimEnter',
    opts = {
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = 'none',
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down' },
            ['<C-u>'] = { 'scroll_documentation_up' },
            ["<Tab>"] = {
                "select_next",
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                "select_prev",
                "snippet_backward",
                "fallback",
            },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            list = { selection  = {preselect = false}},
            documentation = {
              auto_show = true,
              window = { border = 'rounded' },
          },
            accept = { auto_brackets = { enabled = false } },
            menu = { border = 'rounded' },
        },
        signature = {
          enabled = true,
          window = { border = 'rounded' }
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
