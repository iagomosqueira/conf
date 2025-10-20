vim.lsp.config('r_language_server', {
  cmd = { "R", "--slave", "-e", "languageserver::run()" },
  settings = {
    languageserver = {
      diagnostics = {
        globals = { "nvim" },
        update_in_insert = true,
      },
    },
  },
})
