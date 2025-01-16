require("esqueleto").setup(
  {
    patterns = { "LICENSE", "r", "rmd", "markdown"},
    wildcards = {lookup = {
      ["filerelpath"] = function() return vim.fn.expand("%:p") end,
    }}
  }
)
