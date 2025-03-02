# Project-Specific Development Environments

This module sets up support for project-specific development environments using Nix flakes and direnv.

## How to Use

### Setting Up a New Project

1. Create a project directory:
   ```bash
   mkdir my-new-project
   cd my-new-project
   ```

2. Create a `flake.nix` file for your project. Here are some basic examples to get you started:

   **For a Rust project:**
   ```nix
   {
     inputs = {
       nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
       rust-overlay.url = "github:oxalica/rust-overlay";
       flake-utils.url = "github:numtide/flake-utils";
     };

     outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
       flake-utils.lib.eachDefaultSystem (system:
         let
           overlays = [ (import rust-overlay) ];
           pkgs = import nixpkgs { inherit system overlays; };
           
           rustVersion = pkgs.rust-bin.stable.latest.default;
         in
         {
           devShells.default = pkgs.mkShell {
             buildInputs = with pkgs; [
               rustVersion
               pkg-config
               openssl
               # Add other dependencies as needed
             ];
             
             shellHook = ''
               echo "Rust development environment activated!"
             '';
           };
         }
       );
   }
   ```

   **For a Python project:**
   ```nix
   {
     inputs = {
       nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
       flake-utils.url = "github:numtide/flake-utils";
     };

     outputs = { self, nixpkgs, flake-utils, ... }:
       flake-utils.lib.eachDefaultSystem (system:
         let
           pkgs = import nixpkgs { inherit system; };
           
           pythonEnv = pkgs.python311.withPackages (ps: with ps; [
             pip
             # Add Python packages as needed
           ]);
         in
         {
           devShells.default = pkgs.mkShell {
             buildInputs = with pkgs; [
               pythonEnv
               # Add other dependencies as needed
             ];
             
             shellHook = ''
               echo "Python development environment activated!"
             '';
           };
         }
       );
   }
   ```

3. Create a `.envrc` file with:
   ```
   use flake
   ```

4. Allow direnv to use the flake:
   ```bash
   direnv allow
   ```

5. Start working! The environment will automatically activate when you enter the project directory.

### Customizing Your Environment

Edit the `flake.nix` file to add or remove dependencies specific to your project. The key part to modify is the `buildInputs` list, where you specify the packages your project needs.

After changing the flake.nix file, the environment will automatically reload when you re-enter the directory or run:

```bash
direnv reload
```

### Manual Activation

If you prefer not to use direnv, you can manually activate the environment:

```bash
nix develop
```
