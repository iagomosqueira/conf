require("r").setup{
  R_args = {"--no-save"},
  objbr_openlist = false,
  objbr_w = 16,
  setwd = "file",
  external_term = "alacritty --config-file ~/.config/alacritty/R.yml -e"
}

-- keymaps
vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RDSendSelection", {})
vim.api.nvim_buf_set_keymap(0, "n", "<BS>", "<Plug>RSendLine", {})
