{ pkgs, ... }:
{
  # hmts.nvim: Heredoc Matching Tree-sitter (not in nixvim/nixpkgs)
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "hmts";
      src = pkgs.fetchFromGitHub {
        owner = "calops";
        repo = "hmts.nvim";
        rev = "a32cd413f7d0a69d7f3d279c631f20cb117c8d30";
        hash = "sha256-j/RFJgCbaH+V2K20RrQbsz0bzpN8Z6YAKzZMABYg/OU=";
      };
    })
  ];
}
