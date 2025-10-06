-- Lazy
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

require("lazy").setup({
	-- Colorscheme
	{ "rose-pine/neovim", name = "rose-pine" },

	-- nvim-lspconfig (behövs nu igen för Neovim 0.11+)
	"neovim/nvim-lspconfig",

	-- Mason för LSP installation
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	-- Mason tool installer för formatters och debug adapters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"csharpier",
				"js-debug-adapter",
				"netcoredbg",
				-- LSP servers
				"typescript-language-server",
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"eslint-lsp",
				"json-lsp",
				"rust-analyzer",
				"codelldb",
			},
		},
	},

	-- Roslyn för C# (endast laddad för .cs-filer)
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = function()
			return {
				on_attach = function(client, bufnr)
					setup_lsp_keymaps(bufnr)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}
		end,
	},

	-- Rustaceanvim för förbättrad Rust-upplevelse
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Uppdaterad till version 6
		lazy = false, -- Removed ft = { "rust" } konflikt
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						-- Standard LSP keymaps
						setup_lsp_keymaps(bufnr)

						-- Helper för Rust-specifika keymaps
						local buf_map = function(mode, lhs, rhs, opts)
							opts =
								vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
							vim.keymap.set(mode, lhs, rhs, opts)
						end

						-- Rust-specifika keymaps
						buf_map("n", "<leader>re", "<Cmd>RustLsp explainError<CR>", { desc = "Explain Rust error" })
						buf_map("n", "<leader>rd", "<Cmd>RustLsp renderDiagnostic<CR>", { desc = "Render diagnostic" })
						buf_map("n", "<leader>rc", "<Cmd>RustLsp openCargo<CR>", { desc = "Open Cargo.toml" })
						buf_map("n", "<leader>rp", "<Cmd>RustLsp parentModule<CR>", { desc = "Go to parent module" })
						buf_map("n", "<leader>rj", "<Cmd>RustLsp joinLines<CR>", { desc = "Join lines" })
						buf_map("n", "<leader>rh", "<Cmd>RustLsp hover actions<CR>", { desc = "Hover actions" })
						buf_map("n", "<leader>rm", "<Cmd>RustLsp expandMacro<CR>", { desc = "Expand macro" })
						buf_map("n", "<leader>rr", "<Cmd>RustLsp runnables<CR>", { desc = "Runnables" })
						buf_map("n", "<leader>rt", "<Cmd>RustLsp testables<CR>", { desc = "Testables" })
					end,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							-- Korrigerad: checkOnSave är nu en boolean
							checkOnSave = true,
							-- Flytta clippy-konfiguration till check
							check = {
								command = "clippy",
								extraArgs = { "--no-deps" },
								allFeatures = true,
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
				-- Cross-platform codelldb konfiguration
				-- OBS: Rustaceanvim kan hitta codelldb automatiskt från Mason.
				-- Denna config är endast nödvändig om du vill explicit ange sökvägen.
				dap = {
					adapter = function()
						-- Kontrollera om codelldb finns innan vi försöker använda det
						local codelldb_exists = vim.fn.executable("codelldb") == 1
						if not codelldb_exists then
							vim.notify(
								"codelldb not found. Install it with :MasonInstall codelldb",
								vim.log.levels.WARN
							)
							return nil
						end

						-- Använd $MASON env var (rekommenderat i Mason 2.0+)
						local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension")
						local codelldb_path = extension_path .. "/adapter/codelldb"
						local liblldb_path = extension_path .. "/lldb/lib/liblldb"

						local this_os = vim.uv.os_uname().sysname

						-- Platform-specific paths
						if this_os:find("Windows") then
							codelldb_path = extension_path .. "/adapter/codelldb.exe"
							liblldb_path = extension_path .. "/lldb/bin/liblldb.dll"
						else
							-- .so för Linux, .dylib för macOS
							liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
						end

						return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
					end,
				},
			}
		end,
	},

	-- Crates.nvim för Cargo.toml hantering
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			})
		end,
	},

	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"dist/",
					"build/",
					"target/",
					"%.lock",
				},
				layout_config = {
					horizontal = {
						preview_width = 0.55,
					},
				},
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- Treesitter context
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
		},
	},

	-- Git
	"tpope/vim-fugitive",

	-- Formatting
	{
		"stevearc/conform.nvim",
		opts = {},
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- Lualine (statusbar)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Web devicons
	"nvim-tree/nvim-web-devicons",

	-- DAP (Debug Adapter Protocol)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
		},
	},

	-- DAP UI
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},

	-- Mason DAP
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"js-debug-adapter",
				"netcoredbg",
				"codelldb",
			},
		},
	},

	-- Harpoon för snabb filnavigering
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
			settings = {
				save_on_toggle = true,
			},
		},
		keys = function()
			local keys = {
				{
					"<leader>H",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon File",
				},
				{
					"<leader>h",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Harpoon Quick Menu",
				},
			}

			for i = 1, 5 do
				table.insert(keys, {
					"<leader>" .. i,
					function()
						require("harpoon"):list():select(i)
					end,
					desc = "Harpoon to File " .. i,
				})
			end
			return keys
		end,
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Comment plugin
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
			{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
		},
		opts = {},
	},

	-- Todo comments highlighting
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			},
		},
	},

	-- Color highlighter
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- Oil.nvim - bättre filutforskare
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
			},
			view_options = {
				show_hidden = true,
			},
		},
	},

	-- Notify
	{
		"rcarriga/nvim-notify",
		opts = {},
	},

	-- Modern REST client
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

			-- Kulala keymaps (ändrat från <leader>r* till <leader>k* för att undvika konflikt med Rust)
			vim.keymap.set("n", "<leader>kr", function()
				require("kulala").run()
			end, { desc = "Run request" })

			vim.keymap.set("n", "<leader>kp", function()
				require("kulala").from_curl()
			end, { desc = "From curl command" })

			vim.keymap.set("n", "<leader>kc", function()
				require("kulala").copy()
			end, { desc = "Copy as curl" })

			vim.keymap.set("n", "<leader>ki", function()
				require("kulala").inspect()
			end, { desc = "Inspect request" })

			vim.keymap.set("n", "<leader>kt", function()
				require("kulala").toggle_view()
			end, { desc = "Toggle response/headers view" })
		end,
	},

	-- Search and replace
	{
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = {},
	},

	-- Which-key för keymap hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 300,
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			-- Registrera leader key grupper
			wk.add({
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>d", group = "Debug (DAP)" },
				{ "<leader>ds", group = "Debug Step" },
				{ "<leader>g", group = "Git" },
				{ "<leader>r", group = "Rust" },
				{ "<leader>k", group = "Kulala (HTTP)" },
				{ "<leader>s", group = "Search/Replace" },
				{ "<leader>c", group = "Code" },
				{ "<leader>p", group = "Oil (File explorer)" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>1", hidden = true },
				{ "<leader>2", hidden = true },
				{ "<leader>3", hidden = true },
				{ "<leader>4", hidden = true },
				{ "<leader>5", hidden = true },
			})
		end,
	},
})

