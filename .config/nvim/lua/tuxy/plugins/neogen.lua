return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
	},
	event = "BufReadPost",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})
	end,
}
