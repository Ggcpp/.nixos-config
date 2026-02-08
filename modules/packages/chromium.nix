{ self, inputs, ... }:

{
  flake.modules.nixos."packages/chromium" =
    { pkgs, username, ... }:
    {
      home-manager = {
        users."${username}" = {
          home.packages = with pkgs; [
            chromium
          ];

          programs.chromium = {
            enable = true;
            extensions = [
              "annfbnbieaamhaimclajlajpijgkdblo" # dark theme
              "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
              "cfhdojbkjhnklbpkdaibdccddilifddb" # adblock plus
              "khncfooichmfjbepaaaebmommgaepoid" # unhook
            ];
          };
        };
      };
    };
}
