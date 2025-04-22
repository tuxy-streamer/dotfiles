return {
	'stevearc/conform.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatted_by_ft = {
				lua = { "stylua" },
				python = { "ruff","isort", "blackd" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd", "eslintd" },
				typescript = { "prettierd", "eslintd" },
				go = { "gofumpt", "goimports", "goimports-reviser", "golines", "gomodifytags", "gotests" },
				yaml = { "yamlfix", "yamlfmt" },
				bash = { "shfmt" },
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
