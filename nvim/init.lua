local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.options")

if not vim.g.lazy_did_setup then
	require("lazy").setup("plugins")

	pcall(function()
		require("lazy").setup("user")
	end)

	vim.g.lazy_did_setup = true
end

require("config.keymaps")
require("config.autocmds")

pcall(require, "user.keymaps")
pcall(require, "user.options")
