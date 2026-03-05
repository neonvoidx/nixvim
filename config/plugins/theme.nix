{ pkgs, ... }:
{
  # Primary theme: eldritch.nvim (not in nixvim or nixpkgs, built from GitHub)
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "eldritch";
      src = pkgs.fetchFromGitHub {
        owner = "eldritch-theme";
        repo = "eldritch.nvim";
        rev = "0415fa72c348e814a7a6cc9405593a4f812fe12f";
        hash = "sha256-nEt25TqsYePRCYkCI9zEk/awFBQ9ENyYWR0hSyy24GY=";
      };
    })
    # Alternative colorscheme plugins (installed but not active by default)
    pkgs.vimPlugins.catppuccin-nvim
    pkgs.vimPlugins.tokyonight-nvim
    pkgs.vimPlugins.dracula-nvim
    pkgs.vimPlugins.nightfox-nvim
    pkgs.vimPlugins.onedark-nvim
  ];

  extraConfigLua = ''
    require("eldritch").setup({ transparent = true })
    vim.cmd.colorscheme("eldritch")
  '';
}
