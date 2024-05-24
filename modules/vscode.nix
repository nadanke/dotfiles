{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
                svelte.svelte-vscode
                bbenoist.nix
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "copilot";
                    publisher = "GitHub";
                    version = "1.192.0";
                    sha256 = "sha256-t3YngT6ep11gP4Mk8YpJ3WDykQNq0j6oB4+B5SEJck8=";
                }
            ];
        })
    ];
}
