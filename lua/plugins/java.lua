return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          cmd = {
            "-javaagent:" .. vim.fn.expand("$HOME") .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
          },
        },
      },
    },
  },
}
