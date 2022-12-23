-- Bootstrap Lazy.Nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
-- True colors
vim.o.termguicolors = true
-- Line numbers
vim.o.mouse = "nv"
vim.o.number = true
vim.o.relativenumber = true
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.runtimepath:prepend(lazypath)
-- Indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
pcall(require, "plugins")
-- Colorscheme
vim.g.catppuccin_flavour = "mocha"
vim.cmd.colorscheme "catppuccin"
-- Keymaps
vim.keymap.set("n", "L", "<cmd>bnext<CR>")
vim.keymap.set("n", "H", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<leader>c", ":bdelete<CR>")
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
-- LspSaga
vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>')
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>hd', '<cmd>Lspsaga hover_doc<CR>')
-- Trouble
vim.keymap.set('n', '<leader>td', '<cmd>TroubleToggle<CR>')
-- NvimTree
vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeFocus<CR>') -- Focus tree
vim.keymap.set('n', '<leader>st', function() require('nvim-tree.api').tree.toggle(false, true) end) -- Show tree
vim.keymap.set('n', '<leader>ht', '<cmd>NvimTreeClose<CR>') -- Hide tree
-- ToggleTerm
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _Lazygit_toggle()
  lazygit:toggle()
end
vim.keymap.set('n', '<leader>gg', '<cmd>lua _Lazygit_toggle()<CR>', {noremap = true, silent = true}) -- LazyGit
vim.keymap.set('n', '<leader>tf', '<cmd>:ToggleTerm direction=float<CR>', {noremap = true, silent = true}) -- Terminal Floating
vim.keymap.set('n', '<leader>lt', '<cmd>:ToggleTerm <CR>', {noremap = true, silent = true}) -- Little Terminal
