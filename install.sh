#!/usr/bin/env bash
set -e

VERSION=${1:-v1.0.0}
NAMESPACE=ascend-dra-driver
REPO="https://github.com/orangeH25/ascend-dra-driver/releases/download/$VERSION"

echo "Installing Ascend DRA Driver version $VERSION..."

curl -L -o ascend-dra-driver-$VERSION.tgz $REPO/ascend-dra-driver-$VERSION.tgz

helm upgrade -i \
  --create-namespace \
  --namespace $NAMESPACE \
  ascend-dra-driver \
  ./ascend-dra-driver-$VERSION.tgz
