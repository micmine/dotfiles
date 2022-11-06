vim.opt.background = 'dark'

local term = os.getenv("TERM");

if term == 'linux' then
  vim.cmd("colorscheme truedark")

else
  vim.cmd("colorscheme oxocarbon")

  require('colorizer').setup()
end
