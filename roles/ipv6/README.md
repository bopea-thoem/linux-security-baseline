# ipv6

Configures IPv6 sysctl controls for the Linux Security Baseline.

## Controls

- Disables IPv6 router advertisements
- Disables IPv6 redirects
- Optionally disables IPv6 with `linux_security_baseline_ipv6_disable_ipv6`

## Variables

- `linux_security_baseline_ipv6_manage_sysctl`
- `linux_security_baseline_ipv6_disable_ipv6`
- `linux_security_baseline_ipv6_sysctl_file`
- `linux_security_baseline_ipv6_sysctl_settings`
- `linux_security_baseline_ipv6_disable_sysctl_settings`

## Verification

`tasks/verify.yml` checks active IPv6 sysctl runtime values.
