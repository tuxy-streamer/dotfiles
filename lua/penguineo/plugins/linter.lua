return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {
			go = { "golangcilint" },
			lua = { "luacheck" },
			python = { "ruff" },
			css = { "stylelint" },
			markdown = { "markdownlint-cli2" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			html = { "htmlhint" },
			rust = { "clippy" },
			bash = { "shellcheck" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
