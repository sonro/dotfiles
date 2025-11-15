return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		vim.lsp.enable("clangd")
		vim.lsp.enable("zls")
		vim.lsp.enable("markdown_oxide")

		vim.lsp.config("zls", {
			filetypes = { "zig", "zon", "zir" },
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.zig", "*.zon" },

			callback = function(_)
				vim.lsp.buf.code_action({
					context = { only = { "source.fixAll" } },
					apply = true,
				})
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local keymap = vim.keymap
				local opts = { buffer = ev.buf, silent = true }

				-- setup Markdown oxide daily note commands
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client.name == "markdown_oxide" then
					vim.api.nvim_create_user_command("Daily", function(fn_args)
						local input = fn_args.args
						vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
					end, { desc = "Open daily note", nargs = "*" })

					opts.desc = "Today's note"
					keymap.set("n", "<leader>dd", ":Daily today<CR>", opts)
					opts.desc = "Tomorrow's note"
					keymap.set("n", "<leader>dn", ":Daily tomorrow<CR>", opts)
					opts.desc = "Yesterday's note"
					keymap.set("n", "<leader>dp", ":Daily yesterday<CR>", opts)
				end

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})
	end,
}
