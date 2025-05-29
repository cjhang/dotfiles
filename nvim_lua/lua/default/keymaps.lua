vim.g.mapleader = ","
vim.g.maplocalleader = " "
local keymap = vim.keymap -- for conciseness


----------------------------
------ normal mode ---------

-- press n to remove highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc="Clear search highlights"})

-- find and replace
keymap.set("n", ";;", ":1,$s:::gc<left><left><left><left>", {desc="global replace"})

-- increment and decrement numbers
keymap.set("n", "<leader>+", "<C-a>", {desc = "Increment Number"}) -- increment
keymap.set("n", "<leader>-", "<C-x>", {desc = "Decrement Number"}) -- decrement

-- window management
keymap.set("n", "<leader>v", "<C-w>v", {desc="Split window vertically"})
keymap.set("n", "<leader>h", "<C-w>s", {desc="Split window horizontally"})
keymap.set("n", "<leader>=", "<C-w>=", {desc="Make splits equal size"})
keymap.set("n", "<leader>x", "<cmd>close<CR>", {desc="Close current split"})
-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {desc="Open New Tab"})
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {desc="Close current tab"})
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {desc="Go to next tab"})
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {desc="Go to prev tab"})
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc="Open current buffer in new tab"})


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
