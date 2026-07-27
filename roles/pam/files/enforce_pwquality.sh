#!/usr/bin/env bash
set -euo pipefail

pwquality_conf="${1:-/etc/security/pwquality.conf}"
pwhistory_conf="/etc/security/pwhistory.conf"
faillock_conf="/etc/security/faillock.conf"
bashrc_file="${HOME}/.bashrc"
login_defs_file="${LOGIN_DEFS_FILE:-/etc/login.defs}"

touch "$pwquality_conf"
touch "$pwhistory_conf"
touch "$faillock_conf"
touch "$bashrc_file"
touch "$login_defs_file"

ensure_param() {
  local file="$1"
  local key="$2"
  local value="$3"
  local tmp_file
  tmp_file="$(mktemp)"

  cp "$file" "$tmp_file"

  if grep -Eq "^[[:space:]]*#?[[:space:]]*${key}[[:space:]]*=" "$file"; then
    sed -i "s/^[[:space:]]*#*[[:space:]]*${key}[[:space:]]*=.*/${key} = ${value}/" "$file"
  else
    printf '%s\n' "${key} = ${value}" >> "$file"
  fi

  rm -f "$tmp_file"
}

ensure_login_defs_param() {
  local file="$1"
  local key="$2"
  local value="$3"
  local tmp_file

  tmp_file="$(mktemp)"

  awk -v key="$key" -v value="$value" '
    {
      if ($0 ~ "^[[:space:]]*" key "([[:space:]]|$)") {
        if (!seen) {
          print key " " value
          seen = 1
        }
        next
      }
      print $0
    }
    END {
      if (!seen) {
        print key " " value
      }
    }
  ' "$file" > "$tmp_file"

  mv "$tmp_file" "$file"
}

remove_login_defs_param() {
  local file="$1"
  local key="$2"
  local tmp_file

  tmp_file="$(mktemp)"

  awk -v key="$key" '
    {
      if ($0 ~ "^[[:space:]]*" key "([[:space:]]|$)") {
        next
      }
      print $0
    }
  ' "$file" > "$tmp_file"

  mv "$tmp_file" "$file"
}

ensure_bashrc_line() {
  local line="$1"

  if grep -Fq "$line" "$bashrc_file"; then
    return 0
  fi

  if grep -Eq "^[[:space:]]*#?[[:space:]]*${line}$" "$bashrc_file"; then
    sed -i "s/^[[:space:]]*#*[[:space:]]*${line}$/$(printf '%s' "$line")/" "$bashrc_file"
  else
    printf '%s\n' "$line" >> "$bashrc_file"
  fi
}

ensure_param "$pwquality_conf" "minlen" "8"
ensure_param "$pwquality_conf" "minclass" "4"
ensure_param "$pwquality_conf" "usercheck" "1"
ensure_param "$pwquality_conf" "dcredit" "-1"
ensure_param "$pwquality_conf" "ucredit" "-1"
ensure_param "$pwquality_conf" "lcredit" "-1"
ensure_param "$pwquality_conf" "ocredit" "-1"
ensure_param "$pwquality_conf" "maxrepeat" "3"

ensure_param "$pwhistory_conf" "remember" "5"

ensure_param "$faillock_conf" "deny" "3"
ensure_param "$faillock_conf" "unlock_time" "300"
ensure_param "$faillock_conf" "fail_interval" "300"

ensure_bashrc_line "export TMOUT=600"
ensure_bashrc_line "readonly TMOUT"

remove_login_defs_param "$login_defs_file" "PASS_MAN_DAYS"
ensure_login_defs_param "$login_defs_file" "PASS_MAX_DAYS" "60"
ensure_login_defs_param "$login_defs_file" "PASS_MIN_DAYS" "1"
ensure_login_defs_param "$login_defs_file" "PASS_WARN_AGE" "7"

chmod 0644 "$pwquality_conf" "$pwhistory_conf" "$faillock_conf" "$login_defs_file"

export BASHRCSOURCED=1
if [ -f "$bashrc_file" ]; then
  set +e
  . "$bashrc_file"
  status=$?
  set -e
  if [ "$status" -ne 0 ]; then
    exit 0
  fi
fi