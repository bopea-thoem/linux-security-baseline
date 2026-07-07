# auditd

Enterprise auditd role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Install the Red Hat `audit` package.
- Manage `/etc/audit/auditd.conf`.
- Enable and start the `auditd` service.
- Manage persistent audit rules.
- Reload audit rules safely through handlers.
- Verify package, directory, configuration, rules, and service state.

## Rule Management

The default backend uses `augenrules` and writes only role-owned files:

- `/etc/audit/rules.d/10-linux-security-baseline-base.rules`
- `/etc/audit/rules.d/30-linux-security-baseline.rules`
- `/etc/audit/rules.d/99-linux-security-baseline-finalize.rules`

Custom rule files are not removed or overwritten.

For RHEL 7, the default remains `rules_d`, because Red Hat documents
`augenrules` and `/etc/audit/rules.d` for RHEL 7. If a legacy estate requires
direct management of `/etc/audit/audit.rules`, set:

```yaml
linux_security_baseline_auditd_rules_backend_rhel7: audit_rules_file
```

The legacy backend uses an Ansible managed block and preserves unmanaged custom
content in `/etc/audit/audit.rules`.

## Audit Rule Coverage

The generated baseline rules cover:

- Audit control settings
- Time changes
- User and group identity changes
- System locale and network environment changes
- MAC policy changes
- Login and logout records
- Session records
- Sudoers and sudo action logging where paths exist
- Audit configuration and audit log tampering
- Permission and ownership changes
- Failed file access attempts
- Mount operations
- File deletion and rename operations
- Privileged command execution for common RHEL privileged binaries
- Dynamic privileged command discovery for SUID/SGID files under managed roots
- Kernel module loading and unloading

Paths that are optional on a given RHEL build are checked before rules are
rendered. Missing optional paths are skipped so rule loading remains reliable.

Privileged command discovery is enabled by default and scans `/usr` and
`/usr/local` with `find -xdev`. It is read-only and does not change the host.
Disable it with:

```yaml
linux_security_baseline_auditd_discover_privileged_commands: false
```

## Immutable Rules

Immutable audit rules are disabled by default:

```yaml
linux_security_baseline_auditd_rules_immutable: false
```

When enabled, the role writes `-e 2` into the final managed rules file. Live
reload is skipped by default in immutable mode because changing immutable audit
rules safely requires a reboot.

## Tags

- `baseline`
- `auditd`
- `auditd_package`
- `auditd_config`
- `auditd_rules`
- `auditd_service`
- `auditd_verify`
- `verify`

## Verification

Verification tasks run in check mode where possible and fail on predicted drift
when `linux_security_baseline_auditd_verify_fail_on_drift` is `true`.

## References

- DevSec Linux Security Baseline: https://github.com/dev-sec/linux-baseline
- DevSec Ansible hardening collection: https://github.com/dev-sec/ansible-collection-hardening
- Red Hat persistent audit rules guidance: https://docs.redhat.com/
