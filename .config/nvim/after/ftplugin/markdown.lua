
vim.keymap.set("n", "O", function()
  vim.cmd("normal! o")                         -- open new line above
  vim.cmd("normal! <Plug>(bullets-newline)")   -- trigger bullets
  vim.cmd("normal! ^i  - ")                      -- insert two spaces at start
end, {
  buffer = true,
  desc = "Add level 2 bullet"
})


vim.keymap.set("n", "C-Tab", function()
  vim.cmd("normal! ^i  ")                      -- insert two spaces at start
end, {
  buffer = true,
  desc = "Add level 2 bullet"
})
