local M = {}

function M.setup(bufnr)
	local buf_map = function(mode, lhs, rhs, opts)
		opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- Built-in defaults in 0.11+: gd, gD, K, grr, gri, grn, gra, gO, ]d, [d
	buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
	buf_map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
	buf_map("n", "<leader>cf", function()
		require("conform").format({ async = true, lsp_format = "fallback" })
	end, { desc = "Format code" })
	buf_map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })
	buf_map("n", "<leader>cd", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic" })
end

return M
