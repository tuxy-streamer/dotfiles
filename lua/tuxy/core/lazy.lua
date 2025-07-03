vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "tuxy.plugins" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	install = { colorscheme = { "gruvbox" } },
	checker = {
		enabled = true,
		notify = false,
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"zip",
					"zipPlugin",
					"tar",
					"tarPlugin",
					"getscript",
					"getscriptPlugin",
					"vimball",
					"vimballPlugin",
					"2html_plugin",
					"logipat",
					"rrhelper",
					"netrw",
					"netrwPlugin",
					"netrwSettings",
					"netrwFileHandlers",
				},
			},
		},
	},
	profile = {
		enabled = true,
		threshold = 1,
	},
})
