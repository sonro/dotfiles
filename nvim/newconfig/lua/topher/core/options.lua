local opt = vim.opt

---- EDITOR
vim.cmd([[
    set undodir=~/.vimdid
]])
opt.undofile = true

---- UI
-- see more cmd messages
opt.cmdheight = 2
-- shorter msg display
opt.updatetime = 300
-- show hybrid line number
opt.relativenumber = true
opt.number = true
-- prevent buffer moving when adding/deleting sign
opt.signcolumn = "yes"
-- scroll when close to edge
opt.scrolloff = 6
-- don't redraw ui during macros
opt.lazyredraw = true
-- don't give |ins-completion-menu| messages
opt.shortmess:append({ c = true })
-- set right margin
opt.colorcolumn = "80"
-- stop netrw hanging around in buffers
vim.g.netrw_fastbrowse = 0

-- Jump to last edit position on opening file
vim.cmd([[
    if has("autocmd")
    " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
    au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
    au Filetype rust set colorcolumn=100
    au Filetype zig set colorcolumn=100
]])

---- WINDOWS AND SPLITS
-- sane splits
opt.splitright = true
opt.splitbelow = true

---- TABS AND INDENTATION
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- used to be false
opt.autoindent = true

---- FORMATTING
opt.wrap = false
opt.formatoptions = {
	t = true, -- wrap text using textwidth
	c = true, -- wrap comments using textwidth
	q = true, -- enable formatting of comments gq
	n = true, -- detect lists for formatting
	b = true, -- auto-wrap on insert, do not wrap old long lines
}

---- SEARCH
-- sets highlight
opt.incsearch = true
-- ignores case
opt.ignorecase = true
-- unless case is included
opt.smartcase = true
-- set all instances on line as default
-- substitue /g is reversed
opt.gdefault = true
-- centre search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
-- very magic by default
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("c", "%s/", "%sm/")

---- THEME AND COLOURS
opt.termguicolors = true
-- colorschemes that can be light/dark use
opt.background = "dark"

---- FILETYPES
-- zig
vim.filetype.add({ extension = { zon = "zig" } })

---- MISC
-- backspace
-- opt.backspace = "indent,eol,start"
