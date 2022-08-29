#!/usr/bin/env bash
#
#    __                          __
#   / /____ ___ ____  ___  ___ _/ /       This script is provided to you by https://github.com/tegonal/github-commons
#  / __/ -_) _ `/ _ \/ _ \/ _ `/ /        It is licensed under Creative Commons Zero v1.0 Universal
#  \__/\__/\_, /\___/_//_/\_,_/_/         Please report bugs and contribute back your improvements
#         /___/
#                                         Version: v0.1.0-SNAPSHOT
#
###################################
set -euo pipefail
shopt -s inherit_errexit

if ! [[ -v scriptsDir ]]; then
  scriptsDir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)"
  declare -r scriptsDir
fi

if ! [[ -v dir_of_tegonal_scripts ]]; then
  dir_of_tegonal_scripts="$scriptsDir/../lib/tegonal-scripts/src"
  source "$dir_of_tegonal_scripts/setup.sh" "$dir_of_tegonal_scripts"
fi
sourceOnce "$scriptsDir/run-shellcheck.sh"

function beforePr() {
	customRunShellcheck
}

${__SOURCED__:+return}
beforePr "$@"