# cron

Enterprise cron role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Install `cronie` and `at`.
- Configure owner and permissions for:
  - `/etc/crontab`
  - `/etc/cron.hourly`
  - `/etc/cron.daily`
  - `/etc/cron.weekly`
  - `/etc/cron.monthly`
  - `/etc/cron.d`
- Configure `/etc/cron.allow`.
- Configure `/etc/at.allow`.
- Remove `/etc/cron.deny`.
- Remove `/etc/at.deny`.
- Verify package, permission, allow file, and deny file state.

## Default Permissions

| Path | Owner | Group | Mode |
| --- | --- | --- | --- |
| `/etc/crontab` | `root` | `root` | `0600` |
| `/etc/cron.hourly` | `root` | `root` | `0700` |
| `/etc/cron.daily` | `root` | `root` | `0700` |
| `/etc/cron.weekly` | `root` | `root` | `0700` |
| `/etc/cron.monthly` | `root` | `root` | `0700` |
| `/etc/cron.d` | `root` | `root` | `0700` |
| `/etc/cron.allow` | `root` | `root` | `0600` |
| `/etc/at.allow` | `root` | `root` | `0600` |

The role ensures `root` is present in the allow files and preserves any
additional site-approved users already listed there.

## Variables

| Variable | Default | Description |
| --- | --- | --- |
| `linux_security_baseline_cron_enabled` | `true` | Enables the role. |
| `linux_security_baseline_cron_install` | `true` | Installs cron and at packages. |
| `linux_security_baseline_cron_manage_files` | `true` | Manages cron file and directory permissions. |
| `linux_security_baseline_cron_manage_access` | `true` | Manages allow and deny files. |
| `linux_security_baseline_cron_verify` | `true` | Runs verification tasks. |
| `linux_security_baseline_cron_verify_fail_on_drift` | `true` | Fails when verification detects drift. |

## Tags

- `baseline`
- `cron`
- `cron_package`
- `cron_permissions`
- `cron_access`
- `cron_verify`
- `verify`

## Verification

Verification tasks run in check mode and fail when package state, permissions,
allow-file content, or deny-file absence would need remediation.
