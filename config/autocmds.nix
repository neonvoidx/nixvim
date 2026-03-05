{ ... }:
{
  autoGroups = {
    autocmd_checktime.clear = true;
    autocmd_resize_splits.clear = true;
    autocmd_last_loc.clear = true;
    autocmd_close_with_q.clear = true;
    wrap.clear = true;
    spell.clear = true;
    autocmd_auto_create_dir.clear = true;
    NumberToggle.clear = true;
    highlight-yank.clear = true;
    RestoreCursor.clear = true;
    UserLspConfig.clear = true;
    lint.clear = true;
  };

  autoCmd = [
    # Check if file changed
    {
      event = [ "FocusGained" "TermClose" "TermLeave" ];
      group = "autocmd_checktime";
      command = "checktime";
    }

    # Resize splits
    {
      event = [ "VimResized" ];
      group = "autocmd_resize_splits";
      callback.__raw = ''
        function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end
      '';
    }

    # Go to last location
    {
      event = "BufReadPost";
      group = "autocmd_last_loc";
      callback.__raw = ''
        function(event)
          local exclude = { "gitcommit" }
          local buf = event.buf
          if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].autocmd_last_loc then
            return
          end
          vim.b[buf].autocmd_last_loc = true
          local mark = vim.api.nvim_buf_get_mark(buf, '"')
          local lcount = vim.api.nvim_buf_line_count(buf)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      '';
    }

    # Close filetypes with <q>
    {
      event = "FileType";
      group = "autocmd_close_with_q";
      pattern = [
        "PlenaryTestPopup"
        "help"
        "lspinfo"
        "man"
        "notify"
        "qf"
        "query"
        "spectre_panel"
        "startuptime"
        "tsplayground"
        "neotest-output"
        "checkhealth"
        "neotest-summary"
        "neotest-output-panel"
        "lazy"
      ];
      callback.__raw = ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end
      '';
    }

    # Wrap in text filetypes
    {
      event = "FileType";
      group = "wrap";
      pattern = [ "gitcommit" "markdown" "snacks_notif_history" "trouble" ];
      callback.__raw = ''
        function()
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
        end
      '';
    }

    # Spell in text filetypes
    {
      event = "FileType";
      group = "spell";
      pattern = [ "gitcommit" "markdown" ];
      callback.__raw = ''
        function()
          vim.opt_local.spell = true
        end
      '';
    }

    # Auto create dir on save
    {
      event = [ "BufWritePre" ];
      group = "autocmd_auto_create_dir";
      callback.__raw = ''
        function(event)
          if event.match:match("^%w%w+://") then
            return
          end
          local file = vim.loop.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
      '';
    }

    # Relative number: off in insert
    {
      event = [ "InsertEnter" ];
      group = "NumberToggle";
      pattern = "*";
      callback.__raw = ''
        function()
          local ignore = { oil = true, fzf = true }
          if ignore[vim.bo.filetype] then return end
          vim.wo.relativenumber = false
        end
      '';
    }

    # Relative number: on in normal
    {
      event = [ "InsertLeave" ];
      group = "NumberToggle";
      pattern = "*";
      callback.__raw = ''
        function()
          local ignore = { oil = true, fzf = true }
          if ignore[vim.bo.filetype] then return end
          vim.wo.relativenumber = true
        end
      '';
    }

    # Disable minipairs for gitcommit/markdown and disable ai cmp
    {
      event = "FileType";
      pattern = [ "gitcommit" "markdown" ];
      callback.__raw = ''
        function(event)
          vim.keymap.set("i", "`", "`", { buffer = event.buf })
          vim.b.ai_cmp = false
        end
      '';
    }

    # Copilot buffer options
    {
      event = "BufEnter";
      pattern = "copilot-*";
      callback.__raw = ''
        function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
          vim.opt_local.conceallevel = 0
        end
      '';
    }

    # Highlight on yank
    {
      event = "TextYankPost";
      group = "highlight-yank";
      desc = "Highlight when yanking (copying) text";
      callback.__raw = ''
        function()
          vim.hl.on_yank()
        end
      '';
    }

    # Restore cursor position
    {
      event = "BufReadPre";
      group = "RestoreCursor";
      callback.__raw = ''
        function(args)
          vim.api.nvim_create_autocmd("FileType", {
            buffer = args.buf,
            once = true,
            callback = function()
              local ft = vim.bo[args.buf].filetype
              local last_pos = vim.api.nvim_buf_get_mark(args.buf, '"')[1]
              local last_line = vim.api.nvim_buf_line_count(args.buf)
              if
                last_pos >= 1
                and last_pos <= last_line
                and not ft:match("commit")
                and not vim.tbl_contains({ "gitrebase", "nofile", "svn", "gitcommit" }, ft)
              then
                vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
              end
            end,
          })
        end
      '';
    }
  ];

  # MasonUpgrade user command (kept for compat even though Mason isn't used)
  extraConfigLua = ''
    vim.api.nvim_create_user_command("MasonUpgrade", function()
      vim.notify("Mason is not used in NixVim. Use nix to manage LSP servers.", vim.log.levels.INFO)
    end, { force = true })
  '';
}
