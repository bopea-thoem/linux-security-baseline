# firewalld

Enterprise firewalld role for the Linux Security Baseline.

## Supported Platforms

- RHEL 7
- RHEL 8
- RHEL 9
- RHEL 10

## Implemented Controls

- Install `firewalld`.
- Enable the `firewalld` service.
- Start the `firewalld` service.
- Verify package and service state in check mode.

## Variables

| Variable | Default | Description |
| --- | --- | --- |
| `linux_security_baseline_firewalld_enabled` | `true` | Enables the role. |
| `linux_security_baseline_firewalld_install` | `true` | Installs firewalld packages. |
| `linux_security_baseline_firewalld_manage_service` | `true` | Enables and starts the service. |
| `linux_security_baseline_firewalld_verify` | `true` | Runs verification tasks. |
| `linux_security_baseline_firewalld_verify_fail_on_drift` | `true` | Fails when verification detects drift. |

## Tags

- `baseline`
- `firewalld`
- `firewalld_package`
- `firewalld_service`
- `firewalld_verify`
- `verify`

## Verification

Verification tasks use Ansible check mode and fail when the package or service
would need remediation.
