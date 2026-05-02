require("telescope").setup()

vim.cmd("set termguicolors")

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

-- Override the Tree-sitter migration warning function
local ts = require("nvim-treesitter.parsers")

-- Save original function
local original_warn = ts._warn

-- Override
ts._warn = function(msg, ...)
  print("Tree-sitter migration detected! Parser path likely causing it:")
  print(msg)
  -- Call original warning so behavior is unchanged
  original_warn(msg, ...)
end


-- require("plugins.copilot")
vim.cmd("silent! Copilot disable")

-- SET treesitter default foldmethod
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(args)
    vim.schedule(function()
      if args.match == "r" then
        vim.opt_local.foldmethod = "marker"
      elseif require("nvim-treesitter.parsers").has_parser() then
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      else
        vim.opt_local.foldmethod = "syntax"
      end
    end)
  end,
})

vim.g.markdown_recommended_style = 0

-- devcontainer
require("devcontainer").setup{}

-- zotcite
require("zotcite").setup({  
    hl_cite_key = true,  
    sort_key = "date",  
    key_type = "better-bibtex",
    conceallevel = 0,  
    filetypes = { "markdown", "pandoc", "rmd", "quarto", "vimwiki" },  
    python_path = "python3",  
    pdf_extractor = "pdfnotes.py",  
    -- Add any other options from doc/zotcite.txt  
})
