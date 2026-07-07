# Troubleshooting Guide

## Unsupported Platform

Confirm the managed node reports `ansible_facts.distribution == RedHat` and a
major version of 7, 8, 9, or 10.

## Package Facts Fail

Ensure Python package manager bindings are available on the managed node and the
execution environment can run `package_facts`.

## SSH Verification Fails

Run `sshd -t -f /etc/ssh/sshd_config` on the target. If that fails, fix syntax
before restarting `sshd`.

## PAM Verification Fails

On RHEL 7, inspect `/etc/sysconfig/authconfig` and the `*-auth-ac` files. On
RHEL 8+, run `authselect current --raw` and confirm the custom baseline profile
and `with-faillock` feature are selected.

## Audit Verification Fails

Check `/etc/audit/rules.d` for the managed baseline files and run
`auditctl -l`. If rules are immutable, schedule a reboot or maintenance window
before expecting runtime changes.

## Report Missing

Confirm the play reached the verify role and that privilege escalation can write
to `linux_security_baseline_verify_report_dir`.

## AAP Job Fails Before Reporting

Review credential privilege escalation, inventory group membership, and
execution environment collection availability.
