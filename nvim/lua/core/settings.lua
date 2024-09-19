vim.opt.smartcase = true -- Only use case sensitive search when search includes case
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Use relative line numbers
vim.opt.shiftwidth = 2 -- Change the number of spaces used for shift
vim.opt.tabstop = 2 -- Change the number of spaces used for tab
vim.opt.cmdheight = 2 -- Use 2 lines for commands at bottom of screen

vim.cmd(':colorscheme industry') -- Set color scheme

-- Disable providers
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
