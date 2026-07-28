# rsyslog

Enterprise rsyslog role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Install `rsyslog`.
- Manage `/etc/rsyslog.conf` from YAML-defined content.
- Ensure `/etc/rsyslog.d` exists for drop-in configuration.
- Enable the `rsyslog` service.
- Start the `rsyslog` service.
- Restart `rsyslog` only when the managed configuration changes.
- Verify package, configuration, drop-in directory, and service state.

## Variables

| Variable | Default | Description |
| --- | --- | --- |
| `linux_security_baseline_rsyslog_enabled` | `true` | Enables the role. |
| `linux_security_baseline_rsyslog_install` | `true` | Installs rsyslog packages. |
| `linux_security_baseline_rsyslog_manage_service` | `true` | Enables and starts the service. |
| `linux_security_baseline_rsyslog_manage_main_config` | `true` | Manages `/etc/rsyslog.conf`. |
| `linux_security_baseline_rsyslog_manage_dropin_directory` | `true` | Ensures `/etc/rsyslog.d` exists. |
| `linux_security_baseline_rsyslog_verify` | `true` | Runs verification tasks. |
| `linux_security_baseline_rsyslog_verify_fail_on_drift` | `true` | Fails when verification detects drift. |

## Default Configuration

The generated `rsyslog.conf` loads:

- `imuxsock`
- `imjournal`

Default rules write standard RHEL logs including `/var/log/messages`,
`/var/log/secure`, `/var/log/maillog`, `/var/log/cron`, and
`/var/log/boot.log`.

## Tags

- `baseline`
- `rsyslog`
- `rsyslog_package`
- `rsyslog_config`
- `rsyslog_service`
- `rsyslog_verify`
- `verify`

## Verification

Verification tasks use Ansible check mode and fail when package, config,
directory, or service state would need remediation.
