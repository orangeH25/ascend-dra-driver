#!/usr/bin/env bash
set -e

NAMESPACE=ascend-dra-driver

OWNER=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f1)
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f2)

VERSION=${1:-latest}

if [ "$VERSION" = "latest" ]; then
  echo "Fetching latest release version..."
  VERSION=$(curl -s https://api.github.com/repos/$OWNER/$REPO_NAME/releases/latest \
    | grep '"tag_name":' \
    | sed -E 's/.*"([^"]+)".*/\1/')
fi

echo "Installing Ascend DRA Driver version $VERSION..."

REPO="https://github.com/$OWNER/$REPO_NAME/releases/download/$VERSION"

curl -L -o ascend-dra-driver-$VERSION.tgz $REPO/ascend-dra-driver-$VERSION.tgz

helm upgrade -i \
  --create-namespace \
  --namespace $NAMESPACE \
  ascend-dra-driver \
  ./ascend-dra-driver-$VERSION.tgz
