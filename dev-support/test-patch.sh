#!/bin/bash
# - test-patch.sh
#

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"

function check_python() {
    mkdir -p ${ROOT_DIR}/build/python
    python3 -m venv ${ROOT_DIR}/build/python
    source ${ROOT_DIR}/build/python/bin/activate
    pushd ${ROOT_DIR}/src
    pip3 install -e '.[dev]'
    output=$(pylint --rcfile=${ROOT_DIR}/.pylintrc --persistent=n $(git ls-files '*.py'))
    if [ $? -ne 0 ]; then
        printf "%s\n" "${output}"
        exit 1
    fi
    output=$(autopep8 --diff $(git ls-files -- '*.py'))
    if [ -n "$output" ]; then
        echo "Python format(provider: autopep8) error within the following files:"
        printf "%s\n" "${output}"
        exit 1
    fi
    popd
}

function run_scantist() {
    java -jar /home/jenkins/scantist-bom-detect.jar
}

echo "Checking Python repos"
HAS_PYTHON=$(git diff HEAD --name-only --diff-filter=ACMRT | grep -E "^clover/.*\.py$")
if [ -n "${HAS_PYTHON}" ];then
    cd ${ROOT_DIR}
    check_python
fi

run_scantist

echo "Build succeed."
