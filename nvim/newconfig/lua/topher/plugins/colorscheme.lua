COMMENT_COLOR = "#db4b4b"
return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
			})
			-- vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
			-- vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			local transparent = false

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,
				styles = {
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.comment = colors.red1
				end,
			})

			vim.cmd("colorscheme tokyonight")
		end,
	},
}
