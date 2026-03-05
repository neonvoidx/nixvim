{ pkgs, ... }:
{
  imports = [
    ./theme.nix
    ./treesitter.nix
    ./lsp.nix
    ./blink.nix
    ./snacks.nix
    ./whichkey.nix
    ./bufferline.nix
    ./lualine.nix
    ./noice.nix
    ./ai.nix
    ./editing.nix
    ./format.nix
    ./lint.nix
    ./git.nix
    ./diff.nix
    ./comments.nix
    ./folds.nix
    ./markdown.nix
    ./kitty.nix
    ./session.nix
    ./overseer.nix
    ./quickfix.nix
    ./snippets.nix
    ./highlight.nix
    ./nix.nix
  ];

  # Formatters, linters, and other external tools
  extraPackages = with pkgs; [
    # Formatters
    stylua
    black
    isort
    prettierd
    eslint_d
    markdownlint-cli2
    nixfmt
    # Linters
    pylint
    checkmake
    yamllint
    # LSP servers (nixvim may auto-add these, but being explicit ensures they're available)
    bash-language-server
    gopls
    lua-language-server
    basedpyright
    yaml-language-server
    dockerfile-language-server
    vtsls
    terraform-ls
    clang-tools
    zls
    emmet-language-server
    typos-lsp
    # Misc tools
    mermaid-cli
    ripgrep
  ];
}
