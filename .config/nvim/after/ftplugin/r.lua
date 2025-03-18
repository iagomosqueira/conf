local get_root = function(bufnr, lang)
  local parser = vim.treesitter.get_parser(bufnr, lang, {})
  local tree = parser:parse()[1]
  return tree:root()
end

local highlight_roxygen2_tags = function(bufnr)
  local query = [[
((comment) @comment.roxygen2
  (#lua-match? @comment.roxygen2 "^#' (@%a+).*$")
  (#gsub! @comment.roxygen2 "^#' (@%a+).*$" "%1"))
]]
  local root = get_root(bufnr, "r")
  local ts_query = vim.treesitter.query.parse("r", query)
  local ns = vim.api.nvim_create_namespace("r.comments.roxygen2")
  for id, node, metadata in ts_query:iter_captures(root, bufnr) do
    if ts_query.captures[id] == "comment.roxygen2" then
      local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
      local start_col = 3 -- skip leading "#' "
      local end_col = start_col + #metadata[id].text -- add tag length

      vim.highlight.range(bufnr, ns, "@operator", { start_row, start_col }, { end_row, end_col })
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
  desc = "Highlight roxygen2 tags",
  buffer = 0,
  callback = function(args)
    highlight_roxygen2_tags(args.buf)
  end,
})
