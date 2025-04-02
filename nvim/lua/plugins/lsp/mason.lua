return{
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    config = function ()
        require('mason').setup()
        local lsp_zero = require('lsp-zero')
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
    end
}
