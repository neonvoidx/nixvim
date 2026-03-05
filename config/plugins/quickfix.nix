{ pkgs, ... }:
{
  extraPlugins = [
    # quicker.nvim (not in nixvim/nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "quicker";
      src = pkgs.fetchFromGitHub {
        owner = "stevearc";
        repo = "quicker.nvim";
        rev = "2d3f3276eab9352c7b212821c218aca986929f62";
        hash = "sha256-bNsALR0ALVqkXZav/sgZnL6Me//wv1FHVP9USfqRauU=";
      };
    })
  ];

  extraConfigLua = ''
    require("quicker").setup({
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      action.__raw = ''function() require("quicker").toggle() end'';
      options.desc = "Toggle quickfix";
    }
  ];
}
