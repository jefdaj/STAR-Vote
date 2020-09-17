{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, acid-state, aeson, append-only-bb, base
      , binary, blaze-html, byteable, bytestring, case-insensitive
      , containers, crypto-pubkey, crypto-pubkey-types
      , cryptohash-cryptoapi, data-default, DRBG, lens
      , MonadCatchIO-transformers, monadcryptorandom, mtl, process
      , safecopy, snap, snap-core, snap-server, star-types, stdenv, text
      , transformers
      }:
      mkDerivation {
        pname = "star-util";
        version = "0.1";
        src = ./.;
        libraryHaskellDepends = [
          acid-state aeson append-only-bb base binary blaze-html byteable
          bytestring case-insensitive containers crypto-pubkey
          crypto-pubkey-types cryptohash-cryptoapi data-default DRBG lens
          MonadCatchIO-transformers monadcryptorandom mtl process safecopy
          snap snap-core snap-server star-types text transformers
        ];
        description = "Project Synopsis Here";
        license = stdenv.lib.licenses.unfree;
        hydraPlatforms = stdenv.lib.platforms.none;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
