require'outline'.setup {
  
  providers = {
    priority = { 'markdown', 'treesitter', 'lsp' },
	  markdown = {
		  filetypes = { "markdown", "quarto", "rmd" },
	  },
	  treesitter = {
		  filetypes = { "r" },
	  },
  },
  
  outline_window = {
    width = 28,
    relative_width = true,
    focus_on_open = false,
  },
  
  outline_items = {
    show_symbol_lineno = false,
  },

  symbol_folding = {

    autofold_depth = 2,
  },
  symbols = {
    icon_fetcher = function(kind, bufnr, symbol) return kind:sub(1,1) end,
  }
}
