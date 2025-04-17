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
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<leader>ct", ":lua Transparent()<CR>", {noremap = true})
vim.keymap.set("n", "<leader>rn", ":lua  vim.o.relativenumber = not vim.o.relativenumber<CR>", { noremap = true })
vim.keymap.set("n", "<leader>mm", ":lua  ToggleMouse()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>k", ":lua  ToggleVL()<CR>", { noremap = true })

vim.diagnostic.config({virtual_text=true})
VirtualLineEnabled = false
function ToggleVL()
    VirtualLineEnabled = not VirtualLineEnabled
    vim.diagnostic.config({virtual_lines = VirtualLineEnabled, virtual_text=not VirtualLineEnabled})
end

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

vim.keymap.set("n", "<leader>cs", ":lua Switch_color()<CR>", { noremap = true })
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
