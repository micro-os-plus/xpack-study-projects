#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Identify the script location, to reach, for example, the helper scripts.

script_path="$0"
if [[ "${script_path}" != /* ]]
then
  # Make relative path absolute.
  script_path="$(pwd)/$0"
fi

script_name="$(basename "${script_path}")"

script_folder_path="$(dirname "${script_path}")"
script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================

# Clone a repo and checkout a specific commit ID.
function xpm-install-git()
{
  if [ -d "$1.git" ]
  then
    echo "$1.git already present, skiped..."
  else
    git clone --branch xpack-develop https://github.com/micro-os-plus/$1.git $1.git
    if [ $# -gt 2 ]
    then
      (cd $1.git; git checkout -b work $2)
    else
      (cd $1.git; git checkout -b work $HEAD)
    fi
  fi
  xpm link -C $1.git
}

mkdir -p "${script_folder_path}/../../xpacks"
cd "${script_folder_path}/../../xpacks"

xpm-install-git "libs-c-xpack" "8bc7439"
xpm-install-git "libs-cpp-xpack" "17f64a2"
xpm-install-git "diag-trace-xpack" "596d7c9"
xpm-install-git "semihosting-xpack" "0db6262"
xpm-install-git "startup-xpack" "19de852"
xpm-install-git "devices-stm32f0-xpack" "4d725cf"
xpm-install-git "devices-stm32f4-xpack" "cd74d33"
xpm-install-git "architecture-cortexm-xpack" "a31d322"
xpm-install-git "architecture-riscv-xpack" "ca59650"
xpm-install-git "devices-sifive-xpack" "2732c22"

# Add links in the project to writable packages.
xpm link -C "${script_folder_path}/../" \
"@micro-os-plus/libs-c" \
"@micro-os-plus/libs-cpp" \
"@micro-os-plus/diag-trace" \
"@micro-os-plus/semihosting" \
"@micro-os-plus/startup" \
"@micro-os-plus/devices-stm32f0" \
"@micro-os-plus/devices-stm32f4" \
"@micro-os-plus/architecture-cortexm" \
"@micro-os-plus/architecture-riscv" \
"@sifive/devices" \

echo
echo "Done."
