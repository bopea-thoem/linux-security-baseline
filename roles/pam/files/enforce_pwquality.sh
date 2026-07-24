#!/usr/bin/env bash
set -euo pipefail

pwquality_conf="${1:-/etc/security/pwquality.conf}"

touch "$pwquality_conf"

ensure_param() {
  local key="$1"
  local value="$2"
  local tmp_file
  tmp_file="$(mktemp)"

  awk -v key="$key" -v value="$value" '
    BEGIN { seen = 0 }
    {
      if (!seen && $0 ~ "^[[:space:]]*#?[[:space:]]*" key "[[:space:]]*=") {
        print key " = " value
        seen = 1
        next
      }
      print
    }
    END {
      if (!seen) {
        print key " = " value
      }
    }
  ' "$pwquality_conf" > "$tmp_file"

  mv "$tmp_file" "$pwquality_conf"
}

ensure_param "minlen" "8"
ensure_param "minclass" "4"
ensure_param "usercheck" "1"

chmod 0644 "$pwquality_conf"
