-- Author: Jianhang Chen
-- Release: 2017-01-28
-- Update: 2024-01-11
-- Version: 0.3.0
-- Copyright: 2017-2024 cjhang, all rights reserved 
-- Email: cjhastro@gmail.com
--

require("simple.keymaps")

local opt = vim.opt

-- editing
opt.number = true
opt.relativenumber = false
-- opt.cursorline = true
opt.scrolloff = 3

-- tabs, indentation & wrap
opt.tabstop = 2
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent of current line to new line
opt.wrap = true

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- search settings
opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- uses mixed case for case sensitive search

-- colors
-- opt.colorscheme = "jellybeans-nvim", moved to the plugin setups
-- opt.termguicolors = true
opt.background = "dark" -- colorschemes can be light or dark
opt.signcolumn = "yes" -- show sign column so that text doesnt shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position 

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- backups and swapfile
opt.backup = false
opt.hidden = false
opt.swapfile = true


