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
| `linux_security_baseline_verify_ipv6_disable_enabled` | `false` | Verifies `disable_ipv6=1` when the site requires IPv6 disabled. |

## Sysctl Role Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `linux_security_baseline_process_hardening_sysctl_file` | `/etc/sysctl.d/99-linux-security-baseline-process.conf` | Process hardening sysctl file. |
| `linux_security_baseline_network_sysctl_file` | `/etc/sysctl.d/99-linux-security-baseline-network.conf` | IPv4 sysctl file. |
| `linux_security_baseline_ipv6_sysctl_file` | `/etc/sysctl.d/99-linux-security-baseline-ipv6.conf` | IPv6 sysctl file. |
| `linux_security_baseline_ipv6_disable_ipv6` | `false` | Adds `disable_ipv6=1` controls when required by policy. |

## Domain Defaults

Each role exposes role-specific defaults under `roles/<role>/defaults/main.yml`.
The verify role also includes standalone fallback expectations so
`playbooks/verify_security_baseline.yml` can run independently.

When a site customizes a control, update both the remediation role variable and
the matching verify variable if the verify role is run by itself.
