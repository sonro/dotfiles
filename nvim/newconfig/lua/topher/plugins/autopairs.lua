return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		{ "ms-jpq/coq_nvim", branch = "coq" },
	},
	config = function()
		-- import nvim-autopairs
		-- local autopairs = require("nvim-autopairs")

		local remap = vim.api.nvim_set_keymap
		local npairs = require("nvim-autopairs")

		npairs.setup({
			map_bs = false,
			map_cr = false,
			check_ts = true,
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
				java = false, -- don't check treesitter on java
			},
		})

		-- skip it, if you use another global object
		_G.MUtils = {}

		MUtils.CR = function()
			if vim.fn.pumvisible() ~= 0 then
				if vim.fn.complete_info({ "selected" }).selected ~= -1 then
					return npairs.esc("<c-y>")
				else
					return npairs.esc("<c-e>") .. npairs.autopairs_cr()
				end
			else
				return npairs.autopairs_cr()
			end
		end
		remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

		MUtils.BS = function()
			if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
				return npairs.esc("<c-e>") .. npairs.autopairs_bs()
			else
				return npairs.autopairs_bs()
			end
		end
		remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
	end,
}
