# Rollback Procedure

## Scope

This project does not include automated rollback roles. Rollback is handled by
restoring approved configuration backups or by changing baseline variables and
rerunning the playbook.

## General Rollback Steps

1. Stop scheduled rollout jobs in AAP.
2. Identify the changed domain and affected hosts from the job output.
3. Review the target file and the matching role defaults.
4. Restore the approved previous file from configuration management or backup.
5. Restart or reload only the affected service.
6. Run `playbooks/verify_security_baseline.yml` and confirm the expected state.

## Domain Notes

- SSH: validate with `sshd -t` before restarting or reloading `sshd`.
- PAM: use vendor-supported `authconfig` or `authselect` workflows; keep an
  active root session while testing authentication changes.
- Auditd: avoid changing immutable audit rules on production hosts without a
  maintenance window.
- AIDE: never overwrite an existing trusted database during rollback.
- Cron: restore allow and deny files intentionally; access changes can affect
  batch operations.

## Recommended Controls

Maintain external backups through enterprise configuration management, VM
snapshots, or platform backup tooling before broad enforcement.
