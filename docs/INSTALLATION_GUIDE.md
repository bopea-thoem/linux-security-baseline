# Installation Guide

## Requirements

- Red Hat Enterprise Linux 7, 8, 9, or 10 managed nodes
- Red Hat Ansible Automation Platform or ansible-core 2.15+
- Python 3 on the control environment
- Privilege escalation to root on managed nodes
- Collections listed in `requirements.yml`

## Install Collections

```bash
ansible-galaxy collection install -r requirements.yml
```

## Validate Locally

```bash
ansible-playbook -i inventory/hosts.yml playbooks/security_baseline.yml --syntax-check
ansible-lint
```

## Run the Baseline

```bash
ansible-playbook -i inventory/hosts.yml playbooks/security_baseline.yml
```

## Run Verification Only

```bash
ansible-playbook -i inventory/hosts.yml playbooks/verify_security_baseline.yml
```

The verify play writes reports to `/var/tmp/linux-security-baseline` on each
target host and fails by default when any control is non-compliant.
