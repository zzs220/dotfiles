vim.keymap.set("n", "<leader>cs", ":lua Switch_color()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>cd", ":lua Toggle_dark_theme()<CR>", { noremap = true })

local dark_schemes = { "tokyonight-night", "onedark" }
local light_schemes = { "catppuccin-latte" }

local dark_mode = true
local current_index = 1

function Switch_color()
  local active_list = dark_mode and dark_schemes or light_schemes
  current_index = (current_index % #active_list) + 1
  vim.o.background = dark_mode and "dark" or "light"
  vim.cmd.colorscheme(active_list[current_index])
end

function Toggle_dark_theme()
  dark_mode = not dark_mode
  current_index = 0
  Switch_color()
end

-- Set Color
if vim.env.DISPLAY == '' then
    vim.cmd.colorscheme('elflord')
else
    current_index = 1
    Switch_color()
end
