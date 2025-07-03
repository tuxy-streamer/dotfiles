return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		{
			"rafamadriz/friendly-snippets",
			lazy = true,
		},
		{
			"j-hui/fidget.nvim",
			event = "LspAttach",
		},
		"saadparwaiz1/cmp_luasnip",
	},
	event = "InsertEnter",
	config = function()
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			}, {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			}),
			performance = {
				debounce = 0,
				throttle = 0,
				fetching_timeout = 50,
				confirm_resolve_timeout = 80,
				max_view_entries = 10,
			},
			experimental = {
				ghost_text = false,
			},
		})
	end,
}
