
require("nvim-treesitter.configs").setup{

  ensure_installed = { "c", "cpp", "lua", "vim", "latex", "markdown",
    "markdown_inline", "bash", "r", "rnoweb", "yaml"},
 
  highlight = {enable = true},
  
  indent = {enable = true},
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<C-BS>",
      },
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

-- latex

-- parser_config.latex = {
--   install_info = {
--     url = "~/.config/nvim/parsers/tree-sitter-latex",
--     files = {"src/parser.c"},
--     branch = "main",
--     generate_requires_npm = false,
--     requires_generate_from_grammar = false,
--   },
--   filetype = "tex", -- if filetype does not match the parser name
-- }
-- 
-- vim.treesitter.language.register('latex', 'tex')
-- 
-- stan

parser_config.stan = {
  install_info = {
    url = "~/.config/nvim/parsers/tree-sitter-stan",
    files = { 'src/parser.c' }, 
    branch = 'main',
  },
}

vim.treesitter.language.register('stan', 'stan')
