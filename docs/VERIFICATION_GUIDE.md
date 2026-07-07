# Verification Guide

## Run Verification

```bash
ansible-playbook -i inventory/hosts.yml playbooks/verify_security_baseline.yml
```

## Reports

Reports are written on each target host:

- `/var/tmp/linux-security-baseline/compliance_report.json`
- `/var/tmp/linux-security-baseline/compliance_report.md`

The JSON report is intended for automation and ingestion. The Markdown report is
intended for operators and auditors.

## Failure Behavior

The verify role records all findings before failing. This gives operators a
complete non-compliance list from one job run.

To collect reports without failing:

```yaml
linux_security_baseline_verify_fail_on_noncompliance: false
```

## Verification Scope

The verify role covers filesystem, kernel module policy, GPG, process/sysctl,
network, IPv6, auditd, SSH, cron, PAM, login definitions, AIDE, rsyslog, and
firewalld.

## Report Idempotence

By default the report timestamp is disabled so repeated runs with the same host
state do not rewrite reports unnecessarily. Enable
`linux_security_baseline_verify_include_timestamp` when timestamped reports are
required by audit procedure.
