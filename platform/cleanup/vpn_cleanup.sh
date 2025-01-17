#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

DIRECTORY="$1"

source "${DIRECTORY}"/utils/vpn/interface_manager.sh

delete_all_ifs 

rm -f "${DIRECTORY}"/groups/"${VPN_DB_FILE}"
rm -f "${DIRECTORY}"/groups/"${VPN_PASSWD_FILE}"
