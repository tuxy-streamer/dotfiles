return {
	'stevearc/conform.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff", "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettier", "eslint" },
				typescript = { "prettier", "eslint" },
				go = { "goimports", "goimports-reviser", "golines", "gomodifytags", "gotests", "gofumpt" },
				yaml = { "yamlfix", "yamlfmt" },
				bash = { "shfmt" },
				markdown = { "markdownlint-cli2", "prettier" },
				css = { "prettier" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})
	end,
}
