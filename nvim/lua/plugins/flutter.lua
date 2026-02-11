return {
	"nvim-flutter/flutter-tools.nvim",
	ft = "dart",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("flutter-tools").setup({
			widget_guides = { enabled = true },
			closing_tags = {
				highlight = "Comment",
				prefix = "// ",
				enabled = true,
			},
			dev_log = {
				enabled = true,
				notify_errors = true,
			},
			lsp = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				color = { enabled = true },
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
			},
		})
	end,
}
