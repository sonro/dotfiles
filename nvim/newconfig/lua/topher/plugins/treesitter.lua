return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	-- all lang parsers get updated with treesitter
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"graphql",
				"gitcommit",
				"gitignore",
				"html",
				"javascript",
				"json",
				"just",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"php",
				"regex",
				"ron",
				"rust",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"zig",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<C-bs>",
				},
			},
		})
	end,
}
