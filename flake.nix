{
  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" ];
      forSystems =
        function:
        nixpkgs.lib.genAttrs systems (
          system:
          function (
            import nixpkgs {
              inherit system;
            }
          )
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
