# gpg

GPG package trust role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Verify the Red Hat release GPG key fingerprint.
- Import the Red Hat release GPG key into the RPM database when it is missing.
- Verify the RPM database key state in check mode after remediation.

The role uses `/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release` by default. Remote
fallback to `https://security.access.redhat.com/data/fd431d51.txt` is disabled
by default for enterprise and disconnected environments.

## Modules Used

- `ansible.builtin.assert`
- `ansible.builtin.stat`
- `ansible.builtin.set_fact`
- `ansible.builtin.rpm_key`
- `ansible.builtin.import_tasks`

## Variables

| Variable | Default | Description |
| --- | --- | --- |
| `linux_security_baseline_gpg_enabled` | `true` | Enables the role. |
| `linux_security_baseline_gpg_manage_redhat_release_key` | `true` | Manages the Red Hat release RPM GPG key. |
| `linux_security_baseline_gpg_verify` | `true` | Runs verification tasks. |
| `linux_security_baseline_gpg_verify_fail_on_drift` | `true` | Fails when verification detects drift. |
| `linux_security_baseline_gpg_allow_remote_key_source` | `false` | Allows the role to use the official Red Hat URL when the local key file is missing. |

The default Red Hat release key fingerprint is:

```text
567E347AD0044ADE55BA8A5F199E2F91FD431D51
```

## Tags

- `baseline`
- `gpg`
- `gpg_redhat_key`
- `gpg_verify`
- `verify`

## Verification

Verification uses `ansible.builtin.rpm_key` in check mode. If the key would need
to be imported, verification fails when
`linux_security_baseline_gpg_verify_fail_on_drift` is `true`.

## Reference

Red Hat Product Signing Keys:

- https://access.redhat.com/security/team/key
