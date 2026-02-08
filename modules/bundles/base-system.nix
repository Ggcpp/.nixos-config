{ self, inputs, ... }:

{
  flake.modules.nixos."bundles/base-system" =
    let
      packageModules = [
        "networkmanager"
        "pipewire"
        "keyd"
        "dwarf"
        "zsh"
        "fonts"
        "nvim"
        "tmux"
      ];
    in
    {
      imports = map (packageName: self.modules.nixos."packages/${packageName}") packageModules;
    };
}
