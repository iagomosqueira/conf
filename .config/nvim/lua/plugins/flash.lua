require('flash').setup{
    search = {
        mode = function(str)
          return "\\<" .. str
        end
    },
    jump = {
        autojump = true,
    },
    label = {
        rainbow = {
          enabled = true,
          shade = 9,
        }
    }
}

vim.keymap.set({"n","o","x"},"j", function() require("flash").jump() end, {desc="Flash"})
vim.keymap.set({"i"}, "<C-j>", function() require("flash").jump() end, {desc="Flash"})
vim.keymap.set({"n","o","x"},"J", function() require("flash").treesitter() end, {desc="Flash"})
