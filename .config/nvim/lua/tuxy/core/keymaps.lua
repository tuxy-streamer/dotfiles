local map = vim.keymap.set

-- General keymaps
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "General: Clear search highlight" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal: Exit insert mode" })

-- DAP keymaps
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP: Toggle Breakpoint" })
map("n", "<leader>dr", "<cmd>DapToggleRepl<CR>", { desc = "DAP: Toggle REPL" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "DAP: Continue" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "DAP: Step Into" })
map("n", "<leader>do", "<cmd>DapStepOut<CR>", { desc = "DAP: Step Out" })
map("n", "<leader>dO", "<cmd>DapStepOver<CR>", { desc = "DAP: Step Over" })
map("n", "<leader>dP", "<cmd>DapPause<CR>", { desc = "DAP: Pause" })
map("n", "<leader>dt", "<cmd>DapTerminate<CR>", { desc = "DAP: Terminate" })

-- custom function keymaps
local dap = require("dap")
local dap_widgets = require("dap.ui.widgets")
local function dap_cond_bp()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end

local function dap_continue_args()
	require("dap")
	dap.continue({ before = get_args })
end
map("n", "<leader>dB", dap_cond_bp, { desc = "DAP: Conditional Breakpoint" })
map("n", "<leader>da", dap_continue_args, { desc = "DAP: Continue with Args" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
map("n", "<leader>dg", dap.goto_, { desc = "DAP: Go to Line" })
map("n", "<leader>dj", dap.down, { desc = "DAP: Move Down Frame" })
map("n", "<leader>dk", dap.up, { desc = "DAP: Move Up Frame" })
map("n", "<leader>dl", dap.run_last, { desc = "DAP: Run Last" })
map("n", "<leader>ds", dap.session, { desc = "DAP: Show Session Info" })
map("n", "<leader>dw", dap_widgets.hover, { desc = "DAP: Hover Widget" })

-- GitSigns setup and keymaps
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function map_buf(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		map_buf("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "GitSigns: Stage Hunk" })
		map_buf("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "GitSigns: Reset Hunk" })
		map_buf("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "GitSigns: Stage Buffer" })
		map_buf("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "GitSigns: Reset Buffer" })
		map_buf("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "GitSigns: Preview Hunk" })
		map_buf("n", "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<CR>", { desc = "GitSigns: Preview Hunk Inline" })
		map_buf("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "GitSigns: Blame Line (Full)" })

		-- custom function keymaps
		map_buf("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]h", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, { desc = "GitSigns: Next Hunk" })

		map_buf("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[h", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, { desc = "GitSigns: Previous Hunk" })
		map_buf("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "GitSigns: Stage Hunk (Visual)" })
		map_buf("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "GitSigns: Reset Hunk (Visual)" })
		map_buf("n", "<leader>hd", gs.diffthis, { desc = "GitSigns: Diff This" })
		map_buf("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "GitSigns: Diff This ~" })
		map_buf("n", "<leader>hQ", function()
			gs.setqflist("all")
		end, { desc = "GitSigns: Quickfix All Hunks" })
		map_buf("n", "<leader>hq", gs.setqflist, { desc = "GitSigns: Quickfix Hunks" })
		map_buf("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "GitSigns: Toggle Line Blame" })
		map_buf("n", "<leader>tw", gs.toggle_word_diff, { desc = "GitSigns: Toggle Word Diff" })
		map_buf({ "o", "x" }, "ih", gs.select_hunk, { desc = "GitSigns: Select Hunk" })
	end,
})

-- LSP keymaps
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP: Go to Definition" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP: Show References" })
map("n", "gws", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "LSP: Workspace Symbols" })
map("n", "gds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP: Document Symbols" })
map("n", "<leader>rr", "<cmd>LspRestart<CR>", { desc = "LSP: Restart Server" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to Declaration" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: Show Diagnostics" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename Symbol" })

-- Telescope keymaps
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
map("n", "<leader>sl", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
map("n", "<leader>so", "<cmd>Telescope builtin<CR>", { desc = "Telescope options" })
map("n", "<leader>sv", "<cmd>Telescope vim_options<CR>", { desc = "Telescope vim options" })
map("n", "<leader>sg", "<cmd>Telescope git_files<CR>", { desc = "Telescope git files" })

-- Refactoring keymaps
map("x", "<leader>re", "<cmd>Refactor extract <CR>", { desc = "Refactor: Extract function" })
map("x", "<leader>rf", "<cmd>Refactor extract_to_file <CR>", { desc = "Refactor: Extract function to file" })
map("x", "<leader>rv", "<cmd>Refactor extract_var <CR>", { desc = "Refactor: Extract variable" })
map({ "n", "x" }, "<leader>ri", "<cmd>Refactor inline_var<CR>", { desc = "Refactor: Inline variable" })
map("n", "<leader>rI", "<cmd>Refactor inline_func<CR>", { desc = "Refactor: Inline function" })
map("n", "<leader>rb", "<cmd>Refactor extract_block<CR>", { desc = "Refactor: Extract block" })
map("n", "<leader>rbf", "<cmd>Refactor extract_block_to_file<CR>", { desc = "Refactor: Extract block to file" })

-- Oil keymaps
map("n", "\\", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- Neogen keymaps
map("n", "<leader>nf", "<cmd>Neogen func<CR>", { desc = "Neogen: Generate Function docs" })
map("n", "<leader>nt", "<cmd>Neogen type<CR>", { desc = "Neogen: Generate Type/Class docs" })
