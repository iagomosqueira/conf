require("telescope").setup()
require("colorizer").setup()

require("plugins.Rnvim")
require("plugins.cmp-pandoc-references")
require("plugins.cmp-r")
require("plugins.esqueleto")
require("plugins.nvim-cmp")
require("plugins.nvim-treesitter")
require("plugins.obsidian-nvim")
require("plugins.outline")
require("plugins.todo-comments")
require("plugins.nvim-lspconfig")
require("plugins.nvim-origami")

-- require("plugins.copilot")
vim.cmd("silent! Copilot disable")

-- SET treesitter default foldmethod
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})

vim.g.markdown_recommended_style = 0
