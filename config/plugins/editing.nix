{ pkgs, ... }:
{
  extraPlugins = [
    # nvim-scissors (not in nixvim/nixpkgs, disable check for optional pickers)
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-scissors";
      src = pkgs.fetchFromGitHub {
        owner = "chrisgrieser";
        repo = "nvim-scissors";
        rev = "59902c749117640bd5d434642b2df67fb038d4f2";
        hash = "sha256-SWrqTsl1PebLUPT+9PNnMNBwiFTGx2GUKR6IBtNVPFo=";
      };
      nvimRequireCheck = [ "scissors" "scissors.utils" "scissors.config" ];
    })
    pkgs.vimPlugins.numb-nvim
  ];

  plugins.mini = {
    enable = true;
    modules = {
      pairs = {
        modes = { insert = true; command = false; terminal = false; };
        markdown = false;
        mappings = { };
      };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
    };
  };

  plugins.flash = {
    enable = true;
    settings = {
      auto_jump = true;
      multi_window = false;
    };
  };

  plugins.yanky = {
    enable = true;
    settings = {
      highlight.timer = 200;
    };
  };

  plugins.inc-rename.enable = true;

  plugins.guess-indent.enable = true;

  plugins.yazi = {
    enable = true;
    settings = {
      open_for_directories = true;
      pick_window_implementation = "snacks.picker";
      integrations.grep_in_directory = "snacks.picker";
      keymaps.show_help = "<f1>";
    };
  };

  extraConfigLua = ''
    vim.g.loaded_netrwPlugin = 1
    require("numb").setup()
    require("scissors").setup({
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
    })
  '';

  keymaps = [
    # Flash
    { mode = [ "n" "x" "o" ]; key = "s"; action.__raw = "function() require('flash').jump() end"; options.desc = "Flash"; }
    { mode = [ "n" "x" "o" ]; key = "S"; action.__raw = "function() require('flash').treesitter() end"; options.desc = "Flash Treesitter"; }
    { mode = "o"; key = "r"; action.__raw = "function() require('flash').remote() end"; options.desc = "Remote Flash"; }
    { mode = [ "o" "x" ]; key = "R"; action.__raw = "function() require('flash').treesitter_search() end"; options.desc = "Treesitter Search"; }
    { mode = "c"; key = "<c-s>"; action.__raw = "function() require('flash').toggle() end"; options.desc = "Toggle Flash Search"; }
    # Yanky
    { mode = [ "n" "x" ]; key = "y"; action = "<Plug>(YankyYank)"; }
    { mode = [ "n" "x" ]; key = "p"; action = "<Plug>(YankyPutAfter)"; }
    { mode = [ "n" "x" ]; key = "P"; action = "<Plug>(YankyPutBefore)"; }
    { mode = "n"; key = "<c-p>"; action = "<Plug>(YankyCycleForward)"; }
    { mode = "n"; key = "<c-n>"; action = "<Plug>(YankyCycleBackward)"; }
    { mode = "n"; key = "<leader>pp"; action = "<cmd>YankyRingHistory<cr>"; options.desc = "Yank history"; }
    # Inc-rename
    { mode = "n"; key = "<leader>cr"; action = ":IncRename "; options.desc = "Rename symbol"; }
    # Scissors (snippets)
    { mode = "v"; key = "<leader>Sa"; action.__raw = ''function() require("scissors").addNewSnippet() end''; options.desc = "✀  Add Snippet"; }
    { mode = "n"; key = "<leader>Se"; action.__raw = ''function() require("scissors").editSnippet() end''; options.desc = "✀  Edit Snippet"; }
    # Yazi
    { mode = [ "n" "v" ]; key = "<leader>e"; action = "<cmd>Yazi<cr>"; options.desc = "Yazi (current location)"; }
    { mode = "n"; key = "<leader>E"; action = "<cmd>Yazi cwd<cr>"; options.desc = "Yazi (cwd)"; }
  ];
}
