return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	event = "BufRead",
	config = function()
		require("oil").setup()
	end,
}
