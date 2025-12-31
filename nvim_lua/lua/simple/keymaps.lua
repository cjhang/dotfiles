vim.g.mapleader = ","
vim.g.maplocalleader = " "
local keymap = vim.keymap -- for conciseness


----------------------------
------ normal mode ---------

-- press n to remove highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc="Clear search highlights"})

-- find and replace
keymap.set("n", ";;", ":1,$s:::gc<left><left><left><left>", {desc="global replace"})


