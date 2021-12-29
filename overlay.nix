final: prev: with final; {

  haskellPackages = prev.haskellPackages.override (old: {
    overrides = lib.composeManyExtensions [
                  (old.overrides or (_: _: {}))
                  (haskell.lib.packageSourceOverrides { hmatrix-mmap = ./.; })
                ];
  });

}
