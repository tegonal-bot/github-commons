#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit
MY_PROJECT_LATEST_VERSION="v1.0.0"

# Assumes tegonal's github-commons was fetched with gt and put into repoRoot/.gt/remotes/tegonal-gh-commons/lib
# - adjust remote name or location accordingly
dir_of_github_commons="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)/lib/src"

if ! [[ -v dir_of_tegonal_scripts ]]; then
	dir_of_tegonal_scripts="$dir_of_github_commons/../tegonal-scripts/src"
	source "$dir_of_tegonal_scripts/setup.sh" "$dir_of_tegonal_scripts"
fi

source "$dir_of_github_commons/gt/pull-hook-functions.sh"

declare _tag=$1 source=$2 _target=$3
shift 3 || die "could not shift by 3"

# replaces placeholders in all files github-commons provides with placeholders
replaceTegonalGhCommonsPlaceholders "$source" "my-project-name" "$MY_PROJECT_LATEST_VERSION" \
	"MyCompanyName, Country"  "code-of-conduct@my-company.com" "my-companies-github-name"

