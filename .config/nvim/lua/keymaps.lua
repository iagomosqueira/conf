-- :qq to quit window if saved or RO
vim.keymap.set("n", "qq", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.bo[bufnr].modified
  local readonly = vim.bo[bufnr].readonly

  if readonly or not modified then
    vim.cmd("q")
  else
    print("Buffer has unsaved changes")
  end
end, { desc = "Close buffer if saved or read-only" })
