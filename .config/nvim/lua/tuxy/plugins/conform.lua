return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd", "eslint_d" },
				typescript = { "prettierd", "eslint_d" },
				go = { "gofumpt", "goimports-reviser", "golines","gomodifytags", "gotests" },
				yaml = { "yamlfix", "yamlfmt" },
				json = { "fixjson", "prettierd" },
				bash = { "shellcheck", "shellharden", "shfmt" },
				markdown = { "prettierd" },
				css = { "prettierd" },
				sql = {"pgformatter"}
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
