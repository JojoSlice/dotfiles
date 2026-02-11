local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, noremap = true, silent = true })

map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, noremap = true, silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force close buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to the right" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to the left" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin/unpin buffer" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Close unpinned buffers" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map("n", "<leader>pv", "<cmd>Oil<cr>", { desc = "Open parent directory" })

map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help tags" })
map("n", "<leader>fd", function() require("telescope.builtin").diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "Find buffers" })

map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview git hunk" })
map("n", "<leader>gt", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle git blame" })
map("n", "<leader>gb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Git blame line" })
map("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		require("gitsigns").next_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })
map("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		require("gitsigns").prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

map("n", "<leader>kr", function()
	require("kulala").run()
end, { desc = "Run request" })
map("n", "<leader>kp", function()
	require("kulala").from_curl()
end, { desc = "From curl command" })
map("n", "<leader>kc", function()
	require("kulala").copy()
end, { desc = "Copy as curl" })
map("n", "<leader>ki", function()
	require("kulala").inspect()
end, { desc = "Inspect request" })
map("n", "<leader>kt", function()
	require("kulala").toggle_view()
end, { desc = "Toggle response/headers view" })

map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
map("n", "<leader>dsi", function() require("dap").step_into() end, { desc = "Step into" })
map("n", "<leader>dso", function() require("dap").step_over() end, { desc = "Step over" })
map("n", "<leader>dsO", function() require("dap").step_out() end, { desc = "Step out" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run last" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })

-- Flutter
map("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
map("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Restart" })
map("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
map("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
map("n", "<leader>Fl", "<cmd>FlutterLogClear<CR>", { desc = "Flutter Log Clear" })
map("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline" })
map("n", "<leader>Ft", "<cmd>FlutterDevTools<CR>", { desc = "Flutter DevTools" })
