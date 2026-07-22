# Role: verify

Enterprise compliance verification role for the Linux Security Baseline.

This role collects read-only evidence for every security control currently
implemented by the project, writes JSON and Markdown compliance reports, and
fails the play when one or more controls are non-compliant.

## Verified Domains

- Filesystem `/dev/shm` hardening
- Disabled filesystem and protocol kernel modules
- Red Hat GPG key presence
- Process hardening sysctl values
- IPv4 and IPv6 network sysctl values
- Auditd package, service, configuration, and rule families
- SSH package, service, file permissions, syntax, and effective directives
- Cron and at package/access permissions
- PAM password quality, faillock, pwhistory, SHA512, authconfig/authselect
- `login.defs` and local interactive user password aging
- AIDE package, database, and daily integrity check
- Rsyslog package, service, configuration, modules, and routing rules
- Firewalld package and service state

## Reports

Default report locations on each target:

- `/var/tmp/linux-security-baseline/compliance_report.json`
- `/var/tmp/linux-security-baseline/compliance_report.md`

Set `linux_security_baseline_verify_fail_on_noncompliance: false` to collect
reports without failing the job. The default is `true`.

## Idempotence

Report timestamps are disabled by default so repeated verification runs with the
same evidence produce the same report content. Set
`linux_security_baseline_verify_include_timestamp: true` if every report must
carry a run timestamp.
