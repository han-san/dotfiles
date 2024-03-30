vim.g.mapleader = ' '
vim.keymap.set('n', 'n', 'j')
vim.keymap.set('n', 'e', 'k')
vim.keymap.set('n', 'i', 'l')
vim.keymap.set('n', 'k', 'n')
vim.keymap.set('n', 'l', 'u')
vim.keymap.set('n', 'j', 'e')
vim.keymap.set('n', 'u', 'i')
vim.keymap.set('n', 'm', 'h')
vim.keymap.set('n', 'h', 'm')

vim.keymap.set('n', 'N', 'J')
vim.keymap.set('n', 'E', 'K')
vim.keymap.set('n', 'I', 'L')
vim.keymap.set('n', 'K', 'N')
vim.keymap.set('n', 'L', 'U')
vim.keymap.set('n', 'J', 'E')
vim.keymap.set('n', 'U', 'I')
vim.keymap.set('n', 'M', 'H')
vim.keymap.set('n', 'H', 'M')

vim.keymap.set('n', 'Y', 'y$')

vim.keymap.set('n', '<Leader>w', vim.cmd.w)

vim.opt.number = true
vim.opt.path:append("**")
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.report = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spelllang = { 'en', 'sv' }
vim.opt.backupdir:remove({'.'})
vim.opt.backup = true
vim.opt.smartcase = true
