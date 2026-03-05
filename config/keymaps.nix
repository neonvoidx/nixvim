{ ... }:
{
  keymaps = [
    # better up/down (converted from Vimscript to Lua functions)
    { mode = [ "n" "x" ]; key = "j"; action.__raw = "function() return vim.v.count == 0 and 'gj' or 'j' end"; options = { expr = true; silent = true; }; }
    { mode = [ "n" "x" ]; key = "<Down>"; action.__raw = "function() return vim.v.count == 0 and 'gj' or 'j' end"; options = { expr = true; silent = true; }; }
    { mode = [ "n" "x" ]; key = "k"; action.__raw = "function() return vim.v.count == 0 and 'gk' or 'k' end"; options = { expr = true; silent = true; }; }
    { mode = [ "n" "x" ]; key = "<Up>"; action.__raw = "function() return vim.v.count == 0 and 'gk' or 'k' end"; options = { expr = true; silent = true; }; }

    # Resize window
    { mode = "n"; key = "<C-Up>"; action = "<cmd>resize +2<cr>"; options.desc = "Increase window height"; }
    { mode = "n"; key = "<C-Down>"; action = "<cmd>resize -2<cr>"; options.desc = "Decrease window height"; }
    { mode = "n"; key = "<C-Left>"; action = "<cmd>vertical resize -2<cr>"; options.desc = "Decrease window width"; }
    { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<cr>"; options.desc = "Increase window width"; }

    # Move Lines
    { mode = "n"; key = "<A-j>"; action = "<cmd>m .+1<cr>=="; options.desc = "Move down"; }
    { mode = "n"; key = "<A-k>"; action = "<cmd>m .-2<cr>=="; options.desc = "Move up"; }
    { mode = "i"; key = "<A-j>"; action = "<esc><cmd>m .+1<cr>==gi"; options.desc = "Move down"; }
    { mode = "i"; key = "<A-k>"; action = "<esc><cmd>m .-2<cr>==gi"; options.desc = "Move up"; }
    { mode = "v"; key = "<A-j>"; action = ":m '>+1<cr>gv=gv"; options.desc = "Move down"; }
    { mode = "v"; key = "<A-k>"; action = ":m '<-2<cr>gv=gv"; options.desc = "Move up"; }

    # Clear search with <esc>
    { mode = [ "i" "n" ]; key = "<esc>"; action = "<cmd>noh<cr><esc>"; options.desc = "Escape and clear hlsearch"; }

    # Redraw / clear hlsearch / diff update
    { mode = "n"; key = "<leader>ur"; action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"; options.desc = "Redraw / clear hlsearch / diff update"; }

    # Saner n/N behavior (converted from Vimscript to Lua functions)
    { mode = "n"; key = "n"; action.__raw = "function() return vim.v.searchforward == 1 and 'nzv' or 'Nzv' end"; options = { expr = true; desc = "Next search result"; }; }
    { mode = "x"; key = "n"; action.__raw = "function() return vim.v.searchforward == 1 and 'n' or 'N' end"; options = { expr = true; desc = "Next search result"; }; }
    { mode = "o"; key = "n"; action.__raw = "function() return vim.v.searchforward == 1 and 'n' or 'N' end"; options = { expr = true; desc = "Next search result"; }; }
    { mode = "n"; key = "N"; action.__raw = "function() return vim.v.searchforward == 1 and 'Nzv' or 'nzv' end"; options = { expr = true; desc = "Prev search result"; }; }
    { mode = "x"; key = "N"; action.__raw = "function() return vim.v.searchforward == 1 and 'N' or 'n' end"; options = { expr = true; desc = "Prev search result"; }; }
    { mode = "o"; key = "N"; action.__raw = "function() return vim.v.searchforward == 1 and 'N' or 'n' end"; options = { expr = true; desc = "Prev search result"; }; }

    # Undo break-points
    { mode = "i"; key = ","; action = ",<c-g>u"; }
    { mode = "i"; key = "."; action = ".<c-g>u"; }
    { mode = "i"; key = ";"; action = ";<c-g>u"; }

    # Save file
    { mode = [ "i" "x" "n" "s" ]; key = "<C-s>"; action = "<cmd>w!<cr><esc>"; options.desc = "Save file"; }
    # Save all and quit
    { mode = [ "i" "n" ]; key = "<C-q>"; action = "<cmd>silent! xa<cr>"; options.desc = "Save all and quit"; }

    # Better indenting
    { mode = "v"; key = "<"; action = "<gv"; }
    { mode = "v"; key = ">"; action = ">gv"; }

    # Windows
    { mode = "n"; key = "<leader>wd"; action = "<cmd>q<cr>"; options = { desc = "Delete window"; remap = true; }; }
    { mode = "n"; key = "<leader>w|"; action = "<cmd>vsplit<cr>"; options = { desc = "Split window right"; remap = true; }; }
    { mode = "n"; key = "<leader>w-"; action = "<cmd>split<cr>"; options = { desc = "Split window below"; remap = true; }; }

    # jj/kk to escape
    { mode = "i"; key = "jj"; action = "<Esc>"; }
    { mode = "i"; key = "kk"; action = "<Esc>"; }

    # Insert → Esc
    { mode = [ "i" "n" "v" "x" "o" "t" "s" "c" "l" ]; key = "<Insert>"; action = "<Esc>"; }

    # Unbind F1 help
    { mode = [ "i" "n" "v" "x" "o" "t" "s" "c" "l" ]; key = "<F1>"; action = "<Nop>"; }
    # Unbind ctrl left click
    { mode = [ "i" "n" "v" "x" "o" "t" "s" "c" "l" ]; key = "<C-LeftMouse>"; action = "<Nop>"; }
    # Unbind tags
    { mode = "n"; key = "<C-t>"; action = "<Nop>"; }

    # Blackhole delete/change
    { mode = [ "n" "v" ]; key = "D"; action = "\"_d"; }
    { mode = [ "n" "v" ]; key = "C"; action = "\"_c"; }

    # Backspace → first non-blank
    { mode = "n"; key = "<Backspace>"; action = "^"; options.desc = "Move to first non-blank character"; }

    # Paste without losing text
    { mode = "v"; key = "p"; action = "\"_dP"; }
  ];

  # Complex keymaps needing Lua (visual replace, diff to clipboard, kitty nav)
  extraConfigLua = ''
    -- Visual search/replace
    table.unpack = table.unpack or unpack
    local function get_visual()
      local _, ls, cs = table.unpack(vim.fn.getpos("v"))
      local _, le, ce = table.unpack(vim.fn.getpos("."))
      return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
    end
    vim.keymap.set("v", "<C-r>", function()
      local pattern = table.concat(get_visual())
      pattern = vim.fn.substitute(vim.fn.escape(pattern, "^$.*\\/~[]"), "\n", "\\n", "g")
      vim.api.nvim_input("<Esc>:%s/" .. pattern .. "//g<Left><Left>")
    end)

    -- Diff vs clipboard
    local function compareToClip()
      local ftype = vim.api.nvim_eval("&filetype")
      vim.cmd("vsplit")
      vim.cmd("enew")
      vim.cmd("normal! P")
      vim.cmd("setlocal buftype=nowrite")
      vim.cmd("set filetype=" .. ftype)
      vim.cmd("diffthis")
      vim.cmd([[execute "normal! \<C-w>h"]])
      vim.cmd("diffthis")
    end
    vim.keymap.set("n", "<leader>D", compareToClip, { desc = "Diff vs clipboard" })
  '';
}
