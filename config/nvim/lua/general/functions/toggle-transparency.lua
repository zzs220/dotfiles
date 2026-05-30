local transparent = true

local function set_tokyonight()
  require("tokyonight").setup({
    transparent = transparent,
    styles = {
      sidebars = transparent and "transparent" or "dark",
      floats = transparent and "transparent" or "dark",
    },
  })
  vim.cmd.colorscheme("tokyonight-night")
end

function ToggleTransparency()
  transparent = not transparent
  set_tokyonight()
end

vim.keymap.set("n", "<leader>ct", ToggleTransparency, {
  desc = "Toggle transparency",
})
