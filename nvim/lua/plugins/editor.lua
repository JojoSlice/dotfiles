return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		opts = {
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"dist/",
					"build/",
					"target/",
					"%.lock",
				},
				layout_config = {
					horizontal = { preview_width = 0.55 },
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "javascript", "typescript", "html", "css", "c_sharp", "json", "rust", "toml", "svelte", "gleam", "python", "dart", "yaml", "markdown", "markdown_inline", "bash", "vim", "vimdoc", "regex" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				auto_install = true,
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>e", require("nvim-emmet").wrap_with_abbreviation, { desc = "Emmet wrap" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
		},
	},

	"tpope/vim-fugitive",

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "Around function" },
							["if"] = { query = "@function.inner", desc = "Inside function" },
							["ac"] = { query = "@class.outer", desc = "Around class" },
							["ic"] = { query = "@class.inner", desc = "Inside class" },
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = { query = "@function.outer", desc = "Next function start" },
						},
						goto_prev_start = {
							["[m"] = { query = "@function.outer", desc = "Previous function start" },
						},
					},
				},
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			},
		},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = function()
			return {
				menu = { width = vim.api.nvim_win_get_width(0) - 4 },
				settings = { save_on_toggle = true },
			}
		end,
		keys = function()
			local keys = {
				{
					"<leader>H",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon File",
				},
				{
					"<leader>h",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Harpoon Quick Menu",
				},
			}

			for i = 1, 5 do
				table.insert(keys, {
					"<leader>" .. i,
					function()
						require("harpoon"):list():select(i)
					end,
					desc = "Harpoon to File " .. i,
				})
			end
			return keys
		end,
	},

	{
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = {
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = nil,
				},
			},
			default = {
				find = {
					cmd = "rg",
					options = { "ignore-case" },
				},
				replace = {
					cmd = "sed",
				},
			},
			is_insert_mode = false,
			open_cmd = "noswapfile vnew",
		},
		keys = {
			{
				"<leader>S",
				function()
					require("spectre").toggle()
				end,
				desc = "Toggle Spectre",
			},
			{
				"<leader>sw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "Search current word",
			},
			{
				"<leader>sw",
				function()
					require("spectre").open_visual()
				end,
				mode = "v",
				desc = "Search selection",
			},
			{
				"<leader>sf",
				function()
					require("spectre").open_file_search({ select_word = true })
				end,
				desc = "Search in current file",
			},
		},
	},
}
