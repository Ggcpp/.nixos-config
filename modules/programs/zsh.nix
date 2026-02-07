{
  flake.modules.nixos.zsh =
    {
      pkgs,
      username,
      ...
    }:
    {
      programs.zsh.enable = true;
      users.users."${username}".shell = pkgs.zsh;

      home-manager = {
        users."${username}" =
          { config, ... }:
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
      };
    };
}
