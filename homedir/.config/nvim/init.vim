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
Plug 'famiu/feline.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'ellisonleao/glow.nvim'

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

noremap <C-n> :NvimTreeToggle<CR>
noremap <C-p> :Glow<CR>

set mouse=a

lua << EOF

require('gitsigns').setup()
require('feline').setup()

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

""" FELINE
lua << EOF
if not pcall(require, "feline") then
  return
end

local colors = {
    bg = '#282a2e',
    fg = 'c5c8c6',
    yellow = '#f0c674',
    cyan = '#8abeb7',
    darkblue = '#81a2be',
    green = '#b5bd68',
    orange = '#f0c674',
    violet = '#b294bb',
    magenta = '#b294bb',
    blue = '#81a2be',
    red = 'cc6666'
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = '🐧 '
	os = 'UNIX/LINUX'
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local lsp_get_diag = function(str)
  local count = vim.lsp.diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

-- LuaFormatter off

local comps = {
    vi_mode = {
        left = {
            provider = function()
              return ' 🐺 ' .. vi_mode_utils.get_vim_mode()
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color(),
                    -- fg = colors.bg
                }
                return val
            end,
            right_sep = ' '
        },
        right = {
            -- provider = '▊',
            provider = '🐶' ,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color()
                }
                return val
            end,
            left_sep = ' ',
            right_sep = ' '
        }
    },
    file = {
        info = {
            provider = {
              name = 'file_info',
              opts = {
                type = 'relative-short',
                file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_modified_icon = '',
                file_modified_icon = '',
                -- file_modified_icon = 'ﱐ',
                -- file_modified_icon = '',
                -- file_modified_icon = '',
                -- file_modified_icon = '',
              }
            },
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                -- style = 'bold'
            }
        },
    },
    left_end = {
        provider = function() return '' end,
        hl = {
            fg = colors.bg,
            bg = colors.blue,
        }
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
            -- provider = 'diagnostic_errors',
            provider = function()
                return '' .. lsp_get_diag("Error")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Error') end,
            hl = {
                fg = colors.red
            }
        },
        warn = {
            -- provider = 'diagnostic_warnings',
            provider = function()
                return '' ..  lsp_get_diag("Warning")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Warning') end,
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            -- provider = 'diagnostic_info',
            provider = function()
                return '' .. lsp_get_diag("Information")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Information') end,
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            -- provider = 'diagnostic_hints',
            provider = function()
                return '' .. lsp_get_diag("Hint")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Hint') end,
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            -- left_sep = ' ',
            right_sep = ' ',
            -- icon = '  ',
            icon = '慎',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            -- icon = ' ',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)


-- TreeSitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local ts_parsers = require("nvim-treesitter.parsers")
-- local ts_queries = require("nvim-treesitter.query")
--[[ table.insert(components.active[2], {
  provider = function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    return ("%d:%s [%d, %d] - [%d, %d]")
      :format(node:symbol(), node:type(), node:range())
  end,
  enabled = function()
    local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    return ok and ts_parsers.has_parser()
  end
}) ]]

-- require'feline'.setup {}
require'feline'.setup {
    colors = { bg = colors.bg, fg = colors.fg },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}
EOF

""" Bufferline
lua require("bufferline").setup{}
