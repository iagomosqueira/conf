vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "00check.log",
  callback = function()
    vim.bo.filetype = "rchecklog"
  end,
})
