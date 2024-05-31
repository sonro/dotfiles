local keymap = vim.keymap

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- unset
keymap.set("n", "<up>", "<nop>")
keymap.set("n", "<down>", "<nop>")
keymap.set("n", "<left>", "<nop>")
keymap.set("n", "<right>", "<nop>")
keymap.set("i", "<up>", "<nop>")
keymap.set("i", "<down>", "<nop>")
keymap.set("i", "<left>", "<nop>")
keymap.set("i", "<right>", "<nop>")

-- search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- buffers
keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Toggle between buffer" })
keymap.set("n", "gp", ":bp<CR>", { desc = "Goto prev buffer" })
keymap.set("n", "gn", ":bn<CR>", { desc = "Goto next buffer" })

-- files
keymap.set("n", "<leader>e", ":e <c-r>=expand(\"%:p:h\") . \"/\" <cr>", { desc = "Open new file adjacent to current" })

-- misc
keymap.set("n", "<f1>", "<esc", { remap = true }) -- type :help instead
keymap.set("i", "<f1>", "<esc>", { remap = true })

--[[
" move by line
nnoremap j gj
nnoremap k gk

" open terminal
nnoremap <leader>n :new term://bash<cr>i

" phpactor mappings
nnoremap <m-m> :call phpactor#contextmenu()<cr>

" move between splits
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" open splits
nnoremap <leader>u :split<cr>
nnoremap <leader>vu :vsplit<cr>

" open splits
nnoremap <leader>tn :tabnew<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
	" some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

	" use tab for trigger completion with characters ahead and navigate.
	" note: use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <tab>
		  \ coc#pum#visible() ? coc#pum#next(1):
		  \ checkbackspace() ? "\<tab>" :
		  \ coc#refresh()
	inoremap <expr><s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<c-h>"

	" make <cr> to accept selected completion item or notify coc.nvim to format
	" <c-g>u breaks current undo, please make your own choice.
	inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm()
								  \: "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

	function! checkbackspace() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" use <c-space> to trigger completion.
	if has('nvim')
	  inoremap <silent><expr> <c-space> coc#refresh()
	else
	  inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" use `[g` and `]g` to navigate diagnostics
	" use `:cocdiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <plug>(coc-diagnostic-prev)
	nmap <silent> ]g <plug>(coc-diagnostic-next)

	" goto code navigation.
	nmap <silent> gd <plug>(coc-definition)
	nmap <silent> gy <plug>(coc-type-definition)
	nmap <silent> gi <plug>(coc-implementation)
	nmap <silent> gr <plug>(coc-references)

	" use k to show documentation in preview window.
	nnoremap <silent> k :call showdocumentation()<cr>

	function! showdocumentation()
	  if cocaction('hasprovider', 'hover')
		call cocactionasync('dohover')
	  else
		call feedkeys('k', 'in')
	  endif
	endfunction

	" highlight the symbol and its references when holding the cursor.
	autocmd cursorhold * silent call cocactionasync('highlight')

	" symbol renaming.
	nmap <leader>rn <plug>(coc-rename)

	" formatting selected code.
	xmap <leader>f  <plug>(coc-format-selected)
	nmap <leader>f  <plug>(coc-format-selected)

	augroup mygroup
	  autocmd!
	  " setup formatexpr specified filetype(s).
	  autocmd filetype typescript,json setl formatexpr=cocaction('formatselected')
	  " update signature help on jump placeholder.
	  autocmd user cocjumpplaceholder call cocactionasync('showsignaturehelp')
	augroup end

	" applying codeaction to the selected region.
	" example: `<leader>aap` for current paragraph
	xmap <leader>a  <plug>(coc-codeaction-selected)
	nmap <leader>a  <plug>(coc-codeaction-selected)

	" remap keys for applying codeaction to the current buffer.
	nmap <leader>ac  <plug>(coc-codeaction)
	" apply autofix to problem on the current line.
	nmap <leader>qf  <plug>(coc-fix-current)

	" run the code lens action on the current line.
	nmap <leader>cl  <plug>(coc-codelens-action)

	" map function and class text objects
	" note: requires 'textdocument.documentsymbol' support from the language server.
	xmap if <plug>(coc-funcobj-i)
	omap if <plug>(coc-funcobj-i)
	xmap af <plug>(coc-funcobj-a)
	omap af <plug>(coc-funcobj-a)
	xmap ic <plug>(coc-classobj-i)
	omap ic <plug>(coc-classobj-i)
	xmap ac <plug>(coc-classobj-a)
	omap ac <plug>(coc-classobj-a)

	" remap <c-f> and <c-b> for scroll float windows/popups.
	if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
	  nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
	  inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
	  inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<left>"
	  vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
	  vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
	endif

	" use ctrl-s for selections ranges.
	" requires 'textdocument/selectionrange' support of language server.
	nmap <silent> <c-s> <plug>(coc-range-select)
	xmap <silent> <c-s> <plug>(coc-range-select)

	" add `:format` command to format current buffer.
	command! -nargs=0 format :call cocactionasync('format')

	" add `:fold` command to fold current buffer.
	command! -nargs=? fold :call     cocaction('fold', <f-args>)

	" add `:or` command for organize imports of the current buffer.
	command! -nargs=0 or   :call     cocactionasync('runcommand', 'editor.action.organizeimport')



	" " find symbol of current document.
	" nnoremap <silent> <space>o  :<c-u>coclist outline<cr>

	" " search workspace symbols.
	" nnoremap <silent> <space>s  :<c-u>coclist -i symbols<cr>

	" " implement methods for trait
	" nnoremap <silent> <space>i  :call cocactionasync('codeaction', '', 'implement missing members')<cr>

	" " show actions available at this location
	" nnoremap <silent> <leader>a  :cocaction<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" keymap for replacing up to next _ or -
noremap <leader>m ct_

" i can type :help on my own, thanks.
map <f1> <esc>
imap <f1> <esc>


" =============================================================================
" # autocommands
" =============================================================================

" prevent accidental writes to buffers that shouldn't be edited
autocmd bufread *.orig set readonly
autocmd bufread *.pacnew set readonly

" leave paste mode when leaving insert mode
autocmd insertleave * set nopaste

" jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au bufreadpost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" follow rust code style rules
au filetype rust source ~/.config/nvim/scripts/spacetab.vim
au filetype rust set colorcolumn=100
au filetype zig set colorcolumn=100

" help filetype detection
autocmd bufread *.plot set filetype=gnuplot
autocmd bufread *.md set filetype=markdown
autocmd bufread *.lds set filetype=ld
autocmd bufread *.tex set filetype=tex
autocmd bufread *.trm set filetype=c
autocmd bufread *.xlsx.axlsx set filetype=ruby

" script plugins
" autocmd filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" =============================================================================
" # footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif
]]
