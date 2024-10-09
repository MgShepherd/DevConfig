vim.g.mapleader = ' '

-- Tabs
vim.keymap.set('n', '<leader>tc', '<cmd>tabnew<CR>', { desc = 'Create new tab' })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close the current tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Move to the next tab' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Move to the previous tab' })
vim.keymap.set('n', '<leader>ts', '<cmd>tab split<CR>', { desc = 'Move to the previous tab' })

-- General
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>', { desc = 'Open the file explorer' })
vim.keymap.set('n', '<leader>h', '<cmd>nohl<CR>', { desc = 'Clear highlighting' })

-- Treesitter
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Search for files in the project' })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>', { desc = 'Global text search' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Buffers' })
