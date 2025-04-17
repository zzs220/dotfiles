return{
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    config = function ()
        require('mason').setup()
        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            }
        })
        vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and "; " or ":") .. vim.env.PATH
    end
}
