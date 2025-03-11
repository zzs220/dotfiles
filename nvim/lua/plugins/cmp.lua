return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function ()
        local lsp_zero = require('lsp-zero')
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
                ['<S-tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })
    end
}
