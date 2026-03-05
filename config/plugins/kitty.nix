{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.vim-kitty-navigator
    pkgs.vimPlugins.kitty-scrollback-nvim
    # vim-kitty: kitty config file syntax highlighting (not in nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-kitty";
      src = pkgs.fetchFromGitHub {
        owner = "fladson";
        repo = "vim-kitty";
        rev = "cd72f2d9cfee8d6aba5a180a5ac3ca265b5d3a46";
        hash = "sha256-R/qZ4g8CBqdkTQqaIGTiHFPVRFDtVGsF3EmzeVGTorE=";
      };
    })
  ];

  globals = {
    kitty_navigator_no_mappings = 1;
    tmux_navigator_no_mappings = 1;
  };

  extraConfigLua = ''
    -- Conditionally set up kitty navigator and scrollback only when in kitty terminal
    if os.getenv("TERM") == "xterm-kitty" then
      vim.keymap.set("n", "<c-h>", "<cmd>KittyNavigateLeft<cr>", { silent = true, desc = "Navigate Left (Kitty)" })
      vim.keymap.set("n", "<c-l>", "<cmd>KittyNavigateRight<cr>", { silent = true, desc = "Navigate Right (Kitty)" })
      vim.keymap.set("n", "<c-j>", "<cmd>KittyNavigateDown<cr>", { silent = true, desc = "Navigate Down (Kitty)" })
      vim.keymap.set("n", "<c-k>", "<cmd>KittyNavigateUp<cr>", { silent = true, desc = "Navigate Up (Kitty)" })

      require("kitty-scrollback").setup()
    end
  '';
}
