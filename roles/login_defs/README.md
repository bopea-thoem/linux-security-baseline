# login_defs

Enterprise `login.defs` role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Configure `/etc/login.defs` ownership and permissions.
- Configure shell UMASK policy in `/etc/bashrc`.
- Create `/etc/profile.d/umask.sh` for CIS shell profile UMASK policy.
- Configure:
  - `PASS_MAX_DAYS`
  - `PASS_MIN_DAYS`
  - `PASS_WARN_AGE`
  - `UMASK`
- Safely update existing local interactive users with `chage`.
- Verify file settings and existing user password aging state.

## Safe Existing User Updates

Existing users are updated only when their current shadow aging values differ
from the configured policy. By default, the role targets local interactive users
with UID `1000` or greater and skips root, service accounts, nologin shells, and
explicitly excluded users.

Root can be included by setting:

```yaml
linux_security_baseline_login_defs_user_update:
  include_root: true
```

## Default Policy

```yaml
PASS_MAX_DAYS: "90"
PASS_MIN_DAYS: "7"
PASS_WARN_AGE: "7"
UMASK: "027"
linux_security_baseline_login_defs_bashrc_umask: "0773"
linux_security_baseline_login_defs_profile_umask: "0775"
```

## Tags

- `baseline`
- `login_defs`
- `login_defs_file`
- `login_defs_shell`
- `login_defs_users`
- `login_defs_verify`
- `verify`

## Verification

Verification tasks use check mode for `/etc/login.defs` drift and read the local
shadow database with `no_log` enabled before asserting current user aging state.
