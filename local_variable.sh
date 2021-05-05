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

#
# Purpose: Find out if user exits or not
#
does_user_exists() {
  local u=$1
  grep -qEw "^$u" $PASSWD_FILE && die "Username $u exists."
}

#
# Purpose: Is script run by root? Else die..
#
is_user_root() {
  [ "$(id -u)" != "0" ] && die "You must be root to run this script" 2
}

#
# Purpose: Display usage
#
usage() {
  echo "Usage: $0 username"
  exit 2
}

[ $# -eq 0 ] && usage

# invoke the function is_root_user
is_user_root

# call the function is_user_root
is_user_root

# call the function does_user_exists
does_user_exists "$1"

# display something on screen
echo "Adding user $1 to database..."

# just display command but do not add user to system
echo "/sbin/useradd -s /sbin/bash -m $1"
