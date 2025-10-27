return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		vim.lsp.enable("clangd")

		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	callback = function(args)
		-- 		local keymap = vim.keymap
		-- 		local opts = { buffer = args.buf, silent = true }
		--
		-- 		opts.desc = "Go to declaration"
		-- 		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		--
		-- 		opts.desc = "Show LSP definitions"
		-- 		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		-- 	end,
		-- })
	end,
}
