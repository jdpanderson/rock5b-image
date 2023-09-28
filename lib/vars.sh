#!/bin/bash -ex

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../" &> /dev/null && pwd)
TOP=$(dirname $DIR)
BUILD=${DIR}/build
