require("copilot").setup {
  filetypes = {
    markdown =  false,
    r = true
  },
  copilot_node_command = '/home/mosqu003/.nvm/versions/node/v23.11.0/bin/node',
  auto_trigger = false,
  cmd = "Copilot",
  event = "InsertEnter",
  workspace_folders = {
    "/home/mosqu003/Projects/FLR/code",
  }
}
