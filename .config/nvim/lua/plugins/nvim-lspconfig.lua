require('lspconfig').r_language_server.setup {
  cmd = { "R", "--slave", "-e", "languageserver::run()" },
  settings = {
    languageserver = {
      diagnostics = {
        globals = { "nvim" },
        update_in_insert = true,
      },
    },
  },
}
