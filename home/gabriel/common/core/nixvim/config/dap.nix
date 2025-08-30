{
  lib,
  pkgs,
  ...
}:
let
  codelldb-config = {
    name = "Launch (CodeLLDB)";
    type = "codelldb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end
    '';
    cwd = ''''${workspaceFolder}'';
    stopOnEntry = false;
  };

  gdb-config = {
    name = "Launch (GDB)";
    type = "gdb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end'';
    cwd = ''''${workspaceFolder}'';
    stopOnEntry = false;
  };

  lldb-config = {
    name = "Launch (LLDB)";
    type = "lldb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end'';
    cwd = ''''${workspaceFolder}'';
    stopOnEntry = false;
  };
in
{
  config.programs.nixvim.plugins = {
    dap = {
      enable = true;

      adapters = {
        executables = {
          cppdbg = {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          gdb = {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          lldb = {
            command = "${pkgs.lldb}/bin/lldb-vscode";
          };

          coreclr = {
            command = "${lib.getExe pkgs.netcoredbg}";
            args = [ "--interpreter=vscode" ];
          };
        };

        servers = {
          codelldb = lib.mkIf pkgs.stdenv.isLinux {
            port = 13000;
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = [
                "--port"
                "13000"
              ];
            };
          };
        };
      };

      configurations = {
        c = [ lldb-config ] ++ lib.optionals pkgs.stdenv.isLinux [ gdb-config ];

        cpp = [
          lldb-config
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          gdb-config
          codelldb-config
        ];

        rust = [
          lldb-config
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          gdb-config
          codelldb-config
        ];
      };

      extensions = {
        dap-ui = {
          enable = true;
        };

        dap-virtual-text = {
          enable = true;
        };
      };

      signs = {
        dapBreakpoint = {
          text = "";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "";
          texthl = "dapBreakpointCondition";
        };
        dapBreakpointRejected = {
          text = "";
          texthl = "DapBreakpointRejected";
        };
        dapLogPoint = {
          text = "";
          texthl = "DapLogPoint";
        };
        dapStopped = {
          text = "";
          texthl = "DapStopped";
        };
      };
    };
  };

  config.programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>b";
      action.__raw = ''
        function()
          require("dap").toggle_breakpoint()
        end
      '';
      options = {
        desc = "Breakpoint toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>c";
      action.__raw = ''
        function()
          require("dap").continue()
        end
      '';
      options = {
        desc = "Continue Debugging (Start)";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<leader>de";
      action.__raw = ''
        function() require("dapui").eval() end
      '';
      options = {
        desc = "Evaluate Input";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>de";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Expression: " }, function(expr)
            if expr then require("dapui").eval(expr, { enter = true }) end
          end)
        end
      '';
      options = {
        desc = "Evaluate Input";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dh";
      action.__raw = ''
        function() require("dap.ui.widgets").hover() end
      '';
      options = {
        desc = "Debugger Hover";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action.__raw = ''
        function()
          require("dap").step_out()
        end
      '';
      options = {
        desc = "Step Out";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action.__raw = ''
        function()
          require("dap").step_over()
        end
      '';
      options = {
        desc = "Step Over";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dS";
      action.__raw = ''
        function()
          require("dap").step_into()
        end
      '';
      options = {
        desc = "Step Into";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action.__raw = ''
        function() require("dap").terminate() end
      '';
      options = {
        desc = "Terminate Debugging";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>du";
      action.__raw = ''
        function()
          require('dap.ext.vscode').load_launchjs(nil, {})
          require("dapui").toggle()
        end
      '';
      options = {
        desc = "Toggle Debugger UI";
        silent = true;
      };
    }
  ];
}
