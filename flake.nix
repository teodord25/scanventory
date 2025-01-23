{
  description = "Flutter Android App with Nix and Neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        flutter = pkgs.flutter;
        androidSdk = pkgs.androidsdk;
        androidCmdlineTools = pkgs.androidsdk.cmdline-tools;
        dart = pkgs.dart;
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ flutter androidSdk androidCmdlineTools dart ];
          shellHook = ''
            export ANDROID_HOME=${androidSdk}
            export PATH=${flutter}/bin:${androidCmdlineTools}/bin:$PATH
          '';
        };
      });
}
