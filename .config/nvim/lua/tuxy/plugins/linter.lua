return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
			lua = { "luacheck" },
			python = { "ruff", "pydocstyle", "pylint", "vulture" },
			css = { "stylelint" },
			markdown = { "markdownlint-cli2" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			html = { "htmlhint" },
			rust = { "clippy" },
			cpp = { "clangtidy" },
			bash = { "shellcheck", "shellharden" },
			sql = { "sqlfluff", "sqruff" },
			makefile = { "checkmake" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
