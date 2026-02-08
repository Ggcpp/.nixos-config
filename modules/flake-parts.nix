{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  config = {
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
