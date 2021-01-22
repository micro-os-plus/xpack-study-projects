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

# Clone a repo and checkout the development branch, possibly a given commit.
function xpm-install-git()
{
  local repo_name="$1"

  if [ -d "${repo_name}.git" ]
  then
    echo "${repo_name}.git already present, skiped..."
  else
    git clone --branch xpack-develop https://github.com/micro-os-plus/${repo_name}.git ${repo_name}.git
    if [ $# -gt 2 ]
    then
      local commit_id="$2"
      (cd ${repo_name}.git; git checkout -b work ${commit_id})
    else
      (cd ${repo_name}.git; git checkout -b work HEAD)
    fi
  fi

  # Link it to the central xPacks repo.
  xpm link -C ${repo_name}.git
}

# -----------------------------------------------------------------------------


(
  dest="${script_folder_path}/../xpack-repos"
  mkdir -p "${dest}"
  cd "${dest}"

  xpm-install-git "architecture-cortexm-xpack" 
  xpm-install-git "architecture-synthetic-posix-xpack" 
  xpm-install-git "architecture-riscv-xpack" 
  xpm-install-git "build-helper" 
  xpm-install-git "cmsis-os-xpack" 
  xpm-install-git "devices-sifive-xpack" 
  xpm-install-git "devices-stm32f0-xpack" 
  xpm-install-git "devices-stm32f4-xpack" 
  xpm-install-git "diag-trace-xpack" 
  xpm-install-git "libs-c-xpack" 
  xpm-install-git "libs-cpp-estd-xpack" 
  xpm-install-git "libs-cpp-xpack" 
  xpm-install-git "memory-allocators-xpack" 
  xpm-install-git "platform-sifive-hifive1-xpack"
  xpm-install-git "platform-sifive-arty-xpack"
  xpm-install-git "posix-io-xpack" 
  xpm-install-git "rtos-xpack" 
  xpm-install-git "semihosting-xpack" 
  xpm-install-git "startup-xpack" 
  xpm-install-git "utils-lists-xpack" 
  xpm-install-git "version-xpack" 
)

(
  cd "${script_folder_path}/../"

  echo
  xpm install -C "blinky-no-rtos"
  xpm run link-deps -C "blinky-no-rtos"

  echo
  xpm install -C "blinky-rtos"
  xpm run link-deps -C "blinky-rtos"
)

echo
echo "Done."

# -----------------------------------------------------------------------------
