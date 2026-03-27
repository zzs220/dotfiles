return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup({
            highlight={
                enable=true,
            },
            indent = {
                enable = false
            },
            ensure_installed = {},
            auto_install = true,
            sync_install = false,
            additional_vim_regex_highlighting = false,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>v",
                    node_incremental = "<C-k>",
                    scope_incremental = false,
                    node_decremental = "<C-j>",
                },
            },
        })
    end,
}
