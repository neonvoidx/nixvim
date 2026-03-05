{ ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins
  ];

  # Allow unfree packages (copilot-language-server, etc.)
  nixpkgs.config.allowUnfree = true;
}
