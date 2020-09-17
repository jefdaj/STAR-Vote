{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, acid-state, aeson, base, base64-bytestring
      , binary, blaze-html, bytestring, containers, http-client
      , http-client-tls, lens, MonadCatchIO-transformers, multiset
      , random, safecopy, snap-core, split, star-crypto, star-types
      , star-util, stdenv, text, unix, unordered-containers
      }:
      mkDerivation {
        pname = "star-controller";
        version = "0.1.0.0";
        src = ./.;
        jailbreak = true;
        isLibrary = false;
        isExecutable = true;
        enableSeparateDataOutput = true;
        executableHaskellDepends = [
          acid-state aeson base base64-bytestring binary blaze-html
          bytestring containers http-client http-client-tls lens
          MonadCatchIO-transformers multiset random safecopy snap-core split
          star-crypto star-types star-util text unix unordered-containers
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
