return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			require("telescope").setup({
				pickers = {
					find_files = {
						themes = "ivy",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			require("telescope").load_extension("fzf")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<leader>so", builtin.builtin, { desc = "Telescope options" })
			vim.keymap.set("n", "<leader>sv", builtin.vim_options, { desc = "Telescope vim options" })
			vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "Telescope git files" })
			vim.keymap.set("n", "<leader>gR", builtin.lsp_references, { desc = "Telescope lsp references" })

			-- No binary file preview
			local previewers = require("telescope.previewers")
			local Job = require("plenary.job")
			local new_maker = function(filepath, bufnr, opts)
				filepath = vim.fn.expand(filepath)
				Job:new({
					command = "file",
					args = { "--mime-type", "-b", filepath },
					on_exit = function(j)
						local mime_type = vim.split(j:result()[1], "/")[1]
						if mime_type == "text" then
							previewers.buffer_previewer_maker(filepath, bufnr, opts)
						else
							-- maybe we want to write something to the buffer here
							vim.schedule(function()
								vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
							end)
						end
					end,
				}):sync()
			end

			require("telescope").setup({
				defaults = {
					buffer_previewer_maker = new_maker,
				},
			})
		end,
	},
}
