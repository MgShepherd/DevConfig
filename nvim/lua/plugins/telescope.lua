return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          'build/',
          'node_modules/',
          '.git/',
          'gradle/wrapper/',
          'gradlew',
        },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })
  end,
}
