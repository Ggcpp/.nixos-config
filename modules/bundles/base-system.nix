{ self, inputs, ... }:

{
  flake.modules.nixos."bundles/base-system" =
    let
      programModules = [
        "networkmanager"
        "pipewire"
        "keyd"
        "zsh"
        "nvim"
        "tmux"
      ];
    in
    {
      imports = map (programName: self.modules.nixos."programs/${programName}") programModules;
    };
}
