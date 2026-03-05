{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.clangd_extensions-nvim
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;
    servers = {
      bashls.enable = true;
      jsonls.enable = true;
      gopls.enable = true;
      lua_ls.enable = true;
      basedpyright.enable = true;
      yamlls.enable = true;
      docker_compose_language_service.enable = true;
      dockerls.enable = true;
      neocmake.enable = true;
      terraformls.enable = true;
      zls.enable = true;
      emmet_language_server.enable = true;
      fish_lsp.enable = true;
      typos_lsp.enable = true;

      vtsls = {
        enable = true;
        settings = {
          complete_function_calls = true;
          vtsls = {
            enableMoveToFileCodeAction = true;
            autoUseWorkspaceTsdk = true;
            experimental = {
              maxInlayHintLength = 30;
              completion.enableServerSideFuzzyMatch = true;
            };
          };
          typescript = {
            updateImportsOnFileMove.enabled = "always";
            suggest.completeFunctionCalls = true;
            inlayHints = {
              enumMemberValues.enabled = true;
              functionLikeReturnTypes.enabled = true;
              parameterNames.enabled = "literals";
              parameterTypes.enabled = true;
              propertyDeclarationTypes.enabled = true;
              variableTypes.enabled = false;
            };
            preferences.importModuleSpecifier = "relative";
          };
        };
      };

      clangd = {
        enable = true;
        extraOptions = {
          capabilities.offsetEncoding = [ "utf-16" ];
          cmd = [
            "clangd"
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
            "--completion-style=detailed"
            "--function-arg-placeholders"
            "--fallback-style=llvm"
          ];
          root_markers = [
            "compile_commands.json"
            "compile_flags.txt"
            "Makefile"
            "configure.ac"
            "configure.in"
            "config.h.in"
            "meson.build"
            "meson_options.txt"
            "build.ninja"
            ".git"
          ];
          init_options = {
            usePlaceholders = true;
            completeUnimported = true;
            clangdFileStatus = true;
          };
        };
      };
    };
  };

  # clangd_extensions setup (wraps clangd LSP)
  extraConfigLua = ''
    require("clangd_extensions").setup({
      inlay_hints = { inline = false },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    })
  '';

  plugins.illuminate = {
    enable = true;
    settings = {
      providers = [ "lsp" "treesitter" "regex" ];
    };
  };

  plugins.trouble = {
    enable = true;
    settings = {
      modes = {
        diagnostics_buffer = {
          mode = "diagnostics";
          preview = {
            type = "float";
            relative = "editor";
            border = "rounded";
            title = "Preview";
            title_pos = "center";
            position = [ 0 (-2) ];
            size = { width = 0.4; height = 0.4; };
            zindex = 200;
          };
          filter.buf = 0;
        };
      };
    };
  };

  plugins.lazydev = {
    enable = true;
    settings = {
      library = [
        { path = "\${3rd}/luv/library"; words = [ "vim%.uv" ]; }
      ];
    };
  };

  plugins.rustaceanvim.enable = true;

  plugins.lspkind = {
    enable = true;
    settings = {
      preset = "default";
      mode = "symbol";
    };
  };

  # tiny-inline-diagnostic (buildVimPlugin)
  # Configured in blink.nix via extraPlugins

  keymaps = [
    { mode = "n"; key = "<space>cd"; action.__raw = "vim.diagnostic.open_float"; options.desc = "Open diagnostic float"; }
    {
      mode = "n";
      key = "[e";
      action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end";
      options.desc = "Jump to previous diagnostic error";
    }
    {
      mode = "n";
      key = "]e";
      action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR }) end";
      options.desc = "Jump to next diagnostic error";
    }
    { mode = "n"; key = "<leader>Li"; action = "<cmd>LspInfo<cr>"; options.desc = "LSP Info"; }
    { mode = "n"; key = "<leader>Ll"; action = "<cmd>LspLog<cr>"; options.desc = "LSP Logs"; }
    { mode = "n"; key = "<leader>r"; action = "<cmd>LspRestart<cr>"; options.desc = "LSP Restart"; }
    { mode = "n"; key = "<leader>ch"; action = "<cmd>LspClangdSwitchSourceHeader<cr>"; options.desc = "Switch Source/Header (C/C++)"; }

    # Trouble
    { mode = "n"; key = "<leader>xX"; action = "<cmd>Trouble diagnostics toggle<cr>"; options.desc = "Diagnostics (Trouble)"; }
    { mode = "n"; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"; options.desc = "Buffer Diagnostics (Trouble)"; }
    { mode = "n"; key = "<leader>cs"; action = "<cmd>Trouble symbols toggle focus=false<cr>"; options.desc = "Symbols (Trouble)"; }
    { mode = "n"; key = "<leader>cl"; action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>"; options.desc = "LSP Definitions/references (Trouble)"; }
    { mode = "n"; key = "<leader>xl"; action = "<cmd>Trouble loclist toggle<cr>"; options.desc = "Location List (Trouble)"; }
    { mode = "n"; key = "<leader>xq"; action = "<cmd>Trouble qflist toggle<cr>"; options.desc = "Quickfix List (Trouble)"; }
  ];

  autoCmd = [
    {
      event = "LspAttach";
      group = "UserLspConfig";
      callback.__raw = ''
        function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto declaration" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set({ "n", "v" }, "<space>cA", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source" }, diagnostics = {} },
            })
          end, vim.tbl_extend("force", opts, { desc = "Code action (buffer)" }))
        end
      '';
    }
  ];
}
