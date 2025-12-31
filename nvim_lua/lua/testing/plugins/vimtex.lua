return {
  "lervag/vimtex",
  lazy = false,   -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  config = function()
    -- VimTeX configuration goes here
    --vim.g.vimtex_view_method = "zathura"
    vim.g.tex_flavor = 'pdflatex'
    vim.g.vimtex_compiler_enabled = true
    vim.g.vimtex_fold_enabled = true
    vim.g.vimtex_quickfix_enabled = 0
    vim.g.vimtex_view_automatic = 0
    vim.g.vimtex_compiler_method = 'tectonic'
    vim.g.vimtex_compiler_tectonic = {
      out_dir = "./_build",
      options = { "--keep-logs", "--synctex" },
    }
  end,
}
