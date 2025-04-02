return {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- lsp_zero.default_keymaps({ buffer = bufnr })
        end)
    end
}
