vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.deprecation_warnings = true
vim.g.trouble_lualine = true
vim.g.markdown_recommended_style = 0
require("tuxy.core.lazy")
require("tuxy.core.options")
require("tuxy.core.autocmd")
require("tuxy.core.keymaps")
