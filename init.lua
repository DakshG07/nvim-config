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
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup()
    end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.nvim_workspace()
      lsp.setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({
        with_sync = true
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          diagnostics = "nvim_lsp"
        },
    })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = "catppuccin"
        },
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').init_lsp_saga()
    end,
  },
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        highlights = {
          Normal = {
            guibg = "#181825", -- Slightly darker background
          },
        },
        shade_terminals = false,
      })
    end,
  },
})
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
