# pam

Enterprise PAM role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7 with `authconfig`
- RHEL 8 with `authselect`
- RHEL 9 with `authselect`
- RHEL 10 with `authselect`

## Implemented Controls

- SHA512 local password hashing.
- Password complexity through `pam_pwquality`.
- Account lockout through `pam_faillock`.
- Password history through `pam_pwhistory`.
- Lockout policy configuration.
- Check-mode verification tasks.

## RHEL 7 Behavior

RHEL 7 uses `authconfig` for the managed PAM stack:

- `--passalgo=sha512`
- `--enablefaillock`
- `--faillockargs`

The role then manages the authconfig-controlled `*-auth-ac` files for
`pam_pwquality`, `pam_pwhistory`, and `pam_unix` SHA512 entries.

## RHEL 8+ Behavior

RHEL 8, 9, and 10 use `authselect`. The role creates a custom authselect profile
named `linux-security-baseline` based on the active non-custom profile, or `sssd`
when no profile is active. PAM profile templates are copied, not symlinked, so
baseline password history and SHA512 settings are persistent.

The custom profile is selected with `with-faillock`. By default,
`authselect --force` is not used.

## Variables

Primary tunables are in `defaults/main.yml`:

- `linux_security_baseline_pam_pwquality`
- `linux_security_baseline_pam_faillock`
- `linux_security_baseline_pam_pwhistory`
- `linux_security_baseline_pam_password`
- `linux_security_baseline_pam_authselect`

## Tags

- `baseline`
- `pam`
- `pam_package`
- `pam_authconfig`
- `pam_authselect`
- `pam_pwquality`
- `pam_faillock`
- `pam_pwhistory`
- `pam_sha512`
- `pam_verify`
- `verify`

## Verification

Verification tasks check package state, generated policy files, RHEL 7
authconfig state, RHEL 7 PAM entries, RHEL 8+ authselect selection, and custom
authselect profile entries.
