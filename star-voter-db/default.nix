{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let
  inherit (nixpkgs) pkgs;
  f = import ./star-voter-db.nix;
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};
  drv = haskellPackages.callPackage f {};

in
  if pkgs.lib.inNixShell then drv.env else drv

