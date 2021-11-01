call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'do': 'npm install' }
Plug 'RRethy/vim-hexokinase', {'do': 'make; make install'}
Plug 'chriskempson/base16-vim'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'glepnir/dashboard-nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

syntax on
set number relativenumber
set termguicolors
set splitbelow splitright

colorscheme base16-tomorrow-night

let g:dashboard_custom_header = [
	\'  ▄▄▄       ▄████▄   █    ██ ▄▄▄█████▓▓█████  █     █░ ▒█████   ▒█████    █████▒',
	\' ▒████▄    ▒██▀ ▀█   ██  ▓██▒▓  ██▒ ▓▒▓█   ▀ ▓█░ █ ░█░▒██▒  ██▒▒██▒  ██▒▓██   ▒ ',
	\' ▒██  ▀█▄  ▒▓█    ▄ ▓██  ▒██░▒ ▓██░ ▒░▒███   ▒█░ █ ░█ ▒██░  ██▒▒██░  ██▒▒████ ░ ',
	\' ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓▓█  ░██░░ ▓██▓ ░ ▒▓█  ▄ ░█░ █ ░█ ▒██   ██░▒██   ██░░▓█▒  ░ ',
	\'  ▓█   ▓██▒▒ ▓███▀ ░▒▒█████▓   ▒██▒ ░ ░▒████▒░░██▒██▓ ░ ████▓▒░░ ████▓▒░░▒█░    ',
	\'  ▒▒   ▓▒█░░ ░▒ ▒  ░░▒▓▒ ▒ ▒   ▒ ░░   ░░ ▒░ ░░ ▓░▒ ▒  ░ ▒░▒░▒░ ░ ▒░▒░▒░  ▒ ░    ',
	\'   ▒   ▒▒ ░  ░  ▒   ░░▒░ ░ ░     ░     ░ ░  ░  ▒ ░ ░    ░ ▒ ▒░   ░ ▒ ▒░  ░      ',
	\'   ░   ▒   ░         ░░░ ░ ░   ░         ░     ░   ░  ░ ░ ░ ▒  ░ ░ ░ ▒   ░ ░    ',
	\'       ░  ░░ ░         ░                 ░  ░    ░        ░ ░      ░ ░          ',
	\'           ░                                                                    ',
\]

let g:dashboard_default_executive ='telescope'
hi NvimTreeFolderName guifg=fg

nnoremap <C-n> :NvimTreeToggle<CR>

lua << EOF

require('gitsigns').setup()

local cmd = vim.cmd

local present, nvimtree = pcall(require, "nvim-tree")

local g = vim.g

vim.o.termguicolors = true

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = git_status
g.nvim_tree_gitignore = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 1 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
--
g.nvim_tree_show_icons = {
   folders = 1,
   -- folder_arrows= 1
   files = 1,
   git = git_status,
}

g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
   },
   folder = {
      -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
      -- arrow_open = "",
      -- arrow_closed = "",
      default = "",
      empty = "", -- 
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
   },
}

nvimtree.setup {
   diagnostics = {
      enable = false,
      icons = {
         hint = "",
         info = "",
         warning = "",
         error = "",
      },
   },
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = true,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   view = {
      allow_resize = true,
      side = "left",
      width = 25,
   },
}

EOF
