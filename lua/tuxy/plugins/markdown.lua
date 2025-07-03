return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
	ft = "markdown",
	config = function()
		require("render-markdown").setup({
			completions = { lsp = { enabled = true } },
		})
	end,
}
