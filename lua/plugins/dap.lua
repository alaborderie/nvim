return {
  "nvim-dap",
  optional = true,
  enabled = true,
  dependencies = {
    {
      "microsoft/vscode-js-debug",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
    },
  },
  config = function() end,
  opts = function()
    local dap = require("dap")
    local runtime = vim.uv.fs_stat("bun.lock") and "bun" or "node"

    dap.set_log_level("TRACE")

    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = runtime,
          args = {
            vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js",
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end

        local nativeAdapter = dap.adapters["pwa-node"]

        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes

    local dap_configurations = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = runtime,
        runtimeArgs = runtime == "bun" and { "run", "--watch" } or nil,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
      },
    }

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then
        dap.configurations[language] = dap_configurations
      end
    end
  end,
}
