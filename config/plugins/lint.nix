{ ... }:
{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      "javascript.jsx" = [ "eslint_d" ];
      "typescript.sx" = [ "eslint_d" ];
      cmake = [ "cmakelint" ];
    };
  };

  extraConfigLua = ''
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
  '';

  autoGroups.lint_group.clear = true;
  autoCmd = [
    {
      event = [ "BufEnter" "BufWritePost" "InsertLeave" ];
      group = "lint_group";
      callback.__raw = ''
        function()
          require("lint").try_lint()
        end
      '';
    }
  ];
}
