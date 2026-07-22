# kernel_modules

Extension role for Linux Security Baseline kernel module controls.

The currently implemented kernel module controls are filesystem driver and
protocol module disables for `cramfs`, `freevxfs`, `jffs2`, `hfs`, `hfsplus`,
`squashfs`, `udf`, `dccp`, `sctp`, `rds`, and `tipc`. Those controls are
implemented in the `filesystem` role so `/dev/shm` mount policy and module
policy remain together.

Use this role for future non-filesystem module controls.
