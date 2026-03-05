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
        { __unkeyed-1 = "<leader>c"; group = "+code"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>f"; group = "+find"; icon = { icon = "󰍉 "; }; }
        { __unkeyed-1 = "<leader>g"; group = "+git"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>gh"; group = "hunks"; }
        { __unkeyed-1 = "<leader>L"; group = "+LSP"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>n"; group = "+notifications"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>o"; group = "+Overseer"; icon = { icon = ""; }; }
        { __unkeyed-1 = "<leader>a"; group = "+ai"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>p"; group = "+Yanky"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>S"; group = "+snippets"; icon = { icon = "✀"; }; }
        { __unkeyed-1 = "<leader>q"; group = "quit/session"; }
        { __unkeyed-1 = "<leader>s"; group = "+snacks"; icon = { icon = "󰆘 "; }; }
        { __unkeyed-1 = "<leader>t"; group = "test"; }
        { __unkeyed-1 = "<leader>u"; group = "+ui"; icon = { icon = "󰍹 "; }; }
        { __unkeyed-1 = "<leader>w"; group = "+window"; icon = { icon = " "; }; }
        { __unkeyed-1 = "<leader>x"; group = "diagnostics/quickfix"; icon = { icon = "󱖫 "; color = "green"; }; }
        { __unkeyed-1 = "<leader>."; group = "+scratch"; icon = { icon = ""; }; }
        { __unkeyed-1 = "["; group = "prev"; }
        { __unkeyed-1 = "]"; group = "next"; }
        { __unkeyed-1 = "g"; group = "goto"; }
        { __unkeyed-1 = "gz"; group = "surround"; }
        { __unkeyed-1 = "z"; group = "fold"; }
      ];
    };
  };
}
