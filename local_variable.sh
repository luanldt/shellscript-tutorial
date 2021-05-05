#!/bin/bash

# Make readonly variable i.e. constant variable
declare -r PASSWD_FILE=/etc/passwd

#
# Purpose: Display message and die with give exit code
#
die() {
  local message="$1"
  local exitCode=$2

  echo "$message"
  [ "$exitCode" == "" ] && exit 1 || exit $exitCode
}

does_user_exists() {
  local u=$1
  grep -qEw "^$u" $PASSWD_FILE && die "Username $u exists."
}