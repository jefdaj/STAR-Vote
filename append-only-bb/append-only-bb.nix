{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, base, base64-bytestring, blaze-html
      , blaze-markup, byteable, bytestring, containers, convertible
      , crypto-pubkey, crypto-pubkey-types, crypto-random, cryptohash
      , directory, filepath, HDBC, HDBC-sqlite3, HTTP, mtl, old-locale
      , snap-core, snap-server, stdenv, text, time, transformers
      , unordered-containers, utf8-string
      }:
      mkDerivation {
        pname = "append-only-bb";
        version = "0.0.1.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        jailbreak = true;
        enableSeparateDataOutput = true;
        libraryHaskellDepends = [
          aeson base base64-bytestring byteable bytestring convertible
          crypto-pubkey crypto-pubkey-types crypto-random cryptohash HDBC
          HDBC-sqlite3 mtl old-locale text time unordered-containers
          utf8-string
        ];
        executableHaskellDepends = [
          aeson base blaze-html blaze-markup bytestring containers
          crypto-pubkey crypto-pubkey-types crypto-random directory filepath
          HDBC HDBC-sqlite3 HTTP mtl old-locale snap-core snap-server text
          time transformers unordered-containers utf8-string
        ];
        description = "An append-only Web bulletin board, based on Heather and Lundin's paper";
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
