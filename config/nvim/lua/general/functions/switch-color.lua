vim.keymap.set("n", "<leader>cs", ":lua Switch_color()<CR>", { noremap = true })

Colors = {
    "tokyonight-night",
    "onedark",
    "catppuccin-latte",
}
Selected_color = 1
function Switch_color()
    Selected_color = (Selected_color % #Colors) + 1
    vim.cmd.colorscheme(Colors[Selected_color])
end
