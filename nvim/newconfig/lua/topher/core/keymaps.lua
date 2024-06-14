local keymap = vim.keymap

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- unset
keymap.set({ "n", "i" }, "<up>", "<nop>")
keymap.set({ "n", "i" }, "<down>", "<nop>")
keymap.set({ "n", "i" }, "<left>", "<nop>")
keymap.set({ "n", "i" }, "<right>", "<nop>")

-- search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- buffers
keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Toggle between buffer" })
keymap.set("n", "gp", ":bp<CR>", { desc = "Goto prev buffer" })
keymap.set("n", "gn", ":bn<CR>", { desc = "Goto next buffer" })

-- tabs
keymap.set("n", "<leader>tt", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Goto next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Goto prev tab" })

-- files
keymap.set("n", "<leader>e", ':e <c-r>=expand("%:p:h") . "/" <cr>', { desc = "Open new file adjacent to current" })

-- misc
-- toggle background light and dark
keymap.set("n", "<leader>#", ":set background=light<CR>", { desc = "Set to light mode" })
keymap.set("n", "<leader>~", ":set background=dark<CR>", { desc = "Set to dark mode" })
keymap.set({ "n", "i" }, "<f1>", "<esc", { remap = true }) -- type :help instead
