  -- Set up nvim-cmp.
  local cmp = require'cmp'

-- Install nvim-treesitter and set up context checking
local function is_in_code_context()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  
  if not node then return true end
  
  local node_type = node:type()
  local disabled_contexts = {
    'comment',
    'string',
    'string_content',
    'template_string',
  }
  
  for _, context in ipairs(disabled_contexts) do
    if node_type:match(context) then
      return false
    end
  end
  
  return true
end

cmp.setup({
  snippet = {
  -- REQUIRED - you must specify a snippet engine
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    
    window = {
--      completion = cmp.config.window.bordered(),
--      documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),

    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp", group_index = 2 },
      { name = 'vsnip' },
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {{ name = 'cmdline', option = {  treat_trailing_slash = false }}} ,
    {{ name = 'path', option = {  trailing_slash = true }}}
  ),
    matching = { disallow_symbol_nonprefix_matching = false }
})

cmp.setup({
    enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return false
      else
        return not context.in_treesitter_capture("comment") 
          and not context.in_syntax_group("Comment")
      end
    end
})
