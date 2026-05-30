local o = vim.opt
function ToggleMouse()
    if o.mouse._value == 'a' then
        o.mouse = ''
    else
        o.mouse = 'a'
    end
end
vim.keymap.set("n", "<leader>mm", ":lua  ToggleMouse()<CR>", { noremap = true })
