return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
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
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Assembly
				"asmfmt",
				-- Go
				"gofumpt",
				"golangci-lint",
				"goimports-reviser",
				"golines",
				"gomodifytags",
				"gotests",
				-- Python
				"pylint",
				"pydocstyle",
				"vulture",
				-- Lua
				"luacheck",
				"stylua",
				-- Git
				"gitleaks",
				"gitlint",
				-- Rust
				"codelldb",
				-- JS/TS
				"prettierd",
				"eslint_d",
				-- Yaml
				"yamllint",
				"yamlfix",
				"yamlfmt",
				-- Json
				"jsonlint",
				"fixjson",
				-- Bash
				"shellcheck",
				"shellharden",
				"shfmt",
				-- Make
				"checkmake",
				-- Css
				"stylelint",
				-- Markdown
				"markdownlint-cli2",
				-- Html
				"htmlhint",
				-- C++
				"clangtidy",
				-- Sql
				"sqlfluff",
				"sqruff",
				"pgformatter",
			},
			auto_update = true,
			run_on_start = true,
			debounce_hours = 10,
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"asm_lsp",
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
