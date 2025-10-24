return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		vim.lsp.enable("clangd")
	end,
}
