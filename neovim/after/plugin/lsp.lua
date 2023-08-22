local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mas_lsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mas_lsp_status then
	return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local neodev_status, neodev = pcall(require, "neodev")
if not neodev_status then
	return
end

local fidget_status, fidget = pcall(require, "fidget")
if not fidget_status then
	return
end

local mas_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mas_null_ls_status then
	return
end

local ts_builtin_status, ts_builtin = pcall(require, "telescope.builtin")
if not ts_builtin_status then
	return
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		-- add description
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Actions
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	-- Definitions
	nmap("gdf", vim.lsp.buf.definition, "[G]oto [D]e[F]inition")
	nmap("gr", ts_builtin.lsp_references, "[G]oto [R]eferences")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gdc", vim.lsp.buf.declaration, "[G]oto [D]e[C]laration")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", ts_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")

	-- Diagnostics
	nmap("<leader>dop", vim.diagnostic.open_float, "[D]agnostic [OP]en")
	nmap("<leader>dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")
	nmap("<leader>df", ts_builtin.diagnostics, "[D]iagnostics [F]inder")

	-- Documentation
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation") -- conflict with moving line to top (cf: custom keymaps)

	-- Workspaces
	nmap("<leader>ws", ts_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer.
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- Enable the following LSP servers. They will automatically be installed.
local servers = {
	bashls = {},
	cssls = {},
	cssmodules_ls = {},
	graphql = {},
	html = {},
	jsonls = {},
	lua_ls = {},
	phpactor = {},
	prismals = {},
	rust_analyzer = {},
	sqlls = {},
	tailwindcss = {},
	taplo = {},
	tsserver = {},
	vimls = {},
	yamlls = {},
}

-- Setup neovim lua configuration.
neodev.setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup Mason so it can manage external tooling.
mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Ensure the LSP servers above are installed.
mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

-- Ensure the linters and formatters are installed.
mason_null_ls.setup({
	ensure_installed = {
		"prettier", -- formatter for JS/TS
		"stylua", -- formatter for lua
		"eslint_d", -- linter for JS
	},
})

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- Turn on lsp status information.
fidget.setup({})

-- UI
local lsp = vim.lsp

lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

lsp.handlers["textDocument/signatureHelp"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focusable = false,
		source = "always",
		header = "",
		prefix = "",
	},
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Override default vim.diagnostic.open_float() function
-- to change border and background color to adapt colors from Diagnostic event.
vim.diagnostic.open_float = (function(orig)
	return function(bufnr, opts)
		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
		local options = opts or {}

		-- A more robust solution would check the "scope" value in `opts` to
		-- determine where to get diagnostics from, but if you're only using
		-- this for your own purposes you can make it as simple as you like
		local diagnostics = vim.diagnostic.get(options.bufnr or 0, { lnum = lnum })
		local max_severity = vim.diagnostic.severity.HINT

		for _, d in ipairs(diagnostics) do
			-- Equality is "less than" based on how the severities are encoded
			if d.severity < max_severity then
				max_severity = d.severity
			end
		end

		local border_color = ({
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
		})[max_severity]

		options.border = {
			{ "╭", border_color },
			{ "─", border_color },
			{ "╮", border_color },
			{ "│", border_color },
			{ "╯", border_color },
			{ "─", border_color },
			{ "╰", border_color },
			{ "│", border_color },
		}

		-- Change background color
		vim.cmd([[ highlight DiagnosticBGColor guibg=#24283b]])
		vim.api.nvim_win_set_option(0, "winhl", "Normal:DiagnosticBGColor")

		-- Return new params
		orig(bufnr, options)
	end
end)(vim.diagnostic.open_float)
