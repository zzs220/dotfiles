return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function ()
        vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle reveal float<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>E", ":Neotree reveal left<CR>", { noremap = true })
        require("neo-tree").setup({
            filesystem = {
                -- filtered_items = {
                --     visible = true,
                --     show_hidden_count = true,
                --     hide_dotfiles = false,
                --     hide_gitignored = false,
                -- },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
            },
            buffers = { follow_current_file = { enable = true } },
        })
    end
}
