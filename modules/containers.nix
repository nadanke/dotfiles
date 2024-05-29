{ config, pkgs, ... }:

{
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
    virtualisation.containers.enable = true;
    virtualisation = {
        podman = {
            enable = true;
            # Required for containers under podman-compose to be able to talk to each other.
            defaultNetwork.settings.dns_enabled = true;
        };
    };

    environment.systemPackages = with pkgs; [
        docker-compose
    ];

    users.users.nadanke = {
            packages = with pkgs; [
                podman-tui
                dive
            ];
    };
}