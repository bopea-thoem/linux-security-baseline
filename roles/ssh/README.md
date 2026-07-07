# ssh

Enterprise SSH role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Install `openssh-server`.
- Preserve the vendor `/etc/ssh/sshd_config` while adding a managed include
  block at the top of the file.
- Manage `/etc/ssh/sshd_config.d/00-linux-security-baseline.conf`.
- Manage SSH login banner content.
- Enable and start `sshd`.
- Validate SSH configuration before deployment.
- Apply `sshd` changes only when managed configuration changes.
- Verify package, config, banner, and service state.

## Baseline Settings

- `Protocol 2` when supported by the detected OpenSSH version
- `LogLevel INFO`
- `X11Forwarding no`
- `MaxAuthTries 4`
- `IgnoreRhosts yes`
- `HostbasedAuthentication no`
- `PermitRootLogin no`
- `PermitEmptyPasswords no`
- `PermitUserEnvironment no`
- Approved `Ciphers`
- Idle timeout with `ClientAliveInterval` and `ClientAliveCountMax`
- `Banner /etc/issue.net`

## Deprecated Directives

The role detects the OpenSSH version with `sshd -V`. The `Protocol` directive is
rendered only when the detected OpenSSH major version is lower than
`linux_security_baseline_ssh_protocol_directive_deprecated_from_major`, which is
`8` by default. This keeps RHEL 7 compatible while avoiding deprecated
configuration on newer OpenSSH releases.

## Restart Behavior

The handler runs only when managed SSH configuration files change. By default it
uses:

```yaml
linux_security_baseline_ssh_service:
  apply_state_on_config_change: reloaded
```

Set that value to `restarted` only for environments where reload is not
acceptable.

Banner content changes do not notify the handler because the configured banner
path does not change.

## Tags

- `baseline`
- `ssh`
- `ssh_package`
- `ssh_config`
- `ssh_banner`
- `ssh_service`
- `ssh_verify`
- `verify`

## Verification

Verification tasks run in check mode where possible and fail on predicted drift
when `linux_security_baseline_ssh_verify_fail_on_drift` is `true`. The active
SSH daemon configuration is also validated with `sshd -t`.
