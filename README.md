# Linux Security Baseline

Enterprise Ansible project for applying and verifying a Red Hat Enterprise
Linux security baseline across RHEL 7, RHEL 8, RHEL 9, and RHEL 10.

The project is designed for Red Hat Ansible Automation Platform, ansible-core
2.15+, Python 3 execution environments, idempotent execution, fully qualified
Ansible collection names, and one shared codebase across supported RHEL major
versions.

## Implemented Roles

- `filesystem`: `/dev/shm` hardening and filesystem kernel module disablement
- `gpg`: Red Hat release GPG key verification and installation
- `aide`: AIDE installation, first-time database initialization, daily checks
- `process_hardening`: core dump disablement and `fs.suid_dumpable=0`
- `network`: IPv4 sysctl network baseline
- `ipv6`: IPv6 redirect/router-advertisement controls and optional disablement
- `firewalld`: package installation and service enablement
- `rsyslog`: package, service, and managed `rsyslog.conf`
- `auditd`: package, service, configuration, and managed audit rules
- `cron`: cron and at file permissions and access control
- `ssh`: OpenSSH hardening with version-aware deprecated directive handling
- `pam`: RHEL 7 authconfig and RHEL 8+ authselect password policy controls
- `login_defs`: password aging, umask, and existing user aging updates
- `verify`: compliance evidence collection, JSON/Markdown reports, fail on drift

The current kernel module controls disable filesystem drivers and are implemented
by the `filesystem` role. The `kernel_modules` role is reserved for future
non-filesystem module controls.

## Project Layout

```text
.
|-- ansible.cfg
|-- docs/
|-- examples/
|-- group_vars/
|-- handlers/
|-- inventory/
|-- playbooks/
|   |-- security_baseline.yml
|   `-- verify_security_baseline.yml
|-- requirements.yml
`-- roles/
```

## Run

```bash
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory/hosts.yml playbooks/security_baseline.yml
```

## Verify

```bash
ansible-playbook -i inventory/hosts.yml playbooks/verify_security_baseline.yml
```

Compliance reports are written on each target:

- `/var/tmp/linux-security-baseline/compliance_report.json`
- `/var/tmp/linux-security-baseline/compliance_report.md`

Verification fails by default when any control is non-compliant. Set
`linux_security_baseline_verify_fail_on_noncompliance: false` to collect reports
without failing the job.

## Documentation

- [Installation Guide](docs/INSTALLATION_GUIDE.md)
- [AAP Deployment Guide](docs/AAP_DEPLOYMENT_GUIDE.md)
- [Variable Reference](docs/VARIABLE_REFERENCE.md)
- [Role Documentation](docs/ROLE_DOCUMENTATION.md)
- [Verification Guide](docs/VERIFICATION_GUIDE.md)
- [Rollback Procedure](docs/ROLLBACK_PROCEDURE.md)
- [Troubleshooting Guide](docs/TROUBLESHOOTING_GUIDE.md)

Example AAP and inventory definitions are in `examples/`.
