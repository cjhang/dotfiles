return {
-- pyrefly
{
  "neovim/nvim-lspconfig", -- optional, used only as a config anchor
  ft = { "python" },
  config = function()
    -- Inline on_attach (Fix option 2 style)
    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    -- nvim-cmp capabilities
    local capabilities =
      vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

    -- Pyrefly LSP configuration
    vim.lsp.config("pyrefly", {
      cmd = { "pyrefly", "lsp" }, -- or full path if needed
      filetypes = { "python" },
      root_dir = vim.fs.root(0, {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        ".git",
      }),
      on_attach = on_attach,
      capabilities = capabilities,

      -- Optional: pyrefly settings (adjust if needed)
      settings = {
        python = {
          extraPaths = "/path/to/extra/modules",
          analysis = {
            typeCheckingMode = "basic",
          },
        },
      },
    })

    vim.lsp.enable("pyrefly")
  end,
}

}
