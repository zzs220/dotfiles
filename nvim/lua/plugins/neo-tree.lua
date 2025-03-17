return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function ()
        vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle float<CR>", { noremap = true })
    end
}
