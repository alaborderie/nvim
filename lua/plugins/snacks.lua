local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable the features you're using in your keymaps
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      debug = { enabled = true },
      gitbrowse = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
      terminal = {
        win = {
          keys = {
            nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },
      toggle = { enabled = true },
      zen = { enabled = true },
      indent = { enabled = true },
      scroll = { enabled = true },
      dim = { enabled = true },
      animate = { enabled = true },
      profiler = { enabled = true },
      profiler_highlights = { enabled = true },
      dashboard = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>dps",
        function()
          Snacks.profiler.scratch()
        end,
        desc = "Profiler Scratch Buffer",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for easier access
          _G.Snacks = require("snacks")
        end,
      })
    end,
  },
}
