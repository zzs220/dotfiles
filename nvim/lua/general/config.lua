local o = vim.opt
o.number = true
o.autoindent = true
o.smartindent = true
o.expandtab = true
o.tabstop = 4
o.softtabstop = -1
o.shiftwidth = 4
o.mouse = ''
o.hlsearch = false
o.incsearch = true
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ct", ":lua Transparent()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rn", ":lua  vim.o.relativenumber = not vim.o.relativenumber<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>mm", ":lua  ToggleMouse()<CR>", { noremap = true })

function ToggleMouse()
    if o.mouse._value == 'a' then
        o.mouse = ''
    else
        o.mouse = 'a'
    end
end

function Transparent()
    require("onedark").setup({
        transparent = true,
        style = 'darker',
    })
    vim.cmd.colorscheme('onedark')
    require("onedark").setup({
        style = 'darker',
        transparent = false,
    })
end

vim.api.nvim_set_keymap("n", "<leader>cs", ":lua Switch_color()<CR>", { noremap = true })
Colors = {
    "onedark",
    "tokyonight-night"
}
Selected_color = 1
function Switch_color()
    Selected_color = Selected_color + 1
    vim.cmd.colorscheme(Colors[Selected_color % #Colors + 1])
end

--Scripts
function SetTab(number)
    vim.opt.tabstop = number
    vim.opt.shiftwidth = number
end

if vim.env.DISPLAY=='' then
    vim.cmd.colorscheme('elflord')
else
    -- Switch_color()
    Transparent()
end
