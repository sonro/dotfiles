return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		vim.lsp.enable("clangd")
		vim.lsp.enable("zls")
		vim.lsp.enable("markdown_oxide")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local keymap = vim.keymap
				local opts = { buffer = args.buf, silent = true }

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})
	end,
}
