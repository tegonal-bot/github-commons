#!/usr/bin/env bash
#
#    __                          __
#   / /____ ___ ____  ___  ___ _/ /       This script is provided to you by https://github.com/tegonal/scripts
#  / __/ -_) _ `/ _ \/ _ \/ _ `/ /        It is licensed under Apache 2.0
#  \__/\__/\_, /\___/_//_/\_,_/_/         Please report bugs and contribute back your improvements
#         /___/
#                                         Version: v0.15.0
#
#######  Description  #############
#
#  Utility functions to ask the user something via input.
#
#######  Usage  ###################
#
#    #!/usr/bin/env bash
#    set -euo pipefail
#    shopt -s inherit_errexit
#    # Assumes tegonal's scripts were fetched with gget - adjust location accordingly
#    dir_of_tegonal_scripts="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)/../lib/tegonal-scripts/src"
#    source "$dir_of_tegonal_scripts/setup.sh" "$dir_of_tegonal_scripts"
#
#    sourceOnce "$dir_of_tegonal_scripts/utility/ask.sh"
#
#    if askYesOrNo "shall I say hello"; then
#    	echo "hello"
#    fi
#
###################################
set -euo pipefail
shopt -s inherit_errexit
unset CDPATH

if ! [[ -v dir_of_tegonal_scripts ]]; then
	dir_of_tegonal_scripts="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)/.."
	source "$dir_of_tegonal_scripts/setup.sh" "$dir_of_tegonal_scripts"
fi
sourceOnce "$dir_of_tegonal_scripts/utility/parse-fn-args.sh"

function askYesOrNo() {
	if (($# == 0)); then
		logError "At least one argument needs to be passed to askYesOrNo, given \033[0;36m%s\033[0m\n" "$#"
		echo >&2 '1: question   the question which the user should answer with y or n'
		echo >&2 '2... args...  arguments for the question (question is printed with printf)'
		printStackTrace
		exit 9
	fi
	local -r question=$1
	shift || die "could not shift by 1"

	# the question itself can have %s thus we use it in the format string
	# shellcheck disable=SC2059
	printf "\n\033[0;36m$question\033[0m y/[N]:" "$@"
	local answer='n'
	local -r timeout=20
	set +e
	read -t "$timeout" -r answer
	local lastResult=$?
	set -e
	if ((lastResult > 128)); then
		printf "\n"
		logInfo "no user interaction after %s seconds, going to interpret that as a 'no'." "$timeout"
	fi
	[[ $answer == y ]] || [[ $answer == Y ]]
}
