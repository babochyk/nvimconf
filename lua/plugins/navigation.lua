return {
	{
		"xiaoshihou514/squirrel.nvim",
		config = function()
			vim.keymap.set({ "n", "v" }, "M", require("squirrel.hop").hop)
		end
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>",    desc = "File Explorer" },
			{ "<leader>E", "<cmd>Oil ./<cr>", desc = "CWD Explorer" },
		},
		opts = {},
		config = true
	},
	{
		'moll/vim-bbye',

		event = {'BufReadPost', 'BufNewFile'},

		config = function()
			vim.keymap.set('n', '<leader>c', '<cmd>Bdelete!<return>')
			vim.keymap.set('n', '<leader>n', '<cmd>bufdo :Bdelete<return>')
		end
	},
	{
		"nvim-telescope/telescope.nvim", -- telescope
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		keys = {
			{ "<leader>F", desc = "Git Files" },
			{ "<leader>f", desc = "Find Files" },
			{ "<leader>g", desc = "Live Grep" },
			{ "<leader>b", desc = "Buffers" },
			{ "<leader>d", desc = "Diagnostics" },
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					borderchars = require("config.globals").border_chars_alternate,
					wrap_results = true,
					default_mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<CR>"] = actions.select_default,
							["<Esc>"] = actions.close,
						}
					}
				}
			})

			local builtin = require("telescope.builtin")
			local opts = { noremap = true, silent = true }

			local function map(lhs, rhs)
				vim.keymap.set("n", lhs, rhs, opts)
			end

			map("<leader>F", builtin.git_files)
			map("<leader>f", builtin.find_files)
			map("<leader>g", builtin.live_grep)
			map("<leader>b", function()
				builtin.buffers({ sort_lastused = true })
			end)
			map("<leader>d", function()
				builtin.diagnostics({
					bufnr = 0,
					severity_bound = 0,
				})
			end)
			map("<leader>D", builtin.diagnostics)
		end
	}
}
