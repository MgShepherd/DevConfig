return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup()

		mason_lspconfig.setup({
			"tsserver",
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"bashls",
			"jsonls",
			"jdtls",
			"pyright",
			"rust_analyzer",
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"google-java-format",
				"pylint",
				"eslint_d",
				"checkstyle",
			},
		})
	end,
}
