#!/usr/bin/env bash
# Instalação automatizada do Moodle no servidor configurado no .env

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${ROOT_DIR}"

# shellcheck disable=SC1091
source "${ROOT_DIR}/bin/load-env.sh"

ansible-playbook playbooks/server.yml "$@"
