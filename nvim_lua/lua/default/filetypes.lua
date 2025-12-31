
-- python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.treesitter.start() end,
  callback = function()
    local ok = pcall(vim.treesitter.get_parser, 0, "python")
    if not ok then return end
    vim.opt_local.foldmethod = "expr"
    vim.opt.foldexpr =  "v:lua.vim.treesitter.foldexpr()" -- skip if Tree-sitter not used
    vim.opt_local.foldlevel = 0
    vim.opt_local.foldnestmax = 2
  end,
})

-- vim
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldlevel = 0
    vim.opt_local.foldnestmax = 3
  end,
})

-- tex
local texmap_group = vim.api.nvim_create_augroup("texmap", { clear = true })
-- Autocmd: run on FileType tex
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  group = texmap_group,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- Keymaps for vimtex
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "<leader>m", "<Plug>(vimtex-imaps-list)", opts)
    vim.keymap.set("n", "<leader>c", ":VimtexCompileSS<CR>", opts)
    vim.keymap.set("n", "<leader>v", ":VimtexView<CR>", opts)
    vim.keymap.set("n", "<leader>x", ":VimtexCompileOutput<CR>", opts)
    vim.keymap.set("n", "]]", "<Plug>(vimtex-]])", opts)
    vim.keymap.set("n", "[[", "<Plug>(vimtex-[[)", opts)

    -- Buffer-local settings
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
