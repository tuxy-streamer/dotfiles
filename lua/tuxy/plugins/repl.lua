return {
	"pappasam/nvim-repl",
	ft = { "python" },
	opts = {
		open_window_default = "vertical split new",
	},
	keys = {
		{ "<Leader>rc", "<Plug>(ReplSendCell)", mode = "n", desc = "ReplSendCell" },
		{ "<Leader>rr", "<Plug>(ReplSendLine)", mode = "n", desc = "ReplSendLine" },
		{ "<Leader>r", "<Plug>(ReplSendVisual)", mode = "x", desc = "ReplSendVisual" },
	},
}
