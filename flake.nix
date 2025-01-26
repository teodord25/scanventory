{
  description = "Flutter Android App with Nix and Neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;  # Allow unfree packages
          };
        };
        flutter = pkgs.flutter;
        androidSdk = pkgs.androidsdk;
        dart = pkgs.dart;
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ flutter androidSdk dart ];
          shellHook = ''
            export ANDROID_HOME=${androidSdk}
          '';
        };
      });
}
