#!/usr/bin/env bash

set -ae

cwd="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"

function __iso8601_date(){
  date -u +'%Y-%m-%dT%H:%M:%SZ'
}

function msg() {
	echo -e "[$(__iso8601_date)] [ INFO ] >>> $*" >&2
}

function retry() {
    local max_tries=$1
    shift
    local cmd=$@

    for ((tries=0; tries < max_tries; tries++)); do
            sleep $(( 10 * tries ))
            (set +e; eval "$cmd") && break
    done
    if [[ $tries -eq $max_tries ]]; then
        echo "'$1' failed after $tries tries, aborting." >&2
        return 1
    else
        return 0
    fi
}

function build_with_docker() {
    :
}

function build() {
    local dockerfile_path=$1
    local parent_dir="$(dirname -- ${dockerfile_path})"
    msg "Processing ${dockerfile_path}"

    if [[ -f "${parent_dir}/Makefile" ]]; then
        msg "Makefile found, building using default target"
        cd "${parent_dir}" && retry 3 make
    else
        build_with_docker
    fi
}

find "${cwd}" -maxdepth 2 -type f -name "Dockerfile" -print0 | xargs -I '{}' -0 bash -c 'build {}'