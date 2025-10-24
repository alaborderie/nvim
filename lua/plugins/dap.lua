return {
  "rcarriga/nvim-dap-ui",
  config = function(_, opts)
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup(opts)
    -- Remove automatic UI closing on session end
    dap.listeners.after.event_terminated["dapui_config"] = nil
    dap.listeners.after.event_exited["dapui_config"] = nil
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
  end,
}
