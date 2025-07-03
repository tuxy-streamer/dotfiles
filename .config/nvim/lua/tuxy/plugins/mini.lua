return {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			skip_ts = { "string" },
			skip_unbalanced = true,
			markdown = true,
		},
		config = function()
			require("mini.pairs").setup({})
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = "BufReadPost",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
				},
				symbol = "│",
				options = {
					try_as_border = true,
				},
			})
		end,
	},
}
