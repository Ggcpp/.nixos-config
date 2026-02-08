{
  self,
  inputs,
  config,
  ...
}:

{
  perSystem =
    { pkgs, ... }:
    let
      moduleNames = builtins.toJSON (builtins.attrNames config.flake.modules.nixos);
    in
    {
      packages.install =
        pkgs.writers.writePython3Bin "installScript"
          {
            libraries = [ pkgs.python3Packages.questionary ];
            doCheck = false;
          }
          ''
            import json
            import questionary

            module_list = json.loads('${moduleNames}')

            def main():
                print("--- Flake Modules Analyzer ---")

                choice = questionary.select(
                    "Quel module voulez-vous inspecter ?",
                    choices=module_list
                ).ask()

                if choice:
                    print(f"Vous avez sélectionné le module : {choice}")

            if __name__ == "__main__":
                main()
          '';
    };
}
