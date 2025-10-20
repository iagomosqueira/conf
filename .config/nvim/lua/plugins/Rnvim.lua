require("r").setup{
  R_args = {"--no-save"},
  objbr_openlist = false,
  pdfviewer = "xdg-open",
  objbr_w = 16,
  setwd = "file",
  external_term = "alacritty --config-file /home/mosqu003/.config/alacritty/R.yml -e",
  debug = false,
  debug_jump = false,
  hook = {
    on_filetype = function()
      vim.opt.foldmethod = "marker"
      vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {noremap = true})
      vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {noremap = true})
      vim.api.nvim_buf_set_keymap(0, "n", "<BS>", "<Plug>RSendLine", {noremap = true})
    end,
  },
}
