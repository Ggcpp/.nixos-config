{ self, ... }:

{
  flake.modules.nixos.keyd = {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        extraConfig = ''
          [main]

          # Maps capslock to escape when pressed and control when held.
          # capslock = overload(control, esc)
          capslock = overload(ctrl_vim, esc)

          # Remaps the escape key to capslock
          esc = capslock

          rightalt = overload(alt, enter)
          tab = backspace

          backspace = capslock

          [ctrl_vim:C]

          l = tab

          # Should be outside of terminal
          m = C-backspace
        '';
      };
    };
  };
}
