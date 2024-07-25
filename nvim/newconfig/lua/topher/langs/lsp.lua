return {
	zls = {
		filetypes = { "zig" },
		settings = {},
	},
	rust_analyzer = {
		filetypes = { "rust" },
		settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
				cargo = {
					allFeatures = true,
				},
			},
		},
	},
	clangd = {
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = function(fname)
			return require("lspconfig").util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
		end,
	},
}
