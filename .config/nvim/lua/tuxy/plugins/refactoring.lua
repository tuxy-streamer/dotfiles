return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "python", "go", "rust" },
	opts = {},
	conig = function()
		require("refactoring").setup({})
	end,
}
