{
  description = "Stock Sentiment Analysis Tool using Flask and VADER";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        # Use python311Full for ensurepip support
        python = pkgs.python311Full;
      in {
        devShells.default = pkgs.mkShell {
          name = "stock-sentiment-shell";
          buildInputs = [
            python
            pkgs.python311Packages.pip
            pkgs.python311Packages.setuptools
            pkgs.python311Packages.wheel
          ];

          shellHook = ''
            echo "🐍 Python with venv ready. To create a venv, run:"
            echo "    python -m venv venv"
            echo "Then activate with:"
            echo "    source venv/bin/activate"
          '';
        };
      });
}