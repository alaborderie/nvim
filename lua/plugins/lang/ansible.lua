return {
  {
    "mfussenegger/nvim-ansible",
    ft = {},
    keys = {
      { "<leader>ta", function() require("ansible").run() end, desc = "Ansible Run Playbook/Role", silent = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-language-server",
        "ansible-lint",
      },
    },
  },
}
