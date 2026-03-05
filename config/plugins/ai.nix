{ pkgs, ... }:
{
  extraPlugins = [
    # copilot-lsp (not in nixvim/nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "copilot-lsp";
      src = pkgs.fetchFromGitHub {
        owner = "copilotlsp-nvim";
        repo = "copilot-lsp";
        rev = "1b6d8273594643f51bb4c0c1d819bdb21b42159d";
        hash = "sha256-wb6WpIMUggHjUKEI++pRgg53vyiuwEZQmYWEN7sev3M=";
      };
    })
  ];

  plugins.copilot-lua = {
    enable = true;
    settings = {
      filetypes = {
        markdown = false;
        help = false;
        sh.__raw = ''
          function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
              return false
            end
            return true
          end
        '';
      };
      nes.enabled = false;
    };
  };

  plugins.sidekick = {
    enable = true;
    settings = {
      nes.enabled = false;
      mux.enabled = false;
      cli.tools = { };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<tab>";
      action.__raw = ''
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end
      '';
      options = { expr = true; desc = "Goto/Apply Next Edit Suggestion"; };
    }
    { mode = "n"; key = "<leader>aa"; action.__raw = ''function() require("sidekick.cli").toggle({ name = "copilot" }) end''; options.desc = "Sidekick Toggle Copilot"; }
    { mode = "n"; key = "<leader>aA"; action.__raw = ''function() require("sidekick.cli").toggle({ name = "aider" }) end''; options.desc = "Sidekick Toggle Aider"; }
    { mode = "n"; key = "<leader>as"; action.__raw = ''function() require("sidekick.cli").select({ filter = { installed = true } }) end''; options.desc = "Select CLI"; }
    { mode = [ "x" "n" ]; key = "<leader>at"; action.__raw = ''function() require("sidekick.cli").send({ msg = "{this}" }) end''; options.desc = "Send This"; }
    { mode = "x"; key = "<leader>av"; action.__raw = ''function() require("sidekick.cli").send({ msg = "{selection}" }) end''; options.desc = "Send Visual Selection"; }
    { mode = [ "n" "x" ]; key = "<leader>ap"; action.__raw = ''function() require("sidekick.cli").prompt() end''; options.desc = "Sidekick Select Prompt"; }
    { mode = [ "n" "x" "i" "t" ]; key = "<c-.>"; action.__raw = ''function() require("sidekick.cli").focus() end''; options.desc = "Sidekick Switch Focus"; }
  ];
}
