#!/bin/sh

# Ensure we are in the correct directory
cd ~/configuration/nixos || {
	echo "Failed to find ~/configuration/nixos"
	exit 1
}

# Get the current generation for naming the commit later
GENERATION=$(nix-env --list-generations | tail -n 1 | awk '{print $1}')

# Open the configuration in Neovim
nvim configuration.nix

# Check if there are any changes to the configuration file
if git diff --quiet hosts/asus-vivo/configuration.nix; then
	echo "No changes made to configuration.nix."
	exit 0
fi

# Show the updated diff
echo -e "\n--- Changes Detected ---\n"
git diff configuration.nix

# Build the NixOS configuration
echo -e "\n--- Building NixOS Configuration ---"
if sudo nixos-rebuild switch; then
	echo -e "\n--- Build Successful ---"
else
	echo -e "\n--- Build Failed ---"
	exit 1
fi

# Commit the changes to the repo with the generation name
echo -e "\n--- Committing Changes ---"
git add configuration.nix
git commit -m "Update to generation $GENERATION"

echo -e "\nChanges committed with message: 'Update to generation $GENERATION'"
