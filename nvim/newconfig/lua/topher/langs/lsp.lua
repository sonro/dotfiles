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
			},
		},
	},
}
