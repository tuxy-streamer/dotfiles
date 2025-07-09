return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	event = "BufReadPost",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})
	end,
}
