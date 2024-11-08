{
  outputs =
    { systems, nixpkgs, fenix, ... }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f {
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      devShells = eachSystem ({pkgs}: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs
            nodePackages.typescript
            nodePackages.typescript-language-server
          ];
        };
      });
    };
}
