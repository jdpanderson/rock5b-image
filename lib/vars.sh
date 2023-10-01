#!/bin/bash -ex

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../" &> /dev/null && pwd)
TOP=$(dirname $DIR)
BUILD=${DIR}/build

source_git() {
	PROJECT=$1
	ORIGIN=$2
	BRANCH=$3
	if [ -d ${BUILD}/${PROJECT} ]; then
                pushd ${BUILD}/${PROJECT}
                git pull
                popd
        else
                mkdir -p ${BUILD}
                pushd ${BUILD}
                git checkout --depth 1 --branch ${BRANCH} ${ORIGIN} ${PROJECT}
                popd
        fi
}
