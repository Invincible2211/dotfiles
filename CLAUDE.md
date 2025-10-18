# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS dotfiles repository using a modular configuration system powered by [modulix](https://github.com/anders130/modulix). The repository manages multiple NixOS host configurations with shared modules and home-manager integration.

## Architecture

### Flake Structure

The flake uses modulix's `mkHosts` function to automatically discover and configure NixOS systems from the `hosts/` directory. Key components:

- **modulix integration**: Automatically generates NixOS configurations from host directories
- **flakePath**: Set to `/home/hoshi/dotfiles` (default user location)
- **modulesPath**: Points to `./modules` for shared system modules
- **helpers**: Custom library functions from `./lib`
- **sharedConfig**: Default module configuration applied to all hosts

### Module System

Modules follow a hierarchical structure under `modules/`:

- `boot/`: Bootloader configurations (grub, plymouth, systemboot)
- `programms/`: Application configurations
  - `cli/`: CLI tools (kitty, nixvim, docker)
  - `gui/`: GUI applications (browser, theming, vm)
- `services/`: System services (printing, etc.)
- `system/`: Core system configuration (audio, display, fonts, gnome, network, nix, shell, user)
- `git.nix`: Git configuration with delta and custom aliases

Modules are enabled via the `modules.<path>.<name>.enable` option pattern. Home-manager configurations within modules use the `hm` alias instead of `home-manager.users.${username}`.

### Host Configuration

Each host in `hosts/` contains:
- `default.nix`: Hardware imports, overlays, and module enables
- `config.nix`: Host-specific settings (hostname, username)
- `hardware-configuration.nix`: Auto-generated hardware configuration

Current hosts: Tsukoyomi (user: kaguya), Yozora

### Helper Functions

Located in `lib/`:
- `importFromDir`: Imports all Nix files from a directory (excluding specified files)
- `capitalized`: String manipulation helpers

### Overlays

`overlays/nixpkgs.nix` provides unstable packages (currently: citrix_workspace) alongside stable NixOS 25.05.

## Common Commands

### Building and Switching

```bash
# Rebuild current system
sudo nixos-rebuild switch --flake .

# Rebuild specific host
sudo nixos-rebuild switch --flake .#Tsukoyomi

# Build without activating
sudo nixos-rebuild build --flake .

# Test configuration (doesn't add boot entry)
sudo nixos-rebuild test --flake .
```

### Updating

```bash
# Update flake inputs
nix flake update

# Update specific input
nix flake update nixpkgs
```

### Formatting

```bash
# Format all Nix files with alejandra
nix fmt
```

### Development

```bash
# Check flake
nix flake check

# Show flake outputs
nix flake show
```

## Git Configuration

The repository includes custom git aliases in `modules/git.nix`:
- `s`: status -s
- `st`: status
- `ci`: commit
- `ciam`: commit --amend --no-edit
- `co`: checkout
- `d`: diff
- `ds`: diff --staged
- `a`: add
- `aa`: add --all
- `lg`: pretty log graph (last 30 commits)
- `rt`: restore
- `rts`: restore --staged

## Key Dependencies

- NixOS 25.05 (stable channel)
- home-manager (release-25.05)
- nixvim (nixos-25.05)
- stylix (release-25.05)
- modulix (host configuration automation)
- wfetch (custom package)
- nixpkgs-unstable (for select packages)
- updateThinClient ist der Befehl, um den Host Tsukoyomi über das Netzwerk neu zu bauen