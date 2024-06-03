{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (vscode-with-extensions.override {
            vscode = vscodium-fhs;
            vscodeExtensions = with vscode-extensions; [
#                svelte.svelte-vscode
                bbenoist.nix
                haskell.haskell
                justusadam.language-haskell
                k--kato.intellij-idea-keybindings
                esbenp.prettier-vscode
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "copilot";
                    publisher = "GitHub";
                    version = "1.192.0";
                    sha256 = "sha256-t3YngT6ep11gP4Mk8YpJ3WDykQNq0j6oB4+B5SEJck8=";
                }
                {
                    name = "svelte-vscode";
                    publisher = "svelte";
                    version = "108.4.1";
                    sha256 = "1yfwg9f1npyd8avmjvwimrnr34p9xp1d3cjxdh95ymjgdrlpgig8";
                }
                {
                    name = "pretty-ts-errors";
                    publisher = "yoavbls";
                    version = "0.5.4";
                    sha256 = "sha256-SMEqbpKYNck23zgULsdnsw4PS20XMPUpJ5kYh1fpd14=";
                }
            ];
        })
    ];
}
