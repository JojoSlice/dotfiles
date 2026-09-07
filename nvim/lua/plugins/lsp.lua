return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.lsp.config("vtsls", {
				settings = {
					typescript = { format = { enable = false } },
					javascript = { format = { enable = false } },
					vtsls = { autoUseWorkspaceTsdk = true },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("eslint-fix-all", { clear = true }),
				pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
				callback = function()
					pcall(vim.cmd, "EslintFixAll")
				end,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						telemetry = { enable = false },
					},
				},
			})
			vim.lsp.config("yamlls", {
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

			vim.lsp.enable({
				"vtsls", "lua_ls", "html", "cssls", "jsonls", "eslint",
				"yamlls", "pyright", "gopls", "tailwindcss", "angularls",
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
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
				"prettierd",
				"csharpier",
				"vtsls",
				"tailwindcss-language-server",
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
				"angular-language-server",
			},
		},
	},

	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		dependencies = { "saghen/blink.cmp" },
		opts = function()
			return {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			}
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				cs = { "csharpier" },
				yaml = { "prettierd" },
				dart = { "dart_format" },
				python = { "ruff_format", "ruff_organize_imports" },
			go = { "goimports" },
			htmlangular = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 1500,
				lsp_format = "fallback",
			},
		},
	},
}
