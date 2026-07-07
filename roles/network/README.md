# network

Configures IPv4 network sysctl controls for the Linux Security Baseline.

## Controls

The role manages the IPv4 sysctl baseline in
`/etc/sysctl.d/99-linux-security-baseline-network.conf`, including forwarding,
redirects, source routing, martian logging, reverse path filtering, ICMP
hardening, and TCP SYN cookies.

## Variables

- `linux_security_baseline_network_manage_sysctl`
- `linux_security_baseline_network_sysctl_file`
- `linux_security_baseline_network_ipv4_sysctl_settings`

## Verification

`tasks/verify.yml` checks active IPv4 sysctl runtime values.
