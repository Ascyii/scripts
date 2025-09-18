#!/bin/sh

set -e

cd ~/projects/studCrawl

# List your dependencies here (space-separated, Nix/Nixpkgs attribute names)
PYTHON_DEPS="requests beautifulsoup4"

# Optional: set path to your main script
SCRIPT="src/just_update.py"

# Call nix-shell with your dependencies; -p means "with these packages in environment"
nix-shell -p "python3.withPackages (ps: with ps; [ $PYTHON_DEPS ])" --run "python3 $SCRIPT"
