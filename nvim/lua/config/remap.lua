vim.g.mapleader = ";"

vim.keymap.set('n', '<leader>sv', '<Plug>(vimtex-compile-ss)')
vim.keymap.set('n', '<leader>sc', '<Plug>(vimtex-compile)')
vim.keymap.set('n', '<leader>vv', '<Plug>(vimtex-view)')
vim.keymap.set('n', '<leader>cc', '<Plug>(vimtex-toggle-main)')

vim.keymap.set('n', "<leader>fo", function()
  require("conform").format({ async = true })
end)
