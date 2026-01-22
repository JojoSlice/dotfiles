-- Add Linuxbrew to PATH if it exists (for LSP servers like gleam)
local linuxbrew_bin = "/home/linuxbrew/.linuxbrew/bin"
if vim.fn.isdirectory(linuxbrew_bin) == 1 then
	vim.env.PATH = linuxbrew_bin .. ":" .. vim.env.PATH
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 20
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = "↪ "

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})
