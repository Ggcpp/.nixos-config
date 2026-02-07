{
  flake.modules.homeManager.zsh =
    { config, pkgs, ... }:
    {
      programs.zsh = {
        enable = true;
        dotDir = config.home.homeDirectory + "/.config/zsh";
        enableCompletion = true;

        shellAliases = {
          vim = "nvim";
          v = "nvim";
        };

        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };

        history = {
          saveNoDups = true;
          save = 10000;
          size = 10000;
          share = true;
        };

        initContent = ''
          bindkey '^H' backward-kill-word
        '';
      };
    };
}
