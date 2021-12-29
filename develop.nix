{ pkgs }: with pkgs; let

  ghcCharged =  haskellPackages.ghcWithHoogle (p: with p; [
                  haskell-language-server
                  ghcid
                ]);
  ghcid-bin = haskellPackages.ghcid.bin;

  ghcid-lib = let
    ghcid = "${ghcid-bin}/bin/ghcid";
    out = "$out/bin/ghcid-lib";
  in runCommand "ghcid-lib" { buildInputs = [ makeWrapper ]; } ''
    makeWrapper ${ghcid} ${out} --add-flags "--command='cabal repl'"
  '';

in mkShell {
  buildInputs =  haskellPackages.hmatrix-mmap.env.nativeBuildInputs ++
                 [ ghcCharged
                   ghcid-lib
                   cabal-install
                 ];

}