-- Registrera Oil buffer keymaps i which-key när Oil öppnas
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

-- Grundläggande inställningar
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

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- j/k: hoppar visuella rader om inget count anges
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Better visual mode indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Oil.nvim
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Sätt colorscheme
vim.cmd("colorscheme rose-pine")
-- Sätt nvim-notify som standard notification handler
local notify_ok, notify = pcall(require, "notify")
if notify_ok then
	vim.notify = notify
end

-- LSP Setup med nya vim.lsp.enable (Neovim 0.11+)
-- LSP capabilities för completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Konfigurera diagnostics (virtual_text är disabled by default i 0.11)
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

-- Delad funktion för att sätta LSP keymaps
local function setup_lsp_keymaps(bufnr)
	local buf_map = function(mode, lhs, rhs, opts)
		opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- Standard LSP keymaps
	buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	buf_map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
	buf_map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
	buf_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
	buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
	buf_map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
	buf_map("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format code" })
	buf_map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })
end

-- On_attach funktion för LSP-servrar
local on_attach = function(client, bufnr)
	setup_lsp_keymaps(bufnr)
end

-- Konfigurera LSP servers med vim.lsp.config innan vi enabler dem
-- TypeScript/JavaScript
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Lua
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- HTML
vim.lsp.config("html", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- CSS
vim.lsp.config("cssls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- JSON
vim.lsp.config("jsonls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- ESLint
vim.lsp.config("eslint", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Aktivera LSP servers
vim.lsp.enable("ts_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")

-- Conform för formatting
local conform_ok, conform = pcall(require, "conform")
if conform_ok then
	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			cs = { "csharpier" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			timeout_ms = 1500,
			lsp_fallback = true,
		},
	})
end

-- Completion setup
local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")

if not (cmp_ok and luasnip_ok) then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "crates" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

-- Autopairs integration med cmp
local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if cmp_autopairs_ok and cmp_ok then
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

-- Lualine setup
local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "rose-pine",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- DAP Setup
local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

if not (dap_ok and dapui_ok) then
	return
end

-- DAP UI setup
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
			elements = {
				"repl",
				"console",
			},
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
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil,
		max_value_lines = 100,
	},
})

-- Automatisk öppning/stängning av DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- DAP keymaps
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>dsO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

-- Treesitter
local treesitter_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
	return
end

treesitter_configs.setup({
	ensure_installed = { "lua", "javascript", "typescript", "html", "css", "c_sharp", "json", "rust", "toml" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	auto_install = true,
})

-- Telescope
local telescope_ok, telescope = pcall(require, "telescope.builtin")
if not telescope_ok then
	return
end

vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fd", telescope.diagnostics, { desc = "Diagnostics" })

-- Förbättrad telescope buffer picker
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		ignore_current_buffer = true,
	})
end, { desc = "Find buffers" })

-- Gitsigns keymaps
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then
	return
end

vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview git hunk" })
vim.keymap.set("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })
vim.keymap.set("n", "<leader>gb", function()
	gitsigns.blame_line({ full = true })
end, { desc = "Git blame line" })
vim.keymap.set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		gitsigns.next_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })
vim.keymap.set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		gitsigns.prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

-- Spectre keymaps
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
vim.keymap.set(
	"n",
	"<leader>sw",
	'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
	{ desc = "Search current word" }
)
vim.keymap.set(
	"v",
	"<leader>sw",
	'<esc><cmd>lua require("spectre").open_visual()<CR>',
	{ desc = "Search current word" }
)
vim.keymap.set(
	"n",
	"<leader>sp",
	'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
	{ desc = "Search on current file" }
)
