require('origami').setup {
  autoFold = {
    enabled = false
  },
  foldtext = {
    padding = 2,
  },
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}
