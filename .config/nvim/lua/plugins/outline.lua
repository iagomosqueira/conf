require'outline'.setup {
  providers = {
    priority = { 'markdown', 'treesitter', 'lsp' },
  },
  outline_window = {
    width = 25,
        relative_width = true
  }
}
