#!/bin/bash
#ddev-generated
set -e

ARCH="$(uname -m)"

if [ "$ARCH" = "aarch64" ]; then
	ARCH="aarch64"
elif [ "$ARCH" = "x86_64" ]; then
	ARCH="x86-64"
fi