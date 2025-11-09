return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
			lua = { "luacheck" },
			python = { "ruff", "mypy" },
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

		-- -- Mypy
		-- local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
		-- lint.linters.mypy.args = {
		-- 	"--show-column-numbers",
		-- 	"--show-error-end",
		-- 	"--strict",
		-- 	"--python-executable",
		-- 	venv_python,
		-- }

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
