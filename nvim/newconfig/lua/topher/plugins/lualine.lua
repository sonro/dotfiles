return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = {
				theme = "auto",
				icons_enabled = false,
			},
		})
	end,
}
