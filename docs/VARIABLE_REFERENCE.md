# Variable Reference

## Common Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `linux_security_baseline_target_distribution` | `RedHat` | Supported distribution family. |
| `linux_security_baseline_supported_major_versions` | `[7, 8, 9, 10]` | Supported RHEL major versions. |
| `linux_security_baseline_manage_services` | `true` | Allows service management roles to enable/start services. |
| `linux_security_baseline_reboot_allowed` | `false` | Reserved for future controls requiring reboot. |
| `linux_security_baseline_create_backups` | `true` | Signals roles to preserve pre-change files when supported. |

## Role Enablement

Role execution is controlled under `linux_security_baseline_roles` in
`group_vars/all.yml`. Set a role's `enabled` value to `false` to skip it.

## Verify Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `linux_security_baseline_verify_enabled` | `true` | Enables the verify role. |
| `linux_security_baseline_verify_fail_on_noncompliance` | `true` | Fails the play when any finding fails. |
| `linux_security_baseline_verify_report_dir` | `/var/tmp/linux-security-baseline` | Report output directory on managed nodes. |
| `linux_security_baseline_verify_report_json` | `{{ report_dir }}/compliance_report.json` | JSON report path. |
| `linux_security_baseline_verify_report_markdown` | `{{ report_dir }}/compliance_report.md` | Markdown report path. |
| `linux_security_baseline_verify_include_timestamp` | `false` | Adds a run timestamp to reports when enabled. |
| `linux_security_baseline_verify_ipv6_disable_enabled` | `true` | Verifies `disable_ipv6=1` unless the site overrides IPv6 disablement. |

## Sysctl Role Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `linux_security_baseline_process_hardening_sysctl_file` | `/etc/sysctl.conf` | Process hardening sysctl file. |
| `linux_security_baseline_network_sysctl_file` | `/etc/sysctl.conf` | IPv4 sysctl file. |
| `linux_security_baseline_ipv6_sysctl_file` | `/etc/sysctl.conf` | IPv6 sysctl file. |
| `linux_security_baseline_ipv6_disable_ipv6` | `true` | Adds `disable_ipv6=1` controls unless disabled by site policy. |

## Auditd Role Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `linux_security_baseline_auditd_manage_grub` | `true` | Manages the audit kernel argument in `/etc/default/grub`. |
| `linux_security_baseline_auditd_grub_audit_argument` | `audit=1` | Required audit kernel argument for `GRUB_CMDLINE_LINUX`. |

## Login Defs Role Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `linux_security_baseline_login_defs_manage_shell_umask` | `true` | Manages shell UMASK policy in `/etc/bashrc` and `/etc/profile.d/umask.sh`. |
| `linux_security_baseline_login_defs_bashrc_umask` | `0773` | UMASK applied from `/etc/bashrc`. |
| `linux_security_baseline_login_defs_profile_umask` | `0775` | UMASK applied from `/etc/profile.d/umask.sh`. |

## Domain Defaults

Each role exposes role-specific defaults under `roles/<role>/defaults/main.yml`.
The verify role also includes standalone fallback expectations so
`playbooks/verify_security_baseline.yml` can run independently.

When a site customizes a control, update both the remediation role variable and
the matching verify variable if the verify role is run by itself.
