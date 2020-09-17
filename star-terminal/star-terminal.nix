{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, acid-state, aeson, barcodes-code128, base
      , base16-bytestring, base64-bytestring, binary, blaze-html
      , blaze-markup, bytestring, case-insensitive, containers
      , crypto-api, data-default, DRBG, HPDF, http-client
      , http-client-tls, lens, MonadCatchIO-transformers
      , monadcryptorandom, mtl, old-locale, random, safecopy, snap-core
      , snap-server, star-types, star-util, stdenv, text, time
      , transformers, uuid
      }:
      mkDerivation {
        pname = "star-terminal";
        version = "0.1";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        enableSeparateDataOutput = true;
        executableHaskellDepends = [
          acid-state aeson barcodes-code128 base base16-bytestring
          base64-bytestring binary blaze-html blaze-markup bytestring
          case-insensitive containers crypto-api data-default DRBG HPDF
          http-client http-client-tls lens MonadCatchIO-transformers
          monadcryptorandom mtl old-locale random safecopy snap-core
          snap-server star-types star-util text time transformers uuid
        ];
        description = "Prototype of a voting machine";
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
