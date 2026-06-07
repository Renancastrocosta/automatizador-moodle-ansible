#!/usr/bin/env bash
# Carrega .env, valida variáveis obrigatórias e gera o inventory do Ansible.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${ROOT_DIR}/.env"
INVENTORY_TEMPLATE="${ROOT_DIR}/inventory/hosts.ini.template"
INVENTORY_FILE="${ROOT_DIR}/inventory/hosts.ini"

VARIAVEIS_OBRIGATORIAS=(
  MOODLE_HOST
  ANSIBLE_USER
  ANSIBLE_SSH_PRIVATE_KEY_FILE
  MOODLE_DOMAIN
  MOODLE_ADMIN_PASSWORD
  MOODLE_ADMIN_EMAIL
  MOODLE_DB_PASSWORD
  MOODLE_DATA_DIR
  POSTGRES_DATA_DIR
  BACKUP_DIR
)

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "Arquivo .env não encontrado."
  echo "Execute: cp .env.example .env && edite os valores"
  exit 1
fi

set -a
# shellcheck disable=SC1090
source "${ENV_FILE}"
set +a

for variavel in "${VARIAVEIS_OBRIGATORIAS[@]}"; do
  if [[ -z "${!variavel:-}" ]]; then
    echo "Variável obrigatória não definida no .env: ${variavel}"
    exit 1
  fi
done

if [[ ! -f "${INVENTORY_TEMPLATE}" ]]; then
  echo "Template de inventory não encontrado: ${INVENTORY_TEMPLATE}"
  exit 1
fi

export MOODLE_HOST ANSIBLE_USER ANSIBLE_SSH_PRIVATE_KEY_FILE
envsubst < "${INVENTORY_TEMPLATE}" > "${INVENTORY_FILE}"

echo "Ambiente carregado. Inventory gerado em inventory/hosts.ini"
