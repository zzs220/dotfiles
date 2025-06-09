return{
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fq', builtin.resume, {})
        vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>ft', ':Telescope<CR>', {})
    end
}
