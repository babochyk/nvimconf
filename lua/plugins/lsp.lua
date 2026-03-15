local servers = {
	["lua_ls"] = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	["ts_ls"] = { settings = {} },
	["html"] = { settings = {} },
	["cssls"] = { settings = {} },
	["qmlls"] = { settings = {} },
	["pylsp"] = {
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = { enabled = true, maxLineLength = 200 },
					-- flake8 = { enabled = true, ignore = "E501" },
				},
			}
		}
	}
}

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, opts)
end

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			{ "ms-jpq/coq_nvim",      branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = 'shut-up',
				keymap = { manual_complete = "" },
			}
		end,
		config = function()
			local opts = {
				ensure_installed = vim.tbl_keys(servers),
				automatic_installation = true,
			}
			require("mason-lspconfig").setup(opts)
			for server, config in pairs(servers) do
				config.on_attach = function(server)
					local buf = vim.lsp.buf
					map("n", "gD", buf.declaration)
					map("n", "K", buf.hover)
					map("n", "<leader>r", buf.rename)
					map("n", "<leader>a", buf.code_action)
					vim.api.nvim_create_user_command("Format", function() vim.lsp.buf.format() end, {})
					vim.treesitter.start()
				end
				vim.lsp.config(server, config)
			end
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter'.install({ "lua", "typescript", "javascript", "html", "css", "qmljs", "python" })
		end,
	}
}
