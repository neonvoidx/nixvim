{ ... }:
{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      delay = 0;
      expand = 1;
      spec = [
        { __unkeyed-1 = "<leader>b"; group = "buffer"; }
        { __unkeyed-1 = "<leader>c"; group = "code"; }
        { __unkeyed-1 = "<leader>f"; group = "file/find"; }
        { __unkeyed-1 = "<leader>g"; group = "git"; }
        { __unkeyed-1 = "<leader>gh"; group = "hunks"; }
        { __unkeyed-1 = "<leader>L"; group = "lsp"; }
        { __unkeyed-1 = "<leader>n"; group = "notifications"; }
        { __unkeyed-1 = "<leader>o"; group = "overseer"; }
        { __unkeyed-1 = "<leader>q"; group = "quit/session"; }
        { __unkeyed-1 = "<leader>s"; group = "search"; }
        { __unkeyed-1 = "<leader>t"; group = "test"; }
        { __unkeyed-1 = "<leader>u"; group = "ui"; }
        { __unkeyed-1 = "<leader>x"; group = "diagnostics/quickfix"; icon = { icon = "󱖫 "; color = "green"; }; }
        { __unkeyed-1 = "<leader>."; group = "scratch"; }
        { __unkeyed-1 = "["; group = "prev"; }
        { __unkeyed-1 = "]"; group = "next"; }
        { __unkeyed-1 = "g"; group = "goto"; }
        { __unkeyed-1 = "gz"; group = "surround"; }
        { __unkeyed-1 = "z"; group = "fold"; }
      ];
    };
  };
}
