{ config, pkgs, ... }:

{
    systemd.tmpfiles.rules = [
        "w /sys/class/drm/card1/device/power_dpm_force_performance_level - - - - manual"
        "w /sys/class/drm/card1/device/pp_power_profile_mode - - - - 1"
    ];

    environment.systemPackages = with pkgs; [
        lact
    ];

    systemd.services.lact = {
        description = "AMDGPU Control Daemon";
        after = ["multi-user.target"];
        wantedBy = ["multi-user.target"];
        serviceConfig = {
            ExecStart = "${pkgs.lact}/bin/lact daemon";
        };
        enable = true;
    };
}