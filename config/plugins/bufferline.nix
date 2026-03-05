{ ... }:
{
  plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        mode = "buffers";
        always_show_bufferline = false;
        show_buffer_close_icons = false;
        show_close_icon = false;
        style_preset.__raw = "require('bufferline').style_preset.minimal";
        color_icons = true;
        separator_style = "slant";
        diagnostics = "nvim_lsp";
        get_element_icon.__raw = ''
          function(elem)
            local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(elem.filetype, { default = false })
            return icon, hl
          end
        '';
        diagnostics_indicator.__raw = ''
          function(_, _, diag)
            local s = {}
            for _, level in ipairs({ "error", "warning" }) do
              local n = diag[level] and diag[level] or 0
              if n > 0 then
                local icons = { error = " ", warning = " " }
                s[#s+1] = icons[level] .. n
              end
            end
            return table.concat(s, " ")
          end
        '';
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
        ];
      };
    };
  };

  keymaps = [
    { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<cr>"; options.desc = "Prev Buffer"; }
    { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<cr>"; options.desc = "Next Buffer"; }
    { mode = "n"; key = "[b"; action = "<cmd>BufferLineCyclePrev<cr>"; options.desc = "Prev Buffer"; }
    { mode = "n"; key = "]b"; action = "<cmd>BufferLineCycleNext<cr>"; options.desc = "Next Buffer"; }
    { mode = "n"; key = "<leader>bl"; action = "<cmd>BufferLineCloseRight<cr>"; options.desc = "Delete Buffers to the Right"; }
    { mode = "n"; key = "<leader>bh"; action = "<cmd>BufferLineCloseLeft<cr>"; options.desc = "Delete Buffers to the Left"; }
    { mode = "n"; key = "<leader>bo"; action = "<cmd>BufferLineCloseOthers<cr>"; options.desc = "Delete Other Buffers"; }
    { mode = "n"; key = "<leader>bp"; action = "<cmd>BufferLineTogglePin<cr>"; options.desc = "Toggle Pin"; }
    { mode = "n"; key = "<leader>bP"; action = "<cmd>BufferLineGroupClose ungrouped<cr>"; options.desc = "Delete Non-Pinned Buffers"; }
    { mode = "n"; key = "<S-Right>"; action = "<cmd>BufferLineMoveNext<cr>"; options.desc = "Move buffer right"; }
    { mode = "n"; key = "<S-Left>"; action = "<cmd>BufferLineMovePrev<cr>"; options.desc = "Move buffer left"; }
  ];
}
