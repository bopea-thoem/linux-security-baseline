# Roles

This directory contains the enterprise role structure for the Linux Security
Baseline. Roles are intentionally empty until security controls are implemented.

Role dependencies are declared in each role's `meta/main.yml`. The foundation
uses an explicit empty dependency list for every role and centralizes execution
order in `playbooks/security_baseline.yml`.

