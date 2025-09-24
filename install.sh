#!/usr/bin/env bash
set -euo pipefail

OWNER=${OWNER:-cosdt}
REPO_NAME=${REPO_NAME:-ascend-dra-driver}
NAMESPACE=${NAMESPACE:-ascend-dra-driver}
VERSION=${VERSION:-latest}

ARCHIVE="ascend-dra-driver-${VERSION}.tgz"
BASE_URL="https://github.com/${OWNER}/${REPO_NAME}/releases/download/${VERSION}"

echo "🚀 Installing Ascend DRA Driver ${VERSION} into namespace ${NAMESPACE}..."

curl -sSL -o "$ARCHIVE" "${BASE_URL}/${ARCHIVE}"

helm upgrade -i \
  --create-namespace \
  --namespace $NAMESPACE \
  "$REPO_NAME" \
  "./${ARCHIVE}"

echo "✅ Ascend DRA Driver ${VERSION} installed successfully."
