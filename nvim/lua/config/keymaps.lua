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

map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map("n", "<leader>pv", "<cmd>Oil<cr>", { desc = "Open parent directory" })

local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
map("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
map("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })
map("n", "<leader>fd", telescope.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fb", function()
	telescope.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "Find buffers" })

local gitsigns = require("gitsigns")
map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview git hunk" })
map("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })
map("n", "<leader>gb", function()
	gitsigns.blame_line({ full = true })
end, { desc = "Git blame line" })
map("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		gitsigns.next_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })
map("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		gitsigns.prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

map("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })

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

local dap = require("dap")
local dapui = require("dapui")
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
map("n", "<leader>dso", dap.step_over, { desc = "Step over" })
map("n", "<leader>dsO", dap.step_out, { desc = "Step out" })
map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "Run last" })
map("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
