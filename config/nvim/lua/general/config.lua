require("general.functions.init")

local o = vim.opt
o.number = true
o.autoindent = true
o.smartindent = true
o.expandtab = true
o.tabstop = 2
o.softtabstop = -1
o.shiftwidth = 2
o.mouse = ''
o.hlsearch = false
o.incsearch = true

vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<leader>rn", ":lua  vim.o.relativenumber = not vim.o.relativenumber<CR>", { noremap = true })
vim.keymap.set("n", "<leader>k", ":lua  vim.diagnostic.open_float()<CR>", { noremap = true })
vim.keymap.set("n", "gd", ":lua  vim.lsp.buf.definition()<CR>", { noremap = true })
vim.keymap.set("n", "<F2>", ":lua  vim.lsp.buf.format()<CR>", { noremap = true })
-- keep selection after indenting in visual mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Set Color
if vim.env.DISPLAY == '' then
    vim.cmd.colorscheme('elflord')
else
    Selected_color = Selected_color - 1
    Switch_color()
end
