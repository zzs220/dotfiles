return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function ()
    vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true })
    require("toggleterm").setup{
      direction = 'float',
    }
  end
}
