return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function ()
        local position = "float"

        local function toggle_position()
            if position == "float" then
                position = "left"
            else
                position = "float"
            end
            vim.g.position = position
            vim.cmd("Neotree toggle reveal " .. position)
        end

        vim.keymap.set("n", "<leader>e", function() vim.cmd("Neotree toggle reveal " .. position) end)
        vim.keymap.set("n", "<leader>E", toggle_position)
        require("neo-tree").setup({
            popup_border_style = "rounded",
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
