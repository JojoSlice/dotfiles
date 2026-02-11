vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
	callback = function(args)
		require("config.lsp-keymaps").setup(args.buf)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("oil-whichkey", { clear = true }),
	pattern = "oil",
	callback = function()
		local wk = require("which-key")

		wk.add({
			buffer = vim.api.nvim_get_current_buf(),
			{ "-", desc = "Go to parent directory" },
			{ "_", desc = "Open current working directory" },
			{ "`", desc = "Change directory" },
			{ "~", desc = "Change directory (tab)" },
			{ "<CR>", desc = "Select/open file or directory" },
			{ "<C-s>", desc = "Open in vertical split" },
			{ "<C-h>", desc = "Open in horizontal split" },
			{ "<C-t>", desc = "Open in new tab" },
			{ "<C-p>", desc = "Preview file" },
			{ "<C-c>", desc = "Close Oil" },
			{ "<C-l>", desc = "Refresh" },
			{ "g.", desc = "Toggle hidden files" },
			{ "g\\", desc = "Toggle trash" },
			{ "gs", desc = "Change sort order" },
			{ "gx", desc = "Open externally" },
			{ "g?", desc = "Show help" },
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
	pattern = { "help", "qf", "spectre_panel", "notify", "lspinfo", "man", "checkhealth" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true, desc = "Close window" })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore-cursor", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("equalize-splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("auto-reload", { clear = true }),
	callback = function()
		vim.cmd("checktime")
	end,
})
