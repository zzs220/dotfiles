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
        ['<C-j>'] = {'select_next', 'fallback'},
        ['<C-k>'] = {'select_prev', 'fallback'},
        ['<CR>'] = {'accept', 'fallback'},
        ['<C-d>'] = {'scroll_documentation_down'},
        ['<C-u>'] = {'scroll_documentation_up'},
        ["<Tab>"] = {
            function(cmp)
                return cmp.select_next()
            end,
            "snippet_forward",
            "fallback",
        },
        ["<S-Tab>"] = {
            function(cmp)
                return cmp.select_prev()
            end,
            "snippet_backward",
            "fallback",
        },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
        documentation = { auto_show = true },
        accept = {auto_brackets = {enabled = false}},
    },
    signature = {enabled = true},
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
