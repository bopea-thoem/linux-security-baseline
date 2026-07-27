# Role Documentation

## filesystem

Hardens `/dev/shm` with `nodev`, `nosuid`, and `noexec`. Disables and unloads
the prohibited modules `cramfs`, `freevxfs`, `jffs2`, `hfs`, `hfsplus`,
`squashfs`, `udf`, `dccp`, `sctp`, `rds`, and `tipc`.

## gpg

Verifies and installs the Red Hat release GPG key when missing.

## aide

Installs AIDE, initializes the database only when no active or new database
exists, preserves existing databases, and schedules a daily integrity check.

## process_hardening

Disables core dumps in `/etc/security/limits.conf` and configures
`fs.suid_dumpable=0`.

## network

Configures the IPv4 network sysctl baseline for forwarding, redirects, source
routing, martian logging, reverse path filtering, ICMP hardening, and TCP SYN
cookies.

## ipv6

Configures IPv6 router advertisement and redirect controls, and disables IPv6
through sysctl by default.

## firewalld

Installs, enables, and starts firewalld.

## rsyslog

Installs rsyslog, manages `/etc/rsyslog.conf`, enables the service, and restarts
only when configuration changes.

## auditd

Installs auditd, ensures `audit=1` is present in `/etc/default/grub`, manages
`auditd.conf`, writes baseline audit rules under `/etc/audit/rules.d`,
preserves custom rules, and reloads audit rules safely.

## cron

Secures `/etc/crontab`, cron directories, `cron.allow`, and `at.allow`, and
removes `cron.deny` and `at.deny`.

## ssh

Installs and configures OpenSSH server controls including root login denial,
empty-password denial, X11 forwarding disablement, approved ciphers, idle
timeout, banner, and OpenSSH-version-aware deprecated directive handling.

## pam

Uses `authconfig` on RHEL 7 and `authselect` on RHEL 8+ to configure SHA512,
pwquality, faillock, password history, password complexity, and lockout policy.

## login_defs

Configures password aging and umask settings in `/etc/login.defs`, shell UMASK
policy in `/etc/bashrc` and `/etc/profile.d/umask.sh`, RHEL 9/10 shell idle
timeout with `TMOUT=600`, and safely updates existing local interactive users.

## verify

Collects compliance evidence, writes JSON and Markdown reports, and fails the
play when non-compliance is detected.
