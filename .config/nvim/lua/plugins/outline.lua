require'outline'.setup {
  providers = {
    priority = { 'markdown', 'treesitter', 'lsp' },
  },
  outline_window = {
    width = 30,
        relative_width = true
  }
}
