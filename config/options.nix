{ ... }:
{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
    skip_ts_context_commentstring_module = true;
    markdown_recommended_style = 0;
    qf_is_open = false;
  };

  opts = {
    autowrite = true;
    autoread = true;
    clipboard = "unnamedplus";
    completeopt = "menu,menuone,noselect";
    conceallevel = 1;
    confirm = true;
    cursorline = true;
    expandtab = true;
    formatoptions = "jcroqlnt";
    grepformat = "%f:%l:%c:%m";
    grepprg = "rg --vimgrep";
    ignorecase = true;
    inccommand = "nosplit";
    laststatus = 3;
    list = true;
    mouse = "nv";
    mousemoveevent = true;
    number = true;
    pumblend = 10;
    pumheight = 10;
    relativenumber = true;
    scrolloff = 4;
    sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds";
    shiftround = true;
    shiftwidth = 2;
    showmode = false;
    sidescrolloff = 8;
    signcolumn = "yes";
    smartcase = true;
    smartindent = true;
    spelllang = "en";
    splitbelow = true;
    splitkeep = "screen";
    splitright = true;
    tabstop = 2;
    termguicolors = true;
    timeoutlen = 300;
    undofile = true;
    undolevels = 10000;
    updatetime = 200;
    virtualedit = "block";
    wildmode = "longest:full,full";
    winminwidth = 5;
    wrap = false;
    autochdir = false;
    smoothscroll = true;
    foldcolumn = "1";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
    winborder = "rounded";
  };

  # fillchars and diagnostic configuration
  extraConfigLua = ''
    vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

    vim.opt.fillchars:append({
      foldopen = "\u{f07c}",   -- 
      foldclose = "\u{f0f3}",  -- 
      fold = " ",
      foldsep = " ",
      diff = "\u{2571}",       -- ╱
      eob = " ",
    })

    vim.diagnostic.config({
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "󰋼",
          [vim.diagnostic.severity.HINT] = "󰌵",
        },
      },
      float = {
        border = "rounded",
        format = function(d)
          return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
        end,
      },
      underline = true,
      jump = {
        float = true,
      },
    })
  '';
}
