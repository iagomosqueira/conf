-- Rcheck.log Neovim enhancements
-- For R CMD check logs

local api = vim.api
local fn = vim.fn

-- =========================================================
-- CONFIG
-- =========================================================

local ns = api.nvim_create_namespace("rchecklog")

local icons = {
  ERROR = " ",
  WARNING = " ",
  NOTE = " ",
}

local colors = {
  ERROR = "#ff5f5f",
  WARNING = "#ffaf00",
  NOTE = "#5fd7ff",
  STAR = "#888888",
}

-- =========================================================
-- Disable any conflicting highlighting (Treesitter safe)
-- =========================================================

pcall(function()
  vim.treesitter.stop()
end)

vim.cmd("syntax off")

-- =========================================================
-- Highlight groups (IMPORTANT: buffer-safe)
-- =========================================================

local function hl(name, fg)
  vim.api.nvim_set_hl(0, "rcheck_" .. name, { fg = fg })
end

hl("ERROR", colors.ERROR)
hl("WARNING", colors.WARNING)
hl("NOTE", colors.NOTE)
hl("STAR", "#00ff7f")        -- green marker
hl("QUESTION", "#ffcc66")    -- yellow/orange question

-- =========================================================
-- Icon + color rendering
-- =========================================================

local function render()
  local bufnr = api.nvim_get_current_buf()
  api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    local row = i - 1

    -- =========================================================
    -- 1. Lines starting with "*"
    -- =========================================================
    if line:match("^%*") then

      local kind

      if line:find("ERROR") then
        kind = "ERROR"
      elseif line:find("WARNING") then
        kind = "WARNING"
      elseif line:find("NOTE") then
        kind = "NOTE"
      end

      if kind then
        -- replace ONLY the "*" visually with icon
        api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
          virt_text = {
            { icons[kind], "rcheck_" .. kind },
            { line:sub(2), "Normal" },
          },
          virt_text_pos = "overlay",
          hl_mode = "combine",
        })
      else
        -- fallback for generic "* ..." lines
        api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
          virt_text = {
            { "*", "rcheck_STAR" },
            { line:sub(2), "Normal" },
          },
          virt_text_pos = "overlay",
          hl_mode = "combine",
        })
      end

    -- =========================================================
    -- 2. Non-* lines → Question highlight (FULL LINE)
    -- =========================================================
    else
      api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
        end_col = #line,
        hl_group = "rcheck_QUESTION",
      })
    end
  end
end

-- =========================================================
-- Folding: * checking ... blocks
-- =========================================================

vim.opt_local.foldmethod = "expr"

_G.rcheck_foldexpr = function()
  local line = fn.getline(vim.v.lnum)

  if line:match("^%* checking") then
    return ">1"
  elseif line:match("^%* DONE") then
    return "<1"
  else
    return "="
  end
end

vim.opt_local.foldexpr = "v:lua.rcheck_foldexpr()"
vim.opt_local.foldlevelstart = 99

-- =========================================================
-- Auto refresh
-- =========================================================

render()

api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  buffer = 0,
  callback = render,
})
