local M = {}

function M.setup(bufnr)
	local buf_map = function(mode, lhs, rhs, opts)
		opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	buf_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	buf_map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
	buf_map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
	buf_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
	buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
	buf_map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
	buf_map("n", "<leader>cf", function()
		require("conform").format({ async = true, lsp_format = "fallback" })
	end, { desc = "Format code" })
	buf_map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })

	buf_map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })
	buf_map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
	buf_map("n", "<leader>cd", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic" })
end

return M
