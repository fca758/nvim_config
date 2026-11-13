return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = mason_bin .. "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            local function codelldb_config()
                return {
                    {
                        name = "Launch (C/C++)",
                        type = "codelldb",
                        request = "launch",
                        program = function()
                            local build = require("build")
                            if build.last_binary and vim.fn.executable(build.last_binary) == 1 then
                                return build.last_binary
                            end
                            return vim.fn.input("Binario: ", build.root() .. "/", "file")
                        end,
                        cwd = function()
                            return require("build").root()
                        end,
                        stopOnEntry = false,
                        args = {},
                    },
                }
            end

            dap.configurations.c = codelldb_config()
            dap.configurations.cpp = codelldb_config()

            dap.adapters.python = {
                type = "executable",
                command = mason_bin .. "debugpy-adapter",
                args = {},
            }

            dap.configurations.python = {
                {
                    name = "Launch file",
                    type = "python",
                    request = "launch",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    justMyCode = true,
                },
            }

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })

            local map = vim.keymap.set
            map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: breakpoint" })
            map("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Condición: "))
            end, { desc = "DAP: breakpoint condicional" })
            map("n", "<leader>dc", dap.continue, { desc = "DAP: continuar" })
            map("n", "<leader>di", dap.step_into, { desc = "DAP: step into" })
            map("n", "<leader>do", dap.step_over, { desc = "DAP: step over" })
            map("n", "<leader>dO", dap.step_out, { desc = "DAP: step out" })
            map("n", "<leader>dr", dap.restart, { desc = "DAP: reiniciar" })
            map("n", "<leader>dq", dap.terminate, { desc = "DAP: terminar" })
            map("n", "<leader>du", dapui.toggle, { desc = "DAP: toggle UI" })
            map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "DAP: evaluar" })
        end,
    },
}
