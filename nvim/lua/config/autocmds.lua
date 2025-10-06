vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		local wk_ok, wk = pcall(require, "which-key")
		if not wk_ok then
			return
		end

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
