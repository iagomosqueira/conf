require("esqueleto").setup(
  {
    patterns = { "LICENSE", "README.md", "r", "rmd", "markdown"},
    wildcards = {lookup = {
      ["filerelpath"] = function() return vim.fn.expand("%:p") end,
    }}
  }
)
