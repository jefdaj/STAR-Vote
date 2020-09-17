{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, acid-state, barcodes-code128, base
      , blaze-html, blaze-markup, bytestring, cassava, containers
      , data-default, digestive-functors, digestive-functors-blaze
      , digestive-functors-snap, HPDF, lens, safecopy, star-types
      , star-util, stdenv, text, transformers, vector
      }:
      mkDerivation {
        pname = "star-voter-db";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          acid-state barcodes-code128 base blaze-html blaze-markup bytestring
          cassava containers data-default digestive-functors
          digestive-functors-blaze digestive-functors-snap HPDF lens safecopy
          star-types star-util text transformers vector
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
