{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.nvim-ts-context-commentstring
  ];

  plugins.treesitter = {
    enable = true;
    settings = {
      sync_install = false;
      auto_install = true;
      ignore_install = [ ];
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
        disable.__raw = ''
          function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end
        '';
      };
      endwise.enable = true;
      ensure_installed = [
        "css"
        "latex"
        "scss"
        "svelte"
        "typst"
        "vue"
        "bash"
        "c"
        "cpp"
        "cmake"
        "diff"
        "html"
        "javascript"
        "jsdoc"
        "json"
        "jsonc"
        "lua"
        "luadoc"
        "luap"
        "markdown"
        "markdown_inline"
        "printf"
        "python"
        "query"
        "regex"
        "toml"
        "tsx"
        "typescript"
        "vim"
        "vimdoc"
        "xml"
        "yaml"
      ];
    };
  };

  plugins.treesitter-context = {
    enable = true;
    settings = {
      enable = true;
      multiwindow = true;
      max_lines = 0;
      separator = "▔";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "[c";
      action.__raw = "function() require('treesitter-context').go_to_context(vim.v.count1) end";
      options.desc = "Go to Treesitter context";
    }
  ];
}
