{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, acid-state, aeson, base, base16-bytestring
      , binary, bytestring, cassava, containers, lens, monadcryptorandom
      , random, safecopy, SHA, star-crypto, stdenv, text, vector
      }:
      mkDerivation {
        pname = "star-types";
        version = "0.1";
        src = ./.;
        libraryHaskellDepends = [
          acid-state aeson base base16-bytestring binary bytestring cassava
          containers lens monadcryptorandom random safecopy SHA star-crypto
          text vector
        ];
        description = "Project Synopsis Here";
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
