{
  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "nix-direnv-shell";

        buildInputs = with pkgs; [
          bashInteractive
          nixd
          nixfmt-rfc-style
        ];
      };
    };
}
