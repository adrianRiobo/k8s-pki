#!/bin/bash

CURRENT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PKI_EXTERNAL=$CURRENT/../pki-external
TARGET_FOLDER=$CURRENT/../target

rm -fr $PKI_EXTERNAL
rm -fr $TARGET_FOLDER
