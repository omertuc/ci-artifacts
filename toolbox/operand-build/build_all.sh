#! /bin/bash -e

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${THIS_DIR}/../_common.sh

${THIS_DIR}/build_dcgm_exporter.sh & 
${THIS_DIR}/build_device_plugin.sh &
${THIS_DIR}/build_driver.sh &
${THIS_DIR}/build_gfd.sh &
${THIS_DIR}/build_toolkit.sh &
${THIS_DIR}/build_validator.sh &

wait
