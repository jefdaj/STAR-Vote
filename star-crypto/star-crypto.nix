{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, arithmoi, array, base, binary
      , bytestring, containers, crypto-api, crypto-random
      , monadcryptorandom, mtl, QuickCheck, stdenv
      }:
      mkDerivation {
        pname = "star-crypto";
        version = "0.1.0.0";
        src = ./.;
        jailbreak = true;
        libraryHaskellDepends = [
          aeson arithmoi array base binary bytestring containers crypto-api
          crypto-random monadcryptorandom mtl
        ];
        testHaskellDepends = [
          arithmoi array base bytestring crypto-api monadcryptorandom
          QuickCheck
        ];
        license = "unknown";
        hydraPlatforms = stdenv.lib.platforms.none;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
