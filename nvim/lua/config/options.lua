vim.cmd.colorscheme("industry");
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- General settings
vim.opt.number = true       -- line numbers
vim.opt.wrap = false        -- wrap lines
vim.opt.scrolloff = 10      -- keep lines above/below cursor
vim.opt.sidescrolloff = 8   -- keep columns left/right cursor

-- Indentation
vim.opt.tabstop = 4         -- tib width
vim.opt.softtabstop = 4     -- indent width
vim.opt.shiftwidth = 4      -- soft tabe stop
vim.opt.expandtab = true    -- use spaces instead of tabs
vim.opt.smartindent = true  -- smart auto-indenting

-- Search settings
vim.opt.hlsearch = false    -- search result highlight
vim.opt.incsearch = true    -- matching as typing

-- Visual settings
vim.opt.termguicolors = true    -- 24-bit colors
vim.opt.signcolumn = "yes:1"    -- showing sign columns
vim.opt.cmdheight = 1
vim.opt.syntax = "enable"
vim.opt.showmode = false
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300         -- syntax highlighting limit

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.autowrite = false

-- Behavior settings
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.path:append("**")
vim.opt.clipboard:append("unnamedplus")
vim.opt.encoding = "UTF-8"
