{
  description = "Stock Sentiment Analysis Tool using Flask and Vader";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      pythonEnv = pkgs.python311.withPackages (ps: with ps; [
        flask
        vaderSentiment
        pip
        setuptools
        wheel
      ]);
    in
    {
      devShells.default = pkgs.mkShell {
        name = "stock-sentiment-env";
        packages = [
          pythonEnv
        ];

        shellHook = ''
          echo "🐍 Python environment ready. Run 'python app.py' to start the Flask app."
        '';
      };
    }
  );
}
