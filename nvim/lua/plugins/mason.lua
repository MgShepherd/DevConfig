return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'mfussenegger/nvim-dap',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')
    local mason_nvim_dap = require('mason-nvim-dap')

    mason.setup({})
    mason_lspconfig.setup({
      ensure_installed = { 'jdtls', 'lua_ls', 'gopls' },
      automatic_installation = true,
    })
    mason_tool_installer.setup({
      ensure_installed = {
        'stylua',
        'prettier',
      },
    })
    mason_nvim_dap.setup({
      ensure_installed = {
        'javadbg',
        'javatest',
      },
      automatic_installation = true,
    })
  end,
}
