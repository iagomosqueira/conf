
vim.api.nvim_create_user_command("RmdFixImages", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  local new = line:gsub(
    'taf%.png%("(.-)%.png"%)',
    function(name)
      local path = "report/" .. name .. ".png"

      local first = path
        :gsub("^report/", "")
        :gsub("/", "-")
        :gsub("_", "")
        :gsub("%.png$", "")

      return "```{r " .. first .. ', fig.cap=""}\n' ..
             'include_graphics("' .. path .. '")\n```'
    end
  )

  local lines = vim.split(new, "\n")
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, lines)
end, {})


vim.keymap.set("n", "<leader>p", "<cmd>RmdFixImages<CR>", {
  buffer = true,
  desc = "Fix Rmd image block"
})
