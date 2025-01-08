require("r").setup{
  R_args = {"--no-save"},
  objbr_openlist = false,
  pdfviewer = "xdg-open",
  objbr_w = 16,
  setwd = "file",
  external_term = "alacritty --config-file ~/.config/alacritty/R.yml -e"
}

-- keymaps
vim.api.nvim_set_keymap("n", "<Enter>", "<Plug>RDSendLine", {})
vim.api.nvim_set_keymap("v", "<Enter>", "<Plug>RDSendSelection", {})
vim.api.nvim_set_keymap("n", "<BS>", "<Plug>RSendLine", {})
