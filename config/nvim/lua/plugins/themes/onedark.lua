return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup({
      transparent = true,
      style = 'cool',
      highlights = {
        NormalFloat = { bg = 'None' },
        FloatBorder = { bg = 'None' },
        Pmenu = { bg = 'None' },
        PmenuSel = { bg = '#3e4451' },
        PmenuSbar = { bg = '#2c313a' },
      },
    })
    require('onedark').load()
  end
}
