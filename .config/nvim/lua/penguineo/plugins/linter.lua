return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {
			go = { "golangcilint" },
			lua = { "luacheck" },
			python = { "mypy" },
			css = { "stylelint" },
			markdown = { "markdownlint-cli2" },
			yaml = { "yamllint" },
			html = { "htmlhint" },
			rust = { "clippy" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
