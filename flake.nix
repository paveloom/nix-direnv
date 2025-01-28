{
  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";
  };

  outputs =
    { nixpkgs, ... }:
    let
      forSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function (import nixpkgs { inherit system; })
        );
    in
    {
      devShells = forSystems (pkgs: {
        default = pkgs.mkShell {
          name = "nix-direnv-shell";

          buildInputs = with pkgs; [
            bashInteractive
            nixd
            nixfmt-rfc-style
          ];
        };
      });

      templates.default = {
        path = ./template;
        description = "@paveloom's `nix-direnv` template";
      };
    };
}
