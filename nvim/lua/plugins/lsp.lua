return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local simple_servers = { "ts_ls", "html", "cssls", "jsonls", "eslint", "svelte" }
			for _, server in ipairs(simple_servers) do
				vim.lsp.config(server, { capabilities = capabilities })
			end

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = { vim.env.VIMRUNTIME },
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})
			vim.lsp.config("yamlls", {
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = {
							enable = true,
							url = "https://www.schemastore.org/api/json/catalog.json",
						},
						schemas = {
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
							["https://json.schemastore.org/github-action.json"] = "action.{yml,yaml}",
						},
						format = { enable = true },
						validate = true,
						completion = true,
						hover = true,
					},
				},
			})
			vim.lsp.config("gleam", {
				capabilities = capabilities,
				cmd = { "gleam", "lsp" },
				filetypes = { "gleam" },
				root_markers = { "gleam.toml" },
			})

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})

			local all_servers = { "ts_ls", "lua_ls", "html", "cssls", "jsonls", "eslint", "svelte", "yamlls", "gleam", "pyright" }
			for _, server in ipairs(all_servers) do
				vim.lsp.enable(server)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"csharpier",
				"typescript-language-server",
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"eslint-lsp",
				"json-lsp",
				"rust-analyzer",
				"svelte-language-server",
				"roslyn",
				"yaml-language-server",
				"actionlint",
				"pyright",
				"ruff",
			},
		},
	},

	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = function()
			return {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						local buf_map = function(mode, lhs, rhs, opts)
							opts =
								vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
							vim.keymap.set(mode, lhs, rhs, opts)
						end

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
								buildScripts = { enable = true },
							},
							checkOnSave = true,
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
				dap = {
					adapter = function()
						local codelldb_exists = vim.fn.executable("codelldb") == 1
						if not codelldb_exists then
							vim.notify(
								"codelldb not found. Install it with :MasonInstall codelldb",
								vim.log.levels.WARN
							)
							return nil
						end

						local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension")
						local codelldb_path = extension_path .. "/adapter/codelldb"
						local liblldb_path = extension_path .. "/lldb/lib/liblldb"

						local this_os = vim.uv.os_uname().sysname

						if this_os:find("Windows") then
							codelldb_path = extension_path .. "/adapter/codelldb.exe"
							liblldb_path = extension_path .. "/lldb/bin/liblldb.dll"
						else
							liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
						end

						return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
					end,
				},
			}
		end,
	},

	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup({
				completion = { cmp = { enabled = true } },
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				cs = { "csharpier" },
				rust = { "rustfmt" },
				svelte = { "prettier" },
				yaml = { "prettier" },
				gleam = { "gleam_format" },
				dart = { "dart_format" },
				python = { "ruff_format", "ruff_organize_imports" },
			},
			format_on_save = {
				timeout_ms = 1500,
				lsp_format = "fallback",
			},
		},
	},
}
