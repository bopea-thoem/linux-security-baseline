# process_hardening

Configures process hardening controls for the Linux Security Baseline.

## Controls

- Disables core dumps in `/etc/security/limits.conf`
- Sets `fs.suid_dumpable=0` with `ansible.posix.sysctl`

## Variables

- `linux_security_baseline_process_hardening_manage_limits`
- `linux_security_baseline_process_hardening_manage_sysctl`
- `linux_security_baseline_process_hardening_sysctl_file`
- `linux_security_baseline_process_hardening_sysctl_settings`

## Verification

`tasks/verify.yml` checks the limits file and active sysctl runtime values.
