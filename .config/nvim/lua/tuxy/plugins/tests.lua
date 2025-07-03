return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"rcasia/neotest-bash",
	},
	ft = { "bash", "python", "go", "rust" },
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python"),
				require("neotest-go"),
				require("neotest-rust"),
				require("neotest-bash"),
			},
		})
	end,
}
