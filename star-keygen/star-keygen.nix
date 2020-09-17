{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, acid-state, aeson, append-only-bb, base
      , base64-bytestring, binary, blaze-html, byteable, bytestring
      , containers, crypto-api, crypto-pubkey, crypto-pubkey-types
      , crypto-random, cryptohash-cryptoapi, DRBG, HTTP
      , monadcryptorandom, safecopy, star-crypto, star-util, stdenv, text
      , time, utf8-string
      }:
      mkDerivation {
        pname = "star-keygen";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          acid-state aeson append-only-bb base base64-bytestring binary
          blaze-html byteable bytestring containers crypto-api crypto-pubkey
          crypto-pubkey-types crypto-random cryptohash-cryptoapi DRBG HTTP
          monadcryptorandom safecopy star-crypto star-util text time
          utf8-string
        ];
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
