#! /bin/bash -e

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

usage() {
    echo "Usage: $0 <repo file abs path> [--destdir=destinationDir] [--clientcrt=client cert file path] [--clientkey=client key file path]"
}

REPOFILE_FILENAME=""
REPOFILE_DESTDIR=""
CLIENT_AUTH_CRT=""
CLIENT_AUTH_KEY=""

if [ "$#" -lt 1 ]; then
    echo "FATAL: expected at least 1 parameters ... (got $#: '$@')"
    usage
    exit 1
elif [[ ! -e "$1" ]]; then
    echo "FATAL: File '$1' not found"
    usage
    exit 1
fi

REPOFILE_FILENAME=$(realpath $1)
shift

until [ "$#" -lt 1 ]; do
  if [[ "$1" != "--"*"="* ]]; then
    echo "FATAL: unknown flag $1"
    usage
    exit 1
  fi

  value=${1#--*=}
  flag=${1%=*}

  if [[ "${flag}" == "--destdir" ]]; then
        REPOFILE_DESTDIR="${value}"
  elif [[ "${flag}" == "--clientcrt" ]]; then
        CLIENT_AUTH_CRT="${value}"
  elif [[ "${flag}" == "--clientkey" ]]; then
        CLIENT_AUTH_KEY="${value}"
  fi

  shift
done

source ${THIS_DIR}/../_common.sh

ANSIBLE_OPTS="${ANSIBLE_OPTS} -e gpu_operator_set_repo_filename=${REPOFILE_FILENAME}"

if [[ "$REPOFILE_DESTDIR" ]]; then
    ANSIBLE_OPTS="${ANSIBLE_OPTS} -e gpu_operator_set_repo_destdir=${REPOFILE_DESTDIR}"
fi

if [[ "$CLIENT_AUTH_CRT" ]]; then
  ANSIBLE_OPTS="${ANSIBLE_OPTS} -e gpu_operator_set_repo_client_auth_cert_filename=${CERT_FILENAME}"
fi

if [[ "$CLIENT_AUTH_KEY" ]]; then
  ANSIBLE_OPTS="${ANSIBLE_OPTS} -e gpu_operator_set_repo_client_auth_key_filename=${KEY_FILENAME}"
fi

exec ansible-playbook ${ANSIBLE_OPTS} playbooks/gpu_operator_set_repo-config.yml

