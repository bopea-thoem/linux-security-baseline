# kernel_modules

Extension role for Linux Security Baseline kernel module controls.

The currently implemented kernel module controls are filesystem driver disables
for `cramfs`, `freevxfs`, `jffs2`, `hfs`, `hfsplus`, `squashfs`, and `udf`.
Those controls are implemented in the `filesystem` role so `/dev/shm` mount
policy and filesystem module policy remain together.

Use this role for future non-filesystem module controls.
