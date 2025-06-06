require("copilot").setup {
  filetypes = {
    [ '*' ] = false,
--    rmarkdown =  true,
--    r = true
  },
  copilot_node_command = '/home/mosqu003/.nvm/versions/node/v23.11.0/bin/node',
  auto_trigger = false,
  suggestion.enabled = false,
  cmd = "Copilot",
  event = "InsertEnter",
  workspace_folders = {
    "/home/mosqu003/Projects/FLR/code",
  }
}
