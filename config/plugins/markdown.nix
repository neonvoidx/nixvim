{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.helpview-nvim
    # presenting.nvim (not in nixvim/nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "presenting";
      src = pkgs.fetchFromGitHub {
        owner = "sotte";
        repo = "presenting.nvim";
        rev = "e78245995a09233e243bf48169b2f00dc76341f7";
        hash = "sha256-Q/SNFkMSREVEeDiikdMXQCVxrt3iThQUh08YMcN9qSk=";
      };
    })
    # markdown-toc.nvim (not in nixvim/nixpkgs)
    (pkgs.vimUtils.buildVimPlugin {
      name = "markdown-toc";
      src = pkgs.fetchFromGitHub {
        owner = "hedyhli";
        repo = "markdown-toc.nvim";
        rev = "869af35bce0c27e2006f410fa3f706808db4843d";
        hash = "sha256-HfjE9xfahy1U+G4aSopRBt6Qz3FXxss41oJJcuvFh70=";
      };
    })
    pkgs.vimPlugins.obsidian-nvim
  ];

  plugins.markdown-preview = {
    enable = true;
    settings.filetypes = [ "markdown" ];
  };

  plugins.render-markdown = {
    enable = true;
    settings = {
      file_types = [ "markdown" "codecompanion" ];
      anti_conceal = {
        enabled = true;
        ignore = {
          code_background = true;
          sign = true;
        };
      };
      completions.blink.enabled = true;
      preset = "obsidian";
      bullet.right_pad = 1;
      checkbox = {
        enabled = true;
        unchecked.icon = "▢ ";
        checked.icon = "✓ ";
        custom.todo.rendered = "◯ ";
        right_pad = 1;
      };
    };
  };

  extraConfigLua = ''
    -- obsidian.nvim (conditional on vault existence)
    local vault_path = vim.fn.expand("~/vault")
    if vim.fn.isdirectory(vault_path) == 1 then
      require("obsidian").setup({
        workspaces = { { name = "vault", path = vault_path } },
        legacy_commands = false,
        ui = { enable = false },
        checkbox = { order = { " ", "x", "!", ">", "~" } },
        daily_notes = {
          folder = "Daily Notes",
          date_format = "%d %b %Y",
          template = vault_path .. "/templates/daily-note.md",
        },
        completion = { nvim_cmp = false, blink = true },
        preferred_link_style = "markdown",
        disable_frontmatter = false,
        templates = { folder = "templates", date_format = "%d %b %Y" },
        follow_url_func = function(url) vim.ui.open(url) end,
        picker = { name = "snacks.pick", new = "<C-x>", insert_link = "<C-l>" },
        tag_mappings = { tag_note = "<C-x>", insert_tag = "<C-l>" },
        attachments = {
          image_text_func = function(path)
            local name = vim.fs.basename(tostring(path))
            local encoded_name = require("obsidian.util").urlencode(name)
            return string.format("![%s](%s)", name, encoded_name)
          end,
          img_folder = "./",
        },
      })
    end

    -- presenting.nvim
    require("presenting").setup({
      options = { width = 100 },
      separator = { markdown = "^---" },
      keep_separator = false,
      parse_frontmatter = true,
      keymaps = {
        ["n"] = function() Presenting.next() end,
        ["p"] = function() Presenting.prev() end,
        ["q"] = function() Presenting.quit() end,
        ["f"] = function() Presenting.first() end,
        ["l"] = function() Presenting.last() end,
        ["<CR>"] = function() Presenting.next() end,
        ["<BS>"] = function() Presenting.prev() end,
      },
    })

    -- markdown-toc
    require("mtoc").setup({
      heading = { before_toc = false },
      auto_update = true,
    })
  '';

  keymaps = [
    { mode = "n"; key = "<leader>cp"; action = "<cmd>MarkdownPreview<cr>"; options.desc = "Markdown preview"; }
    # Obsidian
    { mode = "n"; key = "<leader>oo"; action = "<cmd>Obsidian open<CR>"; options.desc = "Open on App"; }
    { mode = "n"; key = "<leader>sO"; action = "<cmd>Obsidian search<CR>"; options.desc = "Obsidian Grep"; }
    { mode = "n"; key = "<leader>on"; action = "<cmd>Obsidian new<CR>"; options.desc = "New Note"; }
    { mode = "n"; key = "<leader>o<space>"; action = "<cmd>Obsidian quickswitch<CR>"; options.desc = "Find Files"; }
    { mode = "n"; key = "<leader>ob"; action = "<cmd>Obsidian backlinks<CR>"; options.desc = "Backlinks"; }
    { mode = "n"; key = "<leader>ot"; action = "<cmd>Obsidian tags<CR>"; options.desc = "Tags"; }
    { mode = "n"; key = "<leader>oT"; action = "<cmd>Obsidian template<CR>"; options.desc = "Template"; }
    { mode = "v"; key = "<leader>ol"; action = "<cmd>Obsidian link<CR>"; options.desc = "Link"; }
    { mode = "n"; key = "<leader>oL"; action = "<cmd>Obsidian links<CR>"; options.desc = "Links"; }
    { mode = "v"; key = "<leader>oN"; action = "<cmd>Obsidian linknew<CR>"; options.desc = "New Link"; }
    { mode = "v"; key = "<leader>oe"; action = "<cmd>Obsidian extractnote<CR>"; options.desc = "Extract Note"; }
    { mode = "n"; key = "<leader>ow"; action = "<cmd>Obsidian workspace<CR>"; options.desc = "Workspace"; }
    { mode = "n"; key = "<leader>or"; action = "<cmd>Obsidian rename<CR>"; options.desc = "Rename"; }
    { mode = "n"; key = "<leader>oi"; action = "<cmd>Obsidian paste_img<CR>"; options.desc = "Paste Image"; }
    { mode = "n"; key = "<leader>od"; action = "<cmd>Obsidian dailies<CR>"; options.desc = "Daily Notes"; }
  ];
}
