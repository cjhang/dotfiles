vim.g.mapleader = ","
vim.g.maplocalleader = " "
local keymap = vim.keymap -- for conciseness


----------------------------
------ normal mode ---------

-- press n to remove highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc="Clear search highlights"})

-- find and replace
keymap.set("n", ";;", ":1,$s:::gc<left><left><left><left>", {desc="global replace"})

-- fold management
keymap.set("n", "<leader>f0", function()
	vim.o.foldlevel = 0
end, { desc = "Fold all" })

keymap.set("n", "<leader>f1", function()
	vim.o.foldlevel = 1
end, { desc = "Fold level 1" })

keymap.set("n", "<leader>f2", function()
	vim.o.foldlevel = 2
end, { desc = "Fold level 2" })

keymap.set("n", "<leader>f9", function()
	vim.o.foldlevel = 99
end, { desc = "Unfold all" })



----------------------------
------ cmd line mode -------

-- a more basic way
--vim.api.nvim_set_keymap('c', '<Up>', 'wildmenumode() ? "<Left>" : "<Up>"', {expr = true, noremap=true})
--vim.api.nvim_set_keymap('c', '<Down>', 'wildmenumode() ? "<Right>" : "<Down>"', {expr = true, noremap=true})
--vim.api.nvim_set_keymap('c', '<Left>', 'wildmenumode() ? "<Up>" : "<Left>"', {expr = true, noremap=true})
--vim.api.nvim_set_keymap('c', '<Right>', 'wildmenumode() ? "<Down>" : "<Right>"', {expr = true, noremap=true})

-- follow the keymap style
keymap.set("c", "<Up>", 'wildmenumode() ? "<Left>" : "<Up>"', {expr=true, noremap=true, desc="remap the Up key", replace_keycodes=false})
keymap.set("c", "<Down>", 'wildmenumode() ? "<Right>" : "<Down>"', {expr=true, noremap=true, desc="remap Down left key", replace_keycodes=false})
keymap.set("c", "<Left>", 'wildmenumode() ? "<Up>" : "<Left>"', {expr=true, noremap=true, desc="remap the Left key", replace_keycodes=false})
keymap.set("c", "<Right>", 'wildmenumode() ? "<Down>" : "<Right>"', {expr=true, noremap=true, desc="remap the Right key", replace_keycodes=false})


----------------------------
------ terminal mode -------

-- esc to escape termimal mode
-- keymap.set("t", "<Esc>", "<C-\\><C-n>", {desc="escape terminal with esc"})
