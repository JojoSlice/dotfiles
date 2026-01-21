local function setup_lsp_keymaps(bufnr)
	local buf_map = function(mode, lhs, rhs, opts)
		opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end

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

return {
	"neovim/nvim-lspconfig",

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
				"js-debug-adapter",
				"netcoredbg",
				"typescript-language-server",
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"eslint-lsp",
				"json-lsp",
				"rust-analyzer",
				"codelldb",
				"svelte-language-server",
				"roslyn",
				"yaml-language-server",
				"actionlint",
			},
		},
	},

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

	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						setup_lsp_keymaps(bufnr)

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
			},
			format_on_save = {
				timeout_ms = 1500,
				lsp_fallback = true,
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				setup_lsp_keymaps(bufnr)
			end

			vim.lsp.config("ts_ls", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
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
			vim.lsp.config("html", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("cssls", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("jsonls", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("eslint", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("svelte", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("yamlls", {
				capabilities = capabilities,
				on_attach = on_attach,
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
				on_attach = on_attach,
				cmd = { "gleam", "lsp" },
				filetypes = { "gleam" },
				root_markers = { "gleam.toml" },
			})

			vim.lsp.enable("ts_ls")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("svelte")
			vim.lsp.enable("yamlls")
			vim.lsp.enable("gleam")
		end,
	},
}
