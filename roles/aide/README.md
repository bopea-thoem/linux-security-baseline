# aide

AIDE integrity monitoring role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Install AIDE and cron support packages.
- Initialize the AIDE database only when no active or new database exists.
- Activate the initialized database with `force: false` so an existing database
  is never overwritten.
- Configure a daily AIDE integrity check in `/etc/cron.d`.
- Verify package, database, and cron state after remediation.

## Database Safety

The role uses these safeguards:

- It checks for the active database before initialization.
- It checks for an existing newly initialized database before initialization.
- It runs `aide --init` only when both database files are absent.
- It copies `aide.db.new.gz` to `aide.db.gz` only when the active database is
  absent.
- It uses `force: false` during database activation.

## Modules Used

- `ansible.builtin.assert`
- `ansible.builtin.package`
- `ansible.builtin.file`
- `ansible.builtin.stat`
- `ansible.builtin.command`
- `ansible.builtin.copy`
- `ansible.builtin.import_tasks`
- `ansible.builtin.systemd` in handlers

`ansible.builtin.command` is used only where there is no native Ansible module
for AIDE database initialization or an optional AIDE integrity check.

## Variables

| Variable | Default | Description |
| --- | --- | --- |
| `linux_security_baseline_aide_enabled` | `true` | Enables the role. |
| `linux_security_baseline_aide_install` | `true` | Installs AIDE packages. |
| `linux_security_baseline_aide_initialize` | `true` | Initializes the AIDE database when absent. |
| `linux_security_baseline_aide_configure_daily_check` | `true` | Manages the daily cron check. |
| `linux_security_baseline_aide_verify` | `true` | Runs verification tasks. |
| `linux_security_baseline_aide_verify_fail_on_drift` | `true` | Fails when verification detects drift. |
| `linux_security_baseline_aide_verify_run_integrity_check` | `false` | Runs `aide --check` during verification when enabled. |
| `linux_security_baseline_aide_restart_crond_on_change` | `false` | Restarts `crond` after cron file changes when enabled. |

Default database paths:

```yaml
path: /var/lib/aide/aide.db.gz
new_path: /var/lib/aide/aide.db.new.gz
```

Default daily check:

```yaml
minute: "05"
hour: "03"
command: /usr/sbin/aide --check
```

## Tags

- `baseline`
- `aide`
- `aide_package`
- `aide_database`
- `aide_cron`
- `aide_integrity_check`
- `aide_verify`
- `verify`

## Verification

Verification tasks run after remediation by default:

- Package state is checked in Ansible check mode.
- The active AIDE database must exist.
- The cron file content is checked in Ansible check mode.
- The full `aide --check` integrity scan is available but disabled by default.
