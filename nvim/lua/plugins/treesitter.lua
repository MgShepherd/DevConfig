return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')

    configs.setup({
      ensure_installed = { 'java', 'lua', 'vimdoc', 'query', 'odin' },
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
    })
  end,
}
