# filesystem

Filesystem hardening role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Mount `/dev/shm` as `tmpfs` with `nodev`, `nosuid`, and `noexec`.
- Disable unsupported filesystem and protocol kernel modules with managed
  modprobe policy.
- Unload prohibited kernel modules when they are loaded.
- Verify `/dev/shm`, modprobe policy, and loaded module state without shell.

Disabled modules:

Filesystem modules:

- `cramfs`
- `freevxfs`
- `jffs2`
- `hfs`
- `hfsplus`
- `squashfs`
- `udf`

Protocol modules with `/bin/true` install overrides:

- `dccp`
- `sctp`
- `rds`
- `tipc`

## Modules Used

Only the following Ansible modules are used by this role:

- `ansible.posix.mount`
- `ansible.builtin.copy`
- `community.general.modprobe`
- `ansible.builtin.systemd` in handlers

No shell or command tasks are used.

## Variables

Primary defaults are in `defaults/main.yml`.

| Variable | Default | Description |
| --- | --- | --- |
| `linux_security_baseline_filesystem_enabled` | `true` | Enables the role. |
| `linux_security_baseline_filesystem_manage_dev_shm` | `true` | Manages `/dev/shm` mount options. |
| `linux_security_baseline_filesystem_disable_modules` | `true` | Manages modprobe disable policy. |
| `linux_security_baseline_filesystem_unload_modules` | `true` | Unloads prohibited modules. |
| `linux_security_baseline_filesystem_verify` | `true` | Runs verification tasks after remediation. |
| `linux_security_baseline_filesystem_verify_fail_on_drift` | `true` | Fails verification when drift is detected. |
| `linux_security_baseline_filesystem_fail_on_module_unload_error` | `true` | Fails if a loaded prohibited module cannot be unloaded. |

`linux_security_baseline_filesystem_dev_shm` controls the `/dev/shm` mount
definition. The default options are:

```yaml
opts:
  - defaults
  - nodev
  - nosuid
  - noexec
```

`linux_security_baseline_filesystem_disabled_modules` controls the prohibited
filesystem module list.

`linux_security_baseline_filesystem_disabled_install_true_modules` controls
additional prohibited modules that use `install <module> /bin/true` policy.

## Tags

- `baseline`
- `filesystem`
- `filesystem_dev_shm`
- `filesystem_kernel_modules`
- `filesystem_verify`
- `verify`

## Verification

Verification tasks run in Ansible check mode and fail when drift is detected if
`linux_security_baseline_filesystem_verify_fail_on_drift` is `true`.

The verification tasks do not change managed hosts.
