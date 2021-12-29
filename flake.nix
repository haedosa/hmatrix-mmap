{
  description = "hmatrix-mmap";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/master";

  };

  outputs =
    inputs@{ self, nixpkgs, flake-utils, ... }:
    {
      overlay = nixpkgs.lib.composeManyExtensions (
                  with inputs;
                  [
                    (import ./overlay.nix)
                  ]);

    } // flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          config = {};
          overlays = [ self.overlay ];
        };
      in rec {

        devShell = import ./develop.nix { inherit pkgs; };

        defaultPackage = pkgs.haskellPackages.hmatrix-mmap;

      }
    );

}
