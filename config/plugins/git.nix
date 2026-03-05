{ pkgs, ... }:
{
  extraPlugins = [
    # git-scripts.nvim (not in nixvim/nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "git-scripts";
      src = pkgs.fetchFromGitHub {
        owner = "declancm";
        repo = "git-scripts.nvim";
        rev = "e02c502118d9d24c733c22ec361a44cd873dfa29";
        hash = "sha256-Z/Z4WVLd0uFGgAvtSwpiY54gyfBCbW3kvGs3o7QksWo=";
      };
    })
    # resolved.nvim (not in nixvim/nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "resolved";
      src = pkgs.fetchFromGitHub {
        owner = "noamsto";
        repo = "resolved.nvim";
        rev = "15fd72dc643b60b01c8763e56edc316ff3d5e26e";
        hash = "sha256-9wBsqHvZZMsWGiM90R9WoZ0WF4pBdC1w3FIr++zdd2A=";
      };
    })
  ];

  plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add.text = "▎";
        change.text = "▎";
        delete.text = "";
        topdelete.text = "";
        changedelete.text = "▎";
        untracked.text = "▎";
      };
      signs_staged = {
        add.text = "▎";
        change.text = "▎";
        delete.text = "";
        topdelete.text = "";
        changedelete.text = "▎";
      };
      on_attach.__raw = ''
        function(buffer)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end
          map("n", "]h", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end end, "Next Hunk")
          map("n", "[h", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end end, "Prev Hunk")
          map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<cr>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<cr>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end
      '';
    };
  };

  plugins.gitblame = {
    enable = true;
    settings = {
      enabled = true;
      messageTemplate = "<author> • <date> <<sha>>";
      dateFormat = "%r";
    };
  };

  extraConfigLua = ''
    -- git-scripts: auto-commit vault markdown files (deferred to avoid startup warnings)
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = vim.fn.expand("~") .. "/vault/*.md",
      once = true,
      callback = function()
        local gitscripts = require("git-scripts")
        gitscripts.setup({ default_keymaps = false, commit_on_save = true })
        gitscripts.async_pull()
      end,
      desc = "Setup git-scripts for vault",
    })

    -- resolved.nvim
    require("resolved").setup({})
  '';
}
