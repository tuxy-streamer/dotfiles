return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	event = "BufReadPre",
	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"asm-lsp",
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"ruff",
				"marksman",
				"bashls",
				"jsonls",
				"zls",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "tab",
										indent_size = "1",
									},
								},
							},
						},
					})
				end,
			},
		})


		vim.diagnostic.config({
			float = {
				focusable = false,
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
