return {
	"nvim-tree/nvim-web-devicons",

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "rose-pine",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = {}, winbar = {} },
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		},
	},

	{
		"rcarriga/nvim-notify",
		opts = {},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 300,
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>d", group = "Debug (DAP)" },
				{ "<leader>ds", group = "Debug Step" },
				{ "<leader>g", group = "Git" },
				{ "<leader>r", group = "Rust" },
				{ "<leader>k", group = "Kulala (HTTP)" },
				{ "<leader>s", group = "Search/Replace" },
				{ "<leader>c", group = "Code" },
				{ "<leader>p", group = "Oil (File explorer)" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>1", hidden = true },
				{ "<leader>2", hidden = true },
				{ "<leader>3", hidden = true },
				{ "<leader>4", hidden = true },
				{ "<leader>5", hidden = true },
			})
		end,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = { "icon" },
			view_options = { show_hidden = true },
		},
	},

	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
