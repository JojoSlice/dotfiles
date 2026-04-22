return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local simple_servers = { "ts_ls", "html", "cssls", "jsonls", "eslint", "gopls" }
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

			local all_servers = { "ts_ls", "lua_ls", "html", "cssls", "jsonls", "eslint", "yamlls", "pyright", "gopls" }
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
				"roslyn",
				"yaml-language-server",
				"actionlint",
				"pyright",
				"ruff",
				"gopls",
				"goimports",
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
				yaml = { "prettier" },
				dart = { "dart_format" },
				python = { "ruff_format", "ruff_organize_imports" },
			go = { "goimports" },
			},
			format_on_save = {
				timeout_ms = 1500,
				lsp_format = "fallback",
			},
		},
	},
}
