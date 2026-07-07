# AAP Deployment Guide

## Project

Create an AAP project from this Git repository. Use the default branch selected
by your release process and enable update-on-launch only after repository
credentials and branch protections are in place.

## Execution Environment

Use an execution environment with:

- ansible-core 2.15 or newer
- Python 3
- `ansible.posix`
- `community.general`

## Inventory

Create an inventory with a `linux_security` group. See
`examples/inventory.yml` for a minimal example.

## Credentials

Attach a machine credential with privilege escalation enabled. The roles manage
system files, services, packages, kernel module policy, PAM, auditd, and SSH.

## Job Templates

Recommended templates:

- `Linux Security Baseline - Apply`: `playbooks/security_baseline.yml`
- `Linux Security Baseline - Verify`: `playbooks/verify_security_baseline.yml`

Use `examples/aap_job_template.yml` as a starting point for controller-as-code
or manual template creation.

## Tags

Use `baseline` for the complete project. Domain tags include `filesystem`,
`kernel_modules`, `gpg`, `aide`, `process_hardening`, `network`, `ipv6`,
`firewalld`, `rsyslog`, `auditd`, `cron`, `ssh`, `pam`, `login_defs`, and
`verify`.

## Survey Recommendations

Expose only controlled variables in surveys, such as:

- `linux_security_baseline_verify_fail_on_noncompliance`
- `linux_security_baseline_verify_report_dir`
- `linux_security_baseline_verify_ipv6_disable_enabled`

Avoid exposing package, PAM, SSH, or audit rule internals in broad operator
surveys.
