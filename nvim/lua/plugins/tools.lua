return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
		},
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				expand_lines = vim.fn.has("nvim-0.7"),
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = { "repl", "console" },
						size = 0.25,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "□",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = { close = { "q", "<Esc>" } },
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil,
					max_value_lines = 100,
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"js-debug-adapter",
				"netcoredbg",
				"codelldb",
				"debugpy",
			},
			handlers = {
				python = function(config)
					config.adapters = {
						type = "executable",
						command = vim.fn.expand("$MASON/packages/debugpy/venv/bin/python"),
						args = { "-m", "debugpy.adapter" },
					}
					config.configurations = {
						{
							type = "python",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							pythonPath = function()
								local venv = os.getenv("VIRTUAL_ENV")
								if venv then
									return venv .. "/bin/python"
								end
								return "python3"
							end,
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		},
	},

	{
		"mistweaverco/kulala.nvim",
		ft = "http",
		config = function()
			require("kulala").setup({
				icons = {
					inlay = {
						loading = "⏳",
						done = "✅",
						error = "❌",
					},
					lualine = "🐼",
				},
				additional_curl_options = {},
			})
		end,
	},
}
