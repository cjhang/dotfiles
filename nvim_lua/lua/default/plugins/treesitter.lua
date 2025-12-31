-- nvim-treesitter is already shipped with lazy
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "python",
        "latex",
      },
    },
  },
}
