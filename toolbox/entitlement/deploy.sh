#! /bin/bash -e

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${CURR_DIR}/../_common.sh

usage() {
    echo "Usage: $0 --pem </path/to/file.pem>"
}

if ! [ "$#" -eq 2 ]; then
    echo "ERROR: please pass two arguments."
    usage
    exit 1
fi

if [[ "$1" == "--pem" ]]; then
    ANSIBLE_OPTS="${ANSIBLE_OPTS} -e entitlement_pem=$2"
    echo "Using '$2' as PEM key"
else
    echo "ERROR: please pass a valid flag."
    usage
    exit 1
fi

exec ansible-playbook ${ANSIBLE_OPTS} playbooks/entitlement_deploy.yml
